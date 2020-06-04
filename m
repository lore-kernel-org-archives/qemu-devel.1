Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D810A206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jyf64yu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D810A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguEc-0008Tz-5n
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguDz-0007mf-TG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:04:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguDy-0001WB-22
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591293856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hciRLof/ytfpuZzNAyDKskjD6/DGq9nEEqOhYjHw+G4=;
 b=Jyf64yu7ztlCT8lPAsq/x1Mgepd7HbAsU6UtyAHyj0JT/d8+KLA60FHcWPyw/6pBYpsZ5e
 mYOEcBNgM9SCJ6ULnzCagFc7PEv5fo/k5Cg6vOXYj1SfN1PyBVRvfDNBiZTfpnnrlk2AES
 EBX2UHXPwqF9vE1WWodxHCyNV0Ps1yg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-xsWzHjVFPeK98L5NPUGU9g-1; Thu, 04 Jun 2020 14:04:02 -0400
X-MC-Unique: xsWzHjVFPeK98L5NPUGU9g-1
Received: by mail-wr1-f71.google.com with SMTP id j16so2703786wre.22
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hciRLof/ytfpuZzNAyDKskjD6/DGq9nEEqOhYjHw+G4=;
 b=TPkuTkEmRJU1Dd0BPFzO4x+5xM0MaDabJUokMsoDROD6Z1uu6AT65YarRVoy1WJC/k
 1utBfRXsXl3y3KZMVdSZBzLFB7L8ftlL2B/wQmlzbnGEdbooNol62Qhd/HNO2maEAuUz
 o5tTEBX5L63/V2AA2kSpLj9gHZ9pyv1mvuseaZ1V40vtnQC5oZUwpY8XXUB8wMRkKGlM
 BXP1pLRR75RdagE9s5oIkVQoLnAhZbZ+veTEdcoRVEf3QZtyKIMvP+CtCEoJ4jPqrr0z
 Km8Z6ePLUbrro/gfV+ycEYScn7DGP9pPB/JlGASlsarbQF3Axp5tClrc5sHdCDemnYAr
 GA0g==
X-Gm-Message-State: AOAM5328z9NGkNG8KimBRpE9oCuQ3onBMfpooVdVQwkgRDYVa4fWqdkW
 5ZmagtKasctvLdGrkV93tzFBwPLdKhKm1LKEdrmGho1cw+Thzxkqp40NXTel3nU+sQuzSFf7cqN
 cshZKDrqvYQSR7k4=
X-Received: by 2002:adf:f208:: with SMTP id p8mr5005231wro.388.1591293841560; 
 Thu, 04 Jun 2020 11:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWHdaDS67Fqcv6e3h1/2+0kN9R6Ii9wM9dV+ofXXRcXCrVk98Fooc3F9ucnh4BAeQDrjJGOA==
X-Received: by 2002:adf:f208:: with SMTP id p8mr5005216wro.388.1591293841331; 
 Thu, 04 Jun 2020 11:04:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id z2sm8594386wrs.87.2020.06.04.11.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:03:56 -0700 (PDT)
Subject: Re: [PATCH] hw/sd/sdcard: Verify CMD24 (Block Write) address is valid
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200604173410.21074-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <980fde76-8e26-c5bc-a708-317997f4e329@redhat.com>
Date: Thu, 4 Jun 2020 20:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604173410.21074-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, 1880822@bugs.launchpad.net,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/20 19:34, Philippe Mathieu-Daudé wrote:
> Avoid OOB access by verifying the requested address belong to
> the actual card size. Return ADDRESS_ERROR when not in range.
> 
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
> 
>   4.3.4 Data Write
> 
>   * Block Write
> 
>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
> 
> Fixes: CVE-2020-13253
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3c06a0ac6d..0ced3b5e14 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1211,6 +1211,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> +            if (addr >= sd->size) {
> +                sd->card_status |= ADDRESS_ERROR;
> +                return sd_r1;
> +            }
>              sd->state = sd_receivingdata_state;
>              sd->data_start = addr;
>              sd->data_offset = 0;
> 

I'm not sure if you want me to queue it, but I did.  Probably we should
add qemu-block@nongnu.org to the hw/sd stanza.

Paolo


