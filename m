Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C849C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD662076E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZXbGHOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD662076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPGX-0000wi-IC
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnPFv-0000Nl-Pq
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:25:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnPFt-00040V-Tg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:25:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so4851668wrn.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gtw376XbI40A9AGA6sa3P1YccITIcsfVpmm9uv0sDzs=;
 b=UZXbGHOv7CUz+99KZ83p2GKPcvZm1LdqPuMailDhDcetukOq1vpgMXYo7F2BulK3Cf
 L4Vp5Cw/UWV/5NxR4y7iBuvjR2Brn7Q2XdEQFkJ84vMqTrb9C+VFNruyLXT3euLCPMgc
 LY9IS89uFr3Qmixf+WHZan6oMQCyGz+Odm779ftg9vHjNrpcR477L3jmzC6dxvDjVVKJ
 6Onwumd78Jr1i6l+xHGqB5sWjH26kRqIZ492FggmVo2IChJw0bnxbRs+JfHH9T74PPU0
 Q/ODQwDlDJkLH3vdvqAZy/8Iv2wipx+sa/Q1tFV92FpomeaZaQ8RXXcA4Q3zSCx/d7OX
 PkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gtw376XbI40A9AGA6sa3P1YccITIcsfVpmm9uv0sDzs=;
 b=uW6sSvgj9BCYx2zLMQyxMl9R9o0ErgvjMaClpoTN0SsvcgDml6t1SOc9TjncArgojk
 c6h0/uhwwrOoLASPVEgGL3gtS5hp1PHBQjf2Q6nZmqWZ6PFCiYXkFJVV+DYu31D2mTyO
 JvVeTRBDLNN7sAeGxobVMJhoOWj9NTsbl7KGuNP5BKn43owFmUsQmv/5sZ9TGoCg+/1a
 +d1Q5qe/ckHWuiFCfx0r2nAwUaFMidT8RWnmePB6hzWOeD/nMyuCsGQGi+Orv7UMvcFy
 8unl4ZK5abyDAUjgFD+zc5ki44iSHbq6p+3AU1Zt3bp1bazN8MKmjh7dKq3l81qx8Dg+
 C/WQ==
X-Gm-Message-State: AOAM531IL7v6yCeR0azzW3x0anyopclf7wvbRYvkspljqK2XzNtFnxEQ
 dvcFmbMeqPjFjbuS/s8eTJ0=
X-Google-Smtp-Source: ABdhPJxB3gljYCDzhhMFX27tKqIYnQM7OO3KRHjZpIQLC7NwGuvhZ0enz98UwkDjdDqDQ6720JUEWg==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr20266617wrq.156.1592843108255; 
 Mon, 22 Jun 2020 09:25:08 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c25sm34972wml.46.2020.06.22.09.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 09:25:07 -0700 (PDT)
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <52ed69dc-82c2-8754-eddf-2ce3c92ec79e@amsat.org>
Date: Mon, 22 Jun 2020 18:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 6:01 PM, Peter Maydell wrote:
> On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> The following changes since commit 06c4cc3660b366278bdc7bc8b6677032d7b1118c:
>>
>>   qht: Fix threshold rate calculation (2020-06-19 18:29:11 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/philmd/qemu.git tags/renesas-hw-20200621
>>
>> for you to fetch changes up to 730101266e4026fc19808c740ee4b8118eeaaafe:
>>
>>   docs: Document the RX target (2020-06-21 01:21:47 +0200)
>>
>> ----------------------------------------------------------------
>> Renesas hardware patches
>>
>> - Add a common entry for Renesas hardware in MAINTAINERS
>> - Trivial SH4 cleanups
>> - Add RX GDB simulator from Yoshinori Sato
>>
>> The Renesas RX target emulation was added in commit c8c35e5f51,
>> these patches complete the target by adding the hardware emulation.
>>
>> Thank you Yoshinori for adding this code to QEMU, and your patience
>> during the review process. Now your port is fully integrated.
>>
>> Travis-CI:
>> https://travis-ci.org/github/philmd/qemu/builds/700461815
> 
> Hi; I'm afraid there's a format-string issue here (manifests
> on OSX, openbsd, and 32-bit platforms):
> 
> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function 'rx_gdbsim_init':
> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error: format '%lli'
> expects argument of type 'long long int', but argument 2 has type
> 'ram_addr_t {aka unsigned int}' [-Werror=format=]
>          error_report("Invalid RAM size, should be more than %" PRIi64 " Bytes",
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                       mc->default_ram_size);
>                       ~~~~~~~~~~~~~~~~~~~~

I apologize, I missed that while rebasing on Igor's memdev work.
I disabled my obsd and win32 builds after they started to fail
few months ago and forgot to re-enable them after they were fixed.

We recently dropped the Travis-CI OSX builds (commit 22a231950)
in favor of Cirrus-CI. There the build succeeded (Mojave):
https://cirrus-ci.com/build/6678899172048896
What is different in your OSX setup?

I'll respin with:

-- >8 --
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 8cd7a438f2..b8a56fa7af 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -17,6 +17,7 @@
  */

 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
@@ -90,8 +91,9 @@ static void rx_gdbsim_init(MachineState *machine)
     const char *dtb_filename = machine->dtb;

     if (machine->ram_size < mc->default_ram_size) {
-        error_report("Invalid RAM size, should be more than %" PRIi64 "
Bytes",
-                     mc->default_ram_size);
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be more than %s", sz);
+        g_free(sz);
     }

     /* Allocate memory space */
---

