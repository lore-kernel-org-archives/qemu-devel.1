Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DFAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E3D206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LH9lGcZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E3D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4Rb-0002r3-ID
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic4Ni-0000gr-2s
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic4NA-0002CI-Iq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:21:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic4NA-00026O-Ci
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575364890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMZrmhAzWG4OQz7rU1kvsHIQWFRkKz5BDAnoi7msa54=;
 b=LH9lGcZEFeDl0G1yh8VXQWQvQJaGHIVJrpQEMYp9OBWNNxHIViDCHB2NmhgkUq5Mtdubjt
 6QK3fQ/2F5j9/h9eXdLXMcPaQgCtMvJb4tArBMOAbg+hdcjR9VTb6jI3v1KMV/cTglPgZc
 ODNdK+nx6YHdDnE+ZrjrP4XJHESJijk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-8DP_ZrtYNTqa0vrUZbujsw-1; Tue, 03 Dec 2019 04:21:29 -0500
Received: by mail-wr1-f69.google.com with SMTP id q12so1461880wrr.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 01:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q9m8Y+Y4dyuAq1un6WCaqM2SJU9Li9X2FHwDZ+rt6OQ=;
 b=WjjP5ltY4bVQ1bATsjwNUchgXQeUEI91fUGJYKta6mqqBcd3V6lmcVwtTU0tDqnHBk
 t43ieGkRcpMfhusZ9wiMmlKgb2U0VKxwrv/eBZN+aNKXqL+hs9hXauPC5EAm2jVtOj+J
 Sr4YHjr2GYHwYXjKAnyJmvzUnQpjq3xhG1VYEElfJTnWG87BJFFtvtHV+yIJzJFC3m+E
 L40ifGhyIph3owCelbsgXjRo8wq8pcAjrqgS2AyWrbvSirUR9ThhWKgYm3P9xcwms1DX
 DJSi4a01PcIpOrxZSQMX5IOoJIqLXiW5JO5ntU5feDbfH/v05qmxCrLikCTR5YB982Z2
 NQVg==
X-Gm-Message-State: APjAAAVYV3WzaRT3eCwqd2cuiUBpAKtl7ZXMXCHrShKYjlYHKSInIRCl
 c83Kfz7ocdeOsAFXDKgH5J8pgKnkg0tJJVrvO8V4OhUIwWFEYXkqo4RcKsHwel4Zkj6adcPrFt9
 qUzkUIkQ3syoeLkI=
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr4020109wrw.193.1575364888213; 
 Tue, 03 Dec 2019 01:21:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqya4nSXiY8+Bh6kPNM04GvymOn9zax8ROiip5z+gI0jQJMondhROIjDjYteyYU1pww6aCUp6Q==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr4020087wrw.193.1575364887983; 
 Tue, 03 Dec 2019 01:21:27 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id s15sm843186wrp.4.2019.12.03.01.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 01:21:27 -0800 (PST)
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
 <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
 <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
 <6966e660-688a-977e-c882-9cb44ef97574@redhat.com>
 <f9c24324-b04a-f88c-3da7-3dfd2041b048@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <78a3f7a6-8376-1497-16f9-dde42129cc92@redhat.com>
