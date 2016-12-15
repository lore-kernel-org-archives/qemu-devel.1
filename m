Received: from eggs.gnu.org ([2001:4830:134:3::10]:38586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHWFC-0002mc-3G
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHWF8-0006mx-UJ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:38:46 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:49003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cHWF8-0006ma-Kh
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:38:42 -0500
Received: from player786.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 157FF68AB7
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 14:38:40 +0100 (CET)
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-15-git-send-email-clg@kaod.org>
	<CAFEAcA-E9Uq5YjSOGu9uNwbhAefqbs-0V7sVbCeeeg85NtSugQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <548479f7-eb04-c769-d64b-102ebd360111@kaod.org>
Date: Thu, 15 Dec 2016 14:38:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-E9Uq5YjSOGu9uNwbhAefqbs-0V7sVbCeeeg85NtSugQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 14/30] aspeed/smc: rework the
 prototype of the AspeedSMCFlash helper routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 12/14/2016 06:09 PM, Peter Maydell wrote:
> On 29 November 2016 at 15:43, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> Change the routines prototype to use a 'AspeedSMCFlash *' instead of
>> 'AspeedSMCState *'. The result will help in making future changes
>> clearer.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>=20
> This patch breaks 'make check' because the palmetto-bmc
> model now segfaults on startup:
>=20
> gdb --args ./build/x86/arm-softmmu/qemu-system-arm -M palmetto-bmc
> GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.04) 7.11.1
> [...]
> (gdb) r
> Starting program:
> /home/petmay01/linaro/qemu-from-laptop/qemu/build/x86/arm-softmmu/qemu-=
system-arm
> -M palmetto-bmc
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.=
1".
> [New Thread 0x7fffd1270700 (LWP 30296)]
> [New Thread 0x7fffcfb97700 (LWP 30297)]
> [New Thread 0x7fffcf396700 (LWP 30298)]
> [New Thread 0x7fffceb95700 (LWP 30299)]
> [New Thread 0x7fffbf709700 (LWP 30300)]
>=20
> Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> 0x0000555555b2fce8 in aspeed_smc_flash_update_cs (fl=3D0x0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:=
413
> 413         AspeedSMCState *s =3D fl->controller;
> (gdb) bt
> #0  0x0000555555b2fce8 in aspeed_smc_flash_update_cs (fl=3D0x0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:=
413
> #1  0x0000555555b2fd6a in aspeed_smc_update_cs (s=3D0x7fffcc3924c0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:=
422
> #2  0x0000555555b2febc in aspeed_smc_reset (d=3D0x7fffcc3924c0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:=
447
> #3  0x0000555555b304a6 in aspeed_smc_realize (dev=3D0x7fffcc3924c0,
> errp=3D0x7fffffffdcf0) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/ssi/aspeed_smc.c:556
> #4  0x0000555555a19329 in device_set_realized (obj=3D0x7fffcc3924c0,
> value=3Dtrue, errp=3D0x7fffffffde98) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/qdev.c:918
> #5  0x0000555555c17e50 in property_set_bool (obj=3D0x7fffcc3924c0, v=3D
>     0x555556ea9d90, name=3D0x555555d639e7 "realized",
> opaque=3D0x5555569cafb0, errp=3D0x7fffffffde98) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:1854
> #6  0x0000555555c1635b in object_property_set (obj=3D0x7fffcc3924c0, v=3D
>     0x555556ea9d90, name=3D0x555555d639e7 "realized", errp=3D0x7fffffff=
de98)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:1088
> #7  0x0000555555c19183 in object_property_set_qobject
> (obj=3D0x7fffcc3924c0, value=3D0x555556ea9c80, name=3D0x555555d639e7
> "realized", errp=3D0x7fffffffde98)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/qom-qobject.c:27
> #8  0x0000555555c165fe in object_property_set_bool
> (obj=3D0x7fffcc3924c0, value=3Dtrue, name=3D0x555555d639e7 "realized",
> errp=3D0x7fffffffde98)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:1157
> #9  0x00005555558da673 in aspeed_soc_realize (dev=3D0x7fffcc371010,
> errp=3D0x7fffffffdf20) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/aspeed_soc.c:256
> #10 0x0000555555a19329 in device_set_realized (obj=3D0x7fffcc371010,
> value=3Dtrue, errp=3D0x555556849518 <error_abort>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/qdev.c:918
> #11 0x0000555555c17e50 in property_set_bool (obj=3D0x7fffcc371010, v=3D
>     0x5555569cc5b0, name=3D0x555555d63b5c "realized",
> opaque=3D0x5555569be320, errp=3D0x555556849518 <error_abort>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:1854
> #12 0x0000555555c1635b in object_property_set (obj=3D0x7fffcc371010, v=3D
>     0x5555569cc5b0, name=3D0x555555d63b5c "realized",
> errp=3D0x555556849518 <error_abort>) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:1088
> #13 0x0000555555c19183 in object_property_set_qobject
> (obj=3D0x7fffcc371010, value=3D0x5555569cc3a0, name=3D0x555555d63b5c
> "realized", errp=3D0x555556849518 <error_abort>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/qom-qobject.c:27
> #14 0x0000555555c165fe in object_property_set_bool
> (obj=3D0x7fffcc371010, value=3Dtrue, name=3D0x555555d63b5c "realized",
> errp=3D0x555556849518 <error_abort>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:1157
> #15 0x00005555558dadfe in aspeed_board_init (machine=3D0x55555693d8a0,
> cfg=3D0x555556184fe0 <aspeed_boards>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/aspeed.c:152
> #16 0x00005555558daf9c in palmetto_bmc_init (machine=3D0x55555693d8a0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/aspeed.c:182
> #17 0x000055555596af75 in main (argc=3D3, argv=3D0x7fffffffe4c8,
> envp=3D0x7fffffffe4e8)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/vl.c:4548
>=20
> Calling reset from realize is probably a bad idea (reset gets
> called later anyway), and calling qemu_set_irq() from reset
> isn't recommended either. These may or may not be the cause
> of the crash though.

It it a bad split with the following patch so I will merge them in=20
the next version and try to cleanup up the qemu_set_irq().

Thanks,

C.
