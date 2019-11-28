Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA07C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130A621741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLTvsVDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130A621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHtd-0006xV-7X
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaHjT-0001Hj-CM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaHjL-0000ys-Ml
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:13:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaHjJ-0000sK-VN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574939578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iD34fdLC9E2NqrgwQe4kojPCKRUHCOEifjNJbgQPZRg=;
 b=gLTvsVDItlTSZCP23ijiYLnoguS0naAW84sXQ4ApB5ks98HxYXFjd8xj4Sh1V4MCL83q2H
 Me/FjAXpFz17oSiOH06sLFxcpTOKh+XHdJbXlCT9yORVukXnGmSGZzXeGooUZkPef9vg1T
 A8UBN77B6YKFUdHSC2A1oqhzDb5Ptvs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-0d7eOcpfOeeKBkRSy4C4eQ-1; Thu, 28 Nov 2019 06:12:56 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so961789wrm.23
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 03:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r5XwDbGYDdYF5ISC09n3ZjVoD65288XcNWohzzWD5pA=;
 b=Md8tyh9AcxagxJPGx+yPtJfw22P9Rv1ItGdA5UZT4K1EkiuI2y1199hk8kNWUpXfMj
 QI8rsIziSZtXdodQx8AoZRN+y1pjX45swA3Culf1HC+rkK80WaX0cDcXIRzAAYjRriOp
 +CBjEVLWRhXNyPFxH4U1sb8uYjJa8iiNgp31mQQ+JLtVLfm+QUs4pR4mKglVyDlPs4sR
 k6oTrJHH2+2mMjN+KvlACXQ4F6BIsRmBDD1asPKYs69eLXkYZrR4q0IMBkXNuwt27M3Y
 oDLIuaYfGGorqxjmbHa/6x8Q4qFD3GH1AKXvqMqC7VzkvDbz/RdLFvFdlSkjamH7oly3
 XXDQ==
X-Gm-Message-State: APjAAAXWYEo8NQ5q+vNomhsenRYw8u00JqE26yfUt/0mKghfbka+Y59+
 Q857MwLgkJfCjvkHU76e+VG0xJY0n7MIgmgWZQw6hl/4CHnN6vQg1sjtSA4YbhsbUbQZqxiAYsR
 5YwQgU4VNUateoaE=
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr14619076wrn.235.1574939575021; 
 Thu, 28 Nov 2019 03:12:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKED8A8hWM8mlGAKR2kevYfu6yOXQdB7ihWdh+0WFrvTBNC6bm5995y05Yc4zN4wgGBb9Y5w==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr14619050wrn.235.1574939574718; 
 Thu, 28 Nov 2019 03:12:54 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x9sm22345440wru.32.2019.11.28.03.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 03:12:54 -0800 (PST)
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 dovgaluk <dovgaluk@ispras.ru>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
 <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
 <4ed9736f9e88d9d242a0aed10fb65aac@ispras.ru>
 <CAL1e-=ib7h8szh48ckOk8yvF+7SQd9_hyoYU3E+K=CGy0EJkGA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60174488-c207-030b-23a5-7e8a51d45a04@redhat.com>
Date: Thu, 28 Nov 2019 12:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ib7h8szh48ckOk8yvF+7SQd9_hyoYU3E+K=CGy0EJkGA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 0d7eOcpfOeeKBkRSy4C4eQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 11:20 AM, Aleksandar Markovic wrote:
> On Thursday, November 28, 2019, dovgaluk <dovgaluk@ispras.ru=20
> <mailto:dovgaluk@ispras.ru>> wrote:
>=20
>     Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 12:28:
>=20
>         On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9
>         <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
>=20
>             Add famous ATmega MCUs:
>=20
>             - middle range: ATmega168 and ATmega328
>             - high range: ATmega1280 and ATmega2560
>=20
>             Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>             <mailto:f4bug@amsat.org>>
>             ---
>=20
>=20
>         Philippe, hi.
>=20
>         Thank you for the impetus you give us all.
>=20
>         However, is this the right direction?
>=20
>         Let's analyse some bits and pieces.
>=20
>         Starting from the commit message, the word "famous" is used, but =
I
>         really don't see enumerated CPUs/MCUs are any special in Atmel
>         lineup.
>         Other than we often used the doc describing them (cited several
>         times
>         in our discussions) as our reference, but that doesn't make them
>         "famous". Ofcourse, there other docs for other Atmel CPUs/MCUs,
>         of at
>         lest equivalent significance. For example, "tiny" ones are at
>         least as
>         famous as "mega" ones.
>=20
>         Then, you introduce the term MCU, without proper discussion with
>         others on terminology. In parlance of QEMU, ATmega168 at al. are
>         CPUs
>         (we all know and assume that that are some peripherals in it). I =
am
>         not against using the term MCU, but let's first sync up on that.
>=20
>         The added terminology trouble is that MCUs, as you defined them,
>         have
>         in array atmega_mcu[] a field called "cpu_type" - why is that fie=
ld
>         not called "mcu_type"? *Very* confusing for any future reader. An=
d
>         then, similar terminology conundrum continues with macro
>         AVR_CPU_TYPE_NAME().
>=20
>=20
>     MCU is a system-on-chip which includes CPU core and peripheral device=
s.
>     Separating this is better that including everything into the machine.
>=20
>     E.g., different MCUs may have different IO addresses for USART.
>=20
>=20
> Pavel,
>=20
> Do you know how is this resolved for other platforms?
>=20
> How other platfirms organize and use terms "soc", "mcu", "cpu", =C2=A0"co=
re",=20
> "cpu core"? And what is the relation between each of them and QEMU=20
> command line options "-cpu" and "-machine"? Is thar organization the=20
> same accross all platforms?

The market/industry evolves quicker than the QEMU codebase, so some=20
technical namings that were fine 14 years ago might be not sufficient=20
nowadays.

QEMU started with dies/chipsets being really only a=20
CentralProcessingUnit, cache managed off-die, external RAM, external=20
peripherals.

For example the R4000 is a CPU with internal cache but QEMU doesn't=20
model caches.

Now compare that with the I6500. Is it a CPU? Yes and no...
It has 4-6 cores (each having its own ScratchPad RAM), each core having=20
various threads (now 'thread' =3D=3D QEMU MIPS CPU), there are peripherals=
=20
dedicated to inter-core communication; then there is also some I/O=20
coherence units to use external peripherals. Add to that you can=20
clusterize the cores :)
All that in the same die. The industry calls this 'System-on-Chip',=20
abbreviated SoC.
Actually the 'SoC' abbreviation is used as it by MIPS marketing:
https://www.mips.com/products/warrior/i-class-i6500-multiprocessor-core/

   "As such, in conjunction with popular third party SoC coherent
   interconnect/fabric alternatives, the I6500 family can be used
   in =E2=80=9Cmany core=E2=80=9D implementations of up to 64 clusters, or =
>1500
   processing elements (up to four threads/core, up to six
   cores/cluster, up to 64 clusters)."


MCU and SoC are similar in that they contains CPU and peripherals in the=20
same die.


Now the QEMU codebase has various 'subsystems' of interests. Group of=20
developers are custom to work in the same subsystems. When I'm writing=20
code/comments targeting a specific group, I try to use the technical=20
vocabulary used by the group, often based on the subsystem technical=20
documentation available (specs, datasheets). This is why here I used the=20
MCU terminology.

> (I am asking you as you most likely have much wider experience in the=20
> topic, sincr mine i limited to mips emulation)
>=20
> Yours, Aleksandar
[...]


