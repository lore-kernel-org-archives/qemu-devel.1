Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A6C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280282074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIu9Nmlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280282074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD1Kr-0006Cv-Bn
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 03:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1K9-0005Qt-Va
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1K8-0002oq-SH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:50487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD1K8-0002m7-Kz
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:08 -0400
Received: by mail-pj1-x1036.google.com with SMTP id u10so5319789pjy.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=97p4o19ji/8YDQzjFCiIripegoNrIhXFry1xIb5OoRU=;
 b=BIu9NmlkmIAVTmO6PLG3RN/uKB93hH6ER/f0v+6/S4OnpMGGIK609UKDmhM+B0gSdm
 yUrcpPCCaVYMKsLQKYlrDkWxLDfuGRMuFNp0uPIoYjc7OblBnybOhrHEKDxv1XbNPizL
 ndXq5W0yOPAWqAMCXsibo4ckN4EP1tAx7+NODve4aija5n4A5oKVGqI3HqtaxaKLbWEB
 DCNR7aEtYu0gfCfqHZddfFoU3kqOniGsIVw/t8IpDGaMyOuiTgWYaOMa/h7M/UEHEQiV
 AQpcPVW+m3YpBcNZ5Uw5qo9bJvw0yOCn3UppEZw4WCoIi3qr0GrRxOxoPozo0N8zKv1y
 gaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=97p4o19ji/8YDQzjFCiIripegoNrIhXFry1xIb5OoRU=;
 b=Q+etJvUnQHP45Mrqh9Eqc6PbkE1vBgj/FImFysuL2V4Akeu4oSSua+ewsTHf1Nlyg7
 7WVX9O6huop+eiT0A4amRvonxeMrqWelWpIb39xqnj3kV/aIqd0vkFH3uwtV82/1bCS3
 4A4OrfUiQpLVCST4p5I+saC6lLwZUJpmX+aAxkeroY59sVlBH02PPIvZ09/HZW6v43gA
 V+hUWLswHr36TXy5lpvu0WwthWeKUcPBa5v3L6QPm4wgqrTOqqJvDpNN2KY5iWltP2Z8
 YEjNaa2gMv6R3m+WrReBkjbJW0uyIOVAVISlw0vDExUvGzeALvPNB5s0mZMJ5IJhq2en
 hHog==
X-Gm-Message-State: ANhLgQ1rDhAXp3B14Zv2GFyZMw3KRGWNE57A+PHaqvqZfjd6PGfichWt
 x/GA9AL6nOd9g9SLggqLCtNUEg==
X-Google-Smtp-Source: ADFU+vtup1IQZSJgq1ZkI6xiJIPBTgOU4tyXaLi5fSF/IhPUTcDcnb3jIjiyFQQVdlNvfWIL2l3oJg==
X-Received: by 2002:a17:90b:1b02:: with SMTP id
 nu2mr7352538pjb.95.1584171307326; 
 Sat, 14 Mar 2020 00:35:07 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e28sm59052212pgn.21.2020.03.14.00.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 00:35:06 -0700 (PDT)
Subject: Re: [PATCH v5 20/60] target/riscv: vector single-width integer
 multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-21-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eaf49149-ac2a-fa6b-284d-6827c33acfd6@linaro.org>
Date: Sat, 14 Mar 2020 00:10:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-21-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +#define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)         \
> +static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i)  \
> +{                                                                   \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> +    TD d = *((TD *)vd + HD(i));                                     \
> +    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1, d);      \
> +}

Change the type of s1?  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

