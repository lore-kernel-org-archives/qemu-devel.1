Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772EEC35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EF82192A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+iWWYDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EF82192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j69XB-0005dg-03
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j69WO-00054u-17
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j69WM-0006J6-Fb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:55:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j69WM-0006Ii-BO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582534522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkNmrMbSu3Nb0pRVSIntGehLRlG903huIbMFBQ4VT98=;
 b=a+iWWYDdRiRAiadgV5HQ/2xoT1LhGtRKqeK7GQ+sM3T97TENZrlER7hDRbbC12UxXbBtm5
 SrqL6kcmB/cdokeOUQJ7Ms2FxGP9CXJYdnxxEdFp6o3HGoKIo5zzzK/JqJBpfadyMGiloF
 J2zoIp69snU3H5LhIyS7U/ey6BNOr9Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Q5Sl82U8PKy4TLEmMRKjaQ-1; Mon, 24 Feb 2020 03:55:20 -0500
X-MC-Unique: Q5Sl82U8PKy4TLEmMRKjaQ-1
Received: by mail-ed1-f71.google.com with SMTP id bc3so6185197edb.15
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 00:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5fYMjZEHwxp9ijHOKIbEy/YprHO4ogLS6F+5dH+4mQE=;
 b=bVr7zw9wMU6ltTJqCWGXkMgE3Xg3n7jMJwTVLKnnjIwPcdHZG+StM0HpO0eZerW8AK
 dGFLRQEkn3URQWPUGKpdkBEWlsFLro4Ece8QHLEqHcvmW/GPgXSVOhYTZIKFUpvMtfYd
 ABRoSXxT4xnLXWdWxOEB5FI31C5+D3xhLMotS2A0Zx5XJdyw8L4nZwLT9L7yOgWwW3/z
 7HS0kjFAsEmZRACABDBL4NkxQBRtZFXVVVzPT+qDphnXBQRqFzJXspPXlv+nEzGyHiB/
 qppvfLf0AM3WpZvgNlXp6w8FhtKZwJlhCD2vn8IcqG1IHglYXPHIRqJeEv9TbhLw9Fj3
 sIQg==
X-Gm-Message-State: APjAAAVliDOs8uKHKm4f8vQqwNYuDIMGh4c/fV/pNiP6MbSzxkkqP7f1
 xiuXaBStjtmevMk1oAa+5tt1nExmO5qpIScvMf5pcormZTu6ljb8FzjgXPkxBMfG7f+7OI2hpBb
 z+2fyVd8f3tyoFXc=
X-Received: by 2002:a05:6402:1347:: with SMTP id
 y7mr45778050edw.140.1582534518449; 
 Mon, 24 Feb 2020 00:55:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeMf7FtgWlKAxkA6fwPSBhF2HJlUAGQiJbIyaj0PEa5ubekdWquLShX8MKK9WV6K7N0Swb7Q==
X-Received: by 2002:a05:6402:1347:: with SMTP id
 y7mr45778024edw.140.1582534518194; 
 Mon, 24 Feb 2020 00:55:18 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id sa9sm759075ejb.28.2020.02.24.00.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 00:55:17 -0800 (PST)
Subject: Re: [PATCH v2 12/13] hw/arm/raspi: Add the Raspberry Pi B+ machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-13-f4bug@amsat.org>
 <CAPan3Wr=hxEu_XdKWEYJAZXJY4hHf774O2UfsJd0OmCHc8X0OQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d419e3f-9e85-c014-7cc7-b25544eb341f@redhat.com>
