Received: from eggs.gnu.org ([2001:4830:134:3::10]:53596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gS3MN-0007pK-Ca
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gS3MJ-0001uX-Va
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:10:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:48246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gS3MJ-0001nT-LL
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:10:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gS3MH-00041r-Jv
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:10:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 90EE32E8054
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:10:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Nov 2018 17:02:44 -0000
From: Igor <generalrot@rambler.ru>
Reply-To: Bug 1805445 <1805445@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154332864629.32687.7125797278920412825.malonedeb@wampee.canonical.com>
Message-Id: <154342456454.32725.3282515574808667602.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1805445] Re: QEMU arm virt machine was stopped by
 STMFD command while debug process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hm, I am create a new machine based on palmetto-bmc =

static const AspeedBoardConfig aspeed_boards[] =3D ...{
        .name      =3D MACHINE_TYPE_NAME("texet-tm-333"),
        .desc      =3D "Spreadtrum teXet TM-333 (ARM926EJ-S)",
        .soc_name  =3D "ast2500-a1",                         =

        .hw_strap1 =3D SPREADTRUM_BMC_HW_STRAP1,
        .fmc_model =3D "n25q032a11",h
        .spi_model =3D "mx25l3205d",
        .num_cs    =3D 1,
        .i2c_init  =3D spreadtrum_bmc_i2c_init,
    },...

and change soc_name to the ast2500-a1, because #define AST2500_SDRAM_BASE 0=
x80000000 on the aspeed_soc.c also i change flash for my 4Mb fullflash imag=
e. Building qemu and this is work fine!
The STR command work correctly and STMFD/PUSH/POP also work fine. (The SP r=
egister was equal 0 in past bug)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805445

Title:
  QEMU arm virt machine was stopped by STMFD command while debug process

Status in QEMU:
  New

Bug description:
  Hello, i have a big problem with QEMU arm virtual machine. So...
  I run QEMU machine with bare-metal ThreadX fullflash from Texet TM-333 ph=
one  (Spreadtrum platform)
  [CODE]qemu-system-arm -S -gdb tcp::1234,ipv4 -drive file=3DC:\cygwin64\ho=
me\flash.bin,if=3Dmtd,format=3Draw -M palmetto-bmc -cpu arm926 -m 64M[/CODE]
  I use palmetto-bmc platform because it have ARM926EJ-S core and support S=
PI Flash.
  Then, i attach to gdb qemu process from IDA and run code step-by-step.

  =

  When the IDA run 00032534 STR R11, [R10] command

  =

  instead of store R11 on R10 adress, it jump 000328DC STMFD SP!, {R0-R12,L=
R} instruction...

  and virt machine not execute new instruction...
  [IMG]https://pp.userapi.com/c850624/v850624111/528f3/N7FTpgloWVU.jpg[/IMG]

  and why i did not change flash from n25q256a to n25q032a11 in aspeed.c
  without rebuild qemu?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805445/+subscriptions
