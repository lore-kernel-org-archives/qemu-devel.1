Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ABDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291332467B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO1/AF1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291332467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwBSB-00041B-Bk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 15:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwBRU-0003RY-VW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwBRT-00010z-Db
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:57:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwBRT-00010F-39
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580158626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DzTevrK882ZAAansiIv9LXYymsZC7ykzvhnI8lEgFQ=;
 b=hO1/AF1PKC9ULZn4YXz6shZzdMWCyh+Aw/9oqEDfPUJIVJLmGXe2UEhj9q1v5dRRy04KyK
 y2g5UiKkuukmz1m5j07HrlG0/LSEqRMbXPR0YKepAmshJ9zv2c4t4d+3sd7nqyAsCgcxcK
 W/8yqCjxoMGW/ACZdpstMOYBAhIi0EA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-aaav-O2SNlyMOpUC8plvsQ-1; Mon, 27 Jan 2020 15:57:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id h30so6792726wrh.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 12:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aaNVEPVlebJIt8gBQDTRyy49xw8jN7LxnJaQ8qBYIkw=;
 b=DeIzfOlZbaIrhNQ0N3zjwNlIALYbHIj0369D//U4YQbtsK5QoqBED9SlJbjoVOBtfh
 e50NjkgFhS+mP2iD+od4ylcfjM4bhArzUe4x+IGUzJLdd4WFvX/Hu7d123Vge8ORSacd
 4WFlplXV/LcZmDwaesQb0kUtNoLsfuDpOKVS8XiTtVvT/NWeN+Hy2wYUiMbhLgWYQnCm
 GgUndsBrGN9fQR9ZYAUeIEXUCo4Uc9gXon4cD6Nda4a3AgXm43mXObQCRfv+hBZUb94q
 DCtJ9UTpTOIheRXUmL1IA7mKdxmesiEqBz34vxTYfJuYL3Jf7y3gxq7tPEGvQmZy73ru
 ccqw==
X-Gm-Message-State: APjAAAWvDIqFlxgoGoEHwQ8+Lexz7PCMBrVxVeyB/yB1rvossuwfZ0yJ
 RzxXEXa74EuBGMgB49eax3ahnoVFcZ8QIKBVTl+FKG6OM4mFcFXjj+46CVpndUef/ErlLKcn0LH
 7phJ35HWtc34cKkM=
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr547839wml.88.1580158621029;
 Mon, 27 Jan 2020 12:57:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyW8tpukze9dHr2SNOJVqgnilT3u5chWcgmm1AFMnPbYqxlw4UXRc8jId/8wVt1F/XyAxNC3A==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr547810wml.88.1580158620607;
 Mon, 27 Jan 2020 12:57:00 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a5sm15589wmb.37.2020.01.27.12.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 12:57:00 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
 <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
 <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
 <2a303987-ad19-538b-98ce-a2cb83d8fade@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9856cc15-2365-4609-5af9-f6582cb20ed8@redhat.com>
Date: Mon, 27 Jan 2020 21:56:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2a303987-ad19-538b-98ce-a2cb83d8fade@redhat.com>
Content-Language: en-US
X-MC-Unique: aaav-O2SNlyMOpUC8plvsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey Wainer,

On 1/27/20 6:45 PM, Wainer dos Santos Moschetta wrote:
> On 1/27/20 1:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/27/20 4:39 PM, Thomas Huth wrote:
>>> On 27/01/2020 16.18, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 1/27/20 3:41 PM, Thomas Huth wrote:
>>>>> The canon-a1100 machine can be used with the Barebox firmware. The
>>>>> QEMU Advent Calendar 2018 features a pre-compiled image which we
>>>>> can use for testing.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33=20
>>>>> +++++++++++++++++++++
>=20
>=20
> What is the reason for not adding this case in boot_linux_console suite?

Because there are too many tests in this file and it became hardly=20
maintainable. Also it is easier to add a 'F:' entry in the MAINTAINERS=20
file to each machine section.

>>>>> =C2=A0=C2=A0 1 file changed, 33 insertions(+)
>>>>> =C2=A0=C2=A0 create mode 100644 tests/acceptance/machine_arm_canon-a1=
100.py
>>>>>
>>>>> diff --git a/tests/acceptance/machine_arm_canon-a1100.py
>>>>> b/tests/acceptance/machine_arm_canon-a1100.py
>>>>> new file mode 100644
>>>>> index 0000000000..3888168451
>>>>> --- /dev/null
>>>>> +++ b/tests/acceptance/machine_arm_canon-a1100.py
>>>>> @@ -0,0 +1,33 @@
>>>>> +# Functional test that boots the canon-a1100 machine with firmware
>>>>> +#
>>>>> +# Copyright (c) 2020 Red Hat, Inc.
>>>>> +#
>>>>> +# Author:
>>>>> +#=C2=A0 Thomas Huth <thuth@redhat.com>
>>>>> +#
>>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>>>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>>>>> +
>>>>> +from avocado_qemu import Test
>>>>> +from avocado_qemu import wait_for_console_pattern
>>>>> +from avocado.utils import archive
>>>>> +
>>>>> +class CanonA1100Machine(Test):
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 timeout =3D 90
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 def test_arm_canona1100(self):
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:=
canon-a1100
>>>>
>>>> To the maintainer taking this, please add:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :av=
ocado: tags=3Dpflash_cfi02
>>>
>>> Should there be a "device:" between the "=3D" and the device name? At
>>> least I can see some other files using "device:" for similar tags...
>>
>> Ah yes you are right, it is clearer.
>=20
>=20
> Notice that avocado_qemu won't automatically convert that tag into=20
> QEMU's -device option, If that is the intention...

That could be useful, but currently my usage is 'avocado run -t=20
device:pcnet32' to run all tests using the pcnet32 network device.

I have pflash tests which I plan to use the same way.

This is a hint to other maintainers, who don't have to look at each test=20
to find the set of tests that suits them.

IOW "As a maintainer of the device:pflash I'm interested to run all=20
tests using this device, and while they pass I won't look at them".

(This is how I expect maintainers to use the acceptance tests when I add=20
some).


