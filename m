Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A030C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277942072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsZkklko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277942072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBG74-0008Sy-92
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBG6Q-0007wW-Qh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBG6P-0000Kd-K4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:57:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBG6P-0000K6-Fu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583751461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FyF79uDSNowMiBaGgFXRj7LyLnmpVBSm3VGRAE8Sw/I=;
 b=OsZkklko/JZWlkz1zQ++eelSJNnuP/Lb3lNKCmCDwS1s2wq+xz7ma8S4y/OHgF3EM0HvEz
 tuHsbDvmuAMKU9Vp0JU8kTYK/zQf3tTyHfQLnx1z76zF9lZNrZQw/6fk/qGk9YRe9sf1Jq
 syqljwBnJUYypO5+NzA7wQGZOcEnxEI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-ierDdfqWNrW2tcBeuYhuEQ-1; Mon, 09 Mar 2020 06:57:39 -0400
X-MC-Unique: ierDdfqWNrW2tcBeuYhuEQ-1
Received: by mail-ed1-f69.google.com with SMTP id b100so4048575edf.15
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1K5028EpyDpycuXB8fjyFJB5EeKvDdUsMI8EIJHMlMI=;
 b=uWb84BuWG12EyusLxf6zCi+CExMFlMmEeyN5JOkbxN+DE2L7jkxUBvh/h+4JgMXO6a
 YsAs0oUIaZmKkAvs1M3SMgSzCMIeew68tq4N1i6GmojMKlsH/L8JrKosPs7RdaSjupva
 NLJBGobQFoyonXr2WOqDi/ISuZBcDaBEyQDswBkn6DqxHrouDqZ30jOXOowBzhixfmTe
 Y84LqqQn442TZXaclKZIFyJmNrEoBcSKSHbM3fTDOvU7Paq2PUktol8Fz9rVYBTjoIo+
 /TjVjY4Xq9z9Qv1vbATyfvWQqxVqtO5BrRUYOJDNRiLn6EduxAKwBVy7QWptepnMeb6D
 tWtg==
X-Gm-Message-State: ANhLgQ1sAQ44qY1ClcdXpInyk2c80af6L5lkpkBSLIkrnJG2u35c+78x
 +5rXlqbZAgQ8IxE025hjcQAfnFG56Bz9c2mpDNmmS62KWqWEceDZF6Uj+WwmxITLP8Kf7mtswHt
 WDB/fqzbugSt1hlg=
X-Received: by 2002:a17:906:37d5:: with SMTP id
 o21mr14585317ejc.366.1583751458109; 
 Mon, 09 Mar 2020 03:57:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvvAq+uup7ETOhzcWcqX5Kq09NoZyljxo6yGCuihdG9n3FGFrrHtHjV1UW3fi7aoCbKoUELWQ==
X-Received: by 2002:a17:906:37d5:: with SMTP id
 o21mr14585304ejc.366.1583751457862; 
 Mon, 09 Mar 2020 03:57:37 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b72sm844087edf.95.2020.03.09.03.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 03:57:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Stephanos Ioannidis <root@stephanos.io>
References: <20200227112617.66044-1-root@stephanos.io>
 <20200227112617.66044-2-root@stephanos.io>
 <CAFEAcA9qbndHqoW1oaUAKMZY5hNYjP+mMt-K_WqoT9Z=Q=ct7g@mail.gmail.com>
 <e1813f57-57ac-e6ad-d119-dd6c2cdc90e1@redhat.com>
Message-ID: <34d14a57-812d-5898-9dfc-ac896f657c9b@redhat.com>
Date: Mon, 9 Mar 2020 11:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e1813f57-57ac-e6ad-d119-dd6c2cdc90e1@redhat.com>
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
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/27/20 2:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/27/20 1:13 PM, Peter Maydell wrote:
>> On Thu, 27 Feb 2020 at 11:27, Stephanos Ioannidis <root@stephanos.io>=20
>> wrote:
>>>
>>> The ARMv7-M CPU reset handler, which loads the initial SP and PC
>>> register values from the vector table, is currently executed before
>>> the ROM reset handler (rom_reset), and this causes the devices that
>>> alias low memory region (e.g. STM32F405 that aliases the flash memory
>>> located at 0x8000000 to 0x0) to load an invalid reset vector of 0 when
>>> the kernel image is linked to be loaded at the high memory address.
>>>
>>> For instance, it is norm for the STM32F405 firmware ELF image to have
>>> the text and rodata sections linked at 0x8000000, as this facilitates
>>> proper image loading by the firmware burning utility, and the processor
>>> can execute in place from the high flash memory address region as well.
>>>
>>> In order to resolve this issue, this commit downgrades the ARMCPU reset
>>> handler invocation priority level to -1 such that it is always executed
>>> after the ROM reset handler, which has a priority level of 0.
>>
>>
>> I think we should be able to do this with the new 3-phase
>> reset API : the rom loader reset should happen in phase 2,
>> and the Arm CPU should only load the new PC and SP in
>> phase 3. It's on my todo list to write some code for this
>> to see if this theory works out.
>>
>> I'd prefer it if we do it that way, or alternatively find
>> out for certain that that approach does not work, before
>> we add a reset-priority concept to the reset APIs.

FYI I hit the same problem testing the RX port which on reset loads $PC=20
at 0xfffffffc. Using Stephanos's previous patch and=20
qemu_register_reset_with_priority() in cpu_realize(), the issue is fixed.
I plan to carry the patch in the RX series until we find an alternative.

>=20
> Agreed.
>=20
>>
>> (In particular, this use of qemu_register_reset to arrange for
>> the CPU to be reset should ideally go away in favour of having
>> the CPU reset handled by the SoC which owns the CPU, so it's
>> not a good long-term way to look at trying to fix ordering issues.)

And your "cpu: Use DeviceClass reset instead of a special CPUClass=20
reset=E2=80=8B" patch goes into that direction :)

>=20
> It would be nice to get ride of qemu_register_reset with the reset API :)
>=20
>>
>> thanks
>> -- PMM
>>


