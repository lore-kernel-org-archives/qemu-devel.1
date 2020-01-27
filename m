Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CFC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AE520842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxQHMGKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AE520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivznL-0004bE-6O
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivzmY-0003b9-G4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivzmW-0002IF-Vb
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:30:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivzmW-0002Gt-S7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580113803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDFiPwB3g7qXtkl/qjLNFZ6iknAFbfpVNydSC/I8930=;
 b=RxQHMGKx2TSneHJMonsstZNBXhufQK8y2HdZQx/Q5f+NFAbMf98JYHpBVJxBDGZgXqwepO
 0F7xqNuj5JGVllo7+aqpatHvuGXiPrca6Qt49qxDINtdaoKI5dim0O26sL+oeSsUH3uAkK
 ntNmK9BdGlu7nxsxHMm5VgHxcOLEkqc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-SW84JxFMOiODcjlo0Ui3sA-1; Mon, 27 Jan 2020 03:30:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so5715125wrr.20
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aDFiPwB3g7qXtkl/qjLNFZ6iknAFbfpVNydSC/I8930=;
 b=qY0Xz8xOxKZ+SAUTBjcSVvI8IQNlOsIh/i4o/We25WQC0pYpQAWjF9hTRxrjiJNgMA
 0Bgi3K5CeX475k5NtnbwduMKD8IzIdUjyjjf32lFskSFTN85zXTxwIkFCMQFqGx114VA
 5oX2hAk9MmUXY7FWvTY4+AF1lET10ziIJpBf1Va5Vo54zoUzQ1CyWrRqD/WZ2MhCvOsT
 qup1AlHym8FLMM+3BMVzxa3Vp55U02gyMEv1qlK8bMhTBdCyjHSMutu0KVh3CxJIqL1l
 KWyvGsCyfUkl69LeCAoet1NvuZfKUqZmZUkpYwBWKaVo0bv9wn8Fo1BHnh8zdfnOksPs
 USdQ==
X-Gm-Message-State: APjAAAVOy2adUI3wf/jsMjWujilY6M63/soWpcTHjXCrmCY+dgMksQFx
 dkzcDVuBkhrCQ/MWtEz1AExf/RdAtfnsO18Jrr/gYccYxsrmpRiTEg1D3afwgUoFL8u3XDsyr5T
 /JpBrYj4OdWzdCzw=
X-Received: by 2002:adf:f18b:: with SMTP id h11mr21619825wro.56.1580113801263; 
 Mon, 27 Jan 2020 00:30:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqymZuRFhovgJfKX4mNY6IOppddHndRu/IRUlXKJOLNPuIJTaMlwoQ4dDOI5d4ywcyNc+gMp4A==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr21619807wro.56.1580113801065; 
 Mon, 27 Jan 2020 00:30:01 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q6sm21437416wrx.72.2020.01.27.00.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 00:30:00 -0800 (PST)
Subject: Re: [PATCH] bcm2835_dma: Fix TD mode
To: Rene Stange <rsta2@o2online.de>, qemu-devel@nongnu.org
References: <5099495.CBsx362VbF@desktop2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9d885f77-0bb2-2ab6-cf46-400a0bc2deb8@redhat.com>
Date: Mon, 27 Jan 2020 09:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5099495.CBsx362VbF@desktop2>
Content-Language: en-US
X-MC-Unique: SW84JxFMOiODcjlo0Ui3sA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Rene,

On 1/24/20 6:55 PM, Rene Stange wrote:
> TD (two dimensions) DMA mode did not work, because the xlen variable has
> not been re-initialized before each additional ylen run through in
> bcm2835_dma_update(). Furthermore ylen has to be increased by one after
> reading it from the TXFR_LEN register, because a value of zero has to
> result in one run through of the ylen loop. Both issues have been fixed.

What were you running, how can we reproduce?

> 
> Signed-off-by: Rene Stange <rsta2@o2online.de>
> ---
>   hw/dma/bcm2835_dma.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 1e458d7fba..0881c9506e 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -54,7 +54,7 @@
>   static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
>   {
>       BCM2835DMAChan *ch = &s->chan[c];
> -    uint32_t data, xlen, ylen;
> +    uint32_t data, xlen, xlen_td, ylen;
>       int16_t dst_stride, src_stride;
>   
>       if (!(s->enable & (1 << c))) {
> @@ -72,13 +72,13 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
>   
>           if (ch->ti & BCM2708_DMA_TDMODE) {
>               /* 2D transfer mode */
> -            ylen = (ch->txfr_len >> 16) & 0x3fff;
> -            xlen = ch->txfr_len & 0xffff;
> +            ylen = ((ch->txfr_len >> 16) & 0x3fff) + 1;
> +            xlen_td = xlen = ch->txfr_len & 0xffff;
>               dst_stride = ch->stride >> 16;
>               src_stride = ch->stride & 0xffff;
>           } else {
>               ylen = 1;
> -            xlen = ch->txfr_len;
> +            xlen_td = xlen = ch->txfr_len;
>               dst_stride = 0;
>               src_stride = 0;
>           }
> @@ -117,6 +117,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
>               if (--ylen != 0) {
>                   ch->source_ad += src_stride;
>                   ch->dest_ad += dst_stride;
> +                xlen = xlen_td;
>               }
>           }
>           ch->cs |= BCM2708_DMA_END;
> 


