Received: from eggs.gnu.org ([2001:4830:134:3::10]:37846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fWDPT-0004E7-B9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fWDPQ-0008Kx-36
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:10:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:49296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fWDPP-0008Ks-Pg
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fWDPO-0001wa-Tj
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 04:10:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFE972E8019
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 04:10:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Jun 2018 04:02:21 -0000
From: Matthew Stapleton <matthew4196@gmail.com>
Reply-To: Bug 1777969 <1777969@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152954819319.7254.2594756503297361665.malonedeb@wampee.canonical.com>
Message-Id: <152964014137.7019.17761606205561114191.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777969] Re: Crash with UEFI, q35, AHCI,
 and <= SystemRescueCD 4.3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Okay thanks.  I forgot to mention I am running the Gentoo version of
kernel 4.14 series.  Here is the configure settings for gcc from my
desktop system used to reproduce the crash that originally occurred on
the hardened server, and even though the desktop system isn't using
hardened profile, this gcc is using some hardened features:

/var/tmp/portage/sys-devel/gcc-5.4.0-r3/work/gcc-5.4.0/configure
--host=3Dx86_64-pc-linux-gnu --build=3Dx86_64-pc-linux-gnu --prefix=3D/usr
--bindir=3D/usr/x86_64-pc-linux-gnu/gcc-bin/5.4.0
--includedir=3D/usr/lib/gcc/x86_64-pc-linux-gnu/5.4.0/include
--datadir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/5.4.0
--mandir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/5.4.0/man
--infodir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/5.4.0/info --with-gxx-
include-dir=3D/usr/lib/gcc/x86_64-pc-linux-gnu/5.4.0/include/g++-v5
--with-python-dir=3D/share/gcc-data/x86_64-pc-linux-gnu/5.4.0/python
--enable-languages=3Dc,c++,fortran --enable-obsolete --enable-secureplt
--disable-werror --with-system-zlib --enable-nls --without-included-
gettext --enable-checking=3Drelease --with-bugurl=3Dhttps://bugs.gentoo.org/
--with-pkgversion=3D'Gentoo 5.4.0-r3 p1.3, pie-0.6.5' --enable-libstdcxx-
time --enable-shared --enable-threads=3Dposix --enable-__cxa_atexit
--enable-clocale=3Dgnu --enable-multilib --with-multilib-list=3Dm32,m64
--disable-altivec --disable-fixed-point --enable-targets=3Dall --disable-
libgcj --enable-libgomp --disable-libmudflap --disable-libssp --disable-
libcilkrts --disable-libmpx --enable-vtable-verify --enable-libvtv
--enable-lto --without-isl --enable-libsanitizer

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777969

Title:
  Crash with UEFI, q35, AHCI, and <=3D SystemRescueCD 4.3.0

Status in QEMU:
  New

Bug description:
  I am getting a crash when booting <=3D SystemRescueCD 4.3.0 in UEFI mode
  with q35 machine and from a AHCI device with qemu 2.11.1 and 2.12.0.
  The crash doesn't occur if I compile with --enable-trace-
  backends=3Dsimple or if I use virtio-scsi.  The original crash was
  noticed on Gentoo with hardened gcc 6.4.0 and an Intel CPU, the test
  system to reproduce the crash is on Gentoo with non-hardened gcc 5.4.0
  and an Intel CPU.

  OVMF version is from Gentoo: edk2-ovmf-2017_p20180211-bin.tar.xz

  Here is the commands I have run on qemu 2.12.0 to reproduce the issue alt=
hough it also crashes with accel=3Dkvm removed:
  ./configure --target-list=3D"x86_64-softmmu"
  make
  qemu-system-x86_64 -nodefaults -machine q35,accel=3Dkvm -cpu qemu64 -driv=
e if=3Dpflash,format=3Draw,unit=3D0,file=3D/usr/share/edk2-ovmf/OVMF_CODE.f=
d,readonly=3Don -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.f=
d -m 512 -drive file=3Dsystemrescuecd-x86-4.3.0.iso,if=3Dnone,id=3Dcdrom-sy=
sresc,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Dcdrom-sysre=
sc,bootindex=3D5 -device VGA -display gtk

  Valgrind says "Bad permissions for mapped region at address
  0x4C022FE0" for the crash.

  Here is a backtrace from gdb:
  Program received signal SIGSEGV, Segmentation fault.
  0x00007f42dcbc5833 in malloc () from /lib64/libc.so.6
  (gdb) bt
  #0  0x00007f42dcbc5833 in malloc () from /lib64/libc.so.6
  #1  0x00007f42e10117d9 in g_malloc () from /usr/lib64/libglib-2.0.so.0
  #2  0x000055a3ff9def8f in qemu_aio_get (aiocb_info=3Daiocb_info@entry=3D0=
x55a4001b39a0 <thread_pool_aiocb_info>, bs=3Dbs@entry=3D0x0, cb=3Dcb@entry=
=3D0x55a3ff9dfe20 <thread_pool_co_cb>, opaque=3Dopaque@entry=3D0x7f42961e30=
b0) at util/aiocb.c:33
  #3  0x000055a3ff9e0249 in thread_pool_submit_aio (pool=3Dpool@entry=3D0x5=
