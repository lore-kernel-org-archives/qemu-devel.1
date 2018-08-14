Received: from eggs.gnu.org ([2001:4830:134:3::10]:41622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpURp-0004SY-V2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpURo-0006D8-QL
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:13:01 -0400
Date: Tue, 14 Aug 2018 16:12:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180814081252.GJ7549@lemon.usersys.redhat.com>
References: <20180813023958.5352-1-famz@redhat.com>
	<20180813134206.GF4323@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813134206.GF4323@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Skip effectiveless OFD lock
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Mon, 08/13 15:42, Kevin Wolf wrote:
> Am 13.08.2018 um 04:39 hat Fam Zheng geschrieben:
> > If we know we've already locked the bytes, don't do it again; similarly
> > don't unlock a byte if we haven't locked it. This doesn't change the
> > behavior, but fixes a corner case explained below.
> > 
> > Libvirt had an error handling bug that an image can get its (ownership,
> > file mode, SELinux) permissions changed (RHBZ 1584982) by mistake behind
> > QEMU. Specifically, an image in use by Libvirt VM has:
> > 
> >     $ ls -lhZ b.img
> >     -rw-r--r--. qemu qemu system_u:object_r:svirt_image_t:s0:c600,c690 b.img
> > 
> > Trying to attach it a second time won't work because of image locking.
> > And after the error, it becomes:
> > 
> >     $ ls -lhZ b.img
> >     -rw-r--r--. root root system_u:object_r:virt_image_t:s0 b.img
> > 
> > Then, we won't be able to do OFD lock operations with the existing fd.
> > In other words, the code such as in blk_detach_dev:
> > 
> >     blk_set_perm(blk, 0, BLK_PERM_ALL, &error_abort);
> > 
> > can abort() QEMU, out of environmental changes.
> > 
> > This patch is an easy fix to this and the change is regardlessly
> > reasonable, so do it.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Thanks, applied to the block branch.

Self-NACK. This breaks raw_abort_perm_update(). The extra bytes locked by
raw_check_perm() are not tracked by s->perm (it is only updated in
raw_set_perm()), thus will not get released. This patch is "misusing" s->perm
and s->shared_perm.

I'll revise the implementation and send another version together with dropping
s->lock_fd.

Fam
