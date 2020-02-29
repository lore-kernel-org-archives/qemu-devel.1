Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7565D2469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+k6U+b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7565D2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7rLe-0006Hq-Le
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7rL3-0005qD-NG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7rL2-0000Th-Hf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:54:45 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7rL2-0000Tb-BY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:54:44 -0500
Received: by mail-pj1-x1044.google.com with SMTP id a18so1991568pjs.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WtZQhwepf52NUkkU/1UJ5VjvUnfcZSuNC4qGBI7NQ6g=;
 b=x+k6U+b2pVwFX1g0dXqkm6mlMTzI6omIyWx1VUtWeDsD4PuaBCcvjzD4UgXqlNvZoF
 JptJcNOVDvbLXitQnqIkHPEvLM4EnWc83kKMQ8VdRvTi+71phvLARYKDFSrY0+j2q0xl
 c47VQGrUOr8vvCZupDttPA95ES91P1ViDrhuQACHW+GD0pJdRpQ2n+FqZ3fFowlty9A+
 9BFUJcD5dmuFIoKnF7lGtZOXVs2iqP2U7se9bDIt+juXX2V8ezF2JHRafz97GnQ55PCM
 kvY/XlHJ6GwhdyQrIuBKbcfGAudJO3K1CucEfXY7lF0G7hrrvTBspEzWGRje8xcEIYEE
 eZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WtZQhwepf52NUkkU/1UJ5VjvUnfcZSuNC4qGBI7NQ6g=;
 b=HjmmdBWObSz3Oae0XI07v2GBYatjUy5cw1gSi/nP3VjxO2srZoH/gh58+5tnRlojxe
 GSZlFCn8v2X5bAbCdtZ0amLAo8YelFibJZtp0GCWBkuihGt6CAZNk+sls0SU7GhYIhrB
 hVw2oXFG+D8vTiAguNoE0gYVsItJZ1/k4pDJF+Eia5vhgB1xZbtOPDjoSROxgiZlF3Ko
 qfmIIBh8x9VAui2WW4npIlPBW5R1siBkHEljoxvSQ6cIv5YZmbBbKGrNKmUgrgrIY4nF
 WgZiY08GWBEF3Yz8zqm/loDgqLfB1oVwqmie+yRKQDweWrqhGYfWhZOqPBJi5lBg3dzg
 /dow==
X-Gm-Message-State: APjAAAW+koOWxi3PLcRXzRwAVb7550Mbv1o4X4OloiGlomfCv2HHC8jo
 kYRS45OCOdHeaPWTRW0kUaZuww==
X-Google-Smtp-Source: APXvYqxmMAZ9cFEaudNpENmNtWIzrWIxr3iDNVdpngzS8dDMKe/cOt0mNtnZ7NV79+JsOlzaJwoG6w==
X-Received: by 2002:a17:90a:7345:: with SMTP id
 j5mr7252780pjs.69.1582941283239; 
 Fri, 28 Feb 2020 17:54:43 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c7sm4463721pfp.98.2020.02.28.17.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 17:54:42 -0800 (PST)
Subject: Re: [PATCH v3 1/2] configure: add configure option avx512f_opt
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
References: <1582856696-45663-1-git-send-email-robert.hu@linux.intel.com>
 <1582856696-45663-2-git-send-email-robert.hu@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d1dde69-9b08-42bd-4241-64783df77ec2@linaro.org>
Date: Fri, 28 Feb 2020 17:54:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582856696-45663-2-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: robert.hu@intel.com, chao.p.peng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 6:24 PM, Robert Hoo wrote:
> If it is enabled, config-host.mak will have CONFIG_AVX512F_OPT defined.
> 
> AVX512F instruction set is available since Intel Skylake, and can be enabled in
> compiling with -mavx512f.
> More info:
> https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  configure | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

