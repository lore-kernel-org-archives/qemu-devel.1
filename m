Received: from eggs.gnu.org ([209.51.188.92]:44267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1glTBO-00079g-5W
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1glTBN-0008Tn-9c
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:35:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:43898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1glTBN-0008TD-1W
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:35:41 -0500
Date: Mon, 21 Jan 2019 14:35:57 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20190121063556.GA21693@tiger-server>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<c253d77e9366ae0992341978dd1287efa213611b.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116105336-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116105336-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V9 2/6] memory: use sparse feature define
 RAM_FLAG.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On 2019-01-16 at 10:55:33 -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 16, 2019 at 04:10:29PM +0800, Zhang Yi wrote:
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> OK so if you apply this patch, do you get
> any sparse warning at all?
Didn't get any sparse warning.
> 
> If not how come?
> 
> And we need to ask patchew maintainers to 
> 
> Overall I'd suggest that since you no longer need
> a new RAM flag, split this effort out and finish
> MAP_SYNC work first.
Ok, Will
> 
> 
> > ---
> >  include/exec/memory.h | 12 ++++++------
> >  include/qemu/osdep.h  |  9 +++++++++
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 667466b..03824d9 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -104,27 +104,27 @@ struct IOMMUNotifier {
> >  typedef struct IOMMUNotifier IOMMUNotifier;
> >  
> >  /* RAM is pre-allocated and passed into qemu_ram_alloc_from_ptr */
> > -#define RAM_PREALLOC   (1 << 0)
> > +#define RAM_PREALLOC ((QEMU_FORCE QemuMmapFlags) (1 << 0))
> >  
> >  /* RAM is mmap-ed with MAP_SHARED */
> > -#define RAM_SHARED     (1 << 1)
> > +#define RAM_SHARED ((QEMU_FORCE QemuMmapFlags) (1 << 1))
> >  
> >  /* Only a portion of RAM (used_length) is actually used, and migrated.
> >   * This used_length size can change across reboots.
> >   */
> > -#define RAM_RESIZEABLE (1 << 2)
> > +#define RAM_RESIZEABLE ((QEMU_FORCE QemuMmapFlags) (1 << 2))
> >  
> >  /* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
> >   * zero the page and wake waiting processes.
> >   * (Set during postcopy)
> >   */
> > -#define RAM_UF_ZEROPAGE (1 << 3)
> > +#define RAM_UF_ZEROPAGE ((QEMU_FORCE QemuMmapFlags) (1 << 3))
> >  
> >  /* RAM can be migrated */
> > -#define RAM_MIGRATABLE (1 << 4)
> > +#define RAM_MIGRATABLE ((QEMU_FORCE QemuMmapFlags) (1 << 4))
> >  
> >  /* RAM is a persistent kind memory */
> > -#define RAM_PMEM (1 << 5)
> > +#define RAM_PMEM ((QEMU_FORCE QemuMmapFlags) (1 << 5))
> >  
> >  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
> >                                         IOMMUNotifierFlag flags,
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 3bf48bc..457d24e 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -185,6 +185,15 @@ extern int daemon(int, int);
> >  #define ESHUTDOWN 4099
> >  #endif
> >  
> > +#ifdef __CHECKER__
> > +#define QEMU_BITWISE __attribute__((bitwise))
> > +#define QEMU_FORCE   __attribute__((force))
> > +#else
> > +#define QEMU_BITWISE
> > +#define QEMU_FORCE
> > +#endif
> > +
> > +typedef unsigned QEMU_BITWISE QemuMmapFlags;
> >  /* time_t may be either 32 or 64 bits depending on the host OS, and
> >   * can be either signed or unsigned, so we can't just hardcode a
> >   * specific maximum value. This is not a C preprocessor constant,
> > -- 
> > 2.7.4
