Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F21DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3002070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNQHpqOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3002070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4Hf-00060O-5I
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iY4H1-0005ak-Pk
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iY4Gz-0005IO-JQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:26:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iY4Gz-0005GZ-BO
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:26:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id 8so6585265wmo.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 00:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tnw4tAB6wJ/568PL4rvDgAQZUJya2pgV5GWXAm+Qz5I=;
 b=jNQHpqOumBaZvGnW9HBqH9bnkt0c4m/vwijP1pB6EONcPW69xCdar+UPKY7J3pPWkI
 rLbrVRLeiSsaqNlQes8m6pun6Qmu6N/eB1ruzO/2jvxSxJW0whmRb+MFhRu/M+IMkYfU
 0Ppled/10F8zqfSbDRhzbslFp8d1S7Y9z4/f5JHM2FRwpgy/5ZuRMVuuom8Gt6bqDWD0
 Jaq0SIJsiOJrsqqDefMyhP9e/YFSj/Gm1g36Soz2tYRBvFDiQib9KrEXBkww+GgO4DqQ
 EBM0cDLequpf6Dx8zURWZFnOpm7GBw8p0NcIdXZUUGC7+QJ+i44P2TA69IefBkTmCBxJ
 zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tnw4tAB6wJ/568PL4rvDgAQZUJya2pgV5GWXAm+Qz5I=;
 b=Uii2y27IiyRZaRi10rVgPd2tKHhOONs5rAHeSoELqL0WU8+UUVScF3wDwGaXQHDcPF
 HTKUW1L3eQ3yVx9NT9FZFYe27DmthjBQ7GiMNEYIlychJSfmtHKWeldnFXf0oIREoCVg
 0X4SRAajmrNSbAF37igycGj8eszIY80NHKSR7qUoJb/vvUlvjVKANw/N/y3VXvGfK41q
 tBhmvCvIr9EBCD3vSkTg8pqc9p7zsXbcugC1Pk4R84XGXiQrGMDENOL+w6huTdS+W8AE
 1PHLRcUjhYhaLhvjoPEnM4iA952OgVFN7CzODtDAnWb7c18NH9OJYJYfUzOIwZFhtCBY
 zu5Q==
X-Gm-Message-State: APjAAAUyEkrqY/SMZEspF4sYTJ512T6yRdZO2M9O4cq+xdLZ1vu5tluR
 dAekjFu9jeuvpECGuJr9vO1Y7Q==
X-Google-Smtp-Source: APXvYqwMVBArrR+/ppV9XdOTYkTas2ynD9B7HXRMSp+y5bOq35DancTYZjvZj3v9wVYwOJMX2iBsQw==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr8046383wmh.157.1574411195968; 
 Fri, 22 Nov 2019 00:26:35 -0800 (PST)
Received: from [192.168.1.143]
 (host217-43-132-120.range217-43.btcentralplus.com. [217.43.132.120])
 by smtp.gmail.com with ESMTPSA id t12sm6368385wrx.93.2019.11.22.00.26.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 00:26:35 -0800 (PST)
Subject: Re: [PATCH v3 2/2] util/cutils: Fix incorrect integer->float
 conversion caught by clang
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-3-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <65a06c7b-4ef6-dc12-3804-a50f426be2be@linaro.org>
Date: Fri, 22 Nov 2019 08:13:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122080039.12771-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fangrui Song <i@maskray.me>, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 9:00 AM, Markus Armbruster wrote:
> From: Fangrui Song <i@maskray.me>
> 
> Clang does not like do_strtosz()'s code to guard against overflow:
> 
>     qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709550592 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
> 
> The warning will be enabled by default in clang 10. It is not
> available for clang <= 9.
> 
> val * mul >= 0xfffffffffffffc00 is indeed wrong.  0xfffffffffffffc00
> is not representable exactly as double.  It's half-way between the
> representable values 0xfffffffffffff800 and 0x10000000000000000.
> Which one we get is implementation-defined.  Bad.
> 
> We want val * mul > (the largest uint64_t exactly representable as
> double).  That's 0xfffffffffffff800.  Write it as nextafter(0x1p64, 0)
> with a suitable comment.
> 
> Signed-off-by: Fangrui Song <i@maskray.me>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [Patch split, commit message improved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

