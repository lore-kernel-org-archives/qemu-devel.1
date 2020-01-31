Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F086C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1911C20663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rbl/daGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixLGb-0004jy-5h
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 20:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixLEI-00025d-Fd
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixL0c-0001cP-7A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:22:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixL0b-0001bM-SM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580433729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEyJrWoNGim2xdLBelnBx9w/iQMUzrebRokPEp3MEa4=;
 b=Rbl/daGw7nZl0MuLYXsvxOGT1r8Zmd2oxwxFirOGc0e+GVTbycVGV56z+g5fWEpi3Azt4s
 psj3G1f83M7Bg8n+B84Yfx/xJlHBVJUhpKITJqZbIoOMwPUGFHEXI8PUuZ6VdNFtLhFnwG
 OLYZ1wYdas0XkCumkQVWC9uFkZ73NSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-QZJOweB4M56bXtDFxqQPqg-1; Thu, 30 Jan 2020 20:22:05 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so2103496wmi.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 17:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HOAy40TNIJThyXDe+cNdTSb3VE7dfzAgUJhX5bDHTJY=;
 b=uRL99iUkLpqzg1KxNF68PyYAAM8QqCW8peFz79csb7Wpl0ka3KlZLxbTLMume1rOz0
 7jfuhJlYS2fGhc/nm66ZF17YAFRrvUIr6M3m1I9/TaMAAT6cMBEP4NrkDDjEKXuombKg
 OylGVjEK2MxR7dz84fLgTrxbyLc8g0EWeFLEbAVhXk0f6KaQDBaRldiO4kbgJFy/Uj0e
 dIBo97Y2QLRccOjGiJdckLy4XwrqPWtQWVB8GP702y4SECidSiw90kWEZY0D3pMZ5Qqi
 OG7mZztLnpAMoiRVSoWd8ZHhzCneTpHAbDoyhaZ7FqsnPjcjk6DA0Gbrmi+PHTMtJfWC
 3brQ==
X-Gm-Message-State: APjAAAV0P2HBDDYxm4buT+9RISoI7SqszMY08PfII/YQbBFyNz/OZAL9
 44sTkcd4sOMf5FDDEXIvAgRTXhWWTNXp062+TMzCvFJoCOa4LpXtFeGYRbFgOIUbMlpQ2Ilkjlp
 DWxZWg0HhqCWqye4=
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr8323011wro.209.1580433724065; 
 Thu, 30 Jan 2020 17:22:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdvwPjxkPHWdj0zEYOSmLG8HelSxaKlYAho0RD3qbSxsF5zbgUlBEI6aFGPO2dHeWanpy9Bw==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr8322950wro.209.1580433723479; 
 Thu, 30 Jan 2020 17:22:03 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s1sm737312wro.66.2020.01.30.17.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 17:22:02 -0800 (PST)
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
 <8be57265-7077-45cc-5b5a-d3a4345b4eae@xcancerberox.com.ar>
 <CAK4993jHOZWcujAwD+mpir8UCAnbswaNjtRC2HxXCL0gSWMhBg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a871537b-f7cd-66f0-8433-8cce8d721ba4@redhat.com>
Date: Fri, 31 Jan 2020 02:22:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK4993jHOZWcujAwD+mpir8UCAnbswaNjtRC2HxXCL0gSWMhBg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: QZJOweB4M56bXtDFxqQPqg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 1/27/20 2:38 PM, Michael Rolnik wrote:
> Hi Joaquin.
>=20
> I looks like that the CPU families are not well defined. There are some=
=20
> small variations within the families themselves i.e. some MCUs do not=20
> support all the features of their families.
> To get the features I looked at this file in gcc=20
> https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.=
c
> Have a look here=20
> https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-mcus.def=
.=20
> you can see that not all xmega support RMW instructions. so whenever=20
> QEMU has atxmega128d4 implemented, atxmega128d4 modelit will have to=20
> remove RMW feature.

What source should we trust here? The various datasheets or GCC?
GCC is eventually tested more thoroughly...

