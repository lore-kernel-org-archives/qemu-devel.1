Received: from eggs.gnu.org ([209.51.188.92]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gofc1-0004d6-46
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gofbz-0007no-NG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gofbz-0007nc-BF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:28:23 -0500
Date: Tue, 29 Jan 2019 21:28:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190129212747-mutt-send-email-mst@kernel.org>
References: <cover.1548771590.git.yi.z.zhang@linux.intel.com>
	<ef9d5d6128b853449fda6221a67894de48a09c3c.1548771590.git.yi.z.zhang@linux.intel.com>
	<20190129083952-mutt-send-email-mst@kernel.org>
	<20190130103646.GA53874@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130103646.GA53874@tiger-server>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] util/mmap-alloc: support MAP_SYNC
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

On Wed, Jan 30, 2019 at 06:36:46PM +0800, Yi Zhang wrote:
> On 2019-01-29 at 08:50:46 -0500, Michael S. Tsirkin wrote:
> > On Tue, Jan 29, 2019 at 10:49:09PM +0800, Zhang, Yi wrote:
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
> > >     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
> > > 
> > > 2. The rest of cases:
> > >    - we will never pass the MAP_SYNC to mmap2
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > ---
> > >  include/qemu/osdep.h | 21 +++++++++++++++++++++
> > >  util/mmap-alloc.c    | 28 +++++++++++++++++++++++++++-
> > >  2 files changed, 48 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index 457d24e..96209bb 100644
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
> > > +#ifdef CONFIG_LINUX
> > > +
> > > +#include <linux/mman.h>
> > > +
> > > +#ifndef MAP_SYNC
> > > +#define MAP_SYNC 0x80000
> > > +#endif
> > > +
> > > +#ifndef MAP_SHARED_VALIDATE
> > > +#define MAP_SHARED_VALIDATE 0x03
> > > +#endif
> > > +
> > 
> > I commented on this part in v7. That's a wrong way to handle
> > compatibility.
> MAP_SYNC and MAP_SHARED_VALIDATE have not defined at pre 4.15 kernel.
> to handle the compatibility we should defined it, Right?, That is Why I
> changed the value to run time handle the compatibility.
> 
> in previous version, you comments that we shouldn't direct define that
> in our own headers to avoid duplicated code.
> 
> So we add #include <linux/mman.h> Right?
> 
> Then shouldn't consider build qemu on pre 4.15 kernel header? won't
> failed?
> 
> #ifndef MAP_SYNC
> #define MAP_SYNC 0x80000
> #endif
> 
> #ifndef MAP_SHARED_VALIDATE
> #define MAP_SHARED_VALIDATE 0x03
> #endif
> 
> forgive my poor understanding, I'm getting more confused.

Look at how we handle other such defines such as e.g. kvm ioctl values.


> 
> > 
> > We had this discussion several times in the past. commit log doesn't
> > mention any reasons to ignore this.  All for setting a single bit in a
> > single system call.  This is getting discouraging.
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
> > > index 97bbeed..2c86ad2 100644
> > > --- a/util/mmap-alloc.c
> > > +++ b/util/mmap-alloc.c
> > > @@ -101,6 +101,7 @@ void *qemu_ram_mmap(int fd,
> > >  #else
> > >      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >  #endif
> > > +    int mmap_xflags = 0;
> > 
> > That's not a good variable name. It's extra for you since
> > you are writing the patch but it makes no sense
> > in the context of the function. Just mmap_flags
> > will do - and I would put all flags there, not just
> > the "extra" that this patch is adding.
> > 
> > 
> > >      size_t offset;
> > >      void *ptr1;
> > >  
> > > @@ -111,13 +112,38 @@ void *qemu_ram_mmap(int fd,
> > >      assert(is_power_of_2(align));
> > >      /* Always align to host page size */
> > >      assert(align >= getpagesize());
> > > +    if (shared && is_pmem) {
> > > +        mmap_xflags = MAP_SYNC | MAP_SHARED_VALIDATE;
> > > +    }
> > >  
> > >      offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
> > > +retry_mmap:
> > >      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> > >                  MAP_FIXED |
> > >                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> > > -                (shared ? MAP_SHARED : MAP_PRIVATE),
> > > +                (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
> > >                  fd, 0);
> > > +
> > > +    /* if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
> > > +     * we try with MAP_SHARED_VALIDATE without MAP_SYNC
> > > +     */
> > > +    if (ptr1 == MAP_FAILED &&
> > > +        mmap_xflags == (MAP_SYNC | MAP_SHARED_VALIDATE)) {
> > > +        if (errno == ENOTSUP) {
> > > +            perror("failed to validate with mapping flags");
> > > +        }
> > > +        mmap_xflags = MAP_SHARED_VALIDATE;
> > > +        goto retry_mmap;
> > 
> > Have you read
> > https://homepages.cwi.nl/~storm/teaching/reader/Dijkstra68.pdf
> > 
> > Please just call the function twice. You don't need goto
> > to repeat a single line.
> > 
> > 
> > > +    }
> > > +    /* MAP_SHARED_VALIDATE flag is available since Linux 4.15
> > > +     * Test only with MAP_SHARED_VALIDATE flag for compatibility.
> > > +     * Then ignore the MAP_SHARED_VALIDATE flag and retry again
> > > +     */
> > > +    if (mmap_xflags == MAP_SHARED_VALIDATE &&
> > > +        ptr1 == MAP_FAILED) {
> > > +            mmap_xflags &= ~MAP_SHARED_VALIDATE;
> > > +            goto retry_mmap;
> > > +    }
> > >      if (ptr1 == MAP_FAILED) {
> > >          munmap(ptr, total);
> > >          return MAP_FAILED;
> > > -- 
> > > 2.7.4
