Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F32B2083E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2Ziz6DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F32B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPjwM-00065U-CZ
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 05:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iPjvb-0005bD-IO
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iPjva-0007cq-6w
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:06:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iPjvZ-0007bQ-W8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:06:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id n7so1213618wmc.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HK23rcT6kmOggU0GKLRG5nH5BL666BTmwqQypLR4Uz0=;
 b=k2Ziz6DPfBoCzTmNfPph+wMshUqRv6VdSGNx+wRPb0TT3hCcLkAKCODzxsON0qQ4pI
 ND24jPmjsZRlApK0A3a1HsNklcDd9n+MGY+lJ8WEMNqf0NK9zgfyIY+bGLUV/jRIhKZk
 FAZ34AXUX60SHdmW7UOzpdWPwIsw4o/fLDiYnVnWTIRFZGZxLGBpiZ/7N7ahMKqITXmg
 1C+DMqHWC/1bPMVliHIonWtxMx3fZyXAVno1TZ2uOY9fqOCwC8nY8KA8dlfqC1kxZ4Pc
 lLRRTWakW8ZWzDX+bK57iHL1M1415rqCUcSryLoUjJPEjt75myRWtqu8z2idws6Q7esA
 Vk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HK23rcT6kmOggU0GKLRG5nH5BL666BTmwqQypLR4Uz0=;
 b=DywEXaLT4VG30CiyrrxLbcd7BSsysA8HpxpSA4O+/Pz2O7HRGI597K39+Q0zgnqoWL
 13fspyOrePCvU18Y56/Vflvc5isHCWwCyZlk0fFcuZMdrFbE37A60BQDqeESQWD/Lu2z
 dZeQl8PDxnZdT+ZuMlP9sLPNkdlAV4ewLOsdWxXYPD8Ymqi6r5jHqweczNVtRvIvYpxq
 XShmr6M2+1ZwTGeXtVGT1HFHp4QpXiOKydnrIZHcJMiGpe59liBX9XWnMqYKvvySHFDM
 KDb4Eo9nzHKIHVrZ1t+UMxl/PaUpYea6b6LTj0pLWs5HYBS1kUrQ2bkWPGlOLFPZE3M6
 t+fQ==
X-Gm-Message-State: APjAAAWLS80GCm/jib+ARP6uqBWzHf+kMfHlZLy47bnsroCG3NNBxQM7
 AX1+JMuLwdfElBQsbjJTFCuXRA==
X-Google-Smtp-Source: APXvYqyNheX880W539LkCCS8qqDX3Pq7Ue7qu0BZMopU/beZ5yUUTOF1dZm7OVvbnrQwdX2O/oSbNA==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr7840918wmj.125.1572426364215; 
 Wed, 30 Oct 2019 02:06:04 -0700 (PDT)
Received: from [172.20.33.154] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id b186sm1457507wmb.21.2019.10.30.02.06.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Oct 2019 02:06:03 -0700 (PDT)
Subject: Re: [PATCH v2] Added hardfloat conversion from float32 to float64
To: Matus Kysel <mkysel@tachyum.com>, qemu-devel@nongnu.org
References: <20191017142133.59439-1-mkysel@tachyum.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0484cd81-9ac2-b12b-5bd0-d05d40e3fe7a@linaro.org>
Date: Wed, 30 Oct 2019 10:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017142133.59439-1-mkysel@tachyum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 4:21 PM, Matus Kysel wrote:
> Reintroduce float32_to_float64 that was removed here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00455.html
> 
>  - nbench test it not actually calling this function at all
>  - SPECS 2006 significat number of tests impoved their runtime, just
>    few of them showed small slowdown
> 
> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
> ---
>  fpu/softfloat.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued.


r~

