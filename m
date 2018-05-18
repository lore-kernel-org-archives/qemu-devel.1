Received: from eggs.gnu.org ([2001:4830:134:3::10]:32933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJdK1-0002rC-GX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJdJw-0008Si-Cm
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:13:17 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:52095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fJdJw-0008S9-2W
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:13:12 -0400
Received: from player159.ha.ovh.net (unknown [10.109.122.11])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5E768163D1
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 13:13:10 +0200 (CEST)
Date: Fri, 18 May 2018 13:13:03 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180518131303.6f0778eb@bahia.lan>
In-Reply-To: <886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, 18 May 2018 12:30:44 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> On 18 May 2018 at 11:24PM, Thomas Huth wrote:
> > On 18.05.2018 11:06, Christian Zigotzky wrote: =20
> >> It works on my AmigaOne X5000 (P5020 board with 2x e5500 cores).
> >>
> >> Screenshots: https://plus.google.com/115515624056477014971 =20
> > Interesting ... but you still use your own kernel, and not the stock
> > Ubuntu kernel, right? That would explain how this can work...
> >
> > Anyway, having a quick look at the sources, it seems to me that the
> > ppce500 / mpc8544ds machines in QEMU do not support any mass storage
> > controllor by default, so you got to specify the interface type.
> >
> > For example:
> >
> >   -drive if=3Dvirtio,file=3D...
> >
> > or:
> >
> >   -device virtio-scsi -drive if=3Dnone,id=3Dc1,file=3D... \
> >   -device scsi-cd,drive=3Dc1
> >
> > Same for the graphics card, there does not seem to be support for a
> > default here, so try to specify it like this:
> >
> >   -device VGA
> >
> > or:
> >
> >   -device virtio-vga
> >
> >   HTH,
> >    Thomas
> > =20
> Hello Thomas,
>=20
> Thanks for your reply.
>=20
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel=20
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uIm=
age-4.17=20
> -machine dt_compatible=3Dfsl,,P5020DS -drive=20
> if=3Dvirtio,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_Powe=
rPC_QEMU/ubuntu_MATE_16.04_PowerPC.img=20
> -append "root=3D/dev/sda3"
>=20
> Output:
>=20
> [=C2=A0=C2=A0=C2=A0 0.880961] VFS: Cannot open root device "sda3" or=20
> unknown-block(0,0): error -6

if=3Dvirtio translates to -device virtio-blk-pci AFAIK, in which case you s=
hould
pass "root=3D/dev/vda3".

And of course your kernel should be built with virtio support.

> [=C2=A0=C2=A0=C2=A0 0.881150] Please append a correct "root=3D" boot opti=
on; here are the=20
> available partitions:
> [=C2=A0=C2=A0=C2=A0 0.881446] 0100=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram0
> [=C2=A0=C2=A0=C2=A0 0.881478]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.881709] 0101=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram1
> [=C2=A0=C2=A0=C2=A0 0.881715]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.881875] 0102=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram2
> [=C2=A0=C2=A0=C2=A0 0.881879]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.882033] 0103=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram3
> [=C2=A0=C2=A0=C2=A0 0.882037]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.882189] 0104=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram4
> [=C2=A0=C2=A0=C2=A0 0.882193]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.882347] 0105=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram5
> [=C2=A0=C2=A0=C2=A0 0.882350]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.882503] 0106=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram6
> [=C2=A0=C2=A0=C2=A0 0.882507]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.882700] 0107=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram7
> [=C2=A0=C2=A0=C2=A0 0.882705]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.882862] 0108=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram8
> [=C2=A0=C2=A0=C2=A0 0.882866]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.883018] 0109=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram9
> [=C2=A0=C2=A0=C2=A0 0.883021]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.883174] 010a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram10
> [=C2=A0=C2=A0=C2=A0 0.883178]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.883330] 010b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram11
> [=C2=A0=C2=A0=C2=A0 0.883333]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.883487] 010c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram12
> [=C2=A0=C2=A0=C2=A0 0.883490]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.883694] 010d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram13
> [=C2=A0=C2=A0=C2=A0 0.883699]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.883858] 010e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram14
> [=C2=A0=C2=A0=C2=A0 0.883863]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.884020] 010f=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 131072 ram15
> [=C2=A0=C2=A0=C2=A0 0.884024]=C2=A0 (driver?)
> [=C2=A0=C2=A0=C2=A0 0.884265] Kernel panic - not syncing: VFS: Unable to =
mount root fs=20
> on unknown-block(0,0)
> [=C2=A0=C2=A0=C2=A0 0.884883] Rebooting in 180 seconds..
>=20
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel=20
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uIm=
age-4.17=20
> -machine dt_compatible=3Dfsl,,P5020DS -device virtio-scsi -drive=20
> if=3Dnone,id=3Dc1,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LT=
S_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img=20
> -device scsi-cd,drive=3Dc1 -append "root=3D/dev/sda3"
>=20
> Unfortunately without any success. (same errors like before)
>=20
> Boot with U-Boot:
>=20
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -bios=20
> /home/christian/Downloads/u-boot -machine dt_compatible=3Dfsl,,P5020DS=20
> -device virtio-scsi -drive=20
> if=3Dnone,id=3Dc1,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LT=
S_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img=20
> -device scsi-cd,drive=3Dc1
>=20
> Output:
>=20
> U-Boot 2017.09-00322-g1f6049e (Sep 25 2017 - 20:50:48 +0200)
>=20
> CPU:=C2=A0=C2=A0 Unknown, Version: 0.0, (0x00000000)
> Core:=C2=A0 e5500, Version: 2.0, (0x80240020)
> Clock Configuration:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0:400=C2=A0 MHz,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CCB:400=C2=A0 MHz,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DDR:200=C2=A0 MHz (400 MT/s data ra=
te), LBC: unknown (LCRR[CLKDIV] =3D=20
> 0x00)
> L1:=C2=A0=C2=A0=C2=A0 D-cache 32 KiB enabled
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I-cache 32 KiB enabled
> DRAM:=C2=A0 2 GiB
> L2:=C2=A0=C2=A0=C2=A0 disabled
> Using default environment
>=20
>=20
> PCI: base address e0008000
>  =C2=A0 00:01.0=C2=A0=C2=A0=C2=A0=C2=A0 - 1af4:1000 - Network controller
>  =C2=A0 00:02.0=C2=A0=C2=A0=C2=A0=C2=A0 - 1af4:1004 - Mass storage contro=
ller
> PCI1: Bus 00 - 00
>=20
> In:=C2=A0=C2=A0=C2=A0 serial
> Out:=C2=A0=C2=A0 serial
> Err:=C2=A0=C2=A0 serial
> Net:=C2=A0=C2=A0 No ethernet found.
> Hit any key to stop autoboot:=C2=A0 0
> =3D> =20
>=20
> Any other hints?
>=20
> Thanks,
> Christian
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
