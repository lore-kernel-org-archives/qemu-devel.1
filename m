Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4885AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049D5206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUMRm5YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049D5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblui-0005kl-6a
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbltz-0004oB-J3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:10:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jblty-0004Mv-J1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAD01X8GgRKarsj4gdEF0gEwqsuIYrf5MoJRIpRzHFY=;
 b=OUMRm5YLoSvDrinFeWQGkCDbff2sbRB6U1L9U4ES2KAGmboasnZYR6HJfD8fgPp4kn0sZ9
 LMiVgeAD5uQw7Liv28DoueDONFJUKC8Zxc0+KC0eiCOXR31wLCayZ74F1+fFuYFd0T6vIe
 t4eyvyMdHBxwTSJhj+ZNpw97m1SlVmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-TSjC85diNf-416lB9SRVgg-1; Thu, 21 May 2020 10:10:24 -0400
X-MC-Unique: TSjC85diNf-416lB9SRVgg-1
Received: by mail-wr1-f69.google.com with SMTP id e1so485658wrm.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dAD01X8GgRKarsj4gdEF0gEwqsuIYrf5MoJRIpRzHFY=;
 b=CRgSBzrxrhl9MzlxSwyffDezljhwFiyjtrddiY2wYMfixW2kIsXeIRAA0bg7mdL45S
 vah6KPWUHS2tHGBEvsRQYyFP8yWTp0eF++Ws08Wr5f/XGvwAQHCURaEjyKyDQRs3qzpS
 2WVAJjHKzfnB5sv4pRx22lvdsxf1gDOpDp5cpqs82Qu0PnHPDAs5k6AStcBu7wduwHFQ
 9NZpoMuN+fnKaXhnr8chmOL3ajXo20oV6fn2EmthyzDM6Ds+XSZouMbCR+L66pNOjwa1
 1ddU/QWtjiZeSVFgVOav8uLjaFcJsAYzz27hWjBntJ0UTMon6lj3pnzNiD6leFB5X9BL
 qDRA==
X-Gm-Message-State: AOAM5317O0/UXnm62V1nbu3o9x4JdptLnmJOE3go2maEFiLvNIKOiuUN
 jL5YE6ARmMxTdCuw69Yd4u3/oKP9HwO6975xvT+VHiMP3zbBEgNE5p6fH4dZHdQ+LdjzBF8IAYW
 ahr82cpYVLveAy4Q=
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr9001210wme.0.1590070222306;
 Thu, 21 May 2020 07:10:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUtqgKHKTCXjRPSiR3WJXo2HuUa3ZS8a6PQiw8Q58bOClaWls2nXFxBShDmtR3A3d1xXNQhA==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr9001188wme.0.1590070222108;
 Thu, 21 May 2020 07:10:22 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n65sm5884594wmb.48.2020.05.21.07.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:10:21 -0700 (PDT)
Subject: Re: [PATCH 3/6] sm501: Use BIT(x) macro to shorten constant
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1589981990.git.balaton@eik.bme.hu>
 <6c63555cc4023d05e550d513112f472a2020a117.1589981990.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68a23558-5bf2-8d91-a490-1c631f9a881a@redhat.com>
Date: Thu, 21 May 2020 16:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6c63555cc4023d05e550d513112f472a2020a117.1589981990.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:39 PM, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/sm501.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index f42d05e1e4..97660090bb 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -701,7 +701,7 @@ static void sm501_2d_operation(SM501State *s)
>   {
>       /* obtain operation parameters */
>       int cmd = (s->twoD_control >> 16) & 0x1F;
> -    int rtl = s->twoD_control & 0x8000000;
> +    int rtl = s->twoD_control & BIT(27);
>       int src_x = (s->twoD_source >> 16) & 0x01FFF;
>       int src_y = s->twoD_source & 0xFFFF;
>       int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
> @@ -751,8 +751,7 @@ static void sm501_2d_operation(SM501State *s)
>           }
>       }
>   
> -    if ((s->twoD_source_base & 0x08000000) ||
> -        (s->twoD_destination_base & 0x08000000)) {
> +    if (s->twoD_source_base & BIT(27) || s->twoD_destination_base & BIT(27)) {
>           qemu_log_mask(LOG_UNIMP, "sm501: only local memory is supported.\n");
>           return;
>       }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


