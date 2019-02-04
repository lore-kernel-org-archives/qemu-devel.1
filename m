Received: from eggs.gnu.org ([209.51.188.92]:56663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqg3L-0004Ml-6c
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqg3H-0006Tp-Fi
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqg3H-0006K7-1C
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:20:51 -0500
Date: Mon, 4 Feb 2019 10:20:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204101958-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<20190204142638.27021-24-mst@redhat.com>
	<20190204161554.253d810b@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204161554.253d810b@bahia.lan>
Subject: Re: [Qemu-devel] [PULL 23/25] mmap-alloc: fix hugetlbfs misaligned
 length in ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

I see. Well git should have no trouble resolving this.


On Mon, Feb 04, 2019 at 04:15:54PM +0100, Greg Kurz wrote:
> Hi Michael,
> 
> These two patches (22 and 23) from Murilo already got merged with a pull request
> from David earlier today.
> 
> Cheers,
> 
> --
> Greg
> 
> On Mon, 4 Feb 2019 09:44:04 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> > 
> > The commit 7197fb4058bcb68986bae2bb2c04d6370f3e7218 ("util/mmap-alloc:
> > fix hugetlb support on ppc64") fixed Huge TLB mappings on ppc64.
> > 
> > However, we still need to consider the underlying huge page size
> > during munmap() because it requires that both address and length be a
> > multiple of the underlying huge page size for Huge TLB mappings.
> > Quote from "Huge page (Huge TLB) mappings" paragraph under NOTES
> > section of the munmap(2) manual:
> > 
> >   "For munmap(), addr and length must both be a multiple of the
> >   underlying huge page size."
> > 
> > On ppc64, the munmap() in qemu_ram_munmap() does not work for Huge TLB
> > mappings because the mapped segment can be aligned with the underlying
> > huge page size, not aligned with the native system page size, as
> > returned by getpagesize().
> > 
> > This has the side effect of not releasing huge pages back to the pool
> > after a hugetlbfs file-backed memory device is hot-unplugged.
> > 
> > This patch fixes the situation in qemu_ram_mmap() and
> > qemu_ram_munmap() by considering the underlying page size on ppc64.
> > 
> > After this patch, memory hot-unplug releases huge pages back to the
> > pool.
> > 
> > Fixes: 7197fb4058bcb68986bae2bb2c04d6370f3e7218
> > Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> >  include/qemu/mmap-alloc.h |  2 +-
> >  exec.c                    |  4 ++--
> >  util/mmap-alloc.c         | 22 ++++++++++++++++------
> >  util/oslib-posix.c        |  2 +-
> >  4 files changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> > index 50385e3f81..ef04f0ed5b 100644
> > --- a/include/qemu/mmap-alloc.h
> > +++ b/include/qemu/mmap-alloc.h
> > @@ -9,6 +9,6 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
> >  
> >  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> >  
> > -void qemu_ram_munmap(void *ptr, size_t size);
> > +void qemu_ram_munmap(int fd, void *ptr, size_t size);
> >  
> >  #endif
> > diff --git a/exec.c b/exec.c
> > index 25f3938a27..03dd673d36 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1873,7 +1873,7 @@ static void *file_ram_alloc(RAMBlock *block,
> >      if (mem_prealloc) {
> >          os_mem_prealloc(fd, area, memory, smp_cpus, errp);
> >          if (errp && *errp) {
> > -            qemu_ram_munmap(area, memory);
> > +            qemu_ram_munmap(fd, area, memory);
> >              return NULL;
> >          }
> >      }
> > @@ -2394,7 +2394,7 @@ static void reclaim_ramblock(RAMBlock *block)
> >          xen_invalidate_map_cache_entry(block->host);
> >  #ifndef _WIN32
> >      } else if (block->fd >= 0) {
> > -        qemu_ram_munmap(block->host, block->max_length);
> > +        qemu_ram_munmap(block->fd, block->host, block->max_length);
> >          close(block->fd);
> >  #endif
> >      } else {
> > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > index f71ea038c8..8565885420 100644
> > --- a/util/mmap-alloc.c
> > +++ b/util/mmap-alloc.c
> > @@ -80,6 +80,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >      int flags;
> >      int guardfd;
> >      size_t offset;
> > +    size_t pagesize;
> >      size_t total;
> >      void *guardptr;
> >      void *ptr;
> > @@ -100,7 +101,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >       * anonymous memory is OK.
> >       */
> >      flags = MAP_PRIVATE;
> > -    if (fd == -1 || qemu_fd_getpagesize(fd) == getpagesize()) {
> > +    pagesize = qemu_fd_getpagesize(fd);
> > +    if (fd == -1 || pagesize == getpagesize()) {
> >          guardfd = -1;
> >          flags |= MAP_ANONYMOUS;
> >      } else {
> > @@ -109,6 +111,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >      }
> >  #else
> >      guardfd = -1;
> > +    pagesize = getpagesize();
> >      flags = MAP_PRIVATE | MAP_ANONYMOUS;
> >  #endif
> >  
> > @@ -120,7 +123,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >  
> >      assert(is_power_of_2(align));
> >      /* Always align to host page size */
> > -    assert(align >= getpagesize());
> > +    assert(align >= pagesize);
> >  
> >      flags = MAP_FIXED;
> >      flags |= fd == -1 ? MAP_ANONYMOUS : 0;
> > @@ -143,17 +146,24 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >       * a guard page guarding against potential buffer overflows.
> >       */
> >      total -= offset;
> > -    if (total > size + getpagesize()) {
> > -        munmap(ptr + size + getpagesize(), total - size - getpagesize());
> > +    if (total > size + pagesize) {
> > +        munmap(ptr + size + pagesize, total - size - pagesize);
> >      }
> >  
> >      return ptr;
> >  }
> >  
> > -void qemu_ram_munmap(void *ptr, size_t size)
> > +void qemu_ram_munmap(int fd, void *ptr, size_t size)
> >  {
> > +    size_t pagesize;
> > +
> >      if (ptr) {
> >          /* Unmap both the RAM block and the guard page */
> > -        munmap(ptr, size + getpagesize());
> > +#if defined(__powerpc64__) && defined(__linux__)
> > +        pagesize = qemu_fd_getpagesize(fd);
> > +#else
> > +        pagesize = getpagesize();
> > +#endif
> > +        munmap(ptr, size + pagesize);
> >      }
> >  }
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 4ce1ba9ca4..37c5854b9c 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -226,7 +226,7 @@ void qemu_vfree(void *ptr)
> >  void qemu_anon_ram_free(void *ptr, size_t size)
> >  {
> >      trace_qemu_anon_ram_free(ptr, size);
> > -    qemu_ram_munmap(ptr, size);
> > +    qemu_ram_munmap(-1, ptr, size);
> >  }
> >  
> >  void qemu_set_block(int fd)
