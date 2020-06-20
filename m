Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD68BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997CC2311D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+a/AR6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997CC2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmhPs-0002zT-UD
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 13:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhPE-0002LH-9x
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:35:52 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhPC-0005x5-Ig
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:35:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id d10so3579152pls.5
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h3yGZCDORrFy+QlFQcw0g5yYcdCj1Jz8HToicNoUaOo=;
 b=j+a/AR6HTi6OkyRdKjs1nPIQY/D5XfIWhguzIX+HHaUNTxw7/bqIqDUwCz/XMFuWP4
 3sGS5JJkaewsidunoigh9aZ48sZN/RT/DH3PglM3t2R4ZkT/ZQq91ZG8IY3OHwg8wnO6
 nNTG/NMtoqIQHEoC1ozJNjlyMhMFYHoO8nsbCTcWoIimGaWNb7u52/3ZgQSyZAHMjCS4
 fKgI2q1tZS+bYIPPMYjtfICuno3vc+sgrOm2UEG/hk6VUeuH3+WNvlxM8e4OiPEf5RKt
 lJW1KsTchxRUCKvhncCj2SF7mBXVxVOPGv2rvjCFNDvY/iMPwsbTT3DOpAmUNZW0A0x7
 u+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h3yGZCDORrFy+QlFQcw0g5yYcdCj1Jz8HToicNoUaOo=;
 b=o4wWkKUngJPGi2FNr6z7B8PAUbcOgQOAxdsDjPk9x4MzIsUB9qIrIBaCKnP2S5m0Ym
 CDNwTqkBG4PYfgpgSB1J3Kr1VLjjoTSkDNEbBhgfICVROunzoJ3CmNCCzcHhTF54i99s
 Fe/KWgRi0y0h5M/aAw7heLkTDEJOuYor+xzV74VtWxw/jqSdCEzc8qX6NQW6py8rMQlF
 bHk/SNF3T7QKZearKFYC6F6Jy/ELbmoBOK+ViuO5RTXw+3GavjHAXFcEGVo3XTMG6OGQ
 ziUgARK2P902UmLB3EAwfvGlVh/ehEFvRKuMprrK9JOyrtBst6vHrt0XXoebOeAQKmDo
 qVBw==
X-Gm-Message-State: AOAM533GEA+VEHjkPCIPLDPrUTR5FL+g942OPBq0pTvMKPTCMhtyuda2
 6sDtRAG/W8x3HNg+cAlMybeWmQ==
X-Google-Smtp-Source: ABdhPJzplu1izZTSY+R253vpgbbT7CNj5y1YtNBguwS56CJ5cnSk0s6FwfyYYRInyuW9GTww6Lvx6w==
X-Received: by 2002:a17:90a:acf:: with SMTP id
 r15mr9912288pje.171.1592674549094; 
 Sat, 20 Jun 2020 10:35:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i12sm9267157pfk.180.2020.06.20.10.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 10:35:48 -0700 (PDT)
Subject: Re: [PATCH rc1 14/15] BootLinuxConsoleTest: Test the RX GDB simulator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200617191519.14842-1-f4bug@amsat.org>
 <20200617191519.14842-15-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59849145-d016-15e4-3b9f-cff834cf1cd9@linaro.org>
Date: Sat, 20 Jun 2020 10:35:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617191519.14842-15-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 12:15 PM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Add two tests for the rx-gdbsim machine, based on the recommended
> test setup from Yoshinori Sato:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03586.html
> 
> - U-Boot prompt
> - Linux kernel with Sash shell
> 
> These are very quick tests:
> 
>   $ avocado run -t arch:rx tests/acceptance/machine_rx_gdbsim.py
>   JOB ID     : 84a6ef01c0b87975ecbfcb31a920afd735753ace
>   JOB LOG    : /home/phil/avocado/job-results/job-2019-05-24T05.02-84a6ef0/job.log
>    (1/2) tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_uboot: PASS (0.11 s)
>    (2/2) tests/acceptance/machine_rx_gdbsim.py:RxGdbSimMachine.test_linux_sash: PASS (0.45 s)
>   RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> 
> Tests can also be run with:
> 
>   $ avocado --show=console run -t arch:rx tests/acceptance/machine_rx_gdbsim.py
>   console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - 21:56:06 +0900)
>   console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version 9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
>   ...
>   console: SuperH (H)SCI(F) driver initialized
>   console: 88240.serial: ttySC0 at MMIO 0x88240 (irq = 215, base_baud = 0) is a sci
>   console: console [ttySC0] enabled
>   console: 88248.serial: ttySC1 at MMIO 0x88248 (irq = 219, base_baud = 0) is a sci
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Message-Id: <20200224141923.82118-22-ysato@users.sourceforge.jp>
> [PMD: Replace obsolete set_machine() by machine tag, and rename as gdbsim]
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS                           |  1 +
>  tests/acceptance/machine_rx_gdbsim.py | 68 +++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 tests/acceptance/machine_rx_gdbsim.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

