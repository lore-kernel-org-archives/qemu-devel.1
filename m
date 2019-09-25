Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F9C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3150521D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1C/Mxf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3150521D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCh4-0001ls-1H
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCTP-00042a-EI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCTN-0005tc-W3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:57:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCTN-0005se-M7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:57:09 -0400
Received: by mail-pg1-x543.google.com with SMTP id a3so376719pgm.13
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1rR+kjuTX98NBJMJLS9ic5HyHphdROXDds77bzHdIxY=;
 b=x1C/Mxf4Y74d5ojI4VMXfFyZqxtcAyf8yyC9Zkumf7HIFmgfRLY6PjOVPK32G1bP7t
 J4ijhZDNxzQk8i7d48D03+T+SK6lYQYXmVdP8Obg2VDxrkdIgjGTT4NB1NsEn6k2PS8f
 z1hB9AXtpecpZHi+WDEpilG+7SRWhWHD8cLG2ZPMGBwUCIkd+sQ2iz37nr9FVF77rYpG
 TfFwliqDwgZfcSHvpDivOohE/AfII0+cBbUmup/qk5MnPiCR8MiSZipX4cmkzckWVy7N
 k3tKj+qrd/W8XqQrcxnM2jeElYH7izxQ3t5UceTygny83qMfY3tWrHgMShkjOe67sUrh
 BSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1rR+kjuTX98NBJMJLS9ic5HyHphdROXDds77bzHdIxY=;
 b=pj+AkxY3u7Y2ArvLaU4rMLfIBUNj7rjuQw3eoOBYAroaV7erjuqgBSS+n/pA+JKY0t
 IZ4Rouj48ErwElkPTCY7xhG4gFBnB6AM+dATf6xuAoHZN928uUX2x7pmEWGtVLnY1bFC
 LbkKMWlrCy5pcePzoVWG8QDvBIPAvLlGpd3yGJGzvZFxh1IYu1Kyb+EB4KFK7NkKIoFZ
 VTGDrVVIeiupjTALOpypO7//jDLVXHrvOBaVYCNh8r5hMPkDdmHXlnI0NYvIZ3Lm6Ui4
 MlLzSZ9IdI7VDZV3Lu26+3FxMhXdSCf5ayBxA0Zvwn1lGlunLgR2Gpbxz2sVyKfe7tRX
 aRmg==
X-Gm-Message-State: APjAAAUA5SZ81idt6ROW6c6xwFNbnnDdH2wfl/F8vcYTyf3+KsiaItr1
 +vZm+pWptoReeOgZTG/b0bckCA==
X-Google-Smtp-Source: APXvYqzk/gxRjEG+0auPG8nfOownunuCTb8jgIUqmbcF8O91NSgN8kdMiP8RpFBorZqG4mpkhR2kzw==
X-Received: by 2002:a65:420d:: with SMTP id c13mr782498pgq.293.1569437828557; 
 Wed, 25 Sep 2019 11:57:08 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id r18sm10096324pfc.3.2019.09.25.11.57.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 11:57:07 -0700 (PDT)
Subject: Re: [PATCH v3 33/33] tests/docker: remove debian-powerpc-user-cross
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-34-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e8aaa196-041d-9881-68c6-727884ac97dd@linaro.org>
Date: Wed, 25 Sep 2019 11:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-34-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 f4bug@amsat.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 2:01 PM, Alex Bennée wrote:
> Despite our attempts in 4d26c7fef4 to keep this going it still gets in
> the way of "make docker-test-build" completing because of course we
> can't build a modern QEMU with the image. Let's put the thing out of
> it's misery and remove it.
> 
> People who really care about building on powerpc can still use the
> binfmt_misc support to manually build an image (or just run the build
> from pre this commit).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  tests/docker/Makefile.include                 |  9 --------
>  .../debian-powerpc-user-cross.docker          | 21 -------------------
>  2 files changed, 30 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


