Received: from eggs.gnu.org ([2001:4830:134:3::10]:40909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU3OZ-0008Fd-6D
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU3OV-0003uY-9A
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:28:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cU3OV-0003tO-0v
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:28:11 -0500
Date: Thu, 19 Jan 2017 11:28:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170119032805.GB4914@pxdev.xzpeter.org>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<2163e04a-68cb-6c49-61bf-71c9e32e0487@redhat.com>
	<b9d04ac2-1978-1821-abdf-d73ef80276e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9d04ac2-1978-1821-abdf-d73ef80276e4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 19, 2017 at 10:50:59AM +0800, Jason Wang wrote:

[...]

> >>+static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
> >>+                                          VTDInvDesc *inv_desc)
> >>+{
> >>+    VTDAddressSpace *vtd_dev_as;
> >>+    IOMMUTLBEntry entry;
> >>+    struct VTDBus *vtd_bus;
> >>+    hwaddr addr;
> >>+    uint64_t sz;
> >>+    uint16_t sid;
> >>+    uint8_t devfn;
> >>+    bool size;
> >>+    uint8_t bus_num;
> >>+
> >>+    addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
> >>+    sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
> >>+    devfn = sid & 0xff;
> >>+    bus_num = sid >> 8;
> >>+    size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
> >>+
> >>+    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
> >>+        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
> >>+        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Device "
> >>+                    "IOTLB Invalidate Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
> >>+                    inv_desc->hi, inv_desc->lo);
> >>+        return false;
> >>+    }
> >>+
> >>+    vtd_bus = vtd_find_as_from_bus_num(s, bus_num);
> >>+    if (!vtd_bus) {
> >>+        goto done;
> >>+    }
> >>+
> >>+    vtd_dev_as = vtd_bus->dev_as[devfn];
> >>+    if (!vtd_dev_as) {
> >>+        goto done;
> >>+    }
> >>+
> >>+    if (size) {
> >>+        sz = 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);
> >This should be 1ULL.
> 
> Yes.
> 
> >   It could also be converted to cto64:
> >
> >(VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT)
> >
> >Here, I'm shifting addr right to avoid the case of an addr that is all ones.
> >
> >It probably could use a comment too. :)  The examples in table 2-4 of
> >the PCIe ATS specification are useful:
> >
> >	S = 0, bits 15:12 = xxxx     range size: 4K
> >	S = 1, bits 15:12 = xxx0     range size: 8K
> >	S = 1, bits 15:12 = xx01     range size: 16K
> >	S = 1, bits 15:12 = x011     range size: 32K
> >	S = 1, bits 15:12 = 0111     range size: 64K
> >
> >         and so on
> 
> This seems simpler let me add them comment and convert it to cto64.
> 
> >
> >>+        addr &= ~(sz - 1);

[1]

> >>+    } else {
> >>+        sz = VTD_PAGE_SIZE;
> >>+    }
> >>+    entry.target_as = &vtd_dev_as->as;
> >>+    entry.addr_mask = sz - 1;
> >>+    entry.iova = addr;
> >If S=1, entry.iova must mask away the 1 bits that specified the size.
> >For example,
> >
> >      addr = 0xabcd1000
> >
> >has cto64(0xabcd1) == 1, so it indicates a 16K invalidation from
> >0xabcd0000 to 0xabcd3fff.  The "1" must be masked away with "addr & -sz"
> >or "addr & ~entry.addr_mask".
> >
> >Thanks,
> >
> >Paolo
> 
> Good catch.
> 
> Let me fix it.

Is above [1] doing that?

Thanks,

-- peterx
