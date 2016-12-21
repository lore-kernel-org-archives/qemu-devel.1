Received: from eggs.gnu.org ([2001:4830:134:3::10]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJjcH-0000se-PL
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJjcG-00070U-Ov
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:19:45 -0500
Date: Thu, 22 Dec 2016 00:19:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161221161934.GA18068@lemon>
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-4-famz@redhat.com>
	<405aa216-ab28-51e3-c81c-78a841605c01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405aa216-ab28-51e3-c81c-78a841605c01@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] util: Add VFIO helper library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Karl Rister <krister@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 12/21 16:46, Paolo Bonzini wrote:
> 
> 
> On 20/12/2016 17:31, Fam Zheng wrote:
> > +    hbitmap_iter_init(&iter, s->free_chunks, 1);
> > +    if (contiguous) {
> > +        while (true) {
> > +            bool satisfy = true;
> > +            next = hbitmap_iter_next(&iter);
> > +            if (next < 0) {
> > +                return NULL;
> > +            }
> > +            for (i = 1; i < chunks; i++) {
> > +                if (!hbitmap_get(s->free_chunks, next + i)) {
> > +                    satisfy = false;
> > +                    break;
> > +                }
> > +            }
> > +            if (satisfy) {
> > +                break;
> > +            }
> > +        }
> > +        hbitmap_reset(s->free_chunks, next, chunks);
> > +        r = g_new(IOVARange, 1);
> > +        r->iova = next * pages_per_chunk * getpagesize();
> > +        r->nr_pages = pages;
> > +        QSIMPLEQ_INSERT_TAIL(&m.iova_list, r, next);
> > +    } else {
> > +        next = hbitmap_iter_next(&iter);
> > +        while (pages) {
> > +            uint64_t chunk;
> > +            if (next < 0) {
> > +                hbitmap_iter_init(&iter, s->free_chunks, 1);
> > +                next = hbitmap_iter_next(&iter);
> > +            }
> > +            assert(next >= 0);
> > +            chunk = next;
> > +            DPRINTF("using chunk %ld\n", chunk);
> > +            next = hbitmap_iter_next(&iter);
> > +            hbitmap_reset(s->free_chunks, chunk, 1);
> > +            if (r && r->iova + r->nr_pages == chunk * pages_per_chunk) {
> > +                r->nr_pages += MIN(pages, pages_per_chunk);
> > +            } else {
> > +                r = g_new(IOVARange, 1);
> > +                r->iova = chunk * pages_per_chunk * getpagesize();
> > +                r->nr_pages = MIN(pages, pages_per_chunk);
> > +                QSIMPLEQ_INSERT_TAIL(&m.iova_list, r, next);
> > +            }
> > +            pages -= MIN(pages, pages_per_chunk);
> > +        }
> 
> I'm not sure HBitmap tracking is useful.  If we exhaust the IOVA space,
> we can just throw everything away with a single VFIO_IOMMU_UNMAP_DMA.
> Then replay the RAMBlockNotifier mappings (we need to add this anyway
> for hotplug support) and keep on mapping lazily whatever comes later.

It's clever! It'd be a bit more complicated than that, though. Things like
queues etc in block/nvme.c have to be preserved, and if we already ensure that,
ram blocks can be preserved similarly, but indeed bounce buffers can be handled
that way. I still need to think about how to make sure none of the invalidated
IOVA addresses are in use by other requests.

Also I wonder how expensive the huge VFIO_IOMMU_UNMAP_DMA is. In the worst case
the "throwaway" IOVAs can be limited to a small range.

Fam

> 
> Thanks,
> 
> Paolo
