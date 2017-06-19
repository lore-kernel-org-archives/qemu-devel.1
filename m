Received: from eggs.gnu.org ([2001:4830:134:3::10]:47612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMqOe-0008Bd-UL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 02:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMqOb-0008Lm-RK
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 02:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMqOb-0008L7-H3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 02:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24369624BB
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 06:42:44 +0000 (UTC)
Date: Mon, 19 Jun 2017 14:42:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170619064235.GB16787@pxdev.xzpeter.org>
References: <20170616114443.25838-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616114443.25838-1-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: relax iq tail check on
 VTD_GCMD_QIE enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Fri, Jun 16, 2017 at 01:44:43PM +0200, Ladi Prosek wrote:
> The VT-d spec (section 6.5.2) prescribes software to zero the
> Invalidation Queue Tail Register before enabling the VTD_GCMD_QIE
> Global Command Register bit. Windows Server 2012 R2 and possibly
> other older Windows versions violate the protocol and set a
> non-zero queue tail first, which in effect makes them crash early
> on boot with -device intel-iommu,intremap=on.
> 
> This commit relaxes the check and instead of failing to enable
> VTD_GCMD_QIE with "error: can't enable Queued Invalidation", it
> behaves as if the tail register was set just after enabling
> VTD_GCMD_QIE (see vtd_handle_iqt_write).
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 15610b9..f2cb822 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1466,10 +1466,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
>      return iaig;
>  }
>  
> -static inline bool vtd_queued_inv_enable_check(IntelIOMMUState *s)
> -{
> -    return s->iq_tail == 0;
> -}
> +static void vtd_fetch_inv_desc(IntelIOMMUState *s);
>  
>  static inline bool vtd_queued_inv_disable_check(IntelIOMMUState *s)
>  {
> @@ -1483,19 +1480,20 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
>  
>      VTD_DPRINTF(INV, "Queued Invalidation Enable %s", (en ? "on" : "off"));
>      if (en) {
> -        if (vtd_queued_inv_enable_check(s)) {
> -            s->iq = iqa_val & VTD_IQA_IQA_MASK;
> -            /* 2^(x+8) entries */
> -            s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
> -            s->qi_enabled = true;
> -            VTD_DPRINTF(INV, "DMAR_IQA_REG 0x%"PRIx64, iqa_val);
> -            VTD_DPRINTF(INV, "Invalidation Queue addr 0x%"PRIx64 " size %d",
> -                        s->iq, s->iq_size);
> -            /* Ok - report back to driver */
> -            vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_QIES);
> -        } else {
> -            VTD_DPRINTF(GENERAL, "error: can't enable Queued Invalidation: "
> -                        "tail %"PRIu16, s->iq_tail);
> +        s->iq = iqa_val & VTD_IQA_IQA_MASK;
> +        /* 2^(x+8) entries */
> +        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
> +        s->qi_enabled = true;
> +        VTD_DPRINTF(INV, "DMAR_IQA_REG 0x%"PRIx64, iqa_val);
> +        VTD_DPRINTF(INV, "Invalidation Queue addr 0x%"PRIx64 " size %d",
> +                    s->iq, s->iq_size);
> +        /* Ok - report back to driver */
> +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_QIES);
> +
> +        if (s->iq_tail != 0 &&
> +            !(vtd_get_long_raw(s, DMAR_FSTS_REG) & VTD_FSTS_IQE)) {
> +            VTD_DPRINTF(INV, "warning: QI enabled with non-zero tail");
> +            vtd_fetch_inv_desc(s);

Since looks like we need another post, a tiny suggestion is that we
can also add some comment to tell the reason why we didn't really
check it, and a trace_vtd_warn_invalid_qi_tail() tracer to show that
spec is violated (if you see, we have two other warnings already named
vtd_warn_ir_* which also helps on tracing spec violations).

I'll ack the next version after it's cooked. Thanks Ladi for the
patch!

Peter

>          }
>      } else {
>          if (vtd_queued_inv_disable_check(s)) {
> -- 
> 2.9.3
> 

-- 
Peter Xu
