Received: from eggs.gnu.org ([2001:4830:134:3::10]:42850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben.hekster@foghorn.io>) id 1gZNJO-0007Ug-IK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben.hekster@foghorn.io>) id 1gZNJL-0007OX-76
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:53:58 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben.hekster@foghorn.io>)
	id 1gZNJK-0007Nv-Qb
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 16:53:55 -0500
Received: by mail-pf1-x443.google.com with SMTP id c123so8776873pfb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 13:53:54 -0800 (PST)
Received: from [10.10.6.123] ([12.196.120.194])
	by smtp.gmail.com with ESMTPSA id
	o189sm24595116pfg.117.2018.12.18.13.53.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 18 Dec 2018 13:53:52 -0800 (PST)
From: Ben Hekster <ben.hekster@foghorn.io>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Message-Id: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
Date: Tue, 18 Dec 2018 13:53:51 -0800
Content-Type: text/plain;
	charset=utf-8
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
To: qemu-devel@nongnu.org

Hi, Zoltan=E2=80=94

> On Thu, 29 Nov 2018, Guenter Roeck wrote:
> On 11/29/18 6:42 PM, BALATON Zoltan wrote:
> On Thu, 29 Nov 2018, Guenter Roeck wrote:
> On 11/29/18 4:43 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Zoltan,
>=20
> On 29/11/18 21:29, BALATON Zoltan wrote:
> Hello,
>=20
> I could not boot Raspbian on QEMU's raspi emulation and I'm not sure =
why
> it fails. So question is if this is supposed to work or am I doing
> something wrong or any clues what may be missing? I'm trying with this
> command line with v3.1.0-rc3:
>=20
> qemu-system-arm -M raspi2 -serial stdio \
> -kernel rpi-kernel7.img -dtb bcm2709-rpi-2-b.dtb \
> -append "rw earlyprintk loglevel=3D8 console=3DttyAMA0,115200
> dwc_otg.lpm_enable=3D0 root=3D/dev/mmcblk0p2" \
> -drive file=3D2018-10-09-raspbian-stretch-lite.img,format=3Draw,if=3Dsd
>=20
> Kernel starts to boot, I see raspberries on the guest screen and log
> output to serial:
>=20
> Booting Linux on physical CPU 0xf00
> Linux version 4.14.71-v7+ (address@hidden) (gcc version 4.9.3
> (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1145 SMP Fri Sep 21
> 15:38:35 BST 2018
> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D10c5387d
> [...]
>=20
> My version (https://github.com/groeck/qemu =
<https://github.com/groeck/qemu>) seems to work, using
> Tried with your v3.1.0-local branch but got same results (does not =
find mmcblk0 on raspi2, nothing on raspi3) so probably it's not one of =
the patches in your tree that's missing.
> multi_v7_defconfig.
> Then maybe it's your kernel config that's different? Do you have =
compiled kernels available that I could try?
> Shouldn't be, but I attached my configuration. This time with v4.14.84 =
and
> "make ARCH-arm savedefconfig" after building the image. The output is =
identical
> to "make ARCH=3Darm multi_v7_defconfig; make ARCH=3Darm =
savedefconfig".
>=20
> Oh, and here is my qemu configuration.
>=20
> --disable-user --disable-gnutls --disable-docs \
>        --disable-nettle --disable-gcrypt --disable-vnc-png \
>        --disable-xen --disable-xen-pci-passthrough \
>        --enable-debug --disable-strip
>=20
> That should not make a difference either, but who knows.
> Just to be sure, I copied a kernel and a root file system
> to http://server.roeck-us.net/qemu/arm-raspi2/ =
<http://server.roeck-us.net/qemu/arm-raspi2/>
> It boots with your kernel (also the raspbian-lite image) so it's =
likely that the config of the Raspbian kernel is different and that =
causes the problem. Unfortunately I don't know what config their kernels =
use. If I'm not mistaken this is the raspbian kernel repo:
> https://github.com/raspberrypi/linux/ =
<https://github.com/raspberrypi/linux/>
>=20
> My guesses would be bcm2835_defconfig or some other bcm*config? Or =
something completely different?
> Regards,
> BALATON Zoltan

I had the exact same issue; for me it was just the addition of =
G=C3=BCnther's "rootwait" option that resolved it, so:

$ qemu-system-arm \
	-m 256m \
	-M raspi2 \
	-cpu cortex-a7 \
	-append "console=3DttyAMA0,115200 root=3D/dev/mmcblk0p2 rootwait =
rw" \
	-dtb bcm2709-rpi-2-b.dtb \
	-drive =
file=3D2018-11-13-raspbian-stretch-lite.img,if=3Dsd,format=3Draw \
	-kernel kernel7.img \
	-nographic

Did it for me using stock QEMU 3.1.0.  (I need "-nographic" because the =
OS X port crashes without it)

Ben
