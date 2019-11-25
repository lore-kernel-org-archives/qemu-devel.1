Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44574C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECBB2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbXJR3tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECBB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZE4A-00042b-Hy
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZE27-0003BD-UI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZE25-0004yB-Kz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:04:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZE25-0004y1-HV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLS+SqnLnXRCJVT3KuMONORqerXizxmCbod68H89uWg=;
 b=RbXJR3tR0mSQx5YJjunem70YtxYOA/2Cmkt9di2yVnkp14KGKqDvNMhnuza+QPYRDO7SzO
 FiQTQuq5KMvOJ7KDIqRl6aXRNoLfkkz9+L4d0cmU/Kn6L0NuWGIcSOlv/PLjBLgKeiTEu4
 GVjOgDn3Gw3DuridVi6o/VzhSDCySQQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-piSav1kCNzSstXMjw7YWJg-1; Mon, 25 Nov 2019 08:03:59 -0500
Received: by mail-wr1-f69.google.com with SMTP id k15so8735480wrp.22
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TKW+uNdHuIzmgPbFmfdRDEeo4YTsY36xRNfmZ5QeZmY=;
 b=dFswoXtd59mPDgZfBh+IDWlNGh+ao5kvfG4Cql32sbZfK0MC4FqmoGgjAd9LyOkwtM
 uH6pq5yiyiTO1XqfiDS7LbyavLmXnzVXyxp+aUy6aWGUmdIHWxlLKq//4HA8MgDZ+3pS
 kHozi5ivzIVHJDXN7exa8KHoi+CvVLqRt2E67Wq6UTKAJPHdmjrSsDMnoySGPmOoPHQl
 a4nCUj9JDNIrEM2TMdae42WilzIhYegVktYN++NG4gq+04spRVILhwsZDLxNq0LV/Xib
 pUOYjWX5rwwyOPYyopgxEo8PVp6T2Su8vG792Fs8FmcVXZDN2Bo/S87UAE9MNQDsUZdJ
 OZqg==
X-Gm-Message-State: APjAAAVpu7tK5LyMYsJzPnqekxDe552k5RjKMJBdcVYAG2I2P5mqOYcv
 b3kE34XlXEYu1cp+n9r1UcUviR4mhoBwaUDv21mmvR7drYn9ZQVHhc2pa5CMA23mmxm6CEYndqY
 dbh3wqCyW/fCRsy8=
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr27304066wml.99.1574687037072; 
 Mon, 25 Nov 2019 05:03:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyyf/Cde4oDnlxvpoQLMyeKwSLhDCqt2b540sXRBvYAwWR0kKhe0BiVEz2uTB1NCeUA7wbTQ==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr27304040wml.99.1574687036805; 
 Mon, 25 Nov 2019 05:03:56 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c9sm8088474wmb.42.2019.11.25.05.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 05:03:56 -0800 (PST)
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
 <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
 <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
 <c61a0426-bf43-9afe-3110-51bb11d75bd1@redhat.com>
Message-ID: <8992c003-5d65-77e9-17eb-592449cf9fdc@redhat.com>
Date: Mon, 25 Nov 2019 14:03:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c61a0426-bf43-9afe-3110-51bb11d75bd1@redhat.com>
Content-Language: en-US
X-MC-Unique: piSav1kCNzSstXMjw7YWJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 1:54 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/25/19 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
>>> <aleksandar.m.mail@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau=20
>>>> <marcandre.lureau@redhat.com> wrote:
>>>>>
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>> =C2=A0 hw/mips/mips_mipssim.c | 1 -
>>>>> =C2=A0 1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>>>>> index bfafa4d7e9..3cd0e6eb33 100644
>>>>> --- a/hw/mips/mips_mipssim.c
>>>>> +++ b/hw/mips/mips_mipssim.c
>>>>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (serial_hd(0)) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *d=
ev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(DEVI=
CE(dev), "baudbase", 115200);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_=
chr(dev, "chardev", serial_hd(0));
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_set_legac=
y_instance_id(dev, 0x3f8, 2);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_init_nofa=
il(dev);
>>>>> --=20
>>>>
>>>>
>>>> Please mention in your commit message where the default baudbase is=20
>>>> set.
>>>
>>> ok
>>>
>>>> Also, is there a guarantie that default value 115200 will never=20
>>>> change in future?
>>>
>>> The level of stability on properties in general is unclear to me.
>>>
>>> Given that 115200 is standard for serial, it is unlikely to change
>>> though.. We can have an assert there instead?
>>>
>>> Peter, what do you think? thanks

