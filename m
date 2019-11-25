Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2745020740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UG4OISld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2745020740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZCWp-0008M3-4o
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 06:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZCVy-0007ct-Dd
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 06:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZCVw-0004Lx-Ft
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 06:26:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZCVw-0004LZ-94
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 06:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574681203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cjdk6wFDK5oTus9AXbYVxaAHBSIv6UNf8J/nzoxL0Qc=;
 b=UG4OISldqEbSWywS5s/4Wpah/aAu0LwH+LZ7Oom/Ntw+x7JGtS1YtJt2MkcGIuEahiKsCk
 yp+imHqYJVoIIw0aTJBfMSy1fXnDiHMc7bprPE1IlfTboeYNTih/2wFbOvtpl61k0AoEXV
 ZTIZtIfiUZiKXUJeJ9UqMfgzFI42IEo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-VMA_PkfQNeSNuLL_hJHEIA-1; Mon, 25 Nov 2019 06:26:33 -0500
Received: by mail-wr1-f72.google.com with SMTP id m17so8613716wrb.20
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 03:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NcAffS8AXZBiA910Ydb2Y7fFiWXzmPmfVERd4q1GsuM=;
 b=Nj/qXmaYTZpiRCXDgeXPC+rw83QgOUQiaGEZdYJ4y4wd3yubxBOOX/IVvTtMa/HIno
 UwQh+u52bmCBgu+meiepG684r6M2cZW4iFITKirEFICpsAa+zH8BwdqeGhhXZVBqI/1e
 laowg73x2eBBLi6JKsVVIqxQOowSpTbyzCfKNBPymIQaH8Vs+3kmeTKOedifCB1pvE7V
 xGsXiMkcfxaMCBCIiXlnZjoI4qdsYaW9DJinqM/5P4NRW+eIWJ8S/bapV54igH7E35C2
 SB+iY7r9YC11YJpOmYhtTeRXquPAkurw3s+l+sMyHk9NSEkFwcy4LY+Osd4uz5rO1C0t
 +Jcg==
X-Gm-Message-State: APjAAAUXZogDhoq4JznPO1mHXgCZgcdCUN0WwmIgU+9MLOlrXRgwY9gF
 w9Py5dApUM/qaf+9TqaCDHNrnKtHGWAeP8wzX3TlQn/G3fSxeLVgMQTMRctu11qE+9QOaTxn7X9
 Gt/cPZZn2YD7bKks=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr27234926wma.119.1574681192566; 
 Mon, 25 Nov 2019 03:26:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzE8BBMgV8igR0SkRD7jRo/Xe3+VLTBIT+mPEtZ41nn8t1cLVQ5d4BFwIOxjG0ulYfwKKw1GA==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr27234906wma.119.1574681192352; 
 Mon, 25 Nov 2019 03:26:32 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l4sm7824777wml.33.2019.11.25.03.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 03:26:31 -0800 (PST)
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
 <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58a5a515-2244-a927-9ca7-c0bb64ceca53@redhat.com>
Date: Mon, 25 Nov 2019 12:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: VMA_PkfQNeSNuLL_hJHEIA-1
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
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 11:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>>
>>
>> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lurea=
u@redhat.com> wrote:
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   hw/mips/mips_mipssim.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>>> index bfafa4d7e9..3cd0e6eb33 100644
>>> --- a/hw/mips/mips_mipssim.c
>>> +++ b/hw/mips/mips_mipssim.c
>>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
>>>       if (serial_hd(0)) {
>>>           DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>>>
>>> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>>>           qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>>>           qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>>>           qdev_init_nofail(dev);
>>> --
>>
>>
>> Please mention in your commit message where the default baudbase is set.
>=20
> ok
>=20
>> Also, is there a guarantie that default value 115200 will never change i=
n future?
>=20
> The level of stability on properties in general is unclear to me.
>=20
> Given that 115200 is standard for serial, it is unlikely to change
> though.. We can have an assert there instead?
>=20
> Peter, what do you think? thanks

This property confused me by the past. It is _not_ the baudrate.
It is the input frequency clocking the UART ('XIN' pin, Xtal INput).

Each board has its own frequency, and it can even be variable (the clock=20
domain tree can reconfigure it at a different rate).

I'm not sure it makes sense to have a default, and I don't know what is=20
the frequency modeled by the SPIM simulator.


