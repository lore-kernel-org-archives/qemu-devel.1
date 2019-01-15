Received: from eggs.gnu.org ([209.51.188.92]:53093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFHv-0002zt-8n
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFHu-0007SF-4K
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjFHt-0007Q9-RP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:21:14 -0500
Date: Mon, 14 Jan 2019 22:21:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114221750-mutt-send-email-mst@kernel.org>
References: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
	<eb386264e7015f0a14c0c9686193555b3d2285e0.1546399191.git.yi.z.zhang@linux.intel.com>
	<20190114193938.GG28115@habkost.net>
	<20190115031335.GC67749@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115031335.GC67749@tiger-server>
Subject: Re: [Qemu-devel] [PATCH V8 5/5] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, imammedo@redhat.com, dan.j.williams@intel.com, qemu-devel@nongnu.org

On Tue, Jan 15, 2019 at 11:13:35AM +0800, Yi Zhang wrote:
> On 2019-01-14 at 17:39:38 -0200, Eduardo Habkost wrote:
> > On Wed, Jan 02, 2019 at 01:26:34PM +0800, Zhang Yi wrote:
> > > This option controls will mmap the memory backend file with MAP_SYNC flag,
> > > which can ensure filesystem metadata consistent even after a system crash
> > > or power failure, if MAP_SYNC flag is supported by the host kernel(Linux
> > > kernel 4.15 and later) and the backend is a file supporting DAX (e.g.,
> > > file on ext4/xfs file system mounted with '-o dax').
> > > 
> > > It can take one of following values:
> > >  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> > >         'share=off' or 'pmem!=on', QEMU will not pass this flags to
> > > 	mmap(2)
> > >  - off: default, never pass MAP_SYNC to mmap(2)
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > ---
> > [...]
> > > +vNVDIMM is designed and implemented to guarantee the guest data
> > > +persistence on the backends even on the host crash and power
> > > +failures. However, there are still some requirements and limitations
> > > +as explained below.
> > > +
> > >  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > > -currently the only one that can guarantee the guest write persistence
> > > +if MAP_SYNC is not supported by the host kernel and the backends,
> > > +the only backend that can guarantee the guest write persistence
> > >  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> > >  which all guest access do not involve any host-side kernel cache.
> > >  
> > > +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> > > +systems, QEMU can mmap(2) the backend with MAP_SYNC, which can ensure
> > > +filesystem metadata consistent even after a system crash or power
> > > +failure. Besides the host kernel support, enabling MAP_SYNC in QEMU
> > > +also requires:
> > > +
> > > + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> > > +   xfs file system mounted with '-o dax',
> > > +
> > > + - 'sync' option of memory-backend-file is on, and
> > > +
> > > + - 'share' option of memory-backend-file is 'on'.
> > > +
> > > + - 'pmem' option of memory-backend-file is 'on'
> > 
> > I miss one piece of information here: are there any negative
> > side-effects of enabling MAP_SYNC on a pmem=on backend?  Could it
> > affect performance?  If it has no negative effects, why don't we
> > try to always enable it whenever possible?
> > 
> > 
> > > +
> > >  When using other types of backends, it's suggested to set 'unarmed'
> > >  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> > >  guest NVDIMM region mapping structure.  This unarmed flag indicates
> > [...]
> > > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > > index a9d5e56..33a7639 100644
> > > --- a/util/mmap-alloc.c
> > > +++ b/util/mmap-alloc.c
> > > @@ -99,7 +99,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> > >      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >  #endif
> > >      bool shared = flags & RAM_SHARED;
> > > -    bool is_pmem = flags & RAM_PMEM;
> > > +    bool is_pmemsync = (flags & RAM_PMEM) && (flags & RAM_SYNC);
> > 
> > You seem to be reverting what you did on patch 3/5.  In patch
> > 3/5, you were setting MAP_SYNC automatically on all pmem=on
> > backends.  Now, you are only setting MAP_SYNC only if sync=on is
> > set explicitly.
> > 
> > I don't know which behavior is better (see question above), but
> > it's better to start with the right behavior in the first place.
> > 
> > Also, I don't think we should clear MAP_SYNC silently if sync=on
> > was explicitly requested in the command-line.  If sync=on was
> > set, we should do exactly as told, and require MAP_SYNC.  If we
> > still want to support use cases where MAP_SYNC is desired but
> > optional (do we?), we can make 'sync' a OnOffAuto option.
> Actually, I did this on previous version.
> see https://patchwork.kernel.org/patch/10725671/ 
> 
> Michael said that we should limit that option as it is only valided
> on a dax aware file system, to avoid the potencial performance issues
> we set it off by-defualt, and let a well-know user decides they wanna
> performance or stability.

However I am still unconvinced that the separate sync flag is helpful.
Why don't we set MAP_SYNC unconditionally when pmem is set?

It's a separate question what should happen on an old kernel. Maybe we
want a flag that says "fail unless persistence can be guaranteed".
Even then it's definitely not "sync".






> > 
> > 
> > >      int mmap_xflags = 0;
> > >      size_t offset;
> > >      void *ptr1;
> > > @@ -111,7 +111,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> > >      assert(is_power_of_2(align));
> > >      /* Always align to host page size */
> > >      assert(align >= getpagesize());
> > > -    if (shared && is_pmem) {
> > > +    if (shared && is_pmemsync) {
> > >          mmap_xflags |= MAP_SYNC;
> > >      }
> > >  
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > 
> > -- 
> > Eduardo
