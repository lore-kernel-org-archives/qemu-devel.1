Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE36C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809D52084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpCXA0K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809D52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2Jh-0004dz-HQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc2J7-0004Ed-2w
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:13:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc2J5-0002rk-Ad
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:13:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id 23so4908493wmg.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LfRvXqC6mGefw6JZ/IrznUda4C7hp5xIkkt/ix2f810=;
 b=FpCXA0K2diiuDyqHid6Hi8hZZ6wx2ussVncoSH6tmLAn52Yw5cENGTQ3+3zcfoLEV7
 H1EonGhHQntpCm2OBOVPOs3HqwdaT6fRnyOZr08ZHTmyKtQx4yvZschd1h95zA4ZvEW+
 BLxOLRAAUNMNW8xIsh/WCsm3UBnin4o9wNSWa65mWYvBjz4fklFNChggeBXJrGPayGux
 b+9WV6BL86GmetsiJHmVsAkerLhvv0NM+hQkfJhz4YeCRCOZYRTUMFGbVeN+gPspCFEK
 nwSxQO+ikl6rS9NEtHuw480L5kdBWpchUEFLbVSY7zWciHLXtkiyDNn1RKssbfWLmnId
 wtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LfRvXqC6mGefw6JZ/IrznUda4C7hp5xIkkt/ix2f810=;
 b=hJ9eaf7b+LgUiWoZTBNpRacVmm2YnmOUOLV53Emqi1JBJM0++llgv2PMb5IYoZ+X41
 8yCPDts3gwNYtwYnk2YLl3I9CTNE88XvZ9uRZ/u+pDVL/NDBVCF+mBKwlVBKVKi7i6i7
 cQYjKtfNwRzB0ldXtRlpFqcUCRL9pPKGh7CG31WpwIChJvAb9okq/4GVlerjW2AnY6M5
 0vpH1TKE8FaGwlPbMefooBEMcHmi8q8tS74o2fhL3o6qBBJZQLtVmUGvbBAIc4z20EsL
 hCxc5/eRfoLAvqgaZ4wI8XY25BWuoA/iy1egPf6PX8kFbBzOHxB4QGeQ15qn87Y6yfzd
 q0mw==
X-Gm-Message-State: AOAM5320/aPo3WLU5OpuzQF+s6E7NXEzXZlNZPfaWCpG8rgrAHRqPZ+D
 CK2q3mQoc4bO1DKiwHzTFgE=
X-Google-Smtp-Source: ABdhPJzpBSvUO1ced5u821AzQccRdvP0XqOIHWCyweq643KT2W0WbIefjltlqotsr+THLmDqz3gNQQ==
X-Received: by 2002:a05:600c:21d5:: with SMTP id
 x21mr13898965wmj.133.1604909621039; 
 Mon, 09 Nov 2020 00:13:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d63sm11720761wmd.12.2020.11.09.00.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 00:13:40 -0800 (PST)
Subject: Re: [RFC PATCH-for-5.2 v2] tests/acceptance: Disable Spartan-3A DSP
 1800A test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201109081231.2409773-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ba13129-5213-0898-a60c-0372ac59ba21@amsat.org>
Date: Mon, 9 Nov 2020 09:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109081231.2409773-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 9:12 AM, Philippe Mathieu-Daudé wrote:
> This test is regularly failing on CI:
> 
>    (05/34) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_microblaze_s3adsp1800:
>   Linux version 4.11.3 (thuth@thuth.remote.csb) (gcc version 6.4.0 (Buildroot 2018.05.2) ) #5 Tue Dec 11 11:56:23 CET 2018
>   ...
>   Freeing unused kernel memory: 1444K
>   This architecture does not have kernel memory protection.
>   [nothing happens here]
>   Runner error occurred: Timeout reached (90.91 s)
> 
> Do not run it automatically (it can still be run setting
> AVOCADO_TIMEOUT_EXPECTED=1 environment variable).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Include failure log

I incorrectly used "RFC" in subject, sorry.

> ---
>  tests/acceptance/boot_linux_console.py | 1 +
>  tests/acceptance/replay_kernel.py      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 8f433a67f84..010e8790c0f 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -1025,6 +1025,7 @@ def test_m68k_mcf5208evb(self):
>          tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
>          self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
>  
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>      def test_microblaze_s3adsp1800(self):
>          """
>          :avocado: tags=arch:microblaze
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index 00c228382bd..c1f5fa4de71 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -280,6 +280,7 @@ def test_m68k_mcf5208evb(self):
>          file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>          self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
>  
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>      def test_microblaze_s3adsp1800(self):
>          """
>          :avocado: tags=arch:microblaze
> 


