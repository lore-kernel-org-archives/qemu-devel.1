Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7AAC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3E0208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJQvEd62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3E0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Kj0-0003nv-30
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4KiJ-0003DQ-Ry
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4KiI-00046M-0Y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:28:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4KiH-000468-TP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582100889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrrTnHmlIe3iSUTin1fAsIC99FVgNG1/mjYmYlSnMfs=;
 b=jJQvEd6223RH42lM/MdBA4DIZDYSSMPPqg5nsC/dirYKQLCYgDzZhk5n+nztOC5bFM7iNS
 lN4p2xDMTs6iaKchz+5FPvt7CwDt0vxxqVKKrYU2f2xAVXkgWm7d6T9kty1K6Z1OXB3JoV
 75TZlyYAu4F+Yo2eVGdc7+VwfT9c6ww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-fISG0ZtBNnGGS7ZvPSWQMA-1; Wed, 19 Feb 2020 03:28:00 -0500
Received: by mail-wm1-f70.google.com with SMTP id g185so482715wme.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 00:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sypiMZHKPX5XAJnXbeW5fLyg1Nhcf5FMYhc0Lvx0ryM=;
 b=jJKypvPE81rmDq4cS+Z8KheLuUn2KHC4rRkpIDxsGWGtQZXKL5X1Qzm3dFAg4PHFKF
 Oxnotbiq4mG8iw+niTdj5YbMdgl8ZJg+b7X3AOCIbiW1jfgLt0cLDAHbFCGuxCEANKLy
 T8j0rFqXeiAz65lNrbNR8lyDbUz5lCwDBrT85O0VcLLofRRasdcMK1Na9Huvyqvr+gjR
 xs5h8GY6/xgw7azLrRzMb2AxQXAoNp28dtx5HNu5wc/qNeqAHeH+BDUnUAcjsxnSyztC
 UuNRMPjJJk0OBpx3tje2SLHIzQvUyV2maIHiDSEWCMcbk1zmm2LPVlMc1r+LEw4WejFP
 qumw==
X-Gm-Message-State: APjAAAUVCqYpq78yp42UIHgZtqwn/unbPNdjWOssBm3YdOe0+DpNm+oa
 QJgVpCS9inlfnDqZ7nZAiYThb+GZJ4/vOHuHztGhzX2Cy2ypLHLbaNb0YFvGIY+rUP9lOITZILX
 g5mK8fa0bVF/NtEg=
X-Received: by 2002:a1c:451:: with SMTP id 78mr8112594wme.125.1582100879026;
 Wed, 19 Feb 2020 00:27:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz2qARFQ2mzKoSjc92v27DdHGqZGL11ZWtRApONstjzczaXYuJD0m0+G8KGIjxWSga6Wn31Q==
X-Received: by 2002:a1c:451:: with SMTP id 78mr8112557wme.125.1582100878616;
 Wed, 19 Feb 2020 00:27:58 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b21sm1977544wmd.37.2020.02.19.00.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 00:27:57 -0800 (PST)
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Finn Thain <fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
 <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
 <CAL1e-=gaVz5K=JMg+iN53weESLORKEuXRJvq-SFqU7FERojP8Q@mail.gmail.com>
 <CAL1e-=iUHwE2_h0dxOE6vN_FoyRWyYA6LbL++T9BSB9X8heEcA@mail.gmail.com>
 <67b0565e-9f2c-7ef0-aca6-01cba798fad4@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <785abd9e-a02d-7850-ddfd-b8bc0fa146cd@redhat.com>
Date: Wed, 19 Feb 2020 09:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <67b0565e-9f2c-7ef0-aca6-01cba798fad4@vivier.eu>
Content-Language: en-US
X-MC-Unique: fISG0ZtBNnGGS7ZvPSWQMA-1
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
Cc: Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 8:55 AM, Laurent Vivier wrote:
> Le 19/02/2020 =C3=A0 02:57, Aleksandar Markovic a =C3=A9crit=C2=A0:
>> 2:54 AM Sre, 19.02.2020. Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> =D1=
=98=D0=B5
>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>
>>> 2:06 AM Sre, 19.02.2020. Finn Thain <fthain@telegraphics.com.au
>> <mailto:fthain@telegraphics.com.au>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>>
>>>> On Tue, 18 Feb 2020, Aleksandar Markovic wrote:
>>>>
>>>>> On Wednesday, January 29, 2020, Finn Thain
>> <fthain@telegraphics.com.au <mailto:fthain@telegraphics.com.au>>
>>>>> wrote:
>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> There are bugs in the emulated dp8393x device that can stop packet
>>>>>> reception in a Linux/m68k guest (q800 machine).
>>>>>>
>>>>>> With a Linux/m68k v5.5 guest (q800), it's possible to remotely
>> trigger
>>>>>> an Oops by sending ping floods.
>>>>>>
>>>>>> With a Linux/mips guest (magnum machine), the driver fails to probe
>>>>>> the dp8393x device.
>>>>>>
>>>>>> With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
>>>>>> fatal to the guest kernel.
>>>>>>
>>>>>> Whilst debugging the device, I found that the receiver algorithm
>>>>>> differs from the one described in the National Semiconductor
>>>>>> datasheet.
>>>>>>
>>>>>> This patch series resolves these bugs.
>>>>>>
>>>>>> AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
>>>>>> ---
>>>>>
>>>>>
>>>>> Herve,
>>>>>
>>>>> Do your Jazz tests pass with these changes?
>>>>>
>>>>
>>>> AFAIK those tests did not expose the NetBSD panic that is caused by
>>>> mainline QEMU (mentioned above).
>>>>
>>>> I have actually run the tests you requested (Herv=C3=A9 described them=
 in an
>>>> earlier thread). There was no regression. Quite the reverse -- it's no
>>>> longer possible to remotely crash the NetBSD kernel.
>>>>
>>>> Apparently my testing was also the first time that the jazzsonic drive=
r
>>>> (from the Linux/mips Magnum port) was tested successfully with QEMU. I=
t
>>>> doesn't work in mainline QEMU.
>>>>
>>>
>>> Well, I appologize if I missed all these facts. I just did not notice
>> them, at least not in this form. And, yes, some "Tested-by:" by Herve
>> would be desirable and nice.

FWIW I tested Finn kernel and QEMU part following:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667432.html
to check than its series doesn't introduce regressions, booting Linux=20
and NetBSD.
I haven't run the thorough networking tests Laurent do with the q800=20
(scp of big files, fetch over http in loop).

Herv=C3=A9 testing is welcomed, but as a hobbyist he doesn't spend more tha=
n=20
1h every 2 months on this, so I don't think his approval is a blocker.
We are not talking about business critical emulation, so we can fix=20
regressions on top.

--

That said, I'm spending some hobby time on a Magnum boot code to be able=20
to test the board upstream (without depending on proprietary BIOS and=20
painful graphical setup).

Currently I get NetBSD to kdb and Linux get stuck there:
https://paste.debian.net/plain/1129965

>>>
>>
>> Or, perhaps, even "Reviewed-by:".
>>
>=20
> It would be nice to have this merged before next release because q800
> machine networking is not reliable without them.
>=20
> And thank you to Finn for all his hard work on this device emulation.
>=20
> Laurent
>=20


