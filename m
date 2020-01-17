Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C30C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A142072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4GVpiAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A142072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isG3P-0005VN-LN
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 20:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isG2a-000541-VQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isG2Z-0005p9-Oe
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:03:12 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isG2Z-0005lv-Hm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:03:11 -0500
Received: by mail-pj1-x1042.google.com with SMTP id u63so3605147pjb.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 17:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=E/Rq1SD5tBD0RUyawOsAT2TY31XGskNiazY6K9czKOI=;
 b=l4GVpiAm1D1lVPyqU3q/YEUHvGlp/Wtqp3TrcXfMba/fek0V6UNRWcmKipAoxVPQdM
 zNYSjOgZfnUVsDK2OBIZwabP8M51/fZ+KIwzlwSrv2JPC7YWqyodafzy9V4uQc5PmjAZ
 P6417vrGSb0JDv1ZFRDr81PDLscvTTc/bebKvhiFMfrCqgtlV6WvQ3pfYD/7/EG5jIp8
 NMECZf8fx0viQv+zcwX1SOpvgAb4V0lR4C9kLRvCt9cvCfHPxH4pT29fh8o9e2cS9tR7
 vQlxWAAqvbH70j3EIcKgEGTQqbK3e4lVOjEGzDWMaHd3hln10+5vFoNSxDu3afkxJ+aa
 oGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E/Rq1SD5tBD0RUyawOsAT2TY31XGskNiazY6K9czKOI=;
 b=XueOy2HSpRjfkt/2LuTfEWN2wbTSKdSYeLZ2j6HHuVxZaLK0+CtIBBvn1Ua0PIxgxD
 fZMHSIzfLC+j2h86HCOpbq0JZD8dKb2+I8enwvQJy2QvJN99Hkwc1bUizrTESNrV2FS9
 oZJnmDBT7hh0MXsg7TJZGTMAWKHXdjxzz8uCSTJxzAmxLkfsObdsJDUvWdusw75NutN2
 nFITOjMrMthTj1GMxjAbDwm5hp6KHQMZYojD6H19Gv6LfP8vMopjZvL7SFzZV9pfjIFi
 9OxM8rNWWOxGTT8zRJGkM/hKt0vCb4KJsccz2h7sQNYEgAVoSCVuhwDL0rwRqVrIx3QY
 I98w==
X-Gm-Message-State: APjAAAWiNACPkDTGDJyVeiDu4WqDkzKD8t1o3iX0Yf6TcScUdELxj/86
 11dLbpt/CYmpn5yYaaWu/IbKXNFUW+U=
X-Google-Smtp-Source: APXvYqztzlM5o/Vw/Qs1YSUBxsLxM2pHcaEhNYxkhCJIMP63ziEWIXGIns4Mkj+oJ24xNPoOt5oO8g==
X-Received: by 2002:a17:90a:cc04:: with SMTP id
 b4mr2539043pju.136.1579222989713; 
 Thu, 16 Jan 2020 17:03:09 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s185sm27824579pfc.35.2020.01.16.17.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 17:03:09 -0800 (PST)
Subject: Re: [PATCH v2 0/3] hw/hppa/machine: Restrict the total memory size to
 3GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
References: <20200109000525.24744-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <506434e1-8f51-85e0-1c2e-2441c7be6000@linaro.org>
Date: Thu, 16 Jan 2020 15:03:05 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109000525.24744-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

On 1/8/20 2:05 PM, Philippe Mathieu-Daudé wrote:
> Following the discussion of Igor's patch "hppa: allow max
> ram size upto 4Gb" [1] I tried to simplify the current
> code so Igor's series doesn't change the CLI with this
> machine.
> 
> v2: Simplify by limiting to 3GB (Helge review)
> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg667903.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669309.html
> 
> Philippe Mathieu-Daudé (3):
>   hw/hppa/machine: Correctly check the firmware is in PDC range
>   hw/hppa/machine: Restrict the total memory size to 3GB
>   hw/hppa/machine: Map the PDC memory region with higher priority
> 
>  hw/hppa/machine.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Queued.


r~

