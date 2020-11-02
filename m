Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829DCC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF94F2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGHfPjY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF94F2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZf38-0004l7-Ry
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZf2E-0003Wl-O5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:58:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZf2D-0003G1-48
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:58:30 -0500
Received: by mail-wm1-x343.google.com with SMTP id d142so1824252wmd.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2AFt7lA6Nxr2VPtOX0EuACgFkXjS2a1g6CYen2ChwVc=;
 b=DGHfPjY8H+GlA7sd54SeLrnWtAAOVAOh462W1vJIVhoEDudo9bUGDHiTyOvM++UJOF
 oqcAmbZk3wwAWICOazL0ZE8X4pu9RN3yt7TeCCwe+h+GzFgAI2TgGmUC1Bzk7vhvDqzz
 1rN/OhnF9ukw8kHYPqkXvt7X7hOzi7Ec7bXjGIhxYnWjcWT6UQzxzUenQ8EnGqqlq7u5
 CrRm0FckeESrp0XCCPQ7Ezpdx4Oiy4viowie2iqdxPAT9LF5SojGUgVcSIJ2o0Sw2pf4
 bhLogHVNQYxn1x7ryhkUaJJKjoPCJGQ4I7IIbfYaqC269W3J3hvfT7aMjKMpznJUCI1m
 phPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2AFt7lA6Nxr2VPtOX0EuACgFkXjS2a1g6CYen2ChwVc=;
 b=MGM2nqEhEJh3lXrVYB5rmd77LK+efDfjUNkEAyypYdxUL8Use52k5aCSkrrtc+Cgbv
 ZWW/+X0bGLQM08ZJDkfAU3wvBMNXBYgCn6IzPyptbghvqx0Z5hF7/f6R09Q78q23RbLx
 c/kvLnz1p3XfLFgtTMKh+cAb6fregG/h9wHZx/+WEjB2W8RRZzz0WuGSNnftLxZmEyYK
 D8GxjBLbiDvRJGZ8BCZbgzZjkUJ4v78cyZ40BB7m4FTy63YcZMI8zESZLudBdaaX4Yts
 DEJF+JkJcXpI/UB29G5dEmuA0ACkfSTbX7UOsGcLynlJ5hwuVpBJtX6ueu1mNIshGf6s
 e8hw==
X-Gm-Message-State: AOAM533UEEGsQniMeua474MNyMl5DCxQkWnEkLO/hp92EwQ6ObzOylWJ
 6BnpxPp5N6oeEAspCqjBmak=
X-Google-Smtp-Source: ABdhPJzd+nzRmawp/ahyWXxNqVkK0rKibwcR67ImIUyTlFgbR3Agv4CytqHG78PtPY5bCU4gnYQ94g==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr15651796wmf.185.1604343507751; 
 Mon, 02 Nov 2020 10:58:27 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t19sm415708wmi.26.2020.11.02.10.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 10:58:27 -0800 (PST)
Subject: Re: [PATCH] qtest: add a reproducer for LP#1878642
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-devel@nongnu.org
References: <20201102163336.115444-1-alxndr@bu.edu>
 <7825a2e7-dd79-c4ea-c3f7-673743619d89@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d2fee64d-8ad3-7c84-1988-084ab416b7e1@amsat.org>
Date: Mon, 2 Nov 2020 19:58:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <7825a2e7-dd79-c4ea-c3f7-673743619d89@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 7:23 PM, Paolo Bonzini wrote:
> On 02/11/20 17:33, Alexander Bulekov wrote:
>> https://bugs.launchpad.net/qemu/+bug/1878642
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> ---
>>
>> Based-on: <20200717151705.18611-1-f4bug@amsat.org>
>>
>> The added testcase will fail, unless this ^^^ patch is applied.
>>
>>  tests/qtest/fuzz-test.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
>> index 2f38bb1ec2..9cb4c42bde 100644
>> --- a/tests/qtest/fuzz-test.c
>> +++ b/tests/qtest/fuzz-test.c
>> @@ -34,6 +34,19 @@ static void test_lp1878263_megasas_zero_iov_cnt(void)
>>      qtest_quit(s);
>>  }
>>  
>> +static void test_lp1878642_pci_bus_get_irq_level_assert(void)
>> +{
>> +    QTestState *s;
>> +
>> +    s = qtest_init("-M pc-q35-5.0 "
>> +                   "-nographic -monitor none -serial none "
>> +                   "-d guest_errors -trace pci*");
>> +
>> +    qtest_outl(s, 0xcf8, 0x8400f841);
>> +    qtest_outl(s, 0xcfc, 0xebed205d);
>> +    qtest_outl(s, 0x5d02, 0xebed205d);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>      const char *arch = qtest_get_arch();
>> @@ -43,6 +56,8 @@ int main(int argc, char **argv)
>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>          qtest_add_func("fuzz/test_lp1878263_megasas_zero_iov_cnt",
>>                         test_lp1878263_megasas_zero_iov_cnt);
>> +        qtest_add_func("fuzz/test_lp1878642_pci_bus_get_irq_level_assert",
>> +                       test_lp1878642_pci_bus_get_irq_level_assert);
>>      }
>>  
>>      return g_test_run();
>>
> 
> Queued, thanks.

Great, did you queued the fix too?
(https://www.mail-archive.com/qemu-devel@nongnu.org/msg725783.html)

Regards,

Phil.

