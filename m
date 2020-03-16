Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ACBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F28320663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TejipG6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F28320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsa8-0007H4-9U
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDqIz-0006Oi-RE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDqIy-000330-HC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:01:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDqIy-0002wk-AW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584367279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQ7dZwtJRHWr0ppwGHuRtSpECSj8PWFSLN0ojtxEM5M=;
 b=TejipG6/vIj7OXgE7wkRBENwU52uoS4RGr2osrZQn7BjepRgbxDWeUnlTwDW4Ujx6yQmNv
 encEZABOhI9hLlKwR9kclP+9DPMyvGaXfAacFi7bAtiMl0PwmNFNN+3LWwHYWK7V0p9e2F
 iblCMRhQu2j+TJOPZP3ow8xt/96xKNQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-ZKOeWPMIPi2aRfak0aAIhA-1; Mon, 16 Mar 2020 10:01:18 -0400
X-MC-Unique: ZKOeWPMIPi2aRfak0aAIhA-1
Received: by mail-ed1-f72.google.com with SMTP id i25so15289697edx.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D8+MyFj2dVLBMt/lZhSsIiYpmSpY6oum5eCHUAIHa+o=;
 b=URGZZQmjNew1EhI+MaHFQX0o2VK2wiUYECQuFYo0vRXQFCWKREgieuPUzO0pYGRrRI
 z34CHmiUxhYpTmKQMHnAlVZTpGkP/nKGwCZxjphDIYCpHU9K65SJ8psxjx/hUvibRsPR
 9IdImDCIA8U/L0+FWjDND3Zwyg15ezk4tJaYNLjZosh7DO1gnEybsgEeNOaVJ/I1hYwM
 ZFFDUglhqEyxhdDwQQSQ4LEnP596iuLCziZpDxzNz52++IdpH6TA+EYbIeTBB+OXIMuQ
 M52BeZhJc151RN3PdtBWYRYWxkgX+sV3w9L24jygka9cj0ySuY4ISwKz1X5R2Y35msWT
 VUpg==
X-Gm-Message-State: ANhLgQ1yFFEdOnTWcHmblxV3a4d4V62sO9ADgy7XLJaToQM2rTuceSmt
 v2dSW7rikvt/oWbCc77m49iKAApE3DBqjSCuZEPA7hBAVFQ7jzc8+0xNONuIhm0z1FLccuaaP5z
 mWua2cRcIWTK6jNk=
X-Received: by 2002:a05:6402:228a:: with SMTP id
 cw10mr20019edb.107.1584367276904; 
 Mon, 16 Mar 2020 07:01:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtNAP+1dxDLWYMCS8BE7op5z3Xacs9LPKoDtYKyZ4/pRd4HgFcV2LUjRIZL+OQ3U1KJRgvtUw==
X-Received: by 2002:a05:6402:228a:: with SMTP id
 cw10mr19997edb.107.1584367276712; 
 Mon, 16 Mar 2020 07:01:16 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c15sm169361edu.4.2020.03.16.07.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 07:01:16 -0700 (PDT)
Subject: Re: [PATCH 11/11] hw/semihosting: Make the feature depend of TCG, and
 allow to disable it
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-12-philmd@redhat.com>
 <CAFEAcA-jidDwoZCgf+xKjqHm8xo87iGr6pGtOcWp5iAcWrHETQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <169683cf-5784-b956-cf07-14fe287b6ee6@redhat.com>
Date: Mon, 16 Mar 2020 15:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jidDwoZCgf+xKjqHm8xo87iGr6pGtOcWp5iAcWrHETQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 2:49 PM, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 13:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> The semihosting feature is only meaningful when using TCG.
>>
>> So far only the ARM/MIPS/LM32 provide the semihosting feature.
>=20
> Also m68k, nios2, xtensa. riscv eventually but not yet upstream.
>=20
>>
>> Do not enable it by default, and let the few targets requiring
>> it to manually select it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/semihosting/Kconfig | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
>> index efe0a30734..06e9262af2 100644
>> --- a/hw/semihosting/Kconfig
>> +++ b/hw/semihosting/Kconfig
>> @@ -1,3 +1,5 @@
>>
>>   config SEMIHOSTING
>> -       bool
>> +    bool
>> +    depends on TCG
>> +    default n
>=20
> OK, this is the "do not enable by default" -- where is
> the "but do enable by default for the targets that use it"
> part of the config change ?

This is already the default for these targets, see:

commit 16932bb761e52c2ca9397b57af5bdc5bdc5ae6a4
Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Date:   Mon May 13 15:25:27 2019 +0100

     semihosting: introduce CONFIG_SEMIHOSTING

     There isn't much point building semihosting for platforms that don't
     support it. Introduce a new symbol and enable it only for the
     softmmu targets that need it.

I'll add that information in the description.

>=20
> thanks
> -- PMM
>=20


