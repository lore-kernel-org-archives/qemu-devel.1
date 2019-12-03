Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631752054F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPfDzrlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631752054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8jT-0004aj-5q
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ic8PW-00048d-9x
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ic8PO-0006iq-T1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:40:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ic8PO-0006fm-L9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575380403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIm8k0scJ2bK9yiZ8iR9dDgveKvZhS/Mft46RWXwwHE=;
 b=RPfDzrlmr20BFIdg9OOfqILWtSu/WTEfPphW/FaS54aVy5HWzBQv5xyTO0NutDcG7al6vR
 VYnwr2BzGm5a3V+g97DGSz658KNCuPdb4qTfqfiAhQQyCJaemnQ7QTiqAf0jYvgJ/qLdTS
 QDrzRvI/t054D3/DtEhBwePMCLzh/+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Oit2ZZ_nNfyfKmO4Rh1_oQ-1; Tue, 03 Dec 2019 08:40:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id c17so1787241wrp.10
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 05:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B8Hxq0/0hsGTIMJqqJxxw57QsGyRN8jlb1Y3fvDGz+E=;
 b=FGnFF+4I8wkkk5JIfdrd9xbYyZ0IfpJm+DiNfOTb+pSri1w6NcekzOxHoLtB/pjPVT
 D/8jXMkekW9dzsJtDOWXULTuf721NDwDlLpEGdosFG/tngXBA90zz0IwAVqa77lUWCUO
 WgpAEjNeD6W6tgwydews4J7lISZnpm/D5szwRrqCq+HetwZ+myZrD+7p9V6ibToJiaPS
 rbDl3uBXjDylGIvCw3+GqyNXQDrum2zFufg7eCyHB1ZnaF0wLhox5pOxh1D4RpeWJEGP
 lyg1aMZjpnHmr+1Pze9r/K/FC7++kv36ZWCHzDEsm6tJn65j0G1QPTZ35J1CrnpELtJe
 X/CA==
X-Gm-Message-State: APjAAAU/NFNdt4rAxiP+E2aDP6+lU29l/JU8/tiMwdm5xQIzGOIOTdfp
 Sh7h+mD0A12bBW+eWSCY7/icfvtrt3dwzeIrkkWhr8lkB4GbiDvXQ8RO4J23rx+wuU5MmHOgCxj
 PnaG0J2YdIq5HPZM=
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr5415913wrp.142.1575380400370; 
 Tue, 03 Dec 2019 05:40:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSHfRxKmngzYe1OGQhB8ODvBy39RB+t/yO+a2ReNubTo0o73ehjVI+e9+S+SzX8jn97GJcFQ==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr5415887wrp.142.1575380400066; 
 Tue, 03 Dec 2019 05:40:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id s82sm3105499wms.28.2019.12.03.05.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 05:39:59 -0800 (PST)
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
 <7528162c-ce2f-985e-7f58-9267389edd33@redhat.com>
 <fcee5492-8a0b-c54c-0a6a-16a69532892f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e36bf29a-bc58-2ec1-d796-643679f3c6bc@redhat.com>
Date: Tue, 3 Dec 2019 14:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fcee5492-8a0b-c54c-0a6a-16a69532892f@redhat.com>
Content-Language: en-US
X-MC-Unique: Oit2ZZ_nNfyfKmO4Rh1_oQ-1
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

On 03/12/19 14:16, Thomas Huth wrote:
> On 03/12/2019 14.04, Paolo Bonzini wrote:
>> On 03/12/19 10:15, Thomas Huth wrote:
>>>>>> Maybe we can rename this as read_boot_order_mm, and the previous
>>>>>> read_boot_order_pc as read_boot_order_io.
>>>>>
>>>>> I don't think it makes much sense. This was completely specific to th=
e
>>>>> "prep" machine, even the "40p" machine seems to prefer fw_cfg nowaday=
s.
>>>>> So let's simply remove this old stuff.
>>>>>
>>>>>> diff --git a/tests/endianness-test.c b/tests/endianness-test.c
>>>>>> index 58527952a5..2798802c63 100644
>>>>>> --- a/tests/endianness-test.c
>>>>>> +++ b/tests/endianness-test.c
>>>>>> @@ -35,7 +35,7 @@ static const TestCase test_cases[] =3D {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64", "malta", 0x10000000=
, .bswap =3D true },
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64el", "fulong2e", 0x1fd=
00000 },
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "ppc", "g3beige", 0xfe000000,=
 .bswap =3D true, .superio =3D
>>>>>> "i82378" },
>>>>>> -=C2=A0=C2=A0=C2=A0 { "ppc", "prep", 0x80000000, .bswap =3D true },
>>>>>> +=C2=A0=C2=A0=C2=A0 { "ppc", "40p", 0x80000000, .bswap =3D true },
>>>>
>>>> ... here you access the Super I/O behind the PCI bridge via MMIO?
>>>
>>> The difference is that this is an *arbitrary* address in I/O space
>>> there.
>>
>> No, it's the base address of the ISA space, to which the tests add the
>> address of the pc-testdev device.  It's not any different from the
>> 0x80000000 in boot-order-test.
>=20
> Hmm, interesting. Why is it not necessary to set up the BARs of the
> PCI-to-ISA bridge in this case?

I don't know.  Maybe the machine doesn't need it, since these are not
really BARs, since they are positive-decode addresses on the ISA bus.
It may also be an emulation inaccuracy in the pc87312 ISA bridge.

Paolo

>> That said, I think it's a sensible objection that boot order doesn't
>> come from m48t59 on 40p (does it not?).
> Right. I'm also not an expert here, but I think the OpenBIOS on 40p
> rather uses fw_cfg instead.
>=20
>  Thomas
>=20