> Regards,
> Michael Rolnik
>=20
> On Mon, Jan 27, 2020 at 3:27 PM Joaquin de Andres=20
> <me@xcancerberox.com.ar <mailto:me@xcancerberox.com.ar>> wrote:
>=20
>     On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>      > From: Michael Rolnik <mrolnik@gmail.com <mailto:mrolnik@gmail.com>=
>
>      >
>      > This includes:
>      > - CPU data structures
>      > - object model classes and functions
>      > - migration functions
>      > - GDB hooks
>      >
>      > Co-developed-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>      > Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>      > Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>      > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>      > Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>      > Acked-by: Igor Mammedov <imammedo@redhat.com
>     <mailto:imammedo@redhat.com>>
>      > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>      > Message-Id: <20200118191416.19934-2-mrolnik@gmail.com
>     <mailto:20200118191416.19934-2-mrolnik@gmail.com>>
>      > Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>      > ---
>      > ...
>      > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>      > new file mode 100644
>      > index 0000000000..c74c5106fe
>      > --- /dev/null
>      > +++ b/target/avr/cpu.c
>      > @@ -0,0 +1,826 @@
>      > ...
>      > +/*
>      > + * Setting features of AVR core type avr1
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * at90s1200, attiny11, attiny12, attiny15, attiny28
>      > + */
>      > +static void avr_avr1_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +> +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Hi! According to the datasheets the at90s1200 is an special case and =
the
>     LPM instruction is not present.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with at90s1200 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr2
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22,
>     attiny26, at90s4414,
>      > + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
>      > + */
>      > +static void avr_avr2_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with at90s2313 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with at90s2313 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with at90s2313 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with at90s2313 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with at90s2313 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr25
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * ata5272, ata6616c, attiny13, attiny13a, attiny2313,
>     attiny2313a, attiny24,
>      > + * attiny24a, attiny4313, attiny44, attiny44a, attiny441,
>     attiny84, attiny84a,
>      > + * attiny25, attiny45, attiny85, attiny261, attiny261a,
>     attiny461, attiny461a,
>      > + * attiny861, attiny861a, attiny43u, attiny87, attiny48,
>     attiny88, attiny828,
>      > + * attiny841, at86rf401
>      > + */
>      > +static void avr_avr25_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with attiny13 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with attiny13 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with attiny13 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with attiny13 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with attiny13 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);> +  =20
>     avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with attiny13 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr3
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * at43usb355, at76c711
>      > + */
>      > +static void avr_avr3_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with at43usb355 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);> +  =
=20
>     avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with at43usb355 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with at43usb355 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>      > +}
>=20
>     I couldn't find the full instruction set for this microcontrollers, b=
ut
>     according with this [1] (not a certainty at all) wikipedia page, all =
the
>     instructions in the features are part of the instruction set (BREAK,
>     ICALL, IJMP, JMP, CALL, ADIW, SBIW).
>=20
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr31
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atmega103, at43usb320
>      > + */
>      > +static void avr_avr31_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atmega103 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr35
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * ata5505, ata6617c, ata664251, at90usb82, at90usb162,
>     atmega8u2, atmega16u2,
>      > + * atmega32u2, attiny167, attiny1634
>      > + */
>      > +static void avr_avr35_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr4
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a,
>     atmega48, atmega48a,
>      > + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a,
>     atmega88p,
>      > + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva,
>     at90pwm1,
>      > + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
>      > + */
>      > +static void avr_avr4_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr5
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795,
>     ata5831, ata6613c,
>      > + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161,
>     atmega162,
>      > + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165,
>     atmega165a,
>      > + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p,
>     atmega168pa,
>      > + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa,
>     atmega16hvb,
>      > + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32,
>     atmega323,
>      > + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a,
>     atmega325p,
>      > + * atmega325pa, atmega3250, atmega3250a, atmega3250p,
>     atmega3250pa, atmega328,
>      > + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p,
>     atmega329pa,
>      > + * atmega3290, atmega3290a, atmega3290p, atmega3290pa,
>     atmega32c1, atmega32m1,
>      > + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a,
>     atmega640, atmega644,
>      > + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a,
>     atmega645p,
>      > + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a,
>     atmega649p,
>      > + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb,
>     atmega6490a, atmega6490p,
>      > + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr=
2,
>      > + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64,
>     at90pwm161, at90pwm216,
>      > + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
>      > + */
>      > +static void avr_avr5_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atmega640 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);> +  =
=20
>     avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atmega8 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr51
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284,
>     atmega1284p,
>      > + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128,
>     at90usb1286,
>      > + * at90usb1287
>      > + */
>      > +static void avr_avr51_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atmega128 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avr6
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
>      > + */
>      > +static void avr_avr6_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atmega2560 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type avrtiny
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
>      > + */
>      > +static void avr_avrtiny_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     According with the attiny4/5/9/10 datasheet there is no LPM instructi=
on.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with attiny4/5/9/10 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with attiny4/5/9/10 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with attiny4/5/9/10 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type xmega2
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5,
>     atxmega32a4, atxmega32c3,
>      > + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4,
>     atxmega32a4u,
>      > + * atxmega32c4, atxmega32e5
>      > + */
>      > +static void avr_xmega2_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>=20
>     Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type xmega3
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * attiny212, attiny214, attiny412, attiny414, attiny416,
>     attiny417, attiny814,
>      > + * attiny816, attiny817, attiny1614, attiny1616, attiny1617,
>     attiny3214,
>      > + * attiny3216, attiny3217, atmega808, atmega809, atmega1608,
>     atmega1609,
>      > + * atmega3208, atmega3209, atmega4808, atmega4809
>      > + */
>      > +static void avr_xmega3_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>=20
>     Ok. Checked with attiny212 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type xmega4
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u,
>     atxmega64b1,
>      > + * atxmega64b3, atxmega64c3, atxmega64d4
>      > + */
>      > +static void avr_xmega4_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>=20
>     Ok. Checked with atxmega64a3 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type xmega5
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atxmega64a1, atxmega64a1u
>      > + */
>      > +static void avr_xmega5_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>=20
>     Ok. Checked with atxmega64a1 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type xmega6
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3,
>     atxmega256a3,
>      > + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u,
>     atxmega128b1,
>      > + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u,
>     atxmega192c3,
>      > + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
>      > + */
>      > +static void avr_xmega6_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>=20
>     Ok. Checked with atxmega128a3 datasheet.
>=20
>      > +}
>      > +
>      > +/*
>      > + * Setting features of AVR core type xmega7
>      > + * --------------------------------------
>      > + *
>      > + * This type of AVR core is present in the following AVR MCUs:
>      > + *
>      > + * atxmega128a1, atxmega128a1u, atxmega128a4u
>      > + */
>      > +static void avr_xmega7_initfn(Object *obj)
>      > +{
>      > +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);
>      > +=C2=A0 =C2=A0 CPUAVRState *env =3D &cpu->env;
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);
>=20
>     Ok. Checked with atxmega128a1 datasheet.
>=20
>      > +}
>      > ...
>=20
>=20
>     I hope this cross check is useful. The features that I didn't comment=
 on
>     is because I'm not sure.
>=20
>     Really nice to have this in qemu :). Thanks!
>=20
>     --joa
>=20
>     [1] https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set
>=20
>=20
>=20
> --=20
> Best Regards,
> Michael Rolnik


