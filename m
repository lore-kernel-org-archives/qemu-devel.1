Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA132C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BD824670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yqu6RzLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BD824670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHzr-0004Oj-Oa
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idGK2-0005uN-Lw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idGK0-0003Ah-CZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:19:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idGK0-000342-6A
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575649139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8FkBmT49LXKNBsclsnSXXFcBOEc1Utu4LKmwsbCXCs=;
 b=Yqu6RzLUxCmTX/omRdr8DcAHCy1TldKqcQpwZm/8kh7nLv0H6ylfRiIJUyWXyEiXa1Uesj
 b3cWIZACQ9s9hA3895bYwNHWSsYc1OaXRYYyofUvNTXSa+dTnFMw9+uIoklquxAgXo16aX
 Ag/AHUhQsUdzwOQWU0RWo6dBWLIZ5ig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-okxgRtGWOkiNIh-bKaMVpg-1; Fri, 06 Dec 2019 11:18:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id v8so2276497wml.4
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XDTWNNsDHsp0CCh47OiHb+CMYdzkyMNSlMUYmHnXQpw=;
 b=FIcLYaXAUa16Z3LlQyH9ircsIRdi8ReY1+QnStry+MGyYZuSows7qMrjZnWeaTp2wh
 jbuUDX5u9J1X8+DLsGx761ZWdb+xgjVO/RbwO0HgSP4OQWnrlgIm+bBDB2TygujXpZyF
 mscoXg1omWRMAtWrM13E+sHWx54zMhbva8JgWN6lTq3ZaLuSjQW6ZfhhVQyfJjavssO3
 oNvtfeDmiuTHoPfHZcp5jKgF2rFBhcdSRt+0wRGtCkuoiWhszFT3y2P+w2oY6ctlXcsZ
 SEbTr5Cr31PHvChcylTJUnomlzxlZk2iSeAvl/WZZnncZJibTGjR1lUknwb411vYLoaP
 7hgg==
X-Gm-Message-State: APjAAAW5JIyRBoeNbEPs2lM1Etbj+hYG5jI4MkxTaEXVosYjD+MejTBm
 cuifdjpeBGsGGr9FuYKrbdcH4J95ylygXvAtB06BQwR4dCEfWquG8dv8af9TQwMYyRO40QYQ+Lh
 gA0floiDZkGsaf9A=
X-Received: by 2002:a1c:6485:: with SMTP id y127mr12068571wmb.19.1575649134714; 
 Fri, 06 Dec 2019 08:18:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVNJDRwMuaZGnChuAMtK61dM/NLc1UylbLzzFao/vm+w8iiiFe/5tmqj0GwNA+fUIb1y7Hkg==
X-Received: by 2002:a1c:6485:: with SMTP id y127mr12068550wmb.19.1575649134426; 
 Fri, 06 Dec 2019 08:18:54 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id m7sm11782414wrr.40.2019.12.06.08.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 08:18:53 -0800 (PST)
Subject: Re: [PATCH-for-5.0] hw/arm/sbsa-ref: Call qdev_get_gpio_in in place
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191206072257.7221-1-philmd@redhat.com>
 <CAFEAcA-n=RKviDr9h+hCdwETN-Et5+A--v+HU_DuwqCQ2BWdDA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75d0cce3-de3e-08ac-0ecf-c97d93e30c8d@redhat.com>
Date: Fri, 6 Dec 2019 17:18:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-n=RKviDr9h+hCdwETN-Et5+A--v+HU_DuwqCQ2BWdDA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: okxgRtGWOkiNIh-bKaMVpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 4:34 PM, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 07:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> Instead of filling an array of qemu_irq and passing it around,
>> directly call qdev_get_gpio_in() on the GIC.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> I accept better patch subject suggestions :)
>> ---
>>   hw/arm/sbsa-ref.c | 58 +++++++++++++++++++++++------------------------
>>   1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 27046cc284..30cb647551 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -328,7 +328,7 @@ static void create_secure_ram(SBSAMachineState *sms,
>>       memory_region_add_subregion(secure_sysmem, base, secram);
>>   }
>>
>> -static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
>> +static DeviceState *create_gic(SBSAMachineState *sms)
>>   {
>>       unsigned int smp_cpus =3D MACHINE(sms)->smp.cpus;
>>       DeviceState *gicdev;
>> @@ -403,12 +403,10 @@ static void create_gic(SBSAMachineState *sms, qemu=
_irq *pic)
>>                              qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>>       }
>>
>> -    for (i =3D 0; i < NUM_IRQS; i++) {
>> -        pic[i] =3D qdev_get_gpio_in(gicdev, i);
>> -    }
>> +    return gicdev;
>=20
> If you make DeviceState *gic a field in SBSAMachineState then
> you don't need to pass it in as a parameter to all these
> functions. I think this code is mostly borrowed from the
> virt board, which is written the way it is because at the
> time we didn't have machine state structs which could
> own all the device structs etc for the devices on the board.

Great idea, thanks!