5a400c038d0, func=3Dfunc@entry=3D0x55a3ff956620 <aio_worker>, arg=3Darg@ent=
ry=3D0x55a400bd30b0, cb=3Dcb@entry=3D0x55a3ff9dfe20 <thread_pool_co_cb>, =

      opaque=3Dopaque@entry=3D0x7f42961e30b0) at util/thread-pool.c:251
  #4  0x000055a3ff9e0423 in thread_pool_submit_co (pool=3D0x55a400c038d0, f=
unc=3Dfunc@entry=3D0x55a3ff956620 <aio_worker>, arg=3Darg@entry=3D0x55a400b=
d30b0) at util/thread-pool.c:289
  #5  0x000055a3ff956b50 in paio_submit_co (bs=3D0x55a400bff180, fd=3D<opti=
mized out>, offset=3D362702848, qiov=3D<optimized out>, bytes=3D2048, type=
=3D1) at block/file-posix.c:1536
  #6  0x000055a3ff95c82a in bdrv_driver_preadv (bs=3Dbs@entry=3D0x55a400bff=
180, offset=3Doffset@entry=3D362702848, bytes=3Dbytes@entry=3D2048, qiov=3D=
qiov@entry=3D0x7f42961e3650, flags=3D0) at block/io.c:924
  #7  0x000055a3ff960154 in bdrv_aligned_preadv (child=3Dchild@entry=3D0x55=
a400c03a20, req=3Dreq@entry=3D0x7f42961e32e0, offset=3Doffset@entry=3D36270=
2848, bytes=3Dbytes@entry=3D2048, align=3Dalign@entry=3D1, qiov=3Dqiov@entr=
y=3D0x7f42961e3650, flags=3D0)
      at block/io.c:1228
  #8  0x000055a3ff960434 in bdrv_co_preadv (child=3D0x55a400c03a20, offset=
=3D362702848, bytes=3D2048, qiov=3D0x7f42961e3650, flags=3D0) at block/io.c=
:1324
  #9  0x000055a3ff95c82a in bdrv_driver_preadv (bs=3Dbs@entry=3D0x55a400bf8=
e50, offset=3Doffset@entry=3D362702848, bytes=3Dbytes@entry=3D2048, qiov=3D=
qiov@entry=3D0x7f42961e3650, flags=3D0) at block/io.c:924
  #10 0x000055a3ff960154 in bdrv_aligned_preadv (child=3Dchild@entry=3D0x55=
a400be92c0, req=3Dreq@entry=3D0x7f42961e3510, offset=3Doffset@entry=3D36270=
2848, bytes=3Dbytes@entry=3D2048, align=3Dalign@entry=3D512, qiov=3Dqiov@en=
try=3D0x7f42961e3650, flags=3D0)
      at block/io.c:1228
  #11 0x000055a3ff960434 in bdrv_co_preadv (child=3D0x55a400be92c0, offset=
=3Doffset@entry=3D362702848, bytes=3Dbytes@entry=3D2048, qiov=3Dqiov@entry=
=3D0x7f42961e3650, flags=3Dflags@entry=3D0) at block/io.c:1324
  #12 0x000055a3ff94f4ce in blk_co_preadv (blk=3D0x55a400bf8ba0, offset=3D3=
62702848, bytes=3D2048, qiov=3D0x7f42961e3650, flags=3D0) at block/block-ba=
ckend.c:1158
  #13 0x000055a3ff94f5ac in blk_read_entry (opaque=3D0x7f42961e3670) at blo=
ck/block-backend.c:1206
  #14 0x000055a3ff94e000 in blk_prw (blk=3D0x55a400bf8ba0, offset=3D3627028=
48, buf=3D<optimized out>, bytes=3Dbytes@entry=3D2048, co_entry=3Dco_entry@=
entry=3D0x55a3ff94f590 <blk_read_entry>, flags=3Dflags@entry=3D0) at block/=
block-backend.c:1243
  #15 0x000055a3ff94f076 in blk_pread (blk=3D<optimized out>, offset=3D<opt=
imized out>, buf=3D<optimized out>, count=3Dcount@entry=3D2048) at block/bl=
ock-backend.c:1409
  #16 0x000055a3ff7d8b93 in cd_read_sector_sync (s=3D0x55a401a0faa0) at hw/=
ide/atapi.c:124
  #17 ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at hw/ide/atapi.c:269
  #18 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #19 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #20 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #21 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #22 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #23 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #24 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #25 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #26 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #27 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #28 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #29 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #30 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #31 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #32 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #33 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #34 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #35 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #36 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #37 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #38 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #39 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #40 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #41 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #42 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #43 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285
  #44 0x000055a3ff7dde0e in ahci_start_transfer (dma=3D0x55a401a0f9f0) at h=
w/ide/ahci.c:1325
  #45 0x000055a3ff7d870c in ide_atapi_cmd_reply_end (s=3D0x55a401a0faa0) at=
 hw/ide/atapi.c:285

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777969/+subscriptions
