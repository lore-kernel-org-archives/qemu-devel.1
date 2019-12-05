Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B32C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C2B2464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YobArq7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C2B2464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icoaL-0004jy-9J
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1icoYF-0003dP-0O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1icoYD-0000h3-KB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:40:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1icoYD-0000e0-D3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575542400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWPcJ3ALPwUSQ0HyCh09oGg4lLyEV91wWtHkL2sGBRc=;
 b=YobArq7K3oaJmIYzGytQDxm5EXMo8kbxX0hRNKBSeK7w2YPVp8ZLTdQ+6OGlr+KG/Pfzpt
 B1qIVcHNqWUQd5Gd7J0T8SFiU1mdFAYxP3nGvCUksU2IFmCJo9P3nvUEcwhyqQ55A/W+YI
 E3Vpg2cLLyFGZtfj1YOgThIAxxMVlbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-ZNbHaoY1OZuFyVuHb8N5Mw-1; Thu, 05 Dec 2019 05:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D76018543A3;
 Thu,  5 Dec 2019 10:39:58 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04814600F0;
 Thu,  5 Dec 2019 10:39:56 +0000 (UTC)
Subject: Re: [PATCH 3/5] hw/arm/smmuv3: Align stream table base address to
 table size
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-4-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e6edab1a-25c3-3561-ea61-e2182a4391ad@redhat.com>
Date: Thu, 5 Dec 2019 11:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1575467748-28898-4-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZNbHaoY1OZuFyVuHb8N5Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simon,

On 12/4/19 2:55 PM, Simon Veith wrote:
> Per the specification, and as observed in hardware, the SMMUv3 aligns
> the SMMU_STRTAB_BASE address to the size of the table by masking out the
> respective least significant bits in the ADDR field.
> 
> Apply this masking logic to our smmu_find_ste() lookup function per the
> specification.
> 
> ref. ARM IHI 0070C, section 6.3.23.
> 
> Signed-off-by: Simon Veith <sveith@amazon.de>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/smmuv3.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index aad4639..2d6c275 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -376,8 +376,9 @@ bad_ste:
>  static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>                           SMMUEventInfo *event)
>  {
> -    dma_addr_t addr;
> +    dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> +    int strtab_size_shift;
>      int ret;
>  
>      trace_smmuv3_find_ste(sid, s->features, s->sid_split);
> @@ -391,10 +392,23 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>      }
>      if (s->features & SMMU_FEATURE_2LVL_STE) {
>          int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
> -        dma_addr_t strtab_base, l1ptr, l2ptr;
> +        dma_addr_t l1ptr, l2ptr;
>          STEDesc l1std;
>  
> -        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK;
> +        /*
> +         * Align strtab base address to table size. For this purpose, assume it
> +         * is not bounded by SMMU_IDR1_SIDSIZE.
> +         */
> +        strtab_size_shift = log2size - s->sid_split - 1 + 3;
Maybe just as the spec use MAX(5, (LOG2SIZE-SPLIT-1+3))?
> +        if (strtab_size_shift < DMA_ADDR_BITS) {
> +            if (strtab_size_shift < 5) {
> +                strtab_size_shift = 5;
> +            }
> +            strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
> +                          ~((1ULL << strtab_size_shift) - 1);
nit: you may use ~MAKE_64BIT_MASK(0, strtab_size_shift)
> +        } else {
see below
> +            strtab_base = 0;
> +        }
>          l1_ste_offset = sid >> s->sid_split;
>          l2_ste_offset = sid & ((1 << s->sid_split) - 1);
>          l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
> @@ -433,7 +447,14 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>          }
>          addr = l2ptr + l2_ste_offset * sizeof(*ste);
>      } else {
> -        addr = (s->strtab_base & SMMU_BASE_ADDR_MASK) + sid * sizeof(*ste);
> +        strtab_size_shift = log2size + 5;
> +        if (strtab_size_shift < DMA_ADDR_BITS) {
> +            strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
> +                          ~((1ULL << strtab_size_shift) - 1);
> +        } else {
Can it happen? I understand LOG2SIZE <= SMMU_S_IDR_5.SIDSIZE
and SIDSIZE is max 32. Same above?
> +            strtab_base = 0;
> +        }
> +        addr = strtab_base + sid * sizeof(*ste);
>      }
>  
>      if (smmu_get_ste(s, addr, ste, event)) {
> 
Thank you for those series fixes.

Best Regards

Eric


