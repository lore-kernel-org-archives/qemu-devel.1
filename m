Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93ECC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885AD2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLpZ7UIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885AD2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7xt-0003j9-H0
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ic7qm-0007Ff-31
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ic7qi-0001aG-P6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:04:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ic7qg-0001W8-OM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575378253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4T6TB6RllphAKhqDFjeEKPAkGTZHJpOfG6Z6kWhHlZo=;
 b=BLpZ7UIpDn5l9cHd25O0B6AiUZdnUiGPbNXHb+yGsVn6u3AM+/Kc8tzZL7Hk/rGSCo9JR7
 f3Ecj+7woL8T4OQuZxpneSyXd3392PMX3QBKCZa39BFQOoW+emU4C/LeME8s0XTem6OHC6
 8Y6wVJyZXv+KhGetDGG0NlOLuSD+E7o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-2xIZRS-nMeKhxIMnw_ighA-1; Tue, 03 Dec 2019 08:04:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so1720029wrm.18
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 05:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pIMwvGdNHj623pkNrYKyv65qXj9nhGcyugeYjZMbmZs=;
 b=XuQoDBKhhw/bDvqqDd7KSYfAi65PRIqaOYosXYc88JTeFwa8YonMZEqP351mszZjmi
 Fi8oXsqClpfXJh6YSPj4i1pYCJbP8nP6/a8M/iw1yuXYQcR0c3idXdV1SPhamjpzpy3q
 8iJ7Io91CYPxH5DXTVGdQe195ItwFudPdmX9sUobJdr3rIBQzzz8HYxQ01PuNIHC8xy/
 H+l+UisKK+Mct8RX7C5W2tKf7tE8G9XU5d5lXDfazHPS8+24FhN3FZzLohqg5s1iv8XE
 1S6ZrySwWnzfuof9YibeGZtg7IXVnCy37vWR/Uw8//oWRhVvIgXJHGUyaQa6YNQhQrea
 2pIA==
X-Gm-Message-State: APjAAAXZCg1GzzYtOrNF+wR9BzOfSwr6nKGVDh1pODRJc76W3jy2T1BS
 lOQ2ECCzyPIuCkMGTI28rVTw5uveykwzD3KKX67eiivhVukbHnUSHWIi0SUK0RFaOqUb3gK86i+
 2t3qSvZaqN9zKFx8=
X-Received: by 2002:adf:fc08:: with SMTP id i8mr5447397wrr.82.1575378248581;
 Tue, 03 Dec 2019 05:04:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSIN8JQzNoidSV4b9vvPb4oEORoGf8zBX0rDLlFdpedA70cBx6iSqXE4Wbg6tFagOClKb6dg==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr5447362wrr.82.1575378248270;
 Tue, 03 Dec 2019 05:04:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id l15sm3565597wrv.39.2019.12.03.05.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 05:04:07 -0800 (PST)
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
 <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
 <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
 <6966e660-688a-977e-c882-9cb44ef97574@redhat.com>
 <f9c24324-b04a-f88c-3da7-3dfd2041b048@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7528162c-ce2f-985e-7f58-9267389edd33@redhat.com>
Date: Tue, 3 Dec 2019 14:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f9c24324-b04a-f88c-3da7-3dfd2041b048@redhat.com>
Content-Language: en-US
X-MC-Unique: 2xIZRS-nMeKhxIMnw_ighA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 03/12/19 10:15, Thomas Huth wrote:
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
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64", "malta", 0x10000000, =
.bswap =3D true },
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64el", "fulong2e", 0x1fd00=
000 },
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "ppc", "g3beige", 0xfe000000, .=
bswap =3D true, .superio =3D
>>>> "i82378" },
>>>> -=C2=A0=C2=A0=C2=A0 { "ppc", "prep", 0x80000000, .bswap =3D true },
>>>> +=C2=A0=C2=A0=C2=A0 { "ppc", "40p", 0x80000000, .bswap =3D true },
>>
>> ... here you access the Super I/O behind the PCI bridge via MMIO?
>=20
> The difference is that this is an *arbitrary* address in I/O space
> there.

No, it's the base address of the ISA space, to which the tests add the
address of the pc-testdev device.  It's not any different from the
0x80000000 in boot-order-test.

That said, I think it's a sensible objection that boot order doesn't
come from m48t59 on 40p (does it not?).  The m48t59-test could also be
adjusted to test the 40p... the right way to do it would be to have an
ISA bridge driver in qgraph, but that's a topic for a separate series.

Thanks,


Paolo

> It's not an address of a certain PCI device like the m48t59
> behind a PCI-bridge. As long as it's possible to write and read from
> this address, the test is working. Both, the "prep" and the "40p"
> machine have the "raven-pcihost" device at this address, so in this case
> the switch from "40p" to "prep" was easily possible.
>=20
>  Thomas
>=20
>=20


