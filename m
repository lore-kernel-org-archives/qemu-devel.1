Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2881C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8213C207FD
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8km2NCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8213C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igF6v-0003hW-KS
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igF6C-00033h-D9
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igF6A-0000rJ-Tr
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:37:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igF6A-0000ot-OD
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576359433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+SweqZGhvvzDZQivmUzRPy/SYi+HoyBATJH5rDNahM=;
 b=F8km2NCM3+Dy4peZfESRxusXTC3GFeqN3RNyxXZKY1ej7TGgY8Kna+mmowT5bw+OICHur9
 c2ztmguR2622lRSTE/a0Pk+X+z3nVvHeJw+QcSHOtN9PAGQX34Ue7558HTs7s17yXmQ7e/
 poh8QgE2O8MEY0H/15RAumICcHJ9ZgU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-weW0zhShOIK3midi3LRvzw-1; Sat, 14 Dec 2019 08:35:38 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so351672wrq.12
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B+SweqZGhvvzDZQivmUzRPy/SYi+HoyBATJH5rDNahM=;
 b=jl30zviaJ6mhiq4tC5inx5RFpl9xrPh+soU9X6bBo7TUR3zGOcdIE1gcaqCNYZDDg1
 +H5MD/qFlWXVeZLWZlr0pffO0Ig4X3S/re4xv4nd35OM0OhuzcqNxrIv76JmPBScGRUz
 yv9EhasY9qjcFZnKipF3jTkyEgwZIEBssfFuPIeQB9qxoGzDZbLNVlghBpQM0LEvjGrx
 lxup8xl2zzOxswJeXhOGPx/6VRpwZkPMtOlHlWj35XM2KugJhGTWRhnL8zlXH3VlPqUy
 Pcd8arWua4szvFkMUMiVB6XPEBswz49oGuhCIjLoE+umwGvEEh9cXr4Uiqxa3yrvOCKx
 +cDg==
X-Gm-Message-State: APjAAAUWPA/2obbZp9aHwZHtjkKi1WwWLjKo2FVVlTvMnczscNga80ec
 cY+4yanLHqNaXcAloXFEtnXl6lfg/lxxlnOyCN4454/7biLzQV3mhZIXyxVplKzQOJvSZN7Ci7C
 yqFAijnmWOfeWkDM=
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr18167477wru.395.1576330536784; 
 Sat, 14 Dec 2019 05:35:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHVfBmEDF2xHMF8WyfJ3KE06mQMOgQ1iMaG41yut5+XtO8MXs7asbxU8yjoaOmqgcFlrXRUw==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr18167462wru.395.1576330536603; 
 Sat, 14 Dec 2019 05:35:36 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id s65sm14446825wmf.48.2019.12.14.05.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:35:35 -0800 (PST)
Subject: Re: [PATCH 01/10] dp8393x: Mask EOL bit from descriptor addresses
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <7d220205700c43b15d6ae6cefd6520a97c763709.1576286757.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f28e2ae-e3d1-d4b8-f753-c418b72293c6@redhat.com>
Date: Sat, 14 Dec 2019 14:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7d220205700c43b15d6ae6cefd6520a97c763709.1576286757.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: weW0zhShOIK3midi3LRvzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Herve Poussineau <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Finn,

On 12/14/19 2:25 AM, Finn Thain wrote:
> The LSB of descriptor address registers is used as an EOL flag.
> It has to be masked when those registers are to be used as actual
> addresses for copying memory around. But when the registers are
> to be updated the EOL bit should not be masked.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>   hw/net/dp8393x.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 3d991af163..164311c055 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -197,7 +197,7 @@ static uint32_t dp8393x_crba(dp8393xState *s)
>   
>   static uint32_t dp8393x_crda(dp8393xState *s)
>   {
> -    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
> +    return (s->regs[SONIC_URDA] << 16) | (s->regs[SONIC_CRDA] & 0xfffe);
>   }
>   
>   static uint32_t dp8393x_rbwc(dp8393xState *s)
> @@ -217,7 +217,7 @@ static uint32_t dp8393x_tsa(dp8393xState *s)
>   
>   static uint32_t dp8393x_ttda(dp8393xState *s)
>   {
> -    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
> +    return (s->regs[SONIC_UTDA] << 16) | (s->regs[SONIC_TTDA] & 0xfffe);
>   }
>   
>   static uint32_t dp8393x_wt(dp8393xState *s)
> @@ -506,8 +506,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>                                sizeof(uint16_t) *
>                                (4 + 3 * s->regs[SONIC_TFC]) * width,
>                   MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> -            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
> -            if (dp8393x_get(s, width, 0) & 0x1) {
> +            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0);
> +            if (s->regs[SONIC_CTDA] & 0x1) {

Can you add a definition for the EOL bit and use it, instead of these 
magic 0x1/0xfffe values? That way the meaning will be obvious for future 
reviewers.

Thanks,

Phil.

>                   /* EOL detected */
>                   break;
>               }
> 


