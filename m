Received: from eggs.gnu.org ([2001:4830:134:3::10]:54355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZNwQ-0000Nz-GP
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZNwL-0002If-W7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:34:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:30944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gZNwL-0002GF-I9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:34:13 -0500
Date: Tue, 18 Dec 2018 23:34:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
Message-ID: <alpine.BSF.2.21.9999.1812182314450.71625@zero.eik.bme.hu>
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1812182326570.71625@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Hekster <ben.hekster@foghorn.io>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, 18 Dec 2018, Ben Hekster via Qemu-devel wrote:
> I had the exact same issue; for me it was just the addition of G=FCnthe=
r's "rootwait" option that resolved it, so:
>
> $ qemu-system-arm \
> 	-m 256m \
> 	-M raspi2 \
> 	-cpu cortex-a7 \
> 	-append "console=3DttyAMA0,115200 root=3D/dev/mmcblk0p2 rootwait rw" \
> 	-dtb bcm2709-rpi-2-b.dtb \
> 	-drive file=3D2018-11-13-raspbian-stretch-lite.img,if=3Dsd,format=3Dra=
w \
> 	-kernel kernel7.img \
> 	-nographic
>
> Did it for me using stock QEMU 3.1.0.  (I need "-nographic" because the=
 OS X port crashes without it)

Indeed. Thanks. It also boots with the raspbian kernel7.img after adding=20
this option, so likely the cause of this was that mmc wasn't detected fas=
t=20
enough and without rootwait it tried to mount it without waiting before=20
it was available.

It does not crash on OS X for me even without -nographic but I'm not yet=20
on Mojave. I've read there may be problems on latest macOS and seen=20
patches to fix that. Here's the discussion:

https://bugs.launchpad.net/qemu/+bug/1802684

Launchpad seems to have eaten the RFC patch URL in the last comment but I=
=20
think it's this one:

http://patchew.org/QEMU/20181201123056.432-1-peter.maydell@linaro.org/

Maybe you can test and report back if this fixes your problem so it can b=
e=20
merged if it helps.

Thank you,
BALATON Zoltan
