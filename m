Received: from eggs.gnu.org ([2001:4830:134:3::10]:36884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdTX-0003wZ-Nj
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdTU-0001pj-TC
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:59:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:42153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUdTU-0001ot-Me
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:59:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUdTT-00065l-Nc
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:59:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B11F82E80C2
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:59:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 17:46:21 -0000
From: Francois Gouget <1499908@bugs.launchpad.net>
Reply-To: Bug 1499908 <1499908@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150925223907.9398.42616.malonedeb@gac.canonical.com>
Message-Id: <20170120174621.14598.39421.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1499908] Re: hda sound capture broken with VNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As an alternative to compiling the source code yourselves, I have
attached the capture.exe binary.

** Attachment added: "Executable to reproduce this bug"
   https://bugs.launchpad.net/qemu/+bug/1499908/+attachment/4806840/+files/=
capture.exe.bz2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1499908

Title:
  hda sound capture broken with VNC

Status in QEMU:
  New

Bug description:
  QEmu is being used to run the Wine conformance tests in Windows
  virtual machines. Wine's conformance tests check the behavior of
  various Windows APIs and verify that they behave as expected. One of
  the tests checks the behavior of the mmdevapi sound capture APIs. This
  test works fine on real hardware and also works fine in various QEmu
  VMs but fails in some others. Further investigation showed that:

   * The mmdevapi:capture tests work on the two Vista VMs. Those use the
  ac97 sound card and are configured for VNC access to the VM.

   * The mmdevapi:capture tests fail in the Windows 7+ VMs. Those use an
  hda sound card and are configured for VNC access to the VM (so
  '-device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0' and '-vnc 127.0.0.1:0').

   * Furthermore configuring the VM for Spice access fixes the
  mmdevapi:capture test (so replacing -vnc with '-spice
  port=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Don'),
  this even if no client connects to the VM.

  So in effect the -spice and -vnc options change the behavior of the
  sound device.

  To reproduce this bug:
  1. Set up a Windows 7+ VM with an hda sound card ('ich6' in libvirt).
  2. Set it up for access using VNC.
  3. Copy the attached mmdevapi_test.exe file to it. (*)
  4. Run the tests as follows:
     mmdevapi_test.exe capture

  If you see these 'Test Failed' lines then the bug is still present:

  capture.c:586: Returned latency: 5.8050 ms
  capture.c:178: Test failed: Position 1015 expected 0
  capture.c:186: Wait'ed position 1015 pad 0 flags 1, amount of frames lock=
ed: 448
  capture.c:228: Test failed: Position 2167 expected 1463
  capture.c:248: Sleep.1 position 2167 pad 4032 flags 1, amount of frames l=
ocked: 448
  capture.c:256: Test failed: Position 2167 expected 1463
  capture.c:292: GetBufferSize 21996 period size 448
  capture.c:302: Overrun position 4215 pad 8960 flags 1, amount of frames l=
ocked: 448
  capture.c:308: Test failed: GCP 8960 vs. BufferSize 21996
  capture.c:313: Test failed: Position 4215 gap 2304
  capture.c:329: Cont'ed position 5303 pad 8512 flags 1, amount of frames l=
ocked: 448
  capture.c:333: Test failed: Position 5303 expected 4663
  capture.c:334: Test failed: flags 1
  capture.c:353: Restart position 7351 pad 8064 flags 1, amount of frames l=
ocked: 448
  capture.c:358: Test failed: Position 7351 expected 5111
  capture.c:359: Test failed: flags 1

  In case it helps, here is the source of mmdevapi_test.exe:
  https://source.winehq.org/git/wine.git/?a=3Dblob;f=3Ddlls/mmdevapi/tests/=
capture.c;hb=3D60d1d6f5952e8b5d6fb0327a28c047058851fa70#l178

  =

  So far I have confirmed that this bug is present in QEmu as shipped in th=
e following Debian packages:
   * qemu-kvm + qemu-system-x86 1:2.1+dfsg-12+deb8u2 + linux-image-3.16.0-4=
-amd64 3.16.7-ckt11-1+deb8u3
   * qemu-system-x86 1:2.3+dfsg-6a + linux-image-4.1.0-1-amd64 4.1.3-1

  =

  (*) As alternatives to using the attached binary you can:
  - Compile it from Wine's source. See:
     https://source.winehq.org/git/wine.git/

  - Or download the latest WineTest binary from https://test.winehq.org/bui=
lds/winetest-latest.exe
     And extract the mmdevapi_test.exe from there:
     winetest.exe -x tests
     tests\mmdevapi_test.exe capture

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1499908/+subscriptions
