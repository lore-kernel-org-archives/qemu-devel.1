Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F760C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2853207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlJQst+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2853207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFEe-0004OI-7H
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZF8a-0008J0-Nh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZF8Z-0000Ps-MV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:32 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZF8Z-0000Ky-Hj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id l15so1849878otn.9
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7fUxwkI7/lFmhCPdMN5//RfvbGbZNeItnZOVIDhGNXg=;
 b=mlJQst+NbwGxkjxW7ZiSbDx7dpLL1r4NHvaNVZwE93zCskV3YFHDC0HJAeWg3Lmr3b
 gTVIPhzwX4PyGGckB9eF6bIR+qvaliEkNkoKXxnJmzQ/oAL7o2yiEvic768tAdvW8TuR
 c2srPChliQJtGj2eX5hyhhpDh8KHoMf65bPrwbR/ISTKOHuyqBROlQiId2owo8HNNANv
 xb0QrycUh1+/LZ/Cp8eGgQrGzomI3S30NGlbyeUi92dmCMsNppgtV7Ak5BlHuZ/c42xI
 9KeXP/r7T0ukw0XPg3ZdUd30ea9fw3aKWHtnQ3b+n0SeJeXotiTQnjyuagDgGDYPKV0J
 +C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7fUxwkI7/lFmhCPdMN5//RfvbGbZNeItnZOVIDhGNXg=;
 b=shpQGT2TNJ6IqmQZUTO2conH+Yp0kiHBMPqVTf9zqds11dQopYScyVR6NGHXqa8glS
 7ol1v3hROl3tGYQZtI/OLmcFqvZfgugLyDaAZaWlNoQapmJ82KepovJh203+JnSvjbq4
 6gOpL9RZsvGM4zFoTi24KlH14NqDi3b7WudDE2pWkmDULXIyQv1uPdFOD+PHQjVYnLaI
 xJThc/z5ONxiELRkZ3Gg0HSATyVD7GjBCB7rMDLfMVElT2nuXOEToFUU/ei17AFZttvA
 P4Pd6bc3hol8AuR83UHpE5tcKnexcRF77mtwFnhcfuc9QrT8qJrgLfmHkwTRA1Ld1Qja
 Qo9Q==
X-Gm-Message-State: APjAAAUHqJXotTcSuUtvkVsXszGDDo5BgtSs4qHyUqWOvX1LYTsvEGs7
 6koLyLQ4DkvPcy6aY5pTO5VQ3UVdU1cCkg==
X-Google-Smtp-Source: APXvYqymzYwXO/L8jzwLB05u4jZX40eQwUdpZz0jbJU3fmpXD8R7VlnqO/6kINcw0rIxnKfmiiRqaQ==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr19630823otg.125.1559914950025; 
 Fri, 07 Jun 2019 06:42:30 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id s63sm716753oia.34.2019.06.07.06.42.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:42:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
References: <20190510110357.18825-1-peter.maydell@linaro.org>
 <CAFEAcA_FnpYF_AegaYUqfPhr_k9ZXUS=JCamtD3+nSvonHC1vg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0173bcfb-436e-65ce-fff7-58cbb82bf9c1@linaro.org>
Date: Fri, 7 Jun 2019 08:42:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FnpYF_AegaYUqfPhr_k9ZXUS=JCamtD3+nSvonHC1vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Implement NSACR gating of
 floating point
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

On 6/7/19 8:06 AM, Peter Maydell wrote:
> The NSACR register allows secure code to configure the FPU
> to be inaccessible to non-secure code. If the NSACR.CP10
> bit is set then:
>  * NS accesses to the FPU trap as UNDEF (ie to NS EL1 or EL2)
>  * CPACR.{CP10,CP11} behave as if RAZ/WI
>  * HCPTR.{TCP11,TCP10} behave as if RAO/WI
> 
> Note that we do not implement the NSACR.NSASEDIS bit which
> gates only access to Advanced SIMD, in the same way that
> we don't implement the equivalent CPACR.ASEDIS and HCPTR.TASE.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * fixed bug in cptr_el2_read() that meant we were forcing
>    HCPTR.{TCP11,TCP10} to 0 when they should be 1
> ---
>  target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