Date: Mon, 24 Feb 2020 09:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3Wr=hxEu_XdKWEYJAZXJY4hHf774O2UfsJd0OmCHc8X0OQ@mail.gmail.com>
Content-Language: en-US
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/22/20 11:19 PM, Niek Linnenbank wrote:
> Hey Philippe,
>=20
> Very nice to see that the Raspberry 1 will be supported again, thanks=20
> for contributing this!
>=20
> I tried to bring up the machine using raspbian 2019-09-26. It ran=20
> throught the early kernel initialisation
> but for me it gets stuck at this point:
>=20
> ./arm-softmmu/qemu-system-arm -M raspi1b -kernel=20
> $HOME/raspi/boot/kernel.img -append 'printk.time=3D0=20
> earlycon=3Dpl011,0x20201000 console=3DttyAMA0 rootwait root=3D/dev/mmcblk=
0p2' \
> -dtb $HOME/raspi/boot/bcm2708-rpi-b-plus.dtb -m 512 -sd=20
> $HOME/raspi/2019-09-26-raspbian-buster-lite.img -serial stdio -s
>=20
> [ =C2=A0 =C2=A00.000000] Booting Linux on physical CPU 0x0
> [ =C2=A0 =C2=A00.000000] Linux version 4.19.75+ (dom@buildbot) (gcc versi=
on 4.9.3=20
> (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1270 Tue Sep 24=20
> 18:38:54 BST 2019
> [ =C2=A0 =C2=A00.000000] CPU: ARMv6-compatible processor [410fb767] revis=
ion 7=20
> (ARMv7), cr=3D00c5387d
> [ =C2=A0 =C2=A00.000000] CPU: VIPT aliasing data cache, unknown instructi=
on cache
> [ =C2=A0 =C2=A00.000000] OF: fdt: Machine model: Raspberry Pi Model B+
> [ =C2=A0 =C2=A00.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
> [ =C2=A0 =C2=A00.000000] bootconsole [pl11] enabled
> [ =C2=A0 =C2=A00.000000] Memory policy: Data cache writeback
> [ =C2=A0 =C2=A00.000000] cma: Reserved 8 MiB at 0x1b800000
> [ =C2=A0 =C2=A00.000000] random: get_random_bytes called from=20
> start_kernel+0x8c/0x49c with crng_init=3D0
> [ =C2=A0 =C2=A00.000000] Built 1 zonelists, mobility grouping on.=C2=A0 T=
otal pages: 113680
> [ =C2=A0 =C2=A00.000000] Kernel command line: printk.time=3D0=20
> earlycon=3Dpl011,0x20201000 console=3DttyAMA0 rootwait root=3D/dev/mmcblk=
0p2
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 434380K/458752K available (6973K kernel code, 635K rwdata, 2080K=
=20
> rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
> Virtual kernel memory layout:
>  =C2=A0 =C2=A0 vector =C2=A0: 0xffff0000 - 0xffff1000 =C2=A0 ( =C2=A0 4 k=
B)
>  =C2=A0 =C2=A0 fixmap =C2=A0: 0xffc00000 - 0xfff00000 =C2=A0 (3072 kB)
>  =C2=A0 =C2=A0 vmalloc : 0xdc800000 - 0xff800000 =C2=A0 ( 560 MB)
>  =C2=A0 =C2=A0 lowmem =C2=A0: 0xc0000000 - 0xdc000000 =C2=A0 ( 448 MB)
>  =C2=A0 =C2=A0 modules : 0xbf000000 - 0xc0000000 =C2=A0 ( =C2=A016 MB)
>  =C2=A0 =C2=A0 =C2=A0 .text : 0x(ptrval) - 0x(ptrval) =C2=A0 (6975 kB)
>  =C2=A0 =C2=A0 =C2=A0 .init : 0x(ptrval) - 0x(ptrval) =C2=A0 ( 464 kB)
>  =C2=A0 =C2=A0 =C2=A0 .data : 0x(ptrval) - 0x(ptrval) =C2=A0 ( 636 kB)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0.bss : 0x(ptrval) - 0x(ptrval) =C2=A0 ( 798 k=
B)
> SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
> ftrace: allocating 25197 entries in 74 pages
> NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every=20
> 2147483647500ns
> clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff,=20
> max_idle_ns: 1911260446275 ns
> bcm2835: system timer (irq =3D 27)
> Console: colour dummy device 80x30
>=20
> Maybe it should switch to the graphical console here, but I dont see the=
=20
> boot splash logo either (when using -stdio instead of -nographic).
> With -M raspi2 and -dtb bcm2709-rpi-2-b.dtb the same raspbian image can=
=20
> fully boot to the login console.

Argh this is because I split this of a bigger series and didn't included=20
changes related to the GPU 'properties', sorry.

>=20
> Regards,
> Niek
>=20
>=20
>=20
> On Mon, Feb 17, 2020 at 12:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org=20
> <mailto:f4bug@amsat.org>> wrote:
>=20
>      =C2=A0 $ qemu-system-arm -M raspi1b -serial stdio \
>      =C2=A0 =C2=A0 =C2=A0 -kernel raspberrypi/firmware/boot/kernel.img \
>      =C2=A0 =C2=A0 =C2=A0 -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dt=
b \
>      =C2=A0 =C2=A0 =C2=A0 -append 'printk.time=3D0 earlycon=3Dpl011,0x202=
01000 console=3DttyAMA0'
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] Booting Linux on physical CPU 0x0
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] Linux version 4.19.69+ (dom@buildbot=
) (gcc version
>     4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep
>     3 20:21:01 BST 2019
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] CPU: ARMv6-compatible processor [410=
fb767]
>     revision 7 (ARMv7), cr=3D00c5387d
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] CPU: VIPT aliasing data cache, unkno=
wn instruction
>     cache
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] OF: fdt: Machine model: Raspberry Pi=
 Model B
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] earlycon: pl11 at MMIO 0x20201000 (o=
ptions '')
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] bootconsole [pl11] enabled
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] Memory policy: Data cache writeback
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] cma: Reserved 8 MiB at 0x1b800000
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] random: get_random_bytes called from
>     start_kernel+0x8c/0x49c with crng_init=3D0
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] Built 1 zonelists, mobility grouping=
 on.=C2=A0 Total