Date: Tue, 3 Dec 2019 10:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f9c24324-b04a-f88c-3da7-3dfd2041b048@redhat.com>
Content-Language: en-US
X-MC-Unique: 8DP_ZrtYNTqa0vrUZbujsw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 10:15 AM, Thomas Huth wrote:
> On 03/12/2019 09.51, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/3/19 9:25 AM, Thomas Huth wrote:
>>> On 03/12/2019 08.45, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 12/3/19 8:29 AM, Thomas Huth wrote:
>>>>> It's been deprecated since QEMU v3.1. The 40p machine should be
>>>>> used nowadays instead.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 .gitmodules=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>>>>>  =C2=A0=C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>>>>  =C2=A0=C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +-
>>>>>  =C2=A0=C2=A0 docs/interop/firmware.json |=C2=A0=C2=A0 3 +-
>>>>>  =C2=A0=C2=A0 hw/ppc/ppc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 --
>>>>>  =C2=A0=C2=A0 hw/ppc/prep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 384
>>>>> +------------------------------------
>>>>>  =C2=A0=C2=A0 include/hw/ppc/ppc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 -
>>>>>  =C2=A0=C2=A0 pc-bios/README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>>>>>  =C2=A0=C2=A0 pc-bios/ppc_rom.bin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | Bin 1048576 -> 0 bytes
>>>>>  =C2=A0=C2=A0 qemu-deprecated.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 6 -
>>>>>  =C2=A0=C2=A0 qemu-doc.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
>>>>>  =C2=A0=C2=A0 roms/openhackware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>>>>  =C2=A0=C2=A0 tests/boot-order-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0 25 --=
-
>>>>>  =C2=A0=C2=A0 tests/cdrom-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>>>  =C2=A0=C2=A0 tests/endianness-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 2 +-
>>>>>  =C2=A0=C2=A0 15 files changed, 10 insertions(+), 456 deletions(-)
>>>>>  =C2=A0=C2=A0 delete mode 100644 pc-bios/ppc_rom.bin
>>>>>  =C2=A0=C2=A0 delete mode 160000 roms/openhackware
>>>> [...]
>>>>> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
>>>>> index a725bce729..4a6218a516 100644
>>>>> --- a/tests/boot-order-test.c
>>>>> +++ b/tests/boot-order-test.c
>>>>> @@ -108,30 +108,6 @@ static void test_pc_boot_order(void)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_boot_orders(NULL, read_boo=
t_order_pc, test_cases_pc);
>>>>>  =C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0 -static uint8_t read_m48t59(QTestState *qts, uint64_t a=
ddr, uint16_t
>>>>> reg)
>>>>> -{
>>>>> -=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, addr, reg & 0xff);
>>>>> -=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, addr + 1, reg >> 8);
>>>>> -=C2=A0=C2=A0=C2=A0 return qtest_readb(qts, addr + 3);
>>>>> -}
>>>>> -
>>>>> -static uint64_t read_boot_order_prep(QTestState *qts)
>>>>> -{
>>>>> -=C2=A0=C2=A0=C2=A0 return read_m48t59(qts, 0x80000000 + 0x74, 0x34);
>>>>
>>>> I'd rather keep this generic mmio-mapped ISA test.
>>>> Maybe run it with the 40p machine?
>>>
>>> I don't think that this is possible in an easy way here. On the prep
>>> machine, the ISA bus is on a hard-coded MMIO address. On the 40p
>>> machine, the ISA bus is behind a PCI-to-ISA bridge, thus the PCI part
>>> needs to be set up first.
>>
>> The why ...
>=20

I meant "TheN why". The "..." were to continue the review comment below=20
the endianness-test.c diff.

> If you don't believe me, why don't you simply try to adapt the test on
> your own to use the 40p machine instead?

I didn't meant to be rude, I'm sorry if you misunderstood me.

>>>> Maybe we can rename this as read_boot_order_mm, and the previous
>>>> read_boot_order_pc as read_boot_order_io.
>>>
>>> I don't think it makes much sense. This was completely specific to the
>>> "prep" machine, even the "40p" machine seems to prefer fw_cfg nowadays.
>>> So let's simply remove this old stuff.
>>>
>>>> diff --git a/tests/endianness-test.c b/tests/endianness-test.c
>>>> index 58527952a5..2798802c63 100644
>>>> --- a/tests/endianness-test.c
>>>> +++ b/tests/endianness-test.c
>>>> @@ -35,7 +35,7 @@ static const TestCase test_cases[] =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64", "malta", 0x10000000,=
 .bswap =3D true },
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64el", "fulong2e", 0x1fd0=
0000 },
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "ppc", "g3beige", 0xfe000000, =
.bswap =3D true, .superio =3D
>>>> "i82378" },
>>>> -=C2=A0=C2=A0=C2=A0 { "ppc", "prep", 0x80000000, .bswap =3D true },
>>>> +=C2=A0=C2=A0=C2=A0 { "ppc", "40p", 0x80000000, .bswap =3D true },
>>
>> ... here you access the Super I/O behind the PCI bridge via MMIO?
>=20
> The difference is that this is an *arbitrary* address in I/O space
> there. It's not an address of a certain PCI device like the m48t59
> behind a PCI-bridge. As long as it's possible to write and read from
> this address, the test is working. Both, the "prep" and the "40p"
> machine have the "raven-pcihost" device at this address, so in this case
> the switch from "40p" to "prep" was easily possible.

Now I better understand what this test does, thanks.


