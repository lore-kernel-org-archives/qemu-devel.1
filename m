Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga3Yw-0006OV-AM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga3Yr-0004Hd-9i
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:00:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:48448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ga3Yr-0004Gt-3A
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:00:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ga3Yq-0006yb-4q
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 19:00:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1EA0C2E8074
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 19:00:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Dec 2018 18:53:53 -0000
From: "k.c. Wang" <1809291@bugs.launchpad.net>
Reply-To: Bug 1809291 <1809291@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154532874183.18487.10011391612831676105.malonedeb@gac.canonical.com>
Message-Id: <154533203307.19335.3410429630623694065.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809291] Re: ARM PL181 (mmc for Security Digital
 Card) not working in Ubuntu 18.10 (CMD 2,
 3 timeout). The SDC driver worked fine in Ubuntu 18.04 and earlier versions
 but not in Ubuntu 18.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

'Hi, from this report your setup is unclear to me'.

Hi,
I am not using Linux kernel.
The t.bin image is a program built with .s and .c files using gcc-arm-none-=
eabi for ARM
The sdimage is just a regular 1MB file, which is used by the -sd sdmage as =
a virtual SDC card for
qemu-system-arm under Ubuntu 18.10
The t.bin code calls sdc_init() to initialize the PL181 mmc card, which is

int do_command(int cmd, int arg, int resp)
{
  *(u32 *)(base + ARGUMENT) =3D (u32)arg;
  *(u32 *)(base + COMMAND)  =3D 0x400 | (resp<<6) | cmd;
  delay();
}
int sdc_init()
{
  u32 RCA =3D (u32)0x45670000; // QEMU's hard-coded RCA
  base    =3D (u32)0x10005000; // PL180 base address
  printf("sdc_init : ");
  *(u32 *)(base + POWER) =3D (u32)0xBF; // power on
  *(u32 *)(base + CLOCK) =3D (u32)0xC6; // default CLK

  // send init command sequence
  do_command(0,  0,   MMC_RSP_NONE);// idle state
  do_command(55, 0,   MMC_RSP_R1);  // ready state  =

  do_command(41, 1,   MMC_RSP_R3);  // argument must not be zero
  do_command(2,  0,   MMC_RSP_R2);  // ask card CID
  do_command(3,  RCA, MMC_RSP_R1);  // assign RCA
  do_command(7,  RCA, MMC_RSP_R1);  // transfer state: must use RCA
  do_command(16, 512, MMC_RSP_R1);  // set data block length

  // set interrupt MASK0 registers bits =3D RxAvail|TxEmpty
  *(u32 *)(base + MASK0) =3D (1<<21)|(1<<18); //0x00240000; =

  printf("done\n");
}
 =

After each command, read the MMC status to check for errors.
Commands 2, 3, 7, 16 all failed due to timeout, indicating the MMC card doe=
s not respond.
But the PL181 does generate interrupts for read/write sector commands.
As stated before, the SAME driver code worked fine for all earlier versions=
 of Ubuntu: 15 to 18.04

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809291

Title:
  ARM PL181 (mmc for Security Digital Card) not working in Ubuntu 18.10
  (CMD 2,3 timeout).  The SDC driver worked fine in Ubuntu 18.04 and
  earlier versions but not in Ubuntu 18.10

Status in QEMU:
  New

Bug description:
  ARM PL181 MMC card no longer working in qemu-system-arm in Ubuntu 18.10
  The MMC driver code worked fine in Ubuntu 15.10 to 18.04.
  The command to run qemu-system-arm is

      qemu-system-arm -M versatilepb -m 256M -sd sdimage -kernel t.bin
  -serial mon:stdio

  During SDC initialization, SDC commands 2, 3, 9, 13, 7, 16 all timeout, =

  which cause subsequent read/write commands 17/24 to fail also.

  Tried both ARM versatilepb and realview-pb-a8, realview-pbx-a9 boards:
  all the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809291/+subscriptions
