Received: from eggs.gnu.org ([2001:4830:134:3::10]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ekA7U-0004DI-5M
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ekA7P-0006Oa-AD
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:57:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:18302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1ekA7P-0006Nt-06
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:57:39 -0500
Date: Fri, 9 Feb 2018 22:57:26 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180209145726.55ushghorccxne47@hz-desktop>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-5-haozhong.zhang@intel.com>
	<20180209142740.GA3390@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209142740.GA3390@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] mem/nvdimm: ensure write
 persistence to PMEM in label emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Dan Williams <dan.j.williams@intel.com>

On 02/09/18 14:27 +0000, Stefan Hajnoczi wrote:
> On Wed, Feb 07, 2018 at 03:33:27PM +0800, Haozhong Zhang wrote:
> > @@ -156,11 +157,17 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
> >  {
> >      MemoryRegion *mr;
> >      PCDIMMDevice *dimm = PC_DIMM(nvdimm);
> > +    bool is_pmem = object_property_get_bool(OBJECT(dimm->hostmem),
> > +                                            "pmem", NULL);
> >      uint64_t backend_offset;
> >  
> >      nvdimm_validate_rw_label_data(nvdimm, size, offset);
> >  
> > -    memcpy(nvdimm->label_data + offset, buf, size);
> > +    if (!is_pmem) {
> > +        memcpy(nvdimm->label_data + offset, buf, size);
> > +    } else {
> > +        pmem_memcpy_persist(nvdimm->label_data + offset, buf, size);
> > +    }
> 
> Is this enough to prevent label corruption in case of power failure?
> 
> pmem_memcpy_persist() is not atomic.  Power failure can result in a mix
> of the old and new label data.
> 
> If we want this operation to be 100% safe there needs to be some kind of
> update protocol that makes the change atomic, like a Label A and Label B
> area with a single Label Index field that can be updated atomically to
> point to the active Label A/B area.

All this patch series is to guarantee: if the guest is still alive and
running, all its previous writes to pmem, which were performed by
QEMU, will be still persistent on pmem.

If a power failure happens before QEMU returns to the guest, e.g., in
the middle of above pmem_memcpy_persist(), yes, the guest label data
may be in an inconsistent state, but the guest also has no chance to
progress.  And, that is what could happen in the non-virtualization
environment as well, and it's the responsibility of the (guest) SW to
defend such failures, e.g., by the protocol you mentioned.

Haozhong
