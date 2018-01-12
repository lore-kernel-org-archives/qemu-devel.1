Received: from eggs.gnu.org ([2001:4830:134:3::10]:47386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZo91-0003Wx-Vj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 20:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZo91-0006ty-3V
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 20:28:31 -0500
Date: Fri, 12 Jan 2018 09:28:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180112012814.GA29151@lemon.usersys.redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-3-famz@redhat.com>
	<20180110165244.GC24212@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110165244.GC24212@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 2/9] util: Introduce vfio helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, 01/10 16:52, Stefan Hajnoczi wrote:
> On Wed, Jan 10, 2018 at 05:18:39PM +0800, Fam Zheng wrote:
> > +/* Map [host, host + size) area into a contiguous IOVA address space, and store
> > + * the result in @iova if not NULL. The caller need to make sure the area is
> > + * aligned to page size, and mustn't overlap with existing mapping areas (split
> > + * mapping status within this area is not allowed).
> > + */
> > +int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
> > +                      bool temporary, uint64_t *iova)
> > +{
> > +    int ret = 0;
> > +    int index;
> > +    IOVAMapping *mapping;
> > +    uint64_t iova0;
> > +
> > +    assert(QEMU_PTR_IS_ALIGNED(host, getpagesize()));
> > +    assert(QEMU_IS_ALIGNED(size, getpagesize()));
> > +    trace_qemu_vfio_dma_map(s, host, size, temporary, iova);
> > +    qemu_mutex_lock(&s->lock);
> > +    mapping = qemu_vfio_find_mapping(s, host, &index);
> > +    if (mapping) {
> > +        iova0 = mapping->iova + ((uint8_t *)host - (uint8_t *)mapping->host);
> > +    } else {
> > +        if (s->high_water_mark - s->low_water_mark + 1 < size) {
> > +            ret = -ENOMEM;
> > +            goto out;
> > +        }
> > +        if (!temporary) {
> > +            iova0 = s->low_water_mark;
> > +            mapping = qemu_vfio_add_mapping(s, host, size, index + 1, iova0);
> > +            if (!mapping) {
> > +                ret = -ENOMEM;
> > +                goto out;
> > +            }
> > +            assert(qemu_vfio_verify_mappings(s));
> > +            ret = qemu_vfio_do_mapping(s, host, size, iova0);
> > +            if (ret) {
> > +                qemu_vfio_undo_mapping(s, mapping, NULL);
> > +                goto out;
> > +            }
> > +            s->low_water_mark += size;
> > +            qemu_vfio_dump_mappings(s);
> > +        } else {
> > +            iova0 = s->high_water_mark - size;
> > +            ret = qemu_vfio_do_mapping(s, host, size, iova0);
> > +            if (ret) {
> > +                goto out;
> > +            }
> > +            s->high_water_mark -= size;
> > +        }
> > +    }
> > +    if (iova) {
> > +        *iova = iova0;
> > +    }
> > +    qemu_mutex_unlock(&s->lock);
> > +out:
> 
> Unlock needs to be here to avoid leaking the lock.

Yes, will fix.

Fam
