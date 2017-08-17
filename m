Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1diGan-0007FR-NY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1diGai-0006HN-Pw
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:55:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:57921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1diGai-0006FN-Gc
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:55:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1diGah-0005CR-Bi
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:55:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4EC5D2E80CC
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:55:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Aug 2017 08:49:40 -0000
From: Gergely Czuczy <1711316@bugs.launchpad.net>
Reply-To: Bug 1711316 <1711316@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150295978030.10991.1444485507094830571.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711316] [NEW] fbsd strip(1) segfaults on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hello,

During port builds ld.lld(devel/boost-libs, www/node), and strip
(textproc/libxml2 on xmlcatalog) are segfaulting. On physical boxes
these things do work, as they should:

root@build-aarch64:~ # strip xmlcatalog
Segmentation fault (core dumped)

All the cores fail at the same assembly instruction, here's strip's backtra=
ce:
# lldb -c strip.core strip
(lldb) target create "strip" --core "strip.core"
Core file '/root/strip.core' (aarch64) was loaded.
(lldb) t 1
* thread #1, name =3D 'strip', stop reason =3D signal SIGSEGV
    frame #0: 0x0000000040312f40 libc.so.7`memcpy + 192
libc.so.7`memcpy:
->  0x40312f40 <+192>: ldp    x4, x3, [x4, #-0x10]
    0x40312f44 <+196>: stp    x6, x7, [x0]
    0x40312f48 <+200>: stp    x8, x9, [x0, #0x10]
    0x40312f4c <+204>: stp    x10, x11, [x0, #0x20]
(lldb) bt
* thread #1, name =3D 'strip', stop reason =3D signal SIGSEGV
  * frame #0: 0x0000000040312f40 libc.so.7`memcpy + 192
    frame #1: 0x000000004017ac70 libelf.so.2`_libelf_cvt_HALF_tom(dst=3D<un=
available>, dsz=3D<unavailable>, src=3D<unavailable>, count=3D<unavailable>=
, byteswap=3D<unavailable>) at libelf_convert.c:794
    frame #2: 0x0000000040177b34 libelf.so.2`elf_getdata(s=3D0x0000000040f3=
55a0, ed=3D<unavailable>) at elf_data.c:155
    frame #3: 0x00000000000283d4 strip`copy_data(s=3D0x0000000040f36a40) at=
 sections.c:1176
    frame #4: 0x0000000000027ea4 strip`copy_content(ecp=3D<unavailable>) at=
 sections.c:594
    frame #5: 0x0000000000023ff4 strip`create_elf(ecp=3D0x0000000040ed6000)=
 at main.c:381
    frame #6: 0x000000000002558c strip`create_file(ecp=3D<unavailable>, src=
=3D<unavailable>, dst=3D<unavailable>) at main.c:705
    frame #7: 0x0000000000024e20 strip`main [inlined] strip_main(argc=3D<un=
available>, argv=3D<unavailable>) at main.c:1192
    frame #8: 0x0000000000024cc8 strip`main(argc=3D<unavailable>, argv=3D<u=
navailable>) at main.c:1590
    frame #9: 0x0000000000020190 strip`__start + 376
    frame #10: 0x0000000040050018 ld-elf.so.1`.rtld_start at rtld_start.S:41

Host system information:
# uname -a
FreeBSD marvin.harmless.hu 11.0-STABLE FreeBSD 11.0-STABLE #0 r311927: Wed =
Jan 11 14:53:55 CET 2017     toor@marvin.harmless.hu:/usr/obj/usr/src/sys/M=
ARVIN  amd64

# qemu-system-aarch64 --version
QEMU emulator version 2.9.0
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
# pkg info | grep qemu
qemu-2.9.0                     QEMU CPU Emulator
I also had this happening with 2.8.0 and 2.8.1

Guest information:
# uname -a
FreeBSD build-aarch64.marvin.harmless.hu 12.0-CURRENT FreeBSD 12.0-CURRENT =
#0 r322578: Wed Aug 16 18:08:43 CEST 2017     toor@marvin.harmless.hu:/tank=
/rpi3/obj/arm64.aarch64/tank/rpi3/src/sys/GENERIC-NODEBUG  arm64

Startup:
zdev=3D/dev/zvol/tank/rpi3/qemu-image
qemu-system-aarch64 -m 4096M -cpu cortex-a57 -M virt  \
                    -accel tcg,thread=3Dsingle \
                    -bios QEMU_EFI.fd -serial telnet::4444,server -nographi=
c \
                    -drive if=3Dnone,file=3D${image},id=3Dhd0,format=3Draw \
                    -device virtio-blk-device,drive=3Dhd0 \
                    -device e1000,netdev=3Dnet0 \
                    -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3D/tank/rpi3=
/build/qemu-ifup.sh

Tested with cortex A53 as well, does the same.

I've attached a test image to reproduce with (340MB), if it's too big for a=
n attachment, it can be downloaded from here:
http://czg.harmless.hu/qemu-bug-stripsigsegv/image.gz

Reproduction steps:
1) log in as root, no password
2) strip xmlcatalog, it will segfault

For a full reproduction with ld.lld as well, you need a ports tree, it's su=
ggested to attach a bigger volume to /usr/ports over NFS first (it might ne=
ed more space than the image has). Steps for it:
1) portsnap fetch extract
2) make -C /usr/ports/devel/boost-libs package-recursive
3) make -C /usr/ports/textproc/libxml2 package-recursive
4) make -C /usr/ports/www/node package-recursive

Boost and node can take a day or more in a qemu VM. The build-time
options I've be set already, /var/db/ports is populated, so you
shouldn't have questions asked during the builds.

I've saved the core dumps, those can be found at /root/cores/ in the
image.

