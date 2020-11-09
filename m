Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B650F206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJqO3xSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B650F206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3JU-0006Mp-Ng
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3BR-0005I0-EA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:53 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3BP-0007Bt-MB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id d12so6306913wrr.13
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7ZQ2quXzikAOi/YWC4QujbfmVGXLjSPRMAC55N3U/8k=;
 b=hJqO3xSsB34yKkjnFuQagbsIDcTLctUmcg306FjG8cUdeghA7PckxAgx9D7M0snGyV
 xb9a0OUETYbRqd93czyUs25zmn7XtM+cz2sM+tzRDg0OemSlSrWK9z1eCDCl6nOOlG2d
 /wqcpncrPXMW9wvexrTpHfQ1/NecjNTsOy3s9cb6IbbU+WDwm1OxmZTwB3cC+hS//BGY
 +Js60aYITze05/FZJ3d3CkZM0XevvGbbBbAUHssU7XEMlCXm/+7zCF0dzgy+IRulHdjt
 CBOlJmJrrKCdJaIZQLUqyrRl0yYLxt3nbExo+ElroZ44IJfq3alHnApxXXjJiDuu3HI7
 5QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7ZQ2quXzikAOi/YWC4QujbfmVGXLjSPRMAC55N3U/8k=;
 b=XEZAS/tWuHvjxJEUU8EwOKOK6iv/zfWBcKr/H8DEgKOCD/8F1BWRkQYhNIU0DFKf8r
 28Ay2HvvJG4pWlnJ9sdhcnJLQBeZoLOyOBK2gCBBjWyRiSfNK+7oiXyd84deJJ3O1jUP
 4FbqyW508THYz2lRGIRpm7hCl5SovdViCTKmoMWLK7vgZepM9yTsp7IMeqBmnLzMVjZ9
 Iagahgv8E+yPbCSNIclTM9LvVLzp/tzUJkLjf/roOS+Lrw1J5g3mHiMVWeRJtSSTGQr6
 YKTYH6YRnacar9d0uVmhXzzziRY19XXSJnF1bSLy7UU4d+v5oJhXftlOz+tNBPvjz7u2
 GRGg==
X-Gm-Message-State: AOAM531hFyTSuDbl8NHbTDlRGTinvDzxJYL6b8UdTd65worbR2ubZOnL
 ijmHR6YNT89xmOiTcoP0DXA=
X-Google-Smtp-Source: ABdhPJw2rS5NNe3kqNy7nYOclFkUpG4pv9dSTjqx0HS7Wjfrvy/r/gDBSX30k52As2F4bPt+4keeNw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr16979481wrv.359.1604912990149; 
 Mon, 09 Nov 2020 01:09:50 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n9sm12164858wmd.4.2020.11.09.01.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 01:09:49 -0800 (PST)
Subject: Re: [RFC PATCH-for-5.2] tests/acceptance: Disable Spartan-3A DSP
 1800A test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201109080747.2408489-1-f4bug@amsat.org>
 <a991b796-0d03-6a2a-1008-6e7d2edc9e54@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7d65bef-846d-6880-937b-c3095bda9a09@amsat.org>
Date: Mon, 9 Nov 2020 10:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a991b796-0d03-6a2a-1008-6e7d2edc9e54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 10:04 AM, Thomas Huth wrote:
> On 09/11/2020 09.07, Philippe Mathieu-Daudé wrote:
>> This test is regularly failing on CI :( Do not run it automatically.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/acceptance/boot_linux_console.py | 1 +
>>  tests/acceptance/replay_kernel.py      | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 8f433a67f84..010e8790c0f 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -1025,6 +1025,7 @@ def test_m68k_mcf5208evb(self):
>>          tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
>>          self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
>>  
>> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>>      def test_microblaze_s3adsp1800(self):
>>          """
>>          :avocado: tags=arch:microblaze
>> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
>> index 00c228382bd..c1f5fa4de71 100644
>> --- a/tests/acceptance/replay_kernel.py
>> +++ b/tests/acceptance/replay_kernel.py
>> @@ -280,6 +280,7 @@ def test_m68k_mcf5208evb(self):
>>          file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>>          self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
>>  
>> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>>      def test_microblaze_s3adsp1800(self):
>>          """
>>          :avocado: tags=arch:microblaze
> 
> I think this is a recent regression - it hasn't been failing in the past. We
> should first try to find out why it is failing now before sending it to the
> @skipUnless nirvana... could you maybe add it to the "Known issues" at
> https://wiki.qemu.org/Planning/5.2 instead?

I agree it looks like a regression.

I disagree we should keep broken tests failing the pipeline,
even if we are not using a Gating CI.
I see test_leon3_helenos_uimage has @skip("Test currently broken")
meaning we know there is a problem somewhere, but we don't have
clue/resources to fix the bug, so we demote the test to avoid users
avoid running CI tests.

I'll replace by that.

Regards,

Phil.

