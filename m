Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E79BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278FE206F2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syz2rBGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278FE206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnvQ-0001wO-Et
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxnum-0001ND-MK; Tue, 21 Jul 2020 04:46:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxnuk-000238-U0; Tue, 21 Jul 2020 04:46:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id r12so20254079wrj.13;
 Tue, 21 Jul 2020 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c+JpR+G3QSC03q3FNhA3hK64fihmyt6mvJum4S1jYIA=;
 b=syz2rBGXNULb7TJUZWa9zgIvWydmRUtV1iPVg9/j9aoZRe3f5AjXlcP6KVNmetHcx8
 6pxUQLKx3OZGIiHpDQbIf020ePgoVOz5Crk+JpxcVRRc4E0+k4P8xOTLSPJK/JbKleO4
 BzNSgtSHlQXmQ7kzB4EMZHbTmqCGQC+UJI07vyqWJtuxEW+bTei41M+Ca4mEEPFz2ptJ
 WaoZVGuyIYevfoouQuTtExweTjLDw5VMyUOquCMkCIvXXOkjbQZVGj1EVPQPMqY1O8xN
 kj/HpfzNkIAJDfxWQ2fEs+cOVIFdPu856vFl7A7H4hgz5dYDdos7AoLsNOnpmO1M3npl
 UhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c+JpR+G3QSC03q3FNhA3hK64fihmyt6mvJum4S1jYIA=;
 b=kVD00eifwV1yetW+FQN/Wq2pSqAwAXGAKzlCLwXhIkVA7FymwV9KL+vT/M1N2MRzPD
 40yBOEemUUsWwJzBwvC63ieOt/Q5oVx6TyNWsyj0DhOTHVhJhThYCdVixPwGxyYdCHAa
 g7z+XnEiWxXkhXmFfxeyQ7uvoZTk8duujyfFRctavBR60gJ5h5VT48lX2RRvHWwzdRGO
 NX2HiPFD+XOA7SicM5rTl9yYGBOAEG01FTfDsw41+OV3CG+IChd6tK3dCAhFOvxxT4kN
 t1ODwiCIvBsSUgD/T+f7frV5g15RqBIUa+Jg8yJR9xR/SW+UU3EkH0kzGhzlFWCEHgmG
 R2QA==
X-Gm-Message-State: AOAM532bqzRH3KVzbmd6mjc0ITRIEt5lipbYox4GqwImHOGULzr+/W+H
 7/oT6cEsz07O0pfH7+w6hXCUNj9SMEc=
X-Google-Smtp-Source: ABdhPJyB5mzvHuxaJPNDsamt8Uam3TW8W2ycF3X8zrmQPCCXQp9o3AX0LcokVG9dyN9Qdq38OwCEXg==
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr24412192wrx.332.1595321176871; 
 Tue, 21 Jul 2020 01:46:16 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 31sm18647500wrj.94.2020.07.21.01.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 01:46:16 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/isa/isa-superio: Fix IDE controller realization
To: Markus Armbruster <armbru@redhat.com>
References: <20200720172348.23465-1-f4bug@amsat.org>
 <87zh7t9tda.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c0c7fd3d-fa14-df6f-ecb9-44a7a2a783e6@amsat.org>
Date: Tue, 21 Jul 2020 10:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zh7t9tda.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 10:15 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> When realizing a Super I/O with IDE controller [*], we get:
>>
>>   qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
>>   Aborted (core dumped)
>>
>> This is because the device is already realized when we try to
>> add the QOM property to the parent. Fix by realizing *after*
>> adding the QOM relationship.
>>
>> [*] Set ISASuperIOClass::ide.count = N with N not zero
> 
> Is this a latent bug, or can it bite in master?  If the latter, can you
> show how to reproduce?

Latent bug for master:

$ git grep ide.count
hw/isa/isa-superio.c:149:    if (k->ide.count && (!k->ide.is_enabled ||
k->ide.is_enabled(sio, 0))) {
hw/isa/isa-superio.c:197:    sc->ide.count = 0;
hw/isa/smc37c669-superio.c:100:    sc->ide.count = 0;
hw/isa/vt82c686.c:529:    sc->ide.count = 0;

I hit it rebasing undergoing series for 5.2 and testing them.

> 
>> Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/isa/isa-superio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
>> index e2e47d8fd9..179c185695 100644
>> --- a/hw/isa/isa-superio.c
>> +++ b/hw/isa/isa-superio.c
>> @@ -158,8 +158,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
>>          if (k->ide.get_irq) {
>>              qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
>>          }
>> -        isa_realize_and_unref(isa, bus, &error_fatal);
>>          object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
>> +        isa_realize_and_unref(isa, bus, &error_fatal);
>>          sio->ide = isa;
>>          trace_superio_create_ide(0,
>>                                   k->ide.get_iobase ?
> 
> 

