Received: from eggs.gnu.org ([2001:4830:134:3::10]:41878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfnf-0000Si-GD
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfnc-0002AS-Bw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:30:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:42770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAfnc-00029v-0o
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:30:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAfnb-0008Ug-4L
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 17:30:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0305C2E80CB
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 17:30:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 17:14:13 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1429841 <1429841@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150309124810.20969.37090.malonedeb@gac.canonical.com>
Message-Id: <150972925359.19943.8249638917301147950.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1429841] Re: error "rom: requested regions
 overlap" for NOLOAD sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug is fixed in QEMU master by commits bf1733392ca2 and
f33e5e6299288c, which will be in the upcoming QEMU 2.11 release.

(PS: the thing the loader cares about is not elf sections but elf
segments in the program header, so the section table and its attributes
isn't relevant here, only the program header. In any case your example
ELF file loads OK with the bugfixes applied.)


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1429841

Title:
  error "rom: requested regions overlap" for NOLOAD sections

Status in QEMU:
  Fix Committed

Bug description:
  command line:
  qemu-system-arm -semihosting -nographic -monitor null -serial null -no-re=
boot -kernel build/fw/0HNFcomSLuP1_CUNIT.elf

  output:
  rom: requested regions overlap (rom phdr #6: build/fw/0HNFcomSLuP1_CUNIT.=
elf. free=3D0x8001effc, addr=3D0x8001c000)
  rom loading failed

  I checked the sections of the .elf file with arm-none-eabi-objdump -h:
  Sections:
  Idx Name          Size      VMA       LMA       File off  Algn
  ...
   35 .marker_appli 00001000  801ae000  801ae000  00025000  2**0
                    ALLOC
   36 .safe_data    00000014  80200000  8001b000  00020000  2**2
                    CONTENTS, ALLOC, LOAD, DATA
   37 .safe_bss     00000488  80200020  8001b020  00020014  2**2
                    ALLOC
   38 .marker_safe_data 00001000  80201000  8001c000  00029000  2**0
                    ALLOC
   39 .data         000008cc  80202000  8001b600  00022000  2**3
                    CONTENTS, ALLOC, LOAD, DATA
   40 .bss          0000312c  802028d0  8001bed0  000228cc  2**3
                    ALLOC
   41 .marker_data  00001000  80206000  8001f600  00026000  2**0
                    ALLOC
   42 .cunit        00010000  80300000  80119600  00028000  2**0
                    ALLOC
   43 .marker_code  00001000  8001c000  8001c000  00024000  2**0
                    ALLOC
  ...

  So I had a look where the values in  the error message could come from:
  0x8001c000: is the "LMA" value of section .marker_safe_data
  0x8001effc: is "Size" + "LMA" of the .bss section (0x0000312c + 0x8001bed=
0)

  So it is correct that (regarding the "LMA" value) the .marker_safe_data s=
ection collides with .bss section.
  But actually these sections have no "LOAD" attribute, so I would guess th=
at their "LMA" should not be used anyway.
  Those section should reside at their "VMA" addresses (0x802xxxxx) during =
runtime but they have no data to load.

  Or am I getting something completely wrong?
  Should I give an additional option to qemu?

  I got this error with 2.0.0+dfsg-2ubuntu1.10 and 1.0.50-2012.03-0ubuntu2.1
  I didn't get this error (but others) with 0.10.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1429841/+subscriptions
