Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1CC54FCB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 19:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E2D20714
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 19:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELk/ndQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E2D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSQUY-0004Mz-53
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 15:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jSQTo-0003ls-5G
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 15:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jSQTn-0003MR-GB
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 15:28:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:33845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jSQTm-0003Fs-Vu
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 15:28:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id s10so5131171plr.1
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NytczcyzsZZ4HfE7oOZESY0zhYYG/GFVA/f0IKIwRs8=;
 b=ELk/ndQ0mIR0cFYj9RZrfyLGXjhy5v3RDPAdi1S7/9gSK6vqznXS3LwW20Q+v90ZzZ
 Cjswqpbh7l3pyLPzsOCOp74ZAfMmpTQYDFLJn02JoCUERlJRhdbtIYyJWlBzdCRzIKKz
 b1chcIa3cBhYEg4JRyRKMUIKhw2gm03KldEh8FK3F5zMDx2gpBqMxEHTtSaQm7DorGtq
 AwnsiWsXPQEfmJ18RtgQXGQkOj0562xFG23sX0aOrA7xmaeSBfFvrFug6T3NGnua0UJ1
 ofkOKzuPvTNhMLvzmwuj/80T9DxINkYRtrokH8OY/iW3MTfLR1nacGEs2AvVKwVRdLIl
 jt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NytczcyzsZZ4HfE7oOZESY0zhYYG/GFVA/f0IKIwRs8=;
 b=iaMMp7EJ+OtJH/2HXywO0ktn/P1P0fmXBlZWcOKPvAnDPMqfoRcrOY4FqOP61zymS9
 8/hVmT00emOgYTnvREDWNsGu5j+24QxxUFoXtuvn8RRFdamhQ4+ay1IaR0VHYNXME509
 54zJECMvjCWInGgLU4xx6fzfYn44qG/U7+vMQ6qoRDfFybP26R28eD0+LKHohOMPh2tr
 HqeK+vJrq5x2ItGjzAxvjbLN8LEkEwduwRd35meel9TS9j8B7DyemgCZAQewRfS/diuI
 EDrlpTB5/so4IkRBeXRUoYDYvI7fDSqzChT9ZAyG8av0RJXNB64kfF/sv2oXgUSJ3K50
 bgFA==
X-Gm-Message-State: AGi0PuZWePKJQY7V+iKXrtMuC9kcZSK//Rc9imRfo3Ek6NseRCe7HCGr
 pOpuFG8qmZ6SEK2GyTmAO7sCX9ugi2I=
X-Google-Smtp-Source: APiQypLwFjheQ/CQei4CoJ0anKt0ePGz+2b+bgc8SUZ5T4rtKf+NVcdggmqCXXLw1/571Yc8Mry29A==
X-Received: by 2002:a17:90a:db0a:: with SMTP id
 g10mr14208898pjv.54.1587842925182; 
 Sat, 25 Apr 2020 12:28:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm8726325pfd.107.2020.04.25.12.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 12:28:44 -0700 (PDT)
Subject: Re: ARM SVE issues with non "standard" vector lengths
To: Laurent Desnogues <laurent.desnogues@gmail.com>
References: <CABoDooMSCvi4sxWS-a3cQksD3V5tnHCUbGPsxW69Ou4d1rpQZQ@mail.gmail.com>
 <5c5d4c91-c819-8bb5-2dc7-784cbdbfb789@linaro.org>
 <CABoDooPSYj5ujXj-jKTrBDVFDO3fp=k6ev+Sf=4EgtG7R_kX9Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1dc23e17-f348-f2e8-e292-641619968a6a@linaro.org>
Date: Sat, 25 Apr 2020 12:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABoDooPSYj5ujXj-jKTrBDVFDO3fp=k6ev+Sf=4EgtG7R_kX9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::629
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 9:24 AM, Laurent Desnogues wrote:
> Looking at the code I think sve_punpk_p is affected too.

Got it.  Same issue as zip1.


r~


