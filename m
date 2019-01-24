Received: from eggs.gnu.org ([209.51.188.92]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmfNL-0003xq-6j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmfNJ-00042f-5a
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gmfNI-00040S-Se
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:48:57 -0500
Date: Thu, 24 Jan 2019 08:39:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190124082325-mutt-send-email-mst@kernel.org>
References: <cover.1548136274.git.yi.z.zhang@linux.intel.com>
	<286542bc2f48b0dd6a657f363a8e933806cac92d.1548136274.git.yi.z.zhang@linux.intel.com>
	<20190123100252-mutt-send-email-mst@kernel.org>
	<20190124141524.GB9821@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124141524.GB9821@tiger-server>
Subject: Re: [Qemu-devel] [PATCH V10 2/4] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Thu, Jan 24, 2019 at 10:15:24PM +0800, Yi Zhang wrote:
> On 2019-01-23 at 10:04:01 -0500, Michael S. Tsirkin wrote:
> > On Wed, Jan 23, 2019 at 10:59:45AM +0800, Zhang, Yi wrote:
> > > From: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > 
> > > When a file supporting DAX is used as vNVDIMM backend, mmap it with
> > > MAP_SYNC flag in addition which can ensure file system metadata
> > > synced in each guest writes to the backend file, without other QEMU
> > > actions (e.g., periodic fsync() by QEMU).
> > > 
> > > Current, We have below different possible use cases:
> > > 
> > > 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
> > >    a: backend is a dax supporting file.
> > >     - MAP_SYNC will active.
> > >    b: backend is not a dax supporting file.
> > >     - mmap will result in an EOPNOTSUPP error.
> > > 
> > > 2. The rest of cases:
> > >    - we will never pass the MAP_SYNC to mmap2
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > ---
> > >  include/qemu/mmap-alloc.h |  1 +
> > >  include/qemu/osdep.h      | 21 +++++++++++++++++++++
> > >  util/mmap-alloc.c         |  7 ++++++-
> > >  3 files changed, 28 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> > > index 6fe6ed4..a95d91c 100644
> > > --- a/include/qemu/mmap-alloc.h
> > > +++ b/include/qemu/mmap-alloc.h
> > > @@ -18,6 +18,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
> > >   *  @flags: specifies additional properties of the mapping, which can be one or
> > >   *          bit-or of following values
> > >   *          - RAM_SHARED: mmap with MAP_SHARED flag
> > > + *          - RAM_PMEM: mmap with MAP_SYNC flag
> > >   *          Other bits are ignored.
> > >   *
> > >   * Return:
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index 457d24e..3bcf155 100644
> > > --- a/include/qemu/osdep.h
> > > +++ b/include/qemu/osdep.h
> > > @@ -419,6 +419,27 @@ void qemu_anon_ram_free(void *ptr, size_t size);
> > >  #  define QEMU_VMALLOC_ALIGN getpagesize()
> > >  #endif
> > >  
> > > +/*
> > > + * MAP_SHARED_VALIDATE and MAP_SYNC are introduced in Linux kernel
> > > + * 4.15, so they may not be defined when compiling on older kernels.
> > > + */
> > 
> > 
> > I commented on this part in v7. That's a wrong way to handle
> > compatibility.
> I'm a little confused that, you point me that should use 
> #include <linux/mman.h>
> here in v9, so what is best way to handle compatibility? 
> modify the update-linux-headers.sh and copy the mman.h to
> standard-headers/linux/?
> and #incldue standard-headers/linux/mman.h ?

In fact, asm/mman.h and asm-generic/mman-common.h - that's where
these are defined.

> but it still need fix the compatibility. if the MAP_SYNC not defined in
> the old kernel. Right?

No. You need to check at runtime and handle the case where mmap fails.
There's no guarantee that qemu binary will be rebuilt each time
kernel changes.


> forgive me my poor understandings, I'm pazzled.
> > 
> > > +#ifdef CONFIG_LINUX
> > > +
> > > +#include <linux/mman.h>
> > > +
> > > +#ifndef MAP_SYNC
> > > +#define MAP_SYNC 0x0
> > > +#endif
> > > +
> > > +#ifndef MAP_SHARED_VALIDATE
> > > +#define MAP_SHARED_VALIDATE 0x0
> > > +#endif
> > > +
> > 
> > 
> > 
> > 
> > > +#else  /* !CONFIG_LINUX */
> > > +#define MAP_SYNC              0x0
> > > +#define MAP_SHARED_VALIDATE   0x0
> > > +#endif /* CONFIG_LINUX */
> > > +
> > >  #ifdef CONFIG_POSIX
> > >  struct qemu_signalfd_siginfo {
> > >      uint32_t ssi_signo;   /* Signal number */
> > > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > > index 8f0a740..a4ce9b5 100644
> > > --- a/util/mmap-alloc.c
> > > +++ b/util/mmap-alloc.c
> > > @@ -99,6 +99,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> > >      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >  #endif
> > >      bool shared = flags & RAM_SHARED;
> > > +    bool is_pmem = flags & RAM_PMEM;
> > > +    int mmap_xflags = 0;
> > >      size_t offset;
> > >      void *ptr1;
> > >  
> > > @@ -109,12 +111,15 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> > >      assert(is_power_of_2(align));
> > >      /* Always align to host page size */
> > >      assert(align >= getpagesize());
> > > +    if (shared && is_pmem) {
> > > +        mmap_xflags |= (MAP_SYNC | MAP_SHARED_VALIDATE);
> > > +    }
> > >  
> > >      offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
> > >      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> > >                  MAP_FIXED |
> > >                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> > > -                (shared ? MAP_SHARED : MAP_PRIVATE),
> > > +                (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
> > >                  fd, 0);
> > >      if (ptr1 == MAP_FAILED) {
> > >          munmap(ptr, total);
> > > -- 
> > > 2.7.4
