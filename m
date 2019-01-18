Received: from eggs.gnu.org ([209.51.188.92]:38541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkYcZ-0006ys-Me
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkYcY-0001Eh-MA
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:11:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkYcY-0001D5-DS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:11:58 -0500
Date: Fri, 18 Jan 2019 16:11:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190118181147.GJ4136@habkost.net>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<64bea1ff5f80647cc4592ee94d399d647bdd9862.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116104105-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116104105-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V9 4/6] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>, pagupta@redhat.com, qemu-devel@nongnu.org, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, xiaoguangrong.eric@gmail.com

On Wed, Jan 16, 2019 at 10:58:44AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 16, 2019 at 04:10:58PM +0800, Zhang Yi wrote:
> > When a file supporting DAX is used as vNVDIMM backend, mmap it with
> > MAP_SYNC flag in addition which can ensure file system metadata
> > synced in each guest writes to the backend file, without other QEMU
> > actions (e.g., periodic fsync() by QEMU).
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > ---
> >  include/qemu/mmap-alloc.h |  1 +
> >  include/qemu/osdep.h      | 16 ++++++++++++++++
> >  util/mmap-alloc.c         |  7 ++++++-
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> > index 6fe6ed4..a95d91c 100644
> > --- a/include/qemu/mmap-alloc.h
> > +++ b/include/qemu/mmap-alloc.h
> > @@ -18,6 +18,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
> >   *  @flags: specifies additional properties of the mapping, which can be one or
> >   *          bit-or of following values
> >   *          - RAM_SHARED: mmap with MAP_SHARED flag
> > + *          - RAM_PMEM: mmap with MAP_SYNC flag
> >   *          Other bits are ignored.
> >   *
> >   * Return:
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 457d24e..27a6bfe 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -419,6 +419,22 @@ void qemu_anon_ram_free(void *ptr, size_t size);
> >  #  define QEMU_VMALLOC_ALIGN getpagesize()
> >  #endif
> >  
> > +/*
> > + * MAP_SHARED_VALIDATE and MAP_SYNC are introduced in Linux kernel
> > + * 4.15, so they may not be defined when compiling on older kernels.
> > + */
> > +#ifdef CONFIG_LINUX
> > +
> > +#include <asm-generic/mman.h>
> 
> I suspect this is a wrong way to pull in this header.
> 
> You are normally supposed to use
>        #include <linux/mman.h>
> 
> but see below.
> 
> 
> > +
> > +#ifndef MAP_SYNC
> > +#define MAP_SYNC 0x0
> > +#endif
> 
> Oh that's bad.
> 
> So if you run with a new kernel but
> your installed headers are old, you get MAP_SYNC 0
> and no persistence transparently with no warning.

Yes. The semantics of the command-line to not change depending on
build time circumstances.

Anyway, I see a more fundamental problem in each version of this
patch: the semantics of the command-line options are not clearly
documented.

We have at least 3 different possible use cases we might need to
support:

1) pmem=on, MAP_SYNC not desired
2) pmem=on, MAP_SYNC desired but optional
3) pmem=on, MAP_SYNC required, not optional

Which cases from the list above we need to support?

>From the cases above, what's the expected semantics of "pmem=on"
with no extra options?

If these questions are not answered (in the commit message and
user documentation), we won't be able to review and discuss the
code.


> 
> > +
> > +#else  /* !CONFIG_LINUX */
> > +#define MAP_SYNC              0x0
> > +#endif /* CONFIG_LINUX */
> > +
> >  #ifdef CONFIG_POSIX
> >  struct qemu_signalfd_siginfo {
> >      uint32_t ssi_signo;   /* Signal number */
> > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > index 8f0a740..cba961c 100644
> > --- a/util/mmap-alloc.c
> > +++ b/util/mmap-alloc.c
> > @@ -99,6 +99,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> >      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >  #endif
> >      bool shared = flags & RAM_SHARED;
> > +    bool is_pmem = flags & RAM_PMEM;
> > +    int mmap_xflags = 0;
> >      size_t offset;
> >      void *ptr1;
> >  
> > @@ -109,12 +111,15 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> >      assert(is_power_of_2(align));
> >      /* Always align to host page size */
> >      assert(align >= getpagesize());
> > +    if (shared && is_pmem) {
> > +        mmap_xflags |= MAP_SYNC;
> > +    }
> >  
> >      offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
> >      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> >                  MAP_FIXED |
> >                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> > -                (shared ? MAP_SHARED : MAP_PRIVATE),
> > +                (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
> >                  fd, 0);
> >      if (ptr1 == MAP_FAILED) {
> >          munmap(ptr, total);
> > -- 
> > 2.7.4
> 

-- 
Eduardo
