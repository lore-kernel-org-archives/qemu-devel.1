Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73BE20CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD+ym+Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73BE20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixI7u-0006i5-2x
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixI6U-0005zS-CN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixI6T-0006ab-2z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:16:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixI6S-0006ZZ-Vt
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580422560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lX+qs2N9HT6A5Zpw6DzZ2naG6Pd6buAHgx24B1BGXwk=;
 b=fD+ym+Q78bGZzAp8Q/J+/YabniiVHCL3VY+caMIu8OascEK6a2oAjBGrSPB43nvIcM8IfJ
 NDmZMwrNL/CAGRByEgWZe6PMWQ2XQXhd/FiQiXKoa+ZLA/MfBnRfJJ99rH8hLYtTfDe5tK
 dWojxbApk2kTakp8b3/g4a7/WZa4kTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-mnizRWOlOlGK9oKFgOBT-A-1; Thu, 30 Jan 2020 17:15:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id j4so2346828wrs.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QZ50xQs7hobHTUm2KAmqYPvAxwX7gLND6pBvivH/spA=;
 b=XLySZu8ivUeFwHpPJ3JRiNynAdrYx1GUM+OmgKGR+gAAiHkwTejIT+nYGQawXAI2/r
 09q8VNKNVRvdnpmNOiDAi/uR6wRSuVIQU+kGX+RHbAq0n1Fk82rNc4xc6IOLN4X0hNWp
 hk3ey7yc9mqLs6+pz6mOKZLFwj0Tdv0xPeqgUfSnmU4K6AvIz8ghzU1lM4ZiJYgyiU3y
 kXhmWgec5mc+kvTV4faySiS3pt/1558FM69WSEKeYvlYi/fZRwx55nUojgtTWaRtBiy0
 YHGnZaoGWlh2ff190PVyw/Gt5JtyLC7GFjOuHY+QxvI/+5D0mpq4mcLh48HoTjpDqXya
 4sJQ==
X-Gm-Message-State: APjAAAU6y98b/bFtyAWHpAo5nHhwpMkKicoINNKwwxNuHAaLHihEDX4g
 hJquhyvezEl6YahFD6FBG5HIqmRQutvrMT1pB2z7EXrFvOkwmG0Cl1vCRftFKu7gMQexJUyU7gU
 IRZHEWvArjRWIdsU=
X-Received: by 2002:a1c:960c:: with SMTP id y12mr7766866wmd.9.1580422555043;
 Thu, 30 Jan 2020 14:15:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzYDpnz5MfrWZR0oykeqEvTBpPDIwPFyHi9BRIMGQCXy2a8H5p/Pd4XNnDsy+Ewu0khhsrAg==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr7766841wmd.9.1580422554804;
 Thu, 30 Jan 2020 14:15:54 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s19sm7813787wmj.33.2020.01.30.14.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:15:54 -0800 (PST)
Subject: Re: [PATCH v4 4/7] python/qemu/machine: Allow to use other serial
 consoles than default
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-5-f4bug@amsat.org>
 <6542670c-341f-b259-5705-a5374c5b722d@redhat.com>
Message-ID: <b68b7745-dbac-eba4-a230-0e665ba1c741@redhat.com>
Date: Thu, 30 Jan 2020 23:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6542670c-341f-b259-5705-a5374c5b722d@redhat.com>
Content-Language: en-US
X-MC-Unique: mnizRWOlOlGK9oKFgOBT-A-1
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 9:20 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/21/20 12:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Currently the QEMU Python module limits the QEMUMachine class to
>> use the first serial console.
>>
>> Some machines/guest might use another console than the first one as
>> the 'boot console'. For example the Raspberry Pi uses the second
>> (AUX) console.
>>
>> To be able to use the Nth console as default, we simply need to
>> connect all the N - 1 consoles to the null chardev.
>>
>> Add an index argument, so we can use a specific serial console as
>> default.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> v2:
>> - renamed 'console_index', added docstring (Cleber)
>> - reworded description (pm215)
>> ---
>> =C2=A0 python/qemu/machine.py | 9 ++++++++-
>> =C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index 734efd8536..ef9f5b213f 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine.py
>> @@ -241,6 +241,8 @@ class QEMUMachine(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'chardev=3Dmon,mode=3Dcontrol'])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self._machine =
is not None:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 args.extend(['-machine', self._machine])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in range(self._console=
_index):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args=
.extend(['-serial', 'null'])
>=20
> This patch is not sufficient, we have to initialize _console_index in=20
> __init__():
>=20
> -- >8 --
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index ef9f5b213f..183d8f3d38 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -112,6 +112,7 @@ class QEMUMachine(object):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._sock_dir =3D sock=
_dir
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._launched =3D Fals=
e
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._machine =3D None
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_index =3D 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_set =3D F=
alse
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_device_ty=
pe =3D None
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_address =
=3D None
> ---
>=20
> Else for tests not calling self.set_console() we get:
>=20
>  =C2=A0'QEMUMachine' object has no attribute '_console_index'
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self._console_=
set:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 self._console_address =3D os.path.join(self._sock_dir,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 self._name +=20
>> "-console.sock")
>> @@ -527,7 +529,7 @@ class QEMUMachine(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._machine =3D=
 machine_type
>> -=C2=A0=C2=A0=C2=A0 def set_console(self, device_type=3DNone):
>> +=C2=A0=C2=A0=C2=A0 def set_console(self, device_type=3DNone, console_in=
dex=3D0):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sets the device t=
ype for a console device
>> @@ -548,9 +550,14 @@ class QEMUMachine(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 chardev:console" command line argument will
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 be used instead, resorting to the machine's
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 default device type.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @param console_index: the in=
dex of the console device to use.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If not zero, the command line will create
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'index - 1' consoles and connect them to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the 'null' backing character device.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_set=
 =3D True
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_dev=
ice_type =3D device_type
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._console_index =3D cons=
ole_index
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @property
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def console_socket(self):
>>

Thanks, added missing line and applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


