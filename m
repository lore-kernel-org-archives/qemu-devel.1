Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDEFC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402B624676
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X50opY8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402B624676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id5u4-0003kJ-FG
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1id5tA-0003Fo-4J
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1id5t7-0008OT-Tk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:10:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1id5t5-0008My-Q8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575609041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycyTEVZ0tWGLVY9OJD+QfTiHk6jEuy7uoZmhtWbZ+o8=;
 b=X50opY8Q35RL/fRibZ29s4UwaGRgzQcHfuWVxjgX5apn+qw+BWRpd508+zgb3WGPB7ilBN
 tn3QNlmPBGYByy6cMCFlVrEgs9PLTdvZPKRlB8CvmbQ7LBcpm7jBQE7N7uRaqCXjgg+V6o
 aZZ3tQ7bPY/3vp1OBKYobRjO+CWw+GE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Ody-mAhzNriY4ZZXq3YpMQ-1; Fri, 06 Dec 2019 00:10:39 -0500
Received: by mail-wr1-f71.google.com with SMTP id f1so615920wre.14
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 21:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aNBktPJn/HVyxdAM2/2GPNOtIgoVnqF1Gsl6/ZhQido=;
 b=D9WpxNhc0L0BsWuKWikp/UuBErZ1ANOq+yD3TGc1NgJ2Ydn8fX5Gei/Y20WZeO/KJH
 UnBkZiK9GpXXqifzKKncy9xARHY1EacEUA8k05lseA6mg2yGd3nhlP0A7tTlRLzWenPm
 KeZ6i1UQ24HNmrAdm6j40cTT8O8505VAiWDDNnPGlNA1bs3EuoVwZKZEAHGyZFstms+s
 4qMWJ2hb+OwbnQKy6NjV1w0juDmGazxUC5/r96O242RNcXk19dwcOFR0suPWSCexmrqD
 F0WywStkRcIpz8vbM52qJzYTk1KdlE7aqMjXMxA38DxhkHadMTJxd0VP3Luy2YX2JM2m
 15OA==
X-Gm-Message-State: APjAAAVdJhE+aTuLzdcbCZl/SncW138bnnpYbvNpyFbvEp3v3Nu3gu50
 KpREbECpTIpOJIl/Zy9+sc6U+wQYZajhX8cxTA21Z3GWko7DV4AFJIwhZoXjuKVNOtUxegsMViy
 IPVd9xrsUdLxguVc=
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr8067161wmc.131.1575609038216; 
 Thu, 05 Dec 2019 21:10:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzB6tzkbDc/LyRf2SJPUEk3OVVgxaD+qDjgA22fRF5TgLEvu0tVpVFF0gsroCC4IoCQUus13A==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr8067112wmc.131.1575609037626; 
 Thu, 05 Dec 2019 21:10:37 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id d9sm14146666wrj.10.2019.12.05.21.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:10:37 -0800 (PST)
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs: Force armhf toolchain prefix on
 Debian
To: Laszlo Ersek <lersek@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20191205180913.15263-1-philmd@redhat.com>
 <CAKv+Gu_DqSD9K3Ajsj0q2yQ_AT=pjfhSitn2t-irYXoW662jOg@mail.gmail.com>
 <80925eef-1081-4c5d-49e9-b4d25970efac@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e3fb5e10-0a17-0f85-e034-3d19f50622b8@redhat.com>
Date: Fri, 6 Dec 2019 06:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <80925eef-1081-4c5d-49e9-b4d25970efac@redhat.com>
Content-Language: en-US
X-MC-Unique: Ody-mAhzNriY4ZZXq3YpMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 Serge Hallyn <serge.hallyn@ubuntu.com>, Dann Frazier <dannf@debian.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Steve Langasek <vorlon@debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 8:56 PM, Laszlo Ersek wrote:
> On 12/05/19 19:17, Ard Biesheuvel wrote:
>> On Thu, 5 Dec 2019 at 18:09, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>>
>>> The Debian (based) distributions historically provides 2 ARM
>>> toolchains, documented as [1]:
>>>
>>> * The ARM EABI (armel) port targets a range of older 32-bit ARM
>>>    devices, particularly those used in NAS hardware and a variety
>>>    of *plug computers.
>>> * The newer ARM hard-float (armhf) port supports newer, more
>>>    powerful 32-bit devices using version 7 of the ARM architecture
>>>    specification.
>>>
>>> The EDK2 documentation suggests to use the hard-float toolchain.
>>>
>>
>> We should probably fix that.
>=20
> OK, I'm confused. What case are we talking about?

You answered to your questions after reviewing my v2 (see=20
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01118.html),=20
still I'll reply inline for other reviewers.

> (1) Without this patch, "roms/edk2-funcs.sh" fails to select *any* cross
> compiler on Debian, and the build just croaks.

This is the correct description.

>=20
> --> insist on armhf in this script?

This is what the EDK2 doc suggests in [2], but Ard says Clang default to=20
armel, so we should use the GCC armel version.

> --> insist on armel in this script?

Yes, this is v2 approach:
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01088.html

> --> pick whichever is available, because either works?

I thought about it, because Debian edk2 is packaged with=20
gcc-arm-linux-gnueabihf so this is convenient to install all the=20
prerequisites with 'apt build-dep edk2'. See:
https://salsa.debian.org/qemu-team/edk2/blob/debian/debian/control#L9

>=20
> (2) Without this patch, "roms/edk2-funcs.sh" selects the "armel" flavor,
> and it fails to build edk2.
>=20
> --> insist on armhf in this script?
>=20
> (3) Without this patch, "roms/edk2-funcs.sh" selects the "armel" flavor,
> and it builds edk2 just fine -- but that's not the flavor that the edk2
> documentation suggests.
>=20
> --> drop this patch, and fix the edk2 docs?

Regardless 1/2/3 we should fix the edk2 doc :)

>=20
> Thanks,
> Laszlo
>=20
>> tools_def.template mentions
>> arm-linux-gnueabi, and while it does not really matter in most cases,
>> if you are using Clang, you actually need the armel binutils (see
>> 41203b9ab5d48e029f24e17e9a865e54b7e1643d for details)
>>
>>
>>> Force the armhf cross toolchain prefix on Debian distributions.
>>>
>>> [1] https://www.debian.org/ports/arm/#status
>>> [2] https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#i=
f-cross-compiling
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>   roms/edk2-funcs.sh | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
>>> index 3f4485b201..a546aa1d11 100644
>>> --- a/roms/edk2-funcs.sh
>>> +++ b/roms/edk2-funcs.sh
>>> @@ -112,6 +112,9 @@ qemu_edk2_get_cross_prefix()
>>>        ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] =
); then
>>>       # no cross-compiler needed
>>>       :
>>> +  elif ( [ -e /etc/debian_version ] && [ "$gcc_arch" =3D=3D arm ] ); t=
hen
>>> +    # force hard-float cross-compiler on Debian
>>> +    printf 'arm-linux-gnueabihf-'
>>>     else
>>>       printf '%s-linux-gnu-\n' "$gcc_arch"
>>>     fi
>>> --
>>> 2.21.0
>>>
>>
>=20


