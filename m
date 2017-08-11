Received: from eggs.gnu.org ([2001:4830:134:3::10]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg9By-0003vZ-70
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg9Bx-0006Zb-0j
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:37:30 -0400
Date: Fri, 11 Aug 2017 14:37:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170811123716.GD4162@localhost.localdomain>
References: <CAATJJ0Jgyak9c=wYknret5y=yjfzcjiVw3221wX=SB2+am8H4A@mail.gmail.com>
	<20170811120435.GB23309@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811120435.GB23309@lemon.lan>
Subject: Re: [Qemu-devel] migration issue with qemu 2.10-rc2: QEMU command
 'nbd-server-add': Block node is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 11.08.2017 um 14:04 hat Fam Zheng geschrieben:
> On Fri, 08/11 13:07, Christian Ehrhardt wrote:
> > Simplifying that to a smaller test:
> > 
> > $ qemu-img create -f qcow2 /tmp/test.qcow2 100M
> > $ qemu-system-x86_64 -S -m 512 -smp 1 -nodefaults --nographic -monitor
> > stdio -drive
> > file=/tmp/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 -incoming
> > defer
> > QEMU 2.9.92 monitor - type 'help' for more information
> > (qemu) warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx
> > [bit 5]
> > nbd_server_start 0.0.0.0:49153
> > (qemu) nbd_server_add -w drive-virtio-disk0
> > Block node is read-only
> > (qemu) quit
> > 
> > It might be reasonable to keep the -device section to specify how it is
> > included.
> 
> This is actually caused by
> 
> commit 9c5e6594f15b7364624a3ad40306c396c93a2145
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Thu May 4 18:52:40 2017 +0200
> 
>     block: Fix write/resize permissions for inactive images
> 
> which forbids "nbd_server_add -w" in the "inactive" state set by -incoming.
> 
> But I'm not sure what is a proper fix. Maybe revert the bdrv_is_writable() part
> of the commit? Kevin?

No, the reason why this fail is simply that nbd_export_new() does things
in the wrong order. It always had to activate the image, otherwise the
first write would run into an assertion failure, but it only does so
after requesting the permissions.

blk_insert_bs() in line 1061 requests the permissions,
blk_invalidate_cache() in line 1097 activates the image.

We could either use bdrv_invalidate_cache() instead and call that before
blk_insert_bs(), or start with perm=0, shared=BLK_PERM_ALL and then use
blk_set_perm() only after activating the image. The third option would
be to set blk->disable_perm = true, which would ensure that the
permissions are only effective after the image gets activated; but this
field isn't accessible outside block-backend.c at the moment.

Kevin
