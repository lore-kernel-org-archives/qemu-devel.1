Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928C1C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC6F222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu3yQQsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC6F222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii19N-0000UN-Bg
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ii18K-0007oc-U3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ii18J-0007MM-03
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:06:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ii18I-0007J4-R2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576782406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TynpDEwj2AG/Pgz/mZbQv9Qkv++l8kSA22+NdVyZDnw=;
 b=Iu3yQQsdZA2GCJd8P8l3XPMOmHGWK5ppz7DXVLs39m+yJRkqzUdke64WW4Uv5Va8Sx0XGj
 TwJeigCjRCWuXl788ctCrT9tYHvm8cMi1+LyHvHr1yLgepkUEJH44S7yjsbmaP6ozXVJrA
 Txz7Fk/KN9kvDvOiE9xaC7yaV/W10gQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-xLR4i6IGNN6AWyXtSAS1fw-1; Thu, 19 Dec 2019 14:06:39 -0500
Received: by mail-wm1-f69.google.com with SMTP id t16so1724374wmt.4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 11:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o2OSrHs0YUZFw1j6IF6ir4xvmI4fQhqh/dV7Wa/zFdE=;
 b=AZAOPP6jpCitYdUyj/flCxpVVIGIA0PSEA5PjLnqIck1p5NO0buvH4eLGhvlTdlanu
 dpmx8nguo8NH/aWsDlXN+GNVEbJvqJBaQOAdKRuPJWUW0u3UV+futnrlJeVCyqfj49Gv
 OOoF6el03idQk5IJsm6tph1NHi0aZmuP9kKoYD28hDrhkNsJ2LO2dVWf4NgNTeHk49h6
 yI6k+rq4HRJGYZuCl53OALW30zCUHBF5hXUszREg7PDeUmwFci3j1n5lLCr7DNB5QGH/
 L3p6WU7iFTNKHTX0NH421XlwRjliiT8roYWuOyXUHvc6Y4Pc6siBSSNkNrGfHJUXFDhy
 DI6A==
X-Gm-Message-State: APjAAAWbiSMMCKAaCVTw3S8qDWpAwd1jWtoobKTfxEZwh+P/FcCb94PG
 lF8otEfT4e/PrnXBf/ee+vOvSFe7lPfV0djz+Fd2XeB9TbIDlYfjgh3dZZKc72YnVHPcoEzvdSu
 IZRM1X4Av4UdUrVQ=
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr10913421wrv.335.1576782398795; 
 Thu, 19 Dec 2019 11:06:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDhbbY2fdFhiVISXAHn1Xk0xWzpnvXYVSVMqYZA+q/n2fGZMUMemAviigoTCvPDfodbZjiDg==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr10913386wrv.335.1576782398422; 
 Thu, 19 Dec 2019 11:06:38 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id g7sm7360592wrq.21.2019.12.19.11.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 11:06:37 -0800 (PST)
Subject: Re: [PATCH v2 02/10] hw: arm: add Xunlong Orange Pi PC machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-3-nieklinnenbank@gmail.com>
 <e66415e1-7dcc-9fa3-7ff3-6526087be799@redhat.com>
 <CAPan3Wq6iM1k=UBP7kFUF-hYuSu836VLH+_YNFwdWAffbmnvYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fd3359ca-cbfb-5491-37e7-cf4fe3e783f8@redhat.com>
