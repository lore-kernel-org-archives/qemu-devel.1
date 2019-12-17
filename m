Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482CBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0875B24655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvup+Fbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0875B24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFzU-0006QX-H4
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihFv4-0001Ft-Tz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihFv3-0003g7-Ln
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:41:58 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihFv3-0003eh-GC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:41:57 -0500
Received: by mail-pj1-x1042.google.com with SMTP id l35so97674pje.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=43Dbd2S1AzJNiOKd7dHnjOLXefnUc+FpgARmyexaboI=;
 b=gvup+FblALos6y8TtuxoA/RhPQpTbv5FW4Eja/poTMM4RUe+emsfSWVnmd8OcYY+8e
 NFPx2P00XGu2YLVQ9x6u9ZiFOw4ZcxquK0NT5DBPaGukkS73Rb6C8cs96mdJ6qE0ZMty
 /H2RBDMnuCfJNIVZQBETlxRm0fK8OnIXhndOFO4HYqmZGxqjerN2KUi6PnBa2Fnz4I7Z
 xPsVaCehtEL/nz7qRXVPiW9evzP7BTFINABk7rjTbV9t0x2M210v1U9IBS0QvGrB02mS
 EnyCY0ZdLYQI6JjX/APFOdhzgL75gwd+5bU0zqeXrkUIgShAenqfKJOaCC0dk8cwHaGV
 BnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=43Dbd2S1AzJNiOKd7dHnjOLXefnUc+FpgARmyexaboI=;
 b=U2i88XUN5Nu33sNM2wWcB8k3XxUh5H3fjpZl7HEQ+z99aMV1PLNoCJw13Az3H2DxMJ
 +E0yP9muI49WXXXxNx2U1S1ATEW2g/szdCiLNszaFPh0Zy8Qnra5kMYhygTI69YTT0tx
 iEhONhFuo8QKboLFwczDZMWPZqFen5ASYtQhSJ6pJxu8pYxZMUMA+WF0IHXFQoNLcwc3
 U2jGHe/d004fyHXJbvP9CoZ1AHOnaxuLgNaStkQdCAV31uHRJYldnbEnVV3/V7C+O/yV
 fqlcOZ1fJc8S8t5BMKyxbxQq9RorjdURHt4T+r4ajA6FFPoin23a9gDshWNgkzKmUXy0
 xDrQ==
X-Gm-Message-State: APjAAAW0yGUL1WjZTlOxghjvw6FTGP0SOKKnB0ucUsHLZLrGZo60Rc+l
 JWnHYE8BJTnAZcOnFI7Na73sx+2wmiA=
X-Google-Smtp-Source: APXvYqyBNwGeeOIQBndVpfipHxTpMo6e7mgI4szvoGmDgeO7aLHz2x5VyjbpD+Br/+eskhzEPgEZpg==
X-Received: by 2002:a17:90a:e28e:: with SMTP id
 d14mr7467390pjz.56.1576600916139; 
 Tue, 17 Dec 2019 08:41:56 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k190sm27695401pga.73.2019.12.17.08.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 08:41:55 -0800 (PST)
Subject: Re: [PATCH v2 06/10] arm/arm-powerctl: rebuild hflags after setting
 CP15 bits in arm_set_cpu_on()
To: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-7-nieklinnenbank@gmail.com>
 <CAPan3WpW1Q3zpnqgk=MWRWe99=MQ4XoW2kw8L3tioFxfEBXd+Q@mail.gmail.com>
 <CAFEAcA8Viii4Em_bf4Y=AG0jU+EFFFTX6dO-52qd=RT4uHbCVw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19e4f2ac-6067-f61f-f340-108545fb0f02@linaro.org>
Date: Tue, 17 Dec 2019 06:41:52 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Viii4Em_bf4Y=AG0jU+EFFFTX6dO-52qd=RT4uHbCVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 6:12 AM, Peter Maydell wrote:
> Cc'ing Richard : this is one for you I think... (surely we
> need to rebuild the hflags from scratch when we power up
> a CPU anyway?)

We do compute hflags from scratch in reset.

It has also turned out that there were a few board models that poked at the
contents of the cpu and needed special help.  Some of that I would imagine
would be fixed properly with the multi-phase reset patches, where we could
rebuild hflags when *leaving* reset.

In arm_set_cpu_on_async_work, we start by resetting the cpu and then start
poking at the contents of some system registers.  So, yes, we do need to
rebuild after doing that.  Also, I'm not sure how this function should fit into
the multi-phase reset future.

So:

>> On Tue, Dec 17, 2019 at 12:36 AM Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>>>
>>> After setting CP15 bits in arm_set_cpu_on() the cached hflags must
>>> be rebuild to reflect the changed processor state. Without rebuilding,
>>> the cached hflags would be inconsistent until the next call to
>>> arm_rebuild_hflags(). When QEMU is compiled with debugging enabled
>>> (--enable-debug), this problem is captured shortly after the first
>>> call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-secure mode:
>>>
>>>   qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
>>>   Assertion `flags == rebuild_hflags_internal(env)' failed.
>>>   Aborted (core dumped)
>>>
>>> Fixes: 0c7f8c43daf65
>>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>>> ---
>>>  target/arm/arm-powerctl.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
>>> index b064513d44..b75f813b40 100644
>>> --- a/target/arm/arm-powerctl.c
>>> +++ b/target/arm/arm-powerctl.c
>>> @@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>>>          target_cpu->env.regs[0] = info->context_id;
>>>      }
>>>
>>> +    /* CP15 update requires rebuilding hflags */
>>> +    arm_rebuild_hflags(&target_cpu->env);
>>> +
>>>      /* Start the new CPU at the requested address */
>>>      cpu_set_pc(target_cpu_state, info->entry);
>>>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

