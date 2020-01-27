Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE8822527
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEJGDXS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE8822527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6X1-0000Je-JP
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iw6WI-0008IQ-CX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iw6WH-0005vF-Ck
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:41:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iw6WH-0005uo-9o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580139704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVzUni7ewIwP6z9v8ncO3zA63kArbnByKNOo8Y5gsR0=;
 b=OEJGDXS8PM+cJ6HBEfHhoHjRN/dkyxcYqddsIsc4lZspbKSjsyJi0O/9ej8+xNvF9B5bIw
 IzN7s4PFrEJrF/bJsMbjTeCW5S/OCG8IgV3gRmNJwElJ1OAcng0ZIZ52Dhy2q1xStQcho3
 wwpxil53NIJbMn2ebcxSvOkA8hqn/DI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-pZOD6cbmOFi1fTr6wdvbow-1; Mon, 27 Jan 2020 10:41:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so6244506wrs.13
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 07:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zoUCgX8RIaPawpw4BUvJkUrNzheaDIFrA6A+bw72NYQ=;
 b=Y/UgLvmnmDlUrRx2qMoBtHJMjFxYPpUFT4lGgDd2XeT1QMSF+OsadYifj27E6htpL6
 qEjyWkVaN9Wpq3gJmZc/yGmv/QO1BCNopTdylp3AjiK1odxdZjqXRzuHnGyUGOVZNVBX
 hP0ZeZWXl6oiBBUb5Eh5wsPMILc0O1waaUSn+MfSKf7nrdaO0jE0Oqg3I51Waux2xf9n
 t+CYSTqsv594rzjnxeYKKmWABwxtBRN8Swj8eLvNM0bOYSmRRqXQWTODVh2iyqWogPS2
 2qOGbekLRbubqXZV/TmZXyTdktxoLTnbkNFet2/M2Ka2rswtNUuvDxYVwFPVXDEzXd3D
 CNtQ==
X-Gm-Message-State: APjAAAXUzGLFKeRta6x+lfr90NUouL4CY3FSzco69LhxNJ3tSMhZZqnR
 BEy9ux53cJEFKSHkP1GkXKRJkReK+OSKCsrB8C2BebgN7JY+46+wSmulZ6ujyoNrHJJZoEbwTNa
 zApE3sxRFe7fEojw=
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr14331087wmf.60.1580139701603; 
 Mon, 27 Jan 2020 07:41:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqpeKbpOEbZHsGiTJgAytdFsyZaEK7gAEo+hS0JlRxqDjx2ZBa9Fdu4a80ZDjdDfC0vmJrpw==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr14331058wmf.60.1580139701322; 
 Mon, 27 Jan 2020 07:41:41 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d12sm21092269wrp.62.2020.01.27.07.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 07:41:40 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
 <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
 <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05f7e133-8ad3-8627-79a1-a046e6d42d16@redhat.com>
Date: Mon, 27 Jan 2020 16:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c4976fd4-f1f0-c48b-aad4-4414564f8258@redhat.com>
Content-Language: en-US
X-MC-Unique: pZOD6cbmOFi1fTr6wdvbow-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 4:39 PM, Thomas Huth wrote:
> On 27/01/2020 16.18, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/27/20 3:41 PM, Thomas Huth wrote:
>>> The canon-a1100 machine can be used with the Barebox firmware. The
>>> QEMU Advent Calendar 2018 features a pre-compiled image which we
>>> can use for testing.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  =C2=A0 tests/acceptance/machine_arm_canon-a1100.py | 33 ++++++++++++++=
+++++++
>>>  =C2=A0 1 file changed, 33 insertions(+)
>>>  =C2=A0 create mode 100644 tests/acceptance/machine_arm_canon-a1100.py
>>>
>>> diff --git a/tests/acceptance/machine_arm_canon-a1100.py
>>> b/tests/acceptance/machine_arm_canon-a1100.py
>>> new file mode 100644
>>> index 0000000000..3888168451
>>> --- /dev/null
>>> +++ b/tests/acceptance/machine_arm_canon-a1100.py
>>> @@ -0,0 +1,33 @@
>>> +# Functional test that boots the canon-a1100 machine with firmware
>>> +#
>>> +# Copyright (c) 2020 Red Hat, Inc.
>>> +#
>>> +# Author:
>>> +#=C2=A0 Thomas Huth <thuth@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.=C2=A0 See the COPYING file in the top-level directory.
>>> +
>>> +from avocado_qemu import Test
>>> +from avocado_qemu import wait_for_console_pattern
>>> +from avocado.utils import archive
>>> +
>>> +class CanonA1100Machine(Test):
>>> +
>>> +=C2=A0=C2=A0=C2=A0 timeout =3D 90
>>> +
>>> +=C2=A0=C2=A0=C2=A0 def test_arm_canona1100(self):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:ca=
non-a1100
>>
>> To the maintainer taking this, please add:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: =
tags=3Dpflash_cfi02
>=20
> Should there be a "device:" between the "=3D" and the device name? At
> least I can see some other files using "device:" for similar tags...

Ah yes you are right, it is clearer.


