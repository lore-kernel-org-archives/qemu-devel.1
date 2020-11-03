Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3787420E65
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyP5D4JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3787420E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzvs-0004Zl-9T
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZztu-00025H-LM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:15:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZzts-0004iw-N5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:15:18 -0500
Received: by mail-wm1-x343.google.com with SMTP id c16so70209wmd.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RIDi68FtSRrge15G39Uk8YncI2fL88pAS4XBX1V0648=;
 b=CyP5D4JO2CrrgU3L3goTHlPUc+4fnBvtflccVo8gTfPX7WjCFV3mD51JbvXou44sw3
 9rLP6/6oFpTMH0rsH4o0M2+xjMRwShDiz1veQVFS7vKVvY7VWwAbSTUbA8gwliav+NT2
 3U9xF27EFJha3TJoZBF4K7jp8blAIAbjNb3VWW5qcU7+/oqbV1A29AfR2D/NNcChbabz
 5CMUyLRsfqt2Iyy5W5PAY6yux/30NPAmc4ScbVIbIKvE+ePtjOh35jczIZbj0IrUtcKP
 zrEuP5ym5ixKIZ0nmuUWt+zW3mziKN78KaK99RQPYp4NwR26+Msuh7bWRO+YdRgD3MN0
 /I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RIDi68FtSRrge15G39Uk8YncI2fL88pAS4XBX1V0648=;
 b=gYp+UNnVH+jU2qs7qXYsqarDYF+tW6zP6Me2VmzrUExPQA2LzCuBnOniPyJXDcEZc7
 /yrXHP4cbcKyFqXJZcZLNR8QGrbeJO2pWC6zUlYUqBkUYjNX3GrCFjBPj11oiZlI1kLW
 VsUjbOCVVrkBOIkKT+MwPbvZ47ZkD1op37d4iBjzVRw5OvmzFobvljiVs7b12lHWDNmD
 RmFfX6OtS+4/W4qU0r3K1m6BP+vyggXC+RlD4KizFu7V0MmYzrMGjrMAGZdwO4OkBGpv
 j+5lSfhO+QQwoCoSOl6Q128e8Z1V5bvUMiopJCxyHFW4EX3vTxG7OWfje1pK48A1pGFe
 sr9g==
X-Gm-Message-State: AOAM533TtseNBARDPTKSYQJ/UZzlGJ9o5ESjpZGQRaPz4Rxtf3yjyJ8d
 LFp1FJ2z/+56wgPxTjNTcIM=
X-Google-Smtp-Source: ABdhPJyCBlKEreZS52jw6AzS1Uixj7Z9kKkbE7Ge8Nj1UYQZDCEhQ/vINT4LdrLB2UlZyXnR7Nq24Q==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr169766wms.130.1604423715190; 
 Tue, 03 Nov 2020 09:15:15 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d8sm3378681wmb.11.2020.11.03.09.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 09:15:14 -0800 (PST)
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, AlexChen <alex.chen@huawei.com>,
 chenhc@lemote.com
References: <5FA12391.8090400@huawei.com>
 <a4915556-bc78-a8c4-c887-f53ed14251b6@amsat.org>
 <02FD0B38-19BC-442F-9DAB-1B56BB8115B0@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c3e1462-fdbf-5e2e-6664-28e3ea44b609@amsat.org>
Date: Tue, 3 Nov 2020 18:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <02FD0B38-19BC-442F-9DAB-1B56BB8115B0@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: zhengchuan@huawei.com, Markus Armbruster <armbru@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 4:40 PM, Jiaxun Yang wrote:
> 于 2020年11月3日 GMT+08:00 下午8:28:27, "Philippe Mathieu-Daudé" <f4bug@amsat.org> 写到:
>> On 11/3/20 10:32 AM, AlexChen wrote:
>>> According to the loongson spec
>>> (http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
>>> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
>>> that the ISR size of per CORE is 8, so here we need to divide
>>> (addr - R_PERCORE_ISR(0)) by 8, not 4.
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>> ---
>>>  hw/intc/loongson_liointc.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> For a model added in 2020, its code style is a bit
>> disappointing (leading to that kind of hidden bugs).
>> I'm even surprised it passed the review process.
>>
>> Thanks for the fix.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> It was my proof of concept code.

Don't worry Jiaxun, this comment is not to you, but to
the QEMU community as a whole. We should have asked
improvements during review, and explain what could be
improve, what is not the best style but acceptable,
and what is good.

> Any suggestions on enhancement?
> I'll have some free time afterwards so probably can do something.

It is a bit awkward to not comment on a patch (diff).
Comment I'd have made:

- Add definition for 0x8 magic value in R_PERCORE_ISR()
- Replace R_PERCORE_ISR() macro my function
- Replace dead D() code by trace events
- Use a simple 32-bit implementation (pic_ops.impl.min/max = 4)
  to let the generic memory code deal with the 8-bit accesses
  to mapper[].

If you have time, today what would be more useful is to have
tests for the Loongson-3 board.

You can see some examples with the Malta board in the repository:

$ git-grep malta tests/acceptance/

Regards,

Phil.