IOW, until we merge Damien's "Clock framework API" series, I'd:

- rename 'baudbase' -> 'input_frequency_hz'

- set a 0 default value

  DEFINE_PROP_UINT32("input-frequency-hz", SerialState,
                      input_frequency_hz, 0),

- add a check in serial_realize()

     if (s->input_frequency_hz =3D=3D 0) {
         error_setg(errp,
               "serial: input-frequency-hz property must be set");
         return;
     }

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg642174.html

>> This property confused me by the past. It is _not_ the baudrate.
>> It is the input frequency clocking the UART ('XIN' pin, Xtal INput).
>>
>> Each board has its own frequency, and it can even be variable (the=20
>> clock domain tree can reconfigure it at a different rate).
>=20
> Laurent pointed me to the following commit which confirms my=20
> interpretation:
>=20
> $ git show 038eaf82c853
> commit 038eaf82c853f3bf8d4c106c0677bbf4adada7de
> Author: Stefan Weil <weil@mail.berlios.de>
> Date:=C2=A0=C2=A0 Sat Oct 31 11:28:11 2009 +0100
>=20
>  =C2=A0=C2=A0=C2=A0 serial: Add interface to set reference oscillator fre=
quency
>=20
>  =C2=A0=C2=A0=C2=A0 Many (most?) serial interfaces have a programmable
>  =C2=A0=C2=A0=C2=A0 clock which provides the reference frequency ("baudba=
se").
>  =C2=A0=C2=A0=C2=A0 So a fixed baudbase which is only set once can be wro=
ng.
>=20
>  =C2=A0=C2=A0=C2=A0 omap1.c is an example which could use the new interfa=
ce
>  =C2=A0=C2=A0=C2=A0 to change baudbase when the programmable clock change=
s.
>  =C2=A0=C2=A0=C2=A0 ar7 system emulation (still not part of standard QEMU=
)
>  =C2=A0=C2=A0=C2=A0 is similar to omap and already uses serial_set_freque=
ncy.
>=20
>  =C2=A0=C2=A0=C2=A0 Signed-off-by: Stefan Weil <weil@mail.berlios.de>
>  =C2=A0=C2=A0=C2=A0 Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>=20
> diff --git a/hw/pc.h b/hw/pc.h
> index 15fff8d103..03ffc91536 100644
> --- a/hw/pc.h
> +++ b/hw/pc.h
> @@ -13,6 +13,7 @@ SerialState *serial_mm_init (target_phys_addr_t base,=
=20
> int it_shift,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_irq irq, int baudbase,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 CharDriverState *chr, int ioregister);
>  =C2=A0SerialState *serial_isa_init(int index, CharDriverState *chr);
> +void serial_set_frequency(SerialState *s, uint32_t frequency);
>=20
>  =C2=A0/* parallel.c */
>=20
> diff --git a/hw/serial.c b/hw/serial.c
> index fa12dcc075..0063260569 100644
> --- a/hw/serial.c
> +++ b/hw/serial.c
> @@ -730,6 +730,13 @@ static void serial_init_core(SerialState *s)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 serial_event, s);
>  =C2=A0}
>=20
> +/* Change the main reference oscillator frequency. */
> +void serial_set_frequency(SerialState *s, uint32_t frequency)
> +{
> +=C2=A0=C2=A0=C2=A0 s->baudbase =3D frequency;
> +=C2=A0=C2=A0=C2=A0 serial_update_parameters(s);
> +}
> +


