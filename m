Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A36C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EA82053B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSgvEYOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EA82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZE0X-0002Ud-UN
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZDxW-0001dZ-J5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZDxU-00034S-7P
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:59:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZDxT-00033n-5t
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574686754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Azg7JxHNseyH/B7vgYU+TZIEwn/B5CR0hbUm08NPpkw=;
 b=iSgvEYOSCTJRQgDp8rfKw9N+vKTJiFptVx2aY4Io56Z+DP6flaBaWhj8TRvLfoEm/YltpR
 ywoH5XJgAoEfELsC9fko8M6PRDCvHUuG7e/dIJOH1/mzg814AzyZH00V8AUE1yJ+gSmngX
 Z1RTr1713ON7tBZZtuDzdT6BROKx/W4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-2GJF7-1VOkih1hX2B-2vEw-1; Mon, 25 Nov 2019 07:54:12 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so8793033wrr.5
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y92rAtPOpv45uYQ545truzdzc4gY+KW1XDKsObxbB/Y=;
 b=VC0CSVcfUEJXjMZJ3Xa5a1Hdc6YBBVRHFnbJmJkr0og5tZ+R6Rhepu7cg2y76tmHav
 SoOqdBUkx9e3AvRvO5ZgWFEtWQ6fH+I5FHukbojiHlwU0+FvLwlg5hIAPSpbPO9VZV+e
 Eoex8mh8ZPxPM4V1lMgGRLSYYZxHFv0mxlQf7ZZpfrHdV3nN8kTF6ev2mPuc5OzPinGm
 7aoMPqNX38NgkpswOWUuY1DHKH0PqElPNT8aRiZv080J9brp+2zkL1OcOpPbyD33I5sq
 B5jQ1+UBVPNvso0BhZBb95kdRioxflkEG+c78wD+vsHvzlis64/iyHM2hdAU6fMw8v6N
 tcqg==
X-Gm-Message-State: APjAAAWmU5YuIFppttXtVO0juQPSCuzL8mE3OsfoQ+ht8pRsHPuQUXmi
 HeZA7rXg+XGXwfYfARvdODXSMkklHkdOi/ZXY3RcsLLMKbNrgtgTr4wP22PfrxUiffNZgOqBHBl
 JSb2XoWJzmTv5c00=
X-Received: by 2002:a05:600c:1088:: with SMTP id
 e8mr29788241wmd.7.1574686450247; 
 Mon, 25 Nov 2019 04:54:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyASR27GQ92RxkT6cGiF4D5rxxxxiU0gHNp1luDeXv+BQpcPVWsvgDxTGOiuNErQ4MQVr55bg==
X-Received: by 2002:a05:600c:1088:: with SMTP id
 e8mr29788221wmd.7.1574686449993; 
 Mon, 25 Nov 2019 04:54:09 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x7sm10187976wrq.41.2019.11.25.04.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 04:54:09 -0800 (PST)
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
 <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
 <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
Message-ID: <c61a0426-bf43-9afe-3110-51bb11d75bd1@redhat.com>
Date: Mon, 25 Nov 2019 13:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
Content-Language: en-US
X-MC-Unique: 2GJF7-1VOkih1hX2B-2vEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>>>
>>>
>>>
>>> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau=20
>>> <marcandre.lureau@redhat.com> wrote:
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>> =C2=A0 hw/mips/mips_mipssim.c | 1 -
>>>> =C2=A0 1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>>>> index bfafa4d7e9..3cd0e6eb33 100644
>>>> --- a/hw/mips/mips_mipssim.c
>>>> +++ b/hw/mips/mips_mipssim.c
>>>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (serial_hd(0)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *de=
v =3D qdev_create(NULL, TYPE_SERIAL_IO);
>>>>
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_uint32(DEVIC=
E(dev), "baudbase", 115200);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_c=
hr(dev, "chardev", serial_hd(0));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_set_legacy=
_instance_id(dev, 0x3f8, 2);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_init_nofai=
l(dev);
>>>> --=20
>>>
>>>
>>> Please mention in your commit message where the default baudbase is set=
.
>>
>> ok
>>
>>> Also, is there a guarantie that default value 115200 will never=20
>>> change in future?
>>
>> The level of stability on properties in general is unclear to me.
>>
>> Given that 115200 is standard for serial, it is unlikely to change
>> though.. We can have an assert there instead?
>>
>> Peter, what do you think? thanks
>=20
> This property confused me by the past. It is _not_ the baudrate.
> It is the input frequency clocking the UART ('XIN' pin, Xtal INput).
>=20
> Each board has its own frequency, and it can even be variable (the clock=
=20
> domain tree can reconfigure it at a different rate).

Laurent pointed me to the following commit which confirms my interpretation=
:

$ git show 038eaf82c853
commit 038eaf82c853f3bf8d4c106c0677bbf4adada7de
Author: Stefan Weil <weil@mail.berlios.de>
Date:   Sat Oct 31 11:28:11 2009 +0100

     serial: Add interface to set reference oscillator frequency

     Many (most?) serial interfaces have a programmable
     clock which provides the reference frequency ("baudbase").
     So a fixed baudbase which is only set once can be wrong.

     omap1.c is an example which could use the new interface
     to change baudbase when the programmable clock changes.
     ar7 system emulation (still not part of standard QEMU)
     is similar to omap and already uses serial_set_frequency.

     Signed-off-by: Stefan Weil <weil@mail.berlios.de>
     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/hw/pc.h b/hw/pc.h
index 15fff8d103..03ffc91536 100644
--- a/hw/pc.h
+++ b/hw/pc.h
@@ -13,6 +13,7 @@ SerialState *serial_mm_init (target_phys_addr_t base,=20
int it_shift,
                               qemu_irq irq, int baudbase,
                               CharDriverState *chr, int ioregister);
  SerialState *serial_isa_init(int index, CharDriverState *chr);
+void serial_set_frequency(SerialState *s, uint32_t frequency);

  /* parallel.c */

diff --git a/hw/serial.c b/hw/serial.c
index fa12dcc075..0063260569 100644
--- a/hw/serial.c
+++ b/hw/serial.c
@@ -730,6 +730,13 @@ static void serial_init_core(SerialState *s)
                            serial_event, s);
  }

+/* Change the main reference oscillator frequency. */
+void serial_set_frequency(SerialState *s, uint32_t frequency)
+{
+    s->baudbase =3D frequency;
+    serial_update_parameters(s);
+}
+


