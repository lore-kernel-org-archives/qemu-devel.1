Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54325C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13832222F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F95OrGSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13832222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtML-0000Ht-Mg
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQtKp-0007gz-FX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQtKl-00069Z-Vo
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602253522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEgCb295nGJf+bxbOisbM2rQMfDEWKpR84WjsgHwmQY=;
 b=F95OrGSA8rehc6kpF+ZUhRoO2BSEaNuqyO3/02Ye7gZchr8eCIYDa1DqCmSohoksL+wMAz
 wo9t8jw/R1EXAhmh4Xjc/t4C+e2Xm570P+XfoDSvqXrDFs4nNLMOb/I2yKuiYFsbxgEjVx
 Waf7BVE0g5woCNsSzEWOgNDQe1n07eU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-YQu_ZgjlOu6AviLp-Nq3Jg-1; Fri, 09 Oct 2020 10:25:20 -0400
X-MC-Unique: YQu_ZgjlOu6AviLp-Nq3Jg-1
Received: by mail-wr1-f70.google.com with SMTP id e13so5268603wrj.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NEgCb295nGJf+bxbOisbM2rQMfDEWKpR84WjsgHwmQY=;
 b=fysnlTkB+kggJrn6WhnA4gb9ErrC9XtfN+IA7kjTCxoHLhLBjIZCM6ECM7VXCfW5Ru
 M3B5Y9cVeg8XKIWully86ldaCWidkRqfGzvxrnf3AuSaib0SQm/wFrNgJac0Zm77iGeK
 FdoFUi0za+60UZ201LerjiazKp2jHHtpmjMvmLMrvbDzuHA32dhIbvBRL+D1kc/oL+ll
 eDxZ0YtV78z9alFwWYwolflo1B/eDdNESzcZnUkMCn3agJ/BzYJ+caRjiq483O2E8UOE
 E5S0ePpjBqbbiYMzillTwcMgEqATnIc/owcgiXchQ7MFMt5Q1XeyhQ4Cah0Kg5J/OCsJ
 tu7A==
X-Gm-Message-State: AOAM533bmbQqC7Gf2LNjFsXZXElr65c2kaDAJ4R/UuwNAK5UPP4iGOyw
 JBbUOW5ok6EA5PZaxCUQAHTb/DMYwrbkIuIXGOuqFAOiuTaGlBe9BK9vhHOzhbCMx7kJWNrcXNK
 uHgYTvrJmOm12j3s=
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr15888631wra.187.1602253518901; 
 Fri, 09 Oct 2020 07:25:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfoR+lEY2ufCPeSL6O72gWXrtRBzEDg+wPVGKDYDWyvKyaW7M3mTivbkUFb5+MEE1pQo29fQ==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr15888608wra.187.1602253518662; 
 Fri, 09 Oct 2020 07:25:18 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x65sm12853058wmg.1.2020.10.09.07.25.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:25:18 -0700 (PDT)
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: Elena Afanasova <eafanasova@gmail.com>, david@gibson.dropbear.id.au,
 jasowang@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a18674c-c3bf-2324-7897-cd4916690a13@redhat.com>
Date: Fri, 9 Oct 2020 16:25:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 4:02 PM, Elena Afanasova wrote:
>  From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
> From: Elena Afanasova <eafanasova@gmail.com>
> Date: Fri, 9 Oct 2020 06:41:36 -0700
> Subject: [PATCH] hw/net: move allocation to the heap due to very large stack
>   frame
> 
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/net/spapr_llan.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 2093f1bad0..581320a0e7 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
>       SpaprVioDevice *sdev = spapr_vio_find_by_reg(spapr->vio_bus, reg);
>       SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>       unsigned total_len;
> -    uint8_t *lbuf, *p;
> +    uint8_t *p;
> +    g_autofree uint8_t *lbuf = NULL;
>       int i, nbufs;
>       int ret;
>   
> @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
>           return H_RESOURCE;
>       }
>   
> -    lbuf = alloca(total_len);
> +    lbuf = g_malloc(total_len);
>       p = lbuf;
>       for (i = 0; i < nbufs; i++) {
>           ret = spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
> 


