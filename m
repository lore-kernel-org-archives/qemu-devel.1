Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E2C76186
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 01:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF6A2085A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 01:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCvq7S2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF6A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp13t-00017k-2z
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 21:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58419)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hp13j-0000jb-Sh
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 21:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hp13h-0002p0-Ti
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 21:54:43 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hp13f-0002mL-Ro
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 21:54:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id i8so16026923pgm.13
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f1LhsbgYsNyQ//FScxPd7/U9uJWzKdyUZwBV+zeaR7E=;
 b=ZCvq7S2p+v9UK0b1tEkUOcqe3lOOSyxM/BlKDWwS0B1g0QUj9cSl7bm8UPZtzoqaux
 5rHYrnSfPEDC+u6KwXJe4qg5pXvgUNE/QWjRtC7/3D/HeHjMv1z6bkE/uE+iasUBa0Iq
 VqJPr1AbC7VGH1StIVULTJ9eH+gVpyvmzocH+VBtIswWfkKCtHVxaL28hXnCnP/Yx3ts
 KlHxnysHa4B+vb2K03l1LvI8tya93PbRetM5krO7noB+yNYlhtzWXtFaQXKEcmrzRKgC
 APHwYgazVhPKk5HrzsYKJCGjdXKVDacn0lha9+zWktgjOUHHuqCM5BrvNAhDk01G+yBc
 IchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f1LhsbgYsNyQ//FScxPd7/U9uJWzKdyUZwBV+zeaR7E=;
 b=MJngceubQzk7tQLrYG6DGdQnmwNchFtCX2Brz/XKVLS+IAb/5nW9BKHm//xzL9Gnfj
 Oy/k5herwUXwm1577BcCrHW08oLAFbWhDJ27qm0jW4X/ozBh9YpQ1yBNy672gqtKHlaM
 KrqG5LUXajpt0FnKPbpDbGjWQyrK5DCurxnfsv4CzdzM+7A/h1TFRgmcZI2/0oNBsTws
 MEKvK7gTC0TPPujFruGT+g1GyMWkpT9KjSLvdkZo1uK8dviEJ2TMYRiUHFOAio5AZaCl
 FnkOBqYV46JX84SnATtpIRJkuON4+l6c2uXQJ9nHuPqXGmNnXjX3JA4qBOb/1wsQULCz
 AMug==
X-Gm-Message-State: APjAAAWZs2N1uXuIUN/Op8/DVynbGh1vkkoPD415vMyP1B1h2024UvYA
 h3GN3nth35dY9ufZ59JsUPSL1w==
X-Google-Smtp-Source: APXvYqwWDmwLqPgtiJtc28rf/Blm01PixpJIohMb8Wf9r0nJzq4xjb04FkrQ4RGuwytcar+FUwN+KQ==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr64155392pgj.447.1563674078291; 
 Sat, 20 Jul 2019 18:54:38 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id n140sm35997610pfd.132.2019.07.20.18.54.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 18:54:37 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-5-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aae968d1-acbd-9b9c-56ff-3cca13b8abce@linaro.org>
Date: Sat, 20 Jul 2019 18:54:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-5-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [RISU PATCH v3 04/18] risugen_x86_constraints: add
 module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> +sub data16($%)
> +{
> +    my ($insn, %data16) = @_;
> +    $insn->{data16} = \%data16;
> +}
> +
> +sub rep($%)
> +{
> +    my ($insn, %rep) = @_;
> +    $insn->{rep} = \%rep;
> +}
> +
> +sub repne($%)
> +{
> +    my ($insn, %repne) = @_;
> +    $insn->{repne} = \%repne;
> +}

What do you think of replacing these with p($_, 0x66), etc?

It kinda matches up with the "p => 0x66" within vex(), and it is easier for the
eye to match up with the comments before each pattern.

> +sub modrm($%)
> +{
> +    my ($insn, %args) = @_;
> +    modrm_($insn, indexk => 'index', %args);
> +}
> +
> +sub modrm_vsib($%)
> +{
> +    my ($insn, %args) = @_;
> +    modrm_($insn, indexk => 'vindex', %args);
> +}

I'm thinking of adding a few more exports for very common patterns:

modrm_reg    -- force use of register.
modrm_mem    -- force use of memory.
modrm_mmx_1  -- crop reg1 to 0-7 for mm register.
modrm_mmx_2  -- crop reg2 to 0-7 if in use.
modrm_mmx_12 -- crop both reg1 and reg2.

I think these would significantly shorten some of the !constraints.

I'm willing to do these changes myself; for the GSoC project I'd rather you
continue to the next phase instead of iterating on risugen further.


r~

