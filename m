Received: from eggs.gnu.org ([2001:4830:134:3::10]:57157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eOZQL-0003Bj-0B
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eOZQG-0007zl-6k
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:31:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:9498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1eOZQF-0007xW-SH
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:31:52 -0500
Date: Tue, 12 Dec 2017 02:28:57 +0800
From: Chao Gao <chao.gao@intel.com>
Message-ID: <20171211182856.GA18476@op-computing>
References: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
	<1510899865-40323-3-git-send-email-chao.gao@intel.com>
	<20171211175908.GC2216@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211175908.GC2216@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] xen/pt: Pass the whole msi
 addr/data to Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>

On Mon, Dec 11, 2017 at 05:59:08PM +0000, Anthony PERARD wrote:
>On Fri, Nov 17, 2017 at 02:24:24PM +0800, Chao Gao wrote:
>> Previously, some fields (reserved or unalterable) are filtered by
>> Qemu. This fields are useless for the legacy interrupt format.
>> However, these fields are may meaningful (for intel platform)
>> for the interrupt of remapping format. It is better to pass the whole
>> msi addr/data to Xen without any filtering.
>> 
>> The main reason why we want this is QEMU doesn't have the knowledge
>> to decide the interrupt format after we introduce vIOMMU inside Xen.
>> Passing the whole msi message down and let arch-specific vIOMMU to
>> decide the interrupt format.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>> v3:
>>  - new
>> ---
>>  hw/xen/xen_pt_msi.c | 47 ++++++++++++-----------------------------------
>>  1 file changed, 12 insertions(+), 35 deletions(-)
>> 
>> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
>> index 6d1e3bd..f7d6e76 100644
>> --- a/hw/xen/xen_pt_msi.c
>> +++ b/hw/xen/xen_pt_msi.c
>> @@ -47,25 +47,6 @@ static inline uint32_t msi_ext_dest_id(uint32_t addr_hi)
>>      return addr_hi & 0xffffff00;
>>  }
>>  
>> -static uint32_t msi_gflags(uint32_t data, uint64_t addr)
>> -{
>> -    uint32_t result = 0;
>> -    int rh, dm, dest_id, deliv_mode, trig_mode;
>> -
>> -    rh = (addr >> MSI_ADDR_REDIRECTION_SHIFT) & 0x1;
>> -    dm = (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
>> -    dest_id = msi_dest_id(addr);
>> -    deliv_mode = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
>> -    trig_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
>> -
>> -    result = dest_id | (rh << XEN_PT_GFLAGS_SHIFT_RH)
>> -        | (dm << XEN_PT_GFLAGS_SHIFT_DM)
>> -        | (deliv_mode << XEN_PT_GFLAGSSHIFT_DELIV_MODE)
>> -        | (trig_mode << XEN_PT_GFLAGSSHIFT_TRG_MODE);
>> -
>> -    return result;
>> -}
>> -
>>  static inline uint64_t msi_addr64(XenPTMSI *msi)
>>  {
>>      return (uint64_t)msi->addr_hi << 32 | msi->addr_lo;
>> @@ -160,23 +141,20 @@ static int msi_msix_update(XenPCIPassthroughState *s,
>>                             bool masked)
>>  {
>>      PCIDevice *d = &s->dev;
>> -    uint8_t gvec = msi_vector(data);
>> -    uint32_t gflags = msi_gflags(data, addr);
>> +    uint32_t gflags = masked ? 0 : (1u << XEN_PT_GFLAGSSHIFT_UNMASKED);
>>      int rc = 0;
>>      uint64_t table_addr = 0;
>>  
>> -    XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
>> -               " (entry: %#x)\n",
>> -               is_msix ? "-X" : "", pirq, gvec, gflags, msix_entry);
>> +    XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x addr %"PRIx64
>> +               " data %#x gflags %#x (entry: %#x)\n",
>> +               is_msix ? "-X" : "", pirq, addr, data, gflags, msix_entry);
>>  
>>      if (is_msix) {
>>          table_addr = s->msix->mmio_base_addr;
>>      }
>>  
>> -    gflags |= masked ? 0 : (1u << XEN_PT_GFLAGSSHIFT_UNMASKED);
>> -
>> -    rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
>> -                                  pirq, gflags, table_addr);
>> +    rc = xc_domain_update_msi_irq(xen_xc, xen_domid, pirq, addr,
>> +                                  data, gflags, table_addr);
>
>Are you trying to modifie an existing API? That is not going to work. We
>want to be able to build QEMU against older version of Xen, and it
>should work as well.

Yes. I thought it didn't matter. And definitely, I was wrong. I will keep
compatibility by introducing a new API. A wapper function, which calls
the old or new API according to the Xen version, would be used here.

Thanks
Chao
