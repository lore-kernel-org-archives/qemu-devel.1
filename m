Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8294E20716
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgYVJT2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8294E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih9Lm-00057x-MW
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 04:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ih9L8-0004VS-6I
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ih9L5-0004zi-Ue
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:40:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ih9L5-0004zY-Rb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576575623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtKy5mnNV7pDyud3HaDZYd/omSd7p3W/KoK9NNhXKOk=;
 b=dgYVJT2LwvTudmCFQPzWIJPHSeeQUkIH7cWyBHcLHW8zH7gt/aMZcqPPpRJk8ExoThXBxM
 +w+TqaulNTtC+247YUe2DPDF2IYSxXp6FLGed3CdnOG2/nw1vRrnpApeIcbwsmaZR2MQaR
 vEQrb+MGkXH/yUWls4RLy+HbjnvIOlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-JgchU4QeMq6aXlw9Hs__2w-1; Tue, 17 Dec 2019 04:40:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F40921809A29;
 Tue, 17 Dec 2019 09:40:18 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F30505D9E2;
 Tue, 17 Dec 2019 09:40:17 +0000 (UTC)
Subject: Re: [PATCH v3 4/6] hw/arm/smmuv3: Align stream table base address to
 table size
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1576509312-13083-1-git-send-email-sveith@amazon.de>
 <1576509312-13083-5-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <48ccf9fe-eb28-d138-7de7-3c658c5458a4@redhat.com>
Date: Tue, 17 Dec 2019 10:40:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1576509312-13083-5-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: JgchU4QeMq6aXlw9Hs__2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/16/19 4:15 PM, Simon Veith wrote:
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
Looks good to me.

Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> Changed in v2:
> 
> * Now using MAKE_64BIT_MASK()
> * Eliminated unnecessary branches by using MAX()
> * Removed unnecessary range check against DMA_ADDR_BITS
> 
>  hw/arm/smmuv3.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 727558b..31ac3ca 100644
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
> @@ -391,10 +392,16 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
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
> +        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
> +        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
> +                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
>          l1_ste_offset = sid >> s->sid_split;
>          l2_ste_offset = sid & ((1 << s->sid_split) - 1);
>          l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
> @@ -433,7 +440,10 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>          }
>          addr = l2ptr + l2_ste_offset * sizeof(*ste);
>      } else {
> -        addr = (s->strtab_base & SMMU_BASE_ADDR_MASK) + sid * sizeof(*ste);
> +        strtab_size_shift = log2size + 5;
> +        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
> +                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
> +        addr = strtab_base + sid * sizeof(*ste);
>      }
>  
>      if (smmu_get_ste(s, addr, ste, event)) {
> 


