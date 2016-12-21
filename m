Received: from eggs.gnu.org ([2001:4830:134:3::10]:42081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJj6a-0002HR-Ep
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJj6Z-0002YD-Jf
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:47:00 -0500
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-4-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <405aa216-ab28-51e3-c81c-78a841605c01@redhat.com>
Date: Wed, 21 Dec 2016 16:46:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161220163139.12016-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] util: Add VFIO helper library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Karl Rister <krister@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>



On 20/12/2016 17:31, Fam Zheng wrote:
> +    hbitmap_iter_init(&iter, s->free_chunks, 1);
> +    if (contiguous) {
> +        while (true) {
> +            bool satisfy = true;
> +            next = hbitmap_iter_next(&iter);
> +            if (next < 0) {
> +                return NULL;
> +            }
> +            for (i = 1; i < chunks; i++) {
> +                if (!hbitmap_get(s->free_chunks, next + i)) {
> +                    satisfy = false;
> +                    break;
> +                }
> +            }
> +            if (satisfy) {
> +                break;
> +            }
> +        }
> +        hbitmap_reset(s->free_chunks, next, chunks);
> +        r = g_new(IOVARange, 1);
> +        r->iova = next * pages_per_chunk * getpagesize();
> +        r->nr_pages = pages;
> +        QSIMPLEQ_INSERT_TAIL(&m.iova_list, r, next);
> +    } else {
> +        next = hbitmap_iter_next(&iter);
> +        while (pages) {
> +            uint64_t chunk;
> +            if (next < 0) {
> +                hbitmap_iter_init(&iter, s->free_chunks, 1);
> +                next = hbitmap_iter_next(&iter);
> +            }
> +            assert(next >= 0);
> +            chunk = next;
> +            DPRINTF("using chunk %ld\n", chunk);
> +            next = hbitmap_iter_next(&iter);
> +            hbitmap_reset(s->free_chunks, chunk, 1);
> +            if (r && r->iova + r->nr_pages == chunk * pages_per_chunk) {
> +                r->nr_pages += MIN(pages, pages_per_chunk);
> +            } else {
> +                r = g_new(IOVARange, 1);
> +                r->iova = chunk * pages_per_chunk * getpagesize();
> +                r->nr_pages = MIN(pages, pages_per_chunk);
> +                QSIMPLEQ_INSERT_TAIL(&m.iova_list, r, next);
> +            }
> +            pages -= MIN(pages, pages_per_chunk);
> +        }

I'm not sure HBitmap tracking is useful.  If we exhaust the IOVA space,
we can just throw everything away with a single VFIO_IOMMU_UNMAP_DMA.
Then replay the RAMBlockNotifier mappings (we need to add this anyway
for hotplug support) and keep on mapping lazily whatever comes later.

Thanks,

Paolo
