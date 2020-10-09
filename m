Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5183DC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A0B22259
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP0cnvW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A0B22259
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQusf-0005ay-MJ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuov-0002m4-Hr
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:00:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuot-0000yp-IJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:00:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so10841038wrq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JEPggkBeI4VNTiOy1yfzZusKLxuhYM1OP47yibR9+tg=;
 b=IP0cnvW6t1ly0Ps0UwkTgu/LhT2hb/ZfTaCYT6QK/6TXkBzdcHGKQSyzKsOJ7PKVCy
 L0hvy12YmBnamN7KJPazLCmD8ojIzG69l9hnQFUrx0c1mNaozI6AuepJyG/zhhJPQBQL
 Q/dJgb9m8p0683wjw6cPCq3VKbgRdaqppyho4qLCz98wJ2FuZu7t1AACsLR8R3vfQFBZ
 mIt/8F+/s+bxsdhF3LYJ/apTuLy6U4/hc6MIVlFx6iJc4bsNYBV/MSCv26pfNEH9TbgG
 BtxO4P8f2Lh73RW4jag9Dr9ewl+s9aQ2vv4RgyA1NWES5lMyHBMu65CHwtBqmi4bc1dL
 d94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JEPggkBeI4VNTiOy1yfzZusKLxuhYM1OP47yibR9+tg=;
 b=cJN2SicLWvOJF7DQ3PS51SAGFE5MYHbD2h7HMA00JcEM6spTgCtA1EDhoBnutZ3bSW
 vXPAuGr8vlH2fuMpMy+xlV/iWE0yrR/dfP0tVdaf8DC2+wmV2Jg6IQH7jTXEjTe9lxXk
 hNm7UzO5k+veA6de0Ng5LJvDat/mZENKiJRi5yJ226QJucG8j8Hk0Ixwfhd/FnFzT7Kq
 SCb1tF2zc5k2vtwNbdbwn79fxFnafjkCXIKLfox1Fd7kI5+DJsNBGs7jo9a6bSdYU/XK
 6snOVxdzbzIlZfIOAyzV7DIZ8m2ldg+AdvcMS9ggIQtuXQqiq4/O50lHI0ESoP1LoeRF
 XvIA==
X-Gm-Message-State: AOAM531HjmMnHNuiTh3jwoQZXstWg0FyMxu0VwkZzc0kxKi7j9harbD1
 CFhMTsWj+4Wn0Yo71Cq/Zdo=
X-Google-Smtp-Source: ABdhPJwTFcKGwaN3dSAetTQwMkiopdKrZ0ZgFPK8xEi+pZ229j0+b3iMLndPVFwDOyt0ckYZEbIpLA==
X-Received: by 2002:adf:f212:: with SMTP id p18mr16260777wro.386.1602259233864; 
 Fri, 09 Oct 2020 09:00:33 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v8sm12344013wmb.20.2020.10.09.09.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 09:00:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm: remove exit(1) in case of missing ROM
To: Peter Maydell <peter.maydell@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
References: <159480834629.15819.10175861928294983612.stgit@pasha-ThinkPad-X280>
 <159480835744.15819.10383908697966018668.stgit@pasha-ThinkPad-X280>
 <CAFEAcA9f18nwJQhX5EGtHWeHjw4DbRBmU1xmZm8gCgOkSgP+Mw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be1c96a6-4d9f-a4e9-15b6-e7a6ef5827f0@amsat.org>
Date: Fri, 9 Oct 2020 18:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9f18nwJQhX5EGtHWeHjw4DbRBmU1xmZm8gCgOkSgP+Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 11:56 AM, Peter Maydell wrote:
> On Wed, 15 Jul 2020 at 11:19, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> wrote:
>>
>> This patch updates ARM-based machines to allow starting them without ROM.
>> In this case CPU starts to execute instructions from the empty memory,
>> but QEMU allows introspecting the machine configuration.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> 
> I guess this makes sense -- this is how most of our machines
> already behave, so consistency and being able to introspect
> the machine config are both worth having. Also these errors
> mostly pre-date the 'generic loader' device, which is another
> way to load guest code that the error-exit prevents. (You could
> even load guest code via the gdbstub if you wanted...)

Note the 'generic loader' device allows you to select any CPU
address space, while gdbstub is restricted to the first CPU.

> 
> Calling arm_load_kernel() must not be conditional -- it is the
> function which makes sure the guest CPU is reset.
> 
> (A handful of boards will call arm_load_kernel() only if
> !qtest_enabled(), but most call it unconditionally. We should
> look at why those handful of boards seem to need the conditional
> and either remove it if useless or see if it should be applied
> in other places or if arm_load_kernel() itself could be improved
> to make the check unnecessary for all boards.)

Who should look at that? Maybe add that as a byte-sized task?

Regards,

Phil.

