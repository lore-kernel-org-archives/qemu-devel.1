Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7670AC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213A720857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF/lH0AH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213A720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUX1y-0006IY-4O
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWxb-00037V-Ou
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWvC-00012x-OF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:48:15 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWvC-0000yU-A0
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:45:46 -0400
Received: by mail-pg1-x543.google.com with SMTP id n16so4640643pgb.7
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s/OCfhEHOgJHe55FoOL458vwUhXNcaz87gRjsmL71DE=;
 b=SF/lH0AHal3+EA6TZNTmKpo6q5KeP4NY8FRst336JeqgSDIJ9xBGdciUdfJ8+CKLGq
 5wAHwgKtgPLpIBNzUSOqL6w0yP9u1ROukQBQRtdWrsymLArQCmU21N8w3Szf2keucH/J
 1hu4OoLY0Vt9xre2yED8dxuX1l5jz7qqnAj9DxHg9ffpu9UsSIbit2nd9ycBwQf3PlYv
 Br0VMdbWNARySK80h2PIUK6icHX1ujpFs7+algSGY69z7gxz5tkHAPg/ax4raVW5H5vR
 NL8g0fcqNSEyRdvuj8Xdw54ZUzTE/iMYC/xK/VLxxom0CAWcIkrvYs6uIJ+0dh3Kyyr8
 Sr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s/OCfhEHOgJHe55FoOL458vwUhXNcaz87gRjsmL71DE=;
 b=RHwJO7os/kGWw2L8hf6shYGhw72DcUaF21NKb9Thob55rWeShARhQ3GyZcwzU2ybbw
 Qi56h5W9tkpW0qHhBc9c7dtq0xF/SI99G+laeTEbXEXaIqOVj8Rp1V67R4Bq+5s8ypqj
 Tst5dPHVDHOn1/fwSX/m64jYtAx4dlVS+4n2Wmwr2sJ8Igx+va7vvSMRz9qgf/Mjyfu3
 Z3a1/cuAdukoHj0q/jXBNMNGkbXudbBbZn5LQobxsbwd/dI4Et7G52njhuGEDLwymOyH
 NGdeGwiMgZUXxx3Ch7NvgAiBgkW32yiHMwR/1n5ocdy41YpuaNwXi1DLi8bG5BFJmBeP
 He2A==
X-Gm-Message-State: AGi0PubtD3kx55amchgeOHQkUwSF4IvRs5Mmlgf7i+w6JdZ9+ODOQMeG
 htcFDDndG9c1H3vlrA2rkrKaog==
X-Google-Smtp-Source: APiQypJ5kUguJtF1MuY6L63PBmsya8U7bVWtHGI07vmsD2FRf9K+1L3eySnIMdrHTClxskBGvbgirQ==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr4401618pfb.283.1588344343238; 
 Fri, 01 May 2020 07:45:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d126sm2544063pfc.81.2020.05.01.07.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:45:42 -0700 (PDT)
Subject: Re: [PATCH v1 9/9] target/m68k: fix gdb for m68xxx
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <995a0ac8-0b13-498c-d535-18a07dd098a4@linaro.org>
Date: Fri, 1 May 2020 07:45:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:01 PM, Alex Bennée wrote:
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
> a coldfire FPU instead of the default m68881 FPU.
> 
> This is not OK because the m68881 floats registers are 96 bits wide so it
> crashes GDB with the following error message:
> 
> (gdb) target remote localhost:7960
> Remote debugging using localhost:7960
> warning: Register "fp0" has an unsupported size (96 bits)
> warning: Register "fp1" has an unsupported size (96 bits)
> ...
> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
>   00000000000[...]0000
> 
> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
> 
> (gdb) tar rem :1234
> Remote debugging using :1234
> warning: No executable has been specified and target does not support
> determining executable automatically.  Try using the "file" command.
> 0x00000000 in ?? ()
> (gdb) p $fp0
> $1 = nan(0xffffffffffffffff)
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <1588094279-17913-3-git-send-email-frederic.konrad@adacore.com>
> ---


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


