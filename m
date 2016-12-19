Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2ne-00050C-Fo
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2nb-00044x-KP
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:36:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:48555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cJ2nb-00044R-Eq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:36:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cJ2na-0008Lz-Gj
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:36:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C2DB2E80C2
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:36:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2016 18:18:41 -0000
From: Thomas Huth <597575@bugs.launchpad.net>
Reply-To: Bug 597575 <597575@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100623080638.15164.21600.malonedeb@potassium.ubuntu.com>
Message-Id: <20161219181841.17640.82177.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 597575] Re: Hangs on HTTP errors when using the
 curl block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.11 / 0.12 are pretty much outdated nowadays ... can you still
reproduce this issue with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/597575

Title:
  Hangs on HTTP errors when using the curl block driver

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  It seems that qemu-kvm does not handle HTTP errors gracefully when
  using the curl block driver and a synchronous request is made (i.e.
  one using bdrv_read_em() for example). In these cases, if an HTTP
  error (such as 404 or 416) is returned, the aio thread exits but the
  main thread never finishes waiting for I/O completion, thus freezing
  KVM.

  Versions affected:
  At least 0.11.1 and 0.12.4 were tested and found to be affected.

  How to reproduce:
  Simply specify a non-existing path for an HTTP URL as a CDROM drive.
  kvm -drive file=3Dtest.img,format=3Dqcow2,if=3Dide,index=3D0,boot=3Don -d=
rive file=3Dhttp://127.0.0.1/static/test1.iso,media=3Dcdrom,index=3D2,if=3D=
ide -boot c

  qemu-kvm will hang on boot using 100% cpu as it will try to open the
  block device. At that point, the backtrace is (qemu-kvm-0.12.4):

  #0  0x000000000047aaaf in qemu_aio_wait () at aio.c:163
  #1  0x000000000047a055 in bdrv_read_em (bs=3D0x1592320, sector_num=3D0, b=
uf=3D0x7fffcf7e9ae0 "=C2=A8\237~=C3=8F=C3=BF\177", nb_sectors=3D4)
      at block.c:1939
  #2  0x0000000000479c0e in bdrv_pread (bs=3D0x1592320, offset=3D<value opt=
imized out>, buf=3D0x7fffcf7e9ae0, count1=3D2048)
      at block.c:716
  #3  0x000000000047a862 in bdrv_open2 (bs=3D0x1591a30, filename=3D0x1559f0=
0 "http://127.0.0.1/static/test1.iso", =

      flags=3D0, drv=3D0x84eca0) at block.c:316
  #4  0x000000000040dcb4 in drive_init (opts=3D0x1559e60, opaque=3D<value o=
ptimized out>, fatal_error=3D0x7fffcf7ea494)
      at /build/buildd-qemu-kvm_0.12.4+dfsg-1~bpo50+1-amd64-KOah5G/qemu-kvm=
-0.12.4+dfsg/vl.c:2471
  #5  0x000000000040e086 in drive_init_func (opts=3D0x155db00, opaque=3D0x0)
      at /build/buildd-qemu-kvm_0.12.4+dfsg-1~bpo50+1-amd64-KOah5G/qemu-kvm=
-0.12.4+dfsg/vl.c:2488
  #6  0x0000000000475421 in qemu_opts_foreach (list=3D<value optimized out>=
, func=3D0x40e070 <drive_init_func>, =

      opaque=3D0x8495e0, abort_on_failure=3D12) at qemu-option.c:817
  #7  0x000000000040e9af in main (argc=3D7, argv=3D0x7fffcf7ea838, envp=3D<=
value optimized out>)
      at /build/buildd-qemu-kvm_0.12.4+dfsg-1~bpo50+1-amd64-KOah5G/qemu-kvm=
-0.12.4+dfsg/vl.c:6011

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/597575/+subscriptions
