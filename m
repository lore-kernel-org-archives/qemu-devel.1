Received: from eggs.gnu.org ([2001:4830:134:3::10]:48203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYY0X-0000QC-4x
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYY0T-0007Av-67
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:34:49 -0400
Date: Thu, 28 Jun 2018 16:34:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <5f5a8c59-9466-75ce-f291-ca2841ea5a99@kaod.org>
Message-ID: <alpine.BSF.2.21.1806281625070.26695@zero.eik.bme.hu>
References: <cover.1529839203.git.balaton@eik.bme.hu>
	<61b9cf7d09f0f12a86f036b828665c3fc91c3ce9.1529839203.git.balaton@eik.bme.hu>
	<51f8a2ca-0b35-dd1b-33a5-1fca51ef7a9c@kaod.org>
	<alpine.BSF.2.21.1806242200550.67254@zero.eik.bme.hu>
	<5f5a8c59-9466-75ce-f291-ca2841ea5a99@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/4] ppc4xx_i2c: Rewrite to
 model hardware more closely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 28 Jun 2018, C=E9dric Le Goater wrote:
> I have tried an ISO from :
>
> 	http://aros.sourceforge.net/nightly1.php
>
> which boots and writes :
>
>  U-Boot 2010.06.05 (Oct 22 2017 - 17:40:02)
>
>  CPU:   AMCC PowerPC 460EX Rev. B at 1150 MHz (PLB=3D230 OPB=3D115 EBC=3D=
115)
>         No Security/Kasumi support
>         Bootstrap Option A - Boot ROM Location EBC (8 bits)
>         Internal PCI arbiter disabled
>         32 kB I-Cache 32 kB D-Cache
>  Board: Sam460ex, PCIe 4x + SATA-2
>  I2C:   ready
>  DRAM:  512 MiB (ECC not enabled, 460 MHz, CL0)
>  *** Warning - bad CRC, using default environment
>
>  PCI:   Bus Dev VenId DevId Class Int
>          00  06  126f  0501  0380  00
>  PCIE1: successfully set as root-complex
>  Net:   ppc_4xx_eth0
>  FPGA:  Revision 00 (20 0-00-00)
>  SM502: found
>  VGA:   NO CARDS

This is the U-Boot firmware that prints this.

> and on the graphic window :
>
>  FLB: no SLB found in any of the designated boot sources, returning to =
u-boot.

And also this is from U-Boot saying it could not find bootable image so i=
t=20
did not boot. (One could test i2c from u_boot with date and i2c commands=20
as well.)

> the graphical bool loader menu works but I couldn't exercise much more =
the
> system.

Have you by chance used the -cdrom shortcut? That tries to connect CDROM=20
to secondary master but the sii3112 this board uses only has 2 SATA ports=
=20
so this won't work. You need to use the long options like

-drive if=3Dnone,id=3Dcd,file=3Daros-sam440-ppc.iso,format=3Draw \
-device ide-cd,drive=3Dcd,bus=3Dide.0

I'm not sure how to fix -cdrom or have it print a meaningful warning or=20
error.

> I then used the 4.5 kernel from :
>
>  http://www.supertuxkart-amiga.de/amiga/sam.html#downloads
>
> with this command line :
>
>   qemu-system-ppc -M sam460ex  -serial mon:stdio -nodefaults -kernel ./=
Sam460ex-4.5.0/boot/uImage-sam460ex-4.5.0 -dtb Sam460ex-4.5.0/boot/canyon=
lands.dtb -append "console=3DttyS0,119200"
>
> output was :
>
>
>  [    0.000000] Using Canyonlands machine description
>  [    0.000000] Linux version 4.5.0-sam460ex (root@julian-VirtualBox) (=
gcc version 5.3.1 20160205 (Ubuntu 5.3.1-8ubuntu2) ) #1 PREEMPT Mon Mar 1=
4 06:27:13 AST 2016
>  ...
>  [    2.194282] i2c /dev entries driver
>  [    2.201326] rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
>  [    2.202357] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
>  [    2.203796] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
>  ...
>  [    2.269934] rtc-m41t80 0-0068: setting system clock to 2018-06-28 0=
9:49:28 UTC (1530179368)
>
>
> So I would say from the review of the code and the tests that we are fi=
ne.
>
> Could please document a little more the register and bit definitions an=
d
> remove the raw hex values when possible ?

I'll check what can be dont but I think by now only the extsts state are=20
not #define-d which are also not really implemented and they are not bits=
=20
but 3 bit values so not sure what's the best way to define them. Other he=
x=20
values are some reserved bit masks I think that probably should not need=20
to be #defined.

> With these addressed :
>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>
> Thanks,
>
> C.
>
>
Thanks for testing,
BALATON Zoltan