I hope I've submitted all the required information. If anything else is
needed, please let me know.

Best regards,
Gergely

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711316

Title:
  fbsd strip(1) segfaults on aarch64

Status in QEMU:
  New

Bug description:
  Hello,

  During port builds ld.lld(devel/boost-libs, www/node), and strip
  (textproc/libxml2 on xmlcatalog) are segfaulting. On physical boxes
  these things do work, as they should:

  root@build-aarch64:~ # strip xmlcatalog
  Segmentation fault (core dumped)

  All the cores fail at the same assembly instruction, here's strip's backt=
race:
  # lldb -c strip.core strip
  (lldb) target create "strip" --core "strip.core"
  Core file '/root/strip.core' (aarch64) was loaded.
  (lldb) t 1
  * thread #1, name =3D 'strip', stop reason =3D signal SIGSEGV
      frame #0: 0x0000000040312f40 libc.so.7`memcpy + 192
  libc.so.7`memcpy:
  ->  0x40312f40 <+192>: ldp    x4, x3, [x4, #-0x10]
      0x40312f44 <+196>: stp    x6, x7, [x0]
      0x40312f48 <+200>: stp    x8, x9, [x0, #0x10]
      0x40312f4c <+204>: stp    x10, x11, [x0, #0x20]
  (lldb) bt
  * thread #1, name =3D 'strip', stop reason =3D signal SIGSEGV
    * frame #0: 0x0000000040312f40 libc.so.7`memcpy + 192
      frame #1: 0x000000004017ac70 libelf.so.2`_libelf_cvt_HALF_tom(dst=3D<=
unavailable>, dsz=3D<unavailable>, src=3D<unavailable>, count=3D<unavailabl=
e>, byteswap=3D<unavailable>) at libelf_convert.c:794
      frame #2: 0x0000000040177b34 libelf.so.2`elf_getdata(s=3D0x0000000040=
f355a0, ed=3D<unavailable>) at elf_data.c:155
      frame #3: 0x00000000000283d4 strip`copy_data(s=3D0x0000000040f36a40) =
at sections.c:1176
      frame #4: 0x0000000000027ea4 strip`copy_content(ecp=3D<unavailable>) =
at sections.c:594
      frame #5: 0x0000000000023ff4 strip`create_elf(ecp=3D0x0000000040ed600=
0) at main.c:381
      frame #6: 0x000000000002558c strip`create_file(ecp=3D<unavailable>, s=
rc=3D<unavailable>, dst=3D<unavailable>) at main.c:705
      frame #7: 0x0000000000024e20 strip`main [inlined] strip_main(argc=3D<=
unavailable>, argv=3D<unavailable>) at main.c:1192
      frame #8: 0x0000000000024cc8 strip`main(argc=3D<unavailable>, argv=3D=
<unavailable>) at main.c:1590
      frame #9: 0x0000000000020190 strip`__start + 376
      frame #10: 0x0000000040050018 ld-elf.so.1`.rtld_start at rtld_start.S=
:41

  Host system information:
  # uname -a
  FreeBSD marvin.harmless.hu 11.0-STABLE FreeBSD 11.0-STABLE #0 r311927: We=
d Jan 11 14:53:55 CET 2017     toor@marvin.harmless.hu:/usr/obj/usr/src/sys=
/MARVIN  amd64

  # qemu-system-aarch64 --version
  QEMU emulator version 2.9.0
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  # pkg info | grep qemu
  qemu-2.9.0                     QEMU CPU Emulator
  I also had this happening with 2.8.0 and 2.8.1

  Guest information:
  # uname -a
  FreeBSD build-aarch64.marvin.harmless.hu 12.0-CURRENT FreeBSD 12.0-CURREN=
T #0 r322578: Wed Aug 16 18:08:43 CEST 2017     toor@marvin.harmless.hu:/ta=
nk/rpi3/obj/arm64.aarch64/tank/rpi3/src/sys/GENERIC-NODEBUG  arm64

  Startup:
  zdev=3D/dev/zvol/tank/rpi3/qemu-image
  qemu-system-aarch64 -m 4096M -cpu cortex-a57 -M virt  \
                      -accel tcg,thread=3Dsingle \
                      -bios QEMU_EFI.fd -serial telnet::4444,server -nograp=
hic \
                      -drive if=3Dnone,file=3D${image},id=3Dhd0,format=3Dra=
w \
                      -device virtio-blk-device,drive=3Dhd0 \
                      -device e1000,netdev=3Dnet0 \
                      -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3D/tank/rp=
i3/build/qemu-ifup.sh

  Tested with cortex A53 as well, does the same.

  I've attached a test image to reproduce with (340MB), if it's too big for=
 an attachment, it can be downloaded from here:
  http://czg.harmless.hu/qemu-bug-stripsigsegv/image.gz

  Reproduction steps:
  1) log in as root, no password
  2) strip xmlcatalog, it will segfault

  For a full reproduction with ld.lld as well, you need a ports tree, it's =
suggested to attach a bigger volume to /usr/ports over NFS first (it might =
need more space than the image has). Steps for it:
  1) portsnap fetch extract
  2) make -C /usr/ports/devel/boost-libs package-recursive
  3) make -C /usr/ports/textproc/libxml2 package-recursive
  4) make -C /usr/ports/www/node package-recursive

  Boost and node can take a day or more in a qemu VM. The build-time
  options I've be set already, /var/db/ports is populated, so you
  shouldn't have questions asked during the builds.

  I've saved the core dumps, those can be found at /root/cores/ in the
  image.

  I hope I've submitted all the required information. If anything else
  is needed, please let me know.

  Best regards,
  Gergely

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711316/+subscriptions
