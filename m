Received: from eggs.gnu.org ([2001:4830:134:3::10]:50931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFyZx-00048g-8t
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 02:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFyZu-0002Dx-2J
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 02:29:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:42418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cFyZt-0002DC-TC
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 02:29:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cFyZr-0004hD-9k
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 07:29:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 391C22E80DA
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 07:29:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Dec 2016 07:19:53 -0000
From: Stefan Weil <932487@bugs.launchpad.net>
Reply-To: Bug 932487 <932487@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120215015959.27405.46578.malonedeb@soybean.canonical.com>
Message-Id: <20161211071953.12193.26932.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 932487] Re: win32: git rev 59f971d crashes when
 accessing disk (coroutine issue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed in newer versions which no longer have problems with thread local
storage on Windows.

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/932487

Title:
  win32: git rev 59f971d crashes when accessing disk (coroutine issue)

Status in QEMU:
  Fix Released

Bug description:
  Host: XP SP3 / Vista SP2

  configure commandline: ./configure --target-list=3D"i386-softmmu"
  --audio-drv-list=3Dsdl --audio-card-list=3Dac97,sb16,adlib --disable-
  linux-aio --disable-vnc-thread --disable-vnc-jpeg --extra-cflags=3D"-O0
  -pipe"

  gcc -v:
  Using built-in specs.
  Target: mingw32
  Configured with: ../gcc-4.3.3/configure --prefix=3D/mingw --build=3Dmingw=
32 --enable-languages=3Dc,ada,c++,fortran,objc,obj-c++ --with-bugurl=3Dhttp=
://www.tdragon.net/recentgcc/bugs.php --disable-nls --disable-win32-registr=
y --enable-libgomp --disable-werror --enable-threads --disable-symvers --en=
able-cxx-flags=3D'-fno-function-sections -fno-data-sections' --enable-fully=
-dynamic-string --enable-version-specific-runtime-libs --enable-sjlj-except=
ions --with-pkgversion=3D'4.3.3-tdm-1 mingw32'
  Thread model: win32
  gcc version 4.3.3 (4.3.3-tdm-1 mingw32)

  gdb output:
  C:\msys\home\User\qemu\i386-softmmu>gdb --args qemu-system-i386.exe -L ..=
\pc-bios -hda xp.vmdk
  GNU gdb (GDB) 7.3
  Copyright (C) 2011 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "mingw32".
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>...
  Reading symbols from C:\msys\home\User\qemu\i386-softmmu/qemu-system-i386=
.exe...
  done.
  (gdb) r
  Starting program: C:\msys\home\User\qemu\i386-softmmu/qemu-system-i386.ex=
e -L ..\\pc-bios -hda xp.vmdk
  [New Thread 2472.0x8e0]
  [New Thread 2472.0xdc4]
  [New Thread 2472.0x8f0]

  Program received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 2472.0x8f0]
  0x7c81071e in SwitchToFiber () from C:\WINDOWS\system32\kernel32.dll
  (gdb) bt
  #0  0x7c81071e in SwitchToFiber () from C:\WINDOWS\system32\kernel32.dll
  #1  0x0044774c in qemu_coroutine_switch (from_=3D0x19593fc, to_=3D0xdcee9=
a8,
      action=3DCOROUTINE_YIELD) at coroutine-win32.c:48
  #2  0x004db18d in coroutine_swap (from=3D0x1e00, to=3D0xdcee9a8)
      at qemu-coroutine.c:31
  #3  0x00411618 in bdrv_rw_co (bs=3D<optimized out>, sector_num=3D<optimiz=
ed out>,
      buf=3D0x2140000 "@", nb_sectors=3D1, is_write=3Dfalse) at block.c:1335
  #4  0x00486e39 in ide_sector_read (s=3D0x1bbdaa0)
      at C:/msys/home/User/qemu/hw/ide/core.c:480
  #5  0x0054e71f in memory_region_iorange_write (iorange=3D0x1bbcf60, offse=
t=3D7,
      width=3D1, data=3D32) at C:/msys/home/User/qemu/memory.c:431
  #6  0x005494e0 in ioport_writeb_thunk (opaque=3D0x1bbcf60, addr=3D7680, d=
ata=3D32)
      at C:/msys/home/User/qemu/ioport.c:211
  #7  0x005496cf in ioport_write (data=3D<optimized out>,
      address=3D<optimized out>, index=3D<optimized out>)
      at C:/msys/home/User/qemu/ioport.c:82
  #8  cpu_outb (addr=3D2147340288, val=3D0 '\000')
      at C:/msys/home/User/qemu/ioport.c:274
  #9  0x022c0397 in ?? ()
  Backtrace stopped: previous frame inner to this frame (corrupt stack?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/932487/+subscriptions