>     pages: 113680
>      =C2=A0 [=C2=A0 =C2=A0 0.000000] Kernel command line: printk.time=3D0
>     earlycon=3Dpl011,0x20201000 console=3DttyAMA0
>      =C2=A0 Dentry cache hash table entries: 65536 (order: 6, 262144 byte=
s)
>      =C2=A0 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes=
)
>      =C2=A0 Memory: 434380K/458752K available (6971K kernel code, 635K
>     rwdata, 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K
>     cma-reserved)
>      =C2=A0 ...
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     ---
>      =C2=A0hw/arm/raspi.c | 13 +++++++++++++
>      =C2=A01 file changed, 13 insertions(+)
>=20
>     diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>     index 3537a329ac..2d9f4e3085 100644
>     --- a/hw/arm/raspi.c
>     +++ b/hw/arm/raspi.c
>     @@ -324,6 +324,15 @@ static void
>     raspi_machine_class_common_init(MachineClass *mc,
>      =C2=A0 =C2=A0 =C2=A0mc->default_ram_size =3D board_ram_size(board_re=
v);
>      =C2=A0};
>=20
>     +static void raspi1b_machine_class_init(ObjectClass *oc, void *data)
>     +{
>     +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);
>     +=C2=A0 =C2=A0 RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
>     +
>     +=C2=A0 =C2=A0 rmc->board_rev =3D 0x900032;
>     +=C2=A0 =C2=A0 raspi_machine_class_common_init(mc, rmc->board_rev);
>     +};
>     +
>      =C2=A0static void raspi2b_machine_class_init(ObjectClass *oc, void *=
data)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0MachineClass *mc =3D MACHINE_CLASS(oc);
>     @@ -348,6 +357,10 @@ static void
>     raspi3b_machine_class_init(ObjectClass *oc, void *data)
>=20
>      =C2=A0static const TypeInfo raspi_machine_types[] =3D {
>      =C2=A0 =C2=A0 =C2=A0{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D MACHINE_TYPE_NAME("raspi1b"),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_RASPI_MACHINE,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D raspi=
1b_machine_class_init,
>     +=C2=A0 =C2=A0 }, {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D MACHINE_TYPE_NAME("raspi2b"),
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D TYPE_RASPI_MACHINE,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =C2=A0=3D=
 raspi2b_machine_class_init,
>     --=20
>     2.21.1
>=20
>=20
>=20
>=20
> --=20
> Niek Linnenbank
>=20


