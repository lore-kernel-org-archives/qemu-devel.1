Received: from eggs.gnu.org ([2001:4830:134:3::10]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eWZXX-0004Mq-Pl
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eWZXS-0003Mu-Vv
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:16:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:45305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eWZXS-0003Ll-Mu
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:16:22 -0500
Date: Wed, 3 Jan 2018 11:16:39 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180103031639.26c6iixwzs4auhxr@hz-desktop>
References: <20171227065620.20889-1-haozhong.zhang@intel.com>
	<20180102175733-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180102175733-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 01/02/18 18:02 +0200, Michael S. Tsirkin wrote:
> On Wed, Dec 27, 2017 at 02:56:20PM +0800, Haozhong Zhang wrote:
> > When a file supporting DAX is used as vNVDIMM backend, mmap it with
> > MAP_SYNC flag in addition can guarantee the persistence of guest write
> > to the backend file without other QEMU actions (e.g., periodic fsync()
> > by QEMU).
> > 
> > By using MAP_SHARED_VALIDATE flag with MAP_SYNC, we can ensure mmap
> > with MAP_SYNC fails if MAP_SYNC is not supported by the kernel or the
> > backend file. On such failures, QEMU retries mmap without MAP_SYNC and
> > MAP_SHARED_VALIDATE.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> 
> If users rely on MAP_SYNC then don't you need to fail allocation
> if you can't use it?

MAP_SYNC is supported since Linux kernel 4.15 and only needed for mmap
files on nvdimm. qemu_ram_mmap() has no way to check whether its
parameter 'fd' points to files on nvdimm, except by looking up
sysfs. However, accessing sysfs may be denied by certain SELinux
policies.

The missing of MAP_SYNC should not affect the primary functionality of
vNVDIMM when using files on host nvdimm as backend, except the
guarantee of write persistence in case of qemu/host crash.

We may check the kernel support of MAP_SYNC and the type of vNVDIMM
backend in some management utility (e.g., libvirt?), and deny to
launch QEMU if MAP_SYNC is not supported while files on host NVDIMM
are in use.

> 
> > ---
> >  util/mmap-alloc.c | 36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > index 2fd8cbcc6f..37b302f057 100644
> > --- a/util/mmap-alloc.c
> > +++ b/util/mmap-alloc.c
> > @@ -18,7 +18,18 @@
> >  
> >  #ifdef CONFIG_LINUX
> >  #include <sys/vfs.h>
> > +
> > +/*
> > + * MAP_SHARED_VALIDATE and MAP_SYNC were introduced in 4.15 kernel, so
> > + * they may not be defined when compiling on older kernels.
> > + */
> > +#ifndef MAP_SHARED_VALIDATE
> > +#define MAP_SHARED_VALIDATE   0x3
> >  #endif
> > +#ifndef MAP_SYNC
> > +#define MAP_SYNC              0x80000
> > +#endif
> > +#endif /* CONFIG_LINUX */
> >  
> >  size_t qemu_fd_getpagesize(int fd)
> >  {
> 
> This stuff is arch-specific. I think you want to import this into
> standard-headers rather than duplicate things from Linux.

I'll move them to osdep.h.

> 
> 
> > @@ -97,6 +108,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >  #endif
> >      size_t offset;
> >      void *ptr1;
> > +    int xflags = 0;
> >  
> >      if (ptr == MAP_FAILED) {
> >          return MAP_FAILED;
> > @@ -107,12 +119,34 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >      assert(align >= getpagesize());
> >  
> >      offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
> > +
> > +#if defined(__linux__)
> > +    /*
> > +     * If 'fd' refers to a file supporting DAX, mmap it with MAP_SYNC
> > +     * will guarantee the guest write persistence without other
> > +     * actions in QEMU (e.g., fsync() in QEMU).
> > +     *
> > +     * MAP_SHARED_VALIDATE ensures mmap with MAP_SYNC fails if
> > +     * MAP_SYNC is not supported by the kernel or the file.
> > +     *
> > +     * On failures of mmap with xflags, QEMU will retry mmap without
> > +     * xflags.
> 
> If all you are doing is retrying without, then I don't think you
> even need VALIDATE.

Yes, MAP_SHARED_VALIDATE is not necessary. I'll remove it from xflags.

Thanks,
Haozhong

> 
> > +     */
> > +    xflags = shared ? (MAP_SHARED_VALIDATE | MAP_SYNC) : 0;
> > +#endif
> > +
> > + retry_mmap_fd:
> >      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> >                  MAP_FIXED |
> >                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> > -                (shared ? MAP_SHARED : MAP_PRIVATE),
> > +                (shared ? MAP_SHARED : MAP_PRIVATE) | xflags,
> >                  fd, 0);
> >      if (ptr1 == MAP_FAILED) {
> > +        if (xflags) {
> > +            xflags = 0;
> > +            goto retry_mmap_fd;
> > +        }
> > +
> >          munmap(ptr, total);
> >          return MAP_FAILED;
> >      }
> > -- 
> > 2.14.1
