Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyIpq-0006Xp-D4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyIpk-0001A4-D3
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyIpk-00019a-7Y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:05:52 -0400
Date: Tue, 20 Mar 2018 17:05:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320170328-mutt-send-email-mst@kernel.org>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/50] virtio, vhost, pci, pc: features,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Mar 20, 2018 at 02:18:33PM +0000, Peter Maydell wrote:
> On 20 March 2018 at 03:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Changes from v1:
> > - dropped include change for one generated file - proposed a tree-wide refactoring
> > - dropped vhost used slot refactoring due to alignment issues found by clang
> > - added vhost-user post-copy support
> >
> > The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to a466e2cdb09d7b1262e24bae8cc47a51550d3af3:
> >
> >   postcopy shared docs (2018-03-20 05:03:30 +0200)
> >
> > ----------------------------------------------------------------
> > virtio,vhost,pci,pc: features, cleanups
> >
> > SRAT tables for DIMM devices
> > new virtio net flags for speed/duplex
> > post-copy migration support in vhost
> > cleanups in pci
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> Link failure on aarch64 host:
>   LINK    arm-softmmu/qemu-system-arm
> hw/virtio/vhost-user.o: In function `vhost_user_postcopy_fault_handler':
> /home/pm215/qemu/hw/virtio/vhost-user.c:1000: undefined reference to
> `postcopy_request_shared_page'
> 
> I think this host is taking the "don't have userfaultfd" #ifdef
> path in postcopy-ram.c, which doesn't define a stub
> for the postcopy_request_shared_page function, but there's
> no equivalent guard in vhost-user.c
> 
> thanks
> -- PMM

I'm curious why does it take that path though.
Here's the rule

#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)

If it's Linux we'll pick our own copy of the header
and so __NR_userfaultfd is defined.

CONFIG_EVENTFD is not set?

Actually vhost-user does not work without CONFIG_EVENTFD either.
Maybe we should skip building it in that configuration.

-- 
MST
