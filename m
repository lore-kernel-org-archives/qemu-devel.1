Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAABC206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWxq8cYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAABC206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8JU-0000nQ-UD
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc8IR-0007nX-Ec
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:37:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc8IP-0003Jx-Fx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:37:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id l1so4521591wrb.9
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ngJStzspPwt5gcj0E6T51Y8vDq+smHVcH66xON+ao7A=;
 b=bWxq8cYc0SicTjTi5o4FI6EFQFbf3IAgjbGtdZ0sJv/oBYwsX3GxkzUeWMD2jz8yOF
 39dMVWiFmSaVeYE8BbE87HteOdnWSQmGV+7UQYb/hJyx9hlu6LZmgFbX507xmXlZ41SR
 lTPOGxUq5KpTHhny+XF55iamEEIyvvrRPqfg3OcLwOtwhS5+txr/5Zts7i+gIzEHNlRS
 ZUbO+2He7vvJerB29UzwV3pPyuxRr0SliVpmepes1cykx1JYIQgRRWLLyEMp2mqMH9/K
 4KDD9tHZUZpSjAdf2OTSK3QnrrkqLyFov657gwpUee6wMYFgd1APYlqNq0Y1chluGCvh
 KMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ngJStzspPwt5gcj0E6T51Y8vDq+smHVcH66xON+ao7A=;
 b=iefTJ4cHBxGgLP/RtfzvpCT5WAKnyA8MxfTWYahm7ZcGjwdAi2vLTD4Wesw7A/ckUn
 zIIcZtlHEOkLGe5RHHd8FX6lldIF9SeiTv6wUqvCEmtIhyQ5bsokj4AW1bDogB81QpEe
 BX6qGgRiEQMS8Iz2uJvk7NuXza76SsnXp9xkWXAB4uR1QxQOpgkI+uQHjbTzYkPTZnpE
 hXKb4iAbi3JTCbeo8UHAJtE22PFR3xTlRWDPVs2pqFu9v5zYmii1RILGz2gVznEa8wKy
 hbUntGUBDYM4Z++AB2U624cja/NYa8KQbiGXxy+cAj+r9WddfxKNP0NAD2CXOVnBH94V
 J5BA==
X-Gm-Message-State: AOAM5300dCzBRynYanxGaybW0O2DeZ1mK0T9sZAYcXlzxhv+28se7jn3
 a7wtv58jizo7mZGraC2oBB+TIe5Z1iU=
X-Google-Smtp-Source: ABdhPJzkvD38YJlRqvngOnvrh5864cJZhJw5UYMWbOK075L+7sBhSOKu/lBxdPhDLyRTF+wy+P6RxA==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr17972760wrc.74.1604932643542; 
 Mon, 09 Nov 2020 06:37:23 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id w11sm13359487wmg.36.2020.11.09.06.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:37:22 -0800 (PST)
Subject: Re: [PATCH] qtest: add a reproducer for LP#1878642
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20201102163336.115444-1-alxndr@bu.edu>
 <7825a2e7-dd79-c4ea-c3f7-673743619d89@redhat.com>
 <d2fee64d-8ad3-7c84-1988-084ab416b7e1@amsat.org>
Message-ID: <0d27a5b3-1a20-6889-6de1-defdfe418266@amsat.org>
Date: Mon, 9 Nov 2020 15:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d2fee64d-8ad3-7c84-1988-084ab416b7e1@amsat.org>
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 7:58 PM, Philippe Mathieu-Daudé wrote:
> On 11/2/20 7:23 PM, Paolo Bonzini wrote:
>> On 02/11/20 17:33, Alexander Bulekov wrote:
>>> https://bugs.launchpad.net/qemu/+bug/1878642
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>> ---
>>>
>>> Based-on: <20200717151705.18611-1-f4bug@amsat.org>
>>>
>>> The added testcase will fail, unless this ^^^ patch is applied.
>>>
>>>  tests/qtest/fuzz-test.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
>>> index 2f38bb1ec2..9cb4c42bde 100644
>>> --- a/tests/qtest/fuzz-test.c
>>> +++ b/tests/qtest/fuzz-test.c
>>> @@ -34,6 +34,19 @@ static void test_lp1878263_megasas_zero_iov_cnt(void)
>>>      qtest_quit(s);
>>>  }
>>>  
>>> +static void test_lp1878642_pci_bus_get_irq_level_assert(void)
>>> +{
>>> +    QTestState *s;
>>> +
>>> +    s = qtest_init("-M pc-q35-5.0 "
>>> +                   "-nographic -monitor none -serial none "
>>> +                   "-d guest_errors -trace pci*");
>>> +
>>> +    qtest_outl(s, 0xcf8, 0x8400f841);
>>> +    qtest_outl(s, 0xcfc, 0xebed205d);
>>> +    qtest_outl(s, 0x5d02, 0xebed205d);
>>> +}
>>> +
>>>  int main(int argc, char **argv)
>>>  {
>>>      const char *arch = qtest_get_arch();
>>> @@ -43,6 +56,8 @@ int main(int argc, char **argv)
>>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>>          qtest_add_func("fuzz/test_lp1878263_megasas_zero_iov_cnt",
>>>                         test_lp1878263_megasas_zero_iov_cnt);
>>> +        qtest_add_func("fuzz/test_lp1878642_pci_bus_get_irq_level_assert",
>>> +                       test_lp1878642_pci_bus_get_irq_level_assert);
>>>      }
>>>  
>>>      return g_test_run();
>>>
>>
>> Queued, thanks.
> 
> Great, did you queued the fix too?
> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg725783.html)

Ah I see it has been merged in time for rc1 (commit 4177b062fc58d),
thanks. IIRC few months ago there was a bot responding to patches
"your patch has been merged", was it patchew? Maybe we can a job
to do that on GitLab, but the problem is to expose SMTP credentials
in a runner.

> 
> Regards,
> 
> Phil.
> 

