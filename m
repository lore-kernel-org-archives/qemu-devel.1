Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF12C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77A7224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqj0gmhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77A7224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmih-0001D5-Ro
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1icmi1-0000hG-79
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1icmi0-0002tj-0O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:42:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1icmhl-0002WJ-D5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575535304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWzU1D6brfrqeWW9oo+vPzM9VdKyFyvRG4TgMO+1RUw=;
 b=cqj0gmhxSR7iftuFooTxDWPxylJ3zTsZyLjMEv/Hlivj81FwovJownIJiV424NQkYQuQnc
 XkXO3HWuMJOBixu+cWPBsDz+FZ2Na/KDmFgouSMb5ls6MIms2ZTPXDTeIGKd3y1JiQrbSe
 MI8xRsmg3VBYhDqnB/rvQ/kMY6OggEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-6JD909Y4MhyCz5GoWs41Sg-1; Thu, 05 Dec 2019 03:41:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6422964A7D;
 Thu,  5 Dec 2019 08:41:40 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82FE85C1B5;
 Thu,  5 Dec 2019 08:41:39 +0000 (UTC)
Subject: Re: [PATCH 2/5] hw/arm/smmuv3: Check stream IDs against actual table
 LOG2SIZE
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-3-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1a0656ce-5da0-2251-1304-1ee0e683b887@redhat.com>
Date: Thu, 5 Dec 2019 09:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1575467748-28898-3-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6JD909Y4MhyCz5GoWs41Sg-1
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
> When checking whether a stream ID is in range of the stream table, we
> have so far been only checking it against our implementation limit
> (SMMU_IDR1_SIDSIZE). However, the guest can program the
> STRTAB_BASE_CFG.LOG2SIZE field to a size that is smaller than this
> limit.
> 
> Check the stream ID against this limit as well to match the hardware
> behavior of raising C_BAD_STREAMID events in case the limit is exceeded.
> 
> ref. ARM IHI 0070C, section 6.3.24.
> 
> Signed-off-by: Simon Veith <sveith@amazon.de>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/smmuv3.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index eef9a18..aad4639 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -377,11 +377,15 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>                           SMMUEventInfo *event)
>  {
>      dma_addr_t addr;
> +    uint32_t log2size;
>      int ret;
>  
>      trace_smmuv3_find_ste(sid, s->features, s->sid_split);
> -    /* Check SID range */
> -    if (sid > (1 << SMMU_IDR1_SIDSIZE)) {
> +    log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
> +    /*
> +     * Check SID range against both guest-configured and implementation limits
> +     */
> +    if (sid > (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {I think this should be sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))

If you agree can you fix it at the same time?
>          event->type = SMMU_EVT_C_BAD_STREAMID;
>          return -EINVAL;
>      }
> 

Thanks

Eric