Date: Thu, 19 Dec 2019 20:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Wq6iM1k=UBP7kFUF-hYuSu836VLH+_YNFwdWAffbmnvYQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: xLR4i6IGNN6AWyXtSAS1fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 9:14 PM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> Thanks again for your quick and helpful feedback! :-)
>=20
> On Tue, Dec 17, 2019 at 8:31 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Niek,
>=20
>     On 12/17/19 12:35 AM, Niek Linnenbank wrote:
>      > The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
>      > based embedded computer with mainline support in both U-Boot
>      > and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
>      > 512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
>      > various other I/O. This commit add support for the Xunlong
>      > Orange Pi PC machine.
>      >
>      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > Tested-by: KONRAD Frederic <frederic.konrad@adacore.com
>     <mailto:frederic.konrad@adacore.com>>
>      > ---
>      >=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 | 101
>     +++++++++++++++++++++++++++++++++++++++++++
>      >=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +
>      >=C2=A0 =C2=A0hw/arm/Makefile.objs |=C2=A0 =C2=A02 +-
>      >=C2=A0 =C2=A03 files changed, 103 insertions(+), 1 deletion(-)
>      >=C2=A0 =C2=A0create mode 100644 hw/arm/orangepi.c
>      >
>      > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
>      > new file mode 100644
>      > index 0000000000..62cefc8c06
>      > --- /dev/null
>      > +++ b/hw/arm/orangepi.c
>      > @@ -0,0 +1,101 @@
>      > +/*
>      > + * Orange Pi emulation
>      > + *
>      > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > + *
>      > + * This program is free software: you can redistribute it and/or
>     modify
>      > + * it under the terms of the GNU General Public License as
>     published by
>      > + * the Free Software Foundation, either version 2 of the License,=
 or
>      > + * (at your option) any later version.
>      > + *
>      > + * This program is distributed in the hope that it will be useful=
,
>      > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See=
 the
>      > + * GNU General Public License for more details.
>      > + *
>      > + * You should have received a copy of the GNU General Public Lice=
nse
>      > + * along with this program.=C2=A0 If not, see
>     <http://www.gnu.org/licenses/>.
>      > + */
>      > +
>      > +#include "qemu/osdep.h"
>      > +#include "exec/address-spaces.h"
>      > +#include "qapi/error.h"
>      > +#include "cpu.h"
>      > +#include "hw/sysbus.h"
>      > +#include "hw/boards.h"
>      > +#include "hw/qdev-properties.h"
>      > +#include "hw/arm/allwinner-h3.h"
>      > +
>      > +static struct arm_boot_info orangepi_binfo =3D {
>      > +=C2=A0 =C2=A0 .board_id =3D -1,
>      > +};
>      > +
>      > +typedef struct OrangePiState {
>      > +=C2=A0 =C2=A0 AwH3State *h3;
>      > +=C2=A0 =C2=A0 MemoryRegion sdram;
>      > +} OrangePiState;
>      > +
>      > +static void orangepi_init(MachineState *machine)
>      > +{
>      > +=C2=A0 =C2=A0 OrangePiState *s =3D g_new(OrangePiState, 1);
>      > +
>      > +=C2=A0 =C2=A0 /* Only allow Cortex-A7 for this board */
>      > +=C2=A0 =C2=A0 if (strcmp(machine->cpu_type,
>     ARM_CPU_TYPE_NAME("cortex-a7")) !=3D 0) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report("This board can only be =
used with cortex-a7
>     CPU");
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);
>      > +=C2=A0 =C2=A0 }
>      > +
>      > +=C2=A0 =C2=A0 s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
>      > +
>      > +=C2=A0 =C2=A0 /* Setup timer properties */
>      > +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&s->h3->timer), 3276=
8,
>     "clk0-freq",
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &error_abort);
>=20
>     You access the timer object which is contained inside the soc object,
>     but the soc isn't realized yet... I wonder if this is OK. Usually wha=
t
>     we do is, either:
>     - add a 'xtal-freq-hz' property to the SoC, set it here in the board,
>     then in soc::realize() set the property to the timer
>     - add an alias in the SoC to the timer 'freq-hz' property:
>      =C2=A0 =C2=A0 =C2=A0object_property_add_alias(soc, "xtal-freq-hz", O=
BJECT(&s->timer),
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "freq-hz", &err=
or_abort);
>=20
> Good point. I shall rework that part using your suggestion.
> Actually, I copied the timer support code from the existing cubieboard.c=
=20
> that has
> the Allwinner A10, so potentially the same problem is there.
>=20
> While looking more closer at this part, I now also discovered that the=20
> timer module from the Allwinner H3 is
> mostly a stripped down version of the timer module in the Allwinner A10:
>=20
>  =C2=A0 Allwinner A10, 10.2 Timer Register List, page 85:
> https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf
>=20
> The A10 version has six timers, where the H3 has only two. That should=20
> be fine I would say, the guest would simply
> use those available on H3 and ignore the rest. There is however one=20
> conflicting difference: the WDOG0 registers in the Allwinner H3 start
> at a different offset and are also different. The current A10 timer does=
=20
> not currently implement the watchdog part.
>=20
> The watchdog part of this timer is relevant for the 'reset' command in=20
> U-Boot: that does not work right now, because
> U-Boot implements the reset for the Allwinner H3 boards by letting this=
=20
> watchdog expire (and we dont emulate it).
> Also, this timer module is required for booting Linux, without it the=20
> kernel crashes using the sunxi_defconfig:
>=20
> [    0.000000] PC is at sun4i_timer_init+0x34/0x168
> [    0.000000] LR is at sun4i_timer_init+0x2c/0x168
> [    0.000000] pc : [<c07fa634>]    lr : [<c07fa62c>]    psr: 600000d3
> [    0.000000] sp : c0a03f70  ip : eec00188  fp : ef7ed040
> ...
> [    0.000000] [<c07fa634>] (sun4i_timer_init) from [<c07fa4e8>] (timer_p=
robe+0x74/0xe4)
> [    0.000000] [<c07fa4e8>] (timer_probe) from [<c07d9c10>] (start_kernel=
+0x2e0/0x440)
> [    0.000000] [<c07d9c10>] (start_kernel) from [<00000000>] (0x0)
>=20
>=20
> So in my opinion its a bit of a trade off here: we can keep it like this=
=20
> and re-use the A10 timer for now, and perhaps
> attempt to generalize that module for proper use in both SoCs. Or we can=
=20
> introduce a new H3 specific timer module.
> What do you think?

See my answer about generalize/reuse here:
http://mid.mail-archive.com/20191219185127.24388-1-f4bug@amsat.org


