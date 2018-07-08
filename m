Received: from eggs.gnu.org ([2001:4830:134:3::10]:52903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fc9J1-0006ND-MW
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 09:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fc9Iy-0005Pg-KH
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 09:00:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:33120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fc9Iy-0005MF-Dm
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 09:00:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fc9Iw-0003nx-G4
	for <qemu-devel@nongnu.org>; Sun, 08 Jul 2018 13:00:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53E582E8070
	for <qemu-devel@nongnu.org>; Sun,  8 Jul 2018 13:00:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jul 2018 12:51:58 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1774677 <1774677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152787131775.31828.3557775502793493947.malonedeb@soybean.canonical.com>
Message-Id: <153105431842.18138.925665421120679609.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774677] Re: -icount increases boot time by >10x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I bisected this using the following test case (after the setup shown in
the original bug report, and replacing "e1000" by "ne2k_pci" in the run-
emulator.sh script to avoid a panic in the e1000 driver with some qemu
versions):

QEMU_EXTRA=3D"-icount shift=3D3,sleep=3Doff" sh run-emulator.sh

The bisection identified the following commit:

281b2201e4e18d5b9a26e1e8d81b62b5581a13be is the first bad commit
commit 281b2201e4e18d5b9a26e1e8d81b62b5581a13be
Author: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date:   Thu Mar 10 14:56:03 2016 +0300

    icount: remove obsolete warp call

    qemu_clock_warp call in qemu_tcg_wait_io_event function is not needed
    anymore, because it is called in every iteration of main_loop_wait.

    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

    Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
    Message-Id: <20160310115603.4812.67559.stgit@PASHA-ISP>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

With revision 281b2201e4e18d5b9a26e1e8d81b62b5581a13be, the test case
takes 141 seconds to boot.  With the previous revision,
33577b47c64435fcc2a1bc01c7e82534256f1fc3, it takes 1.7 seconds.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774677

Title:
  -icount increases boot time by >10x

Status in QEMU:
  Confirmed

Bug description:
  When I specify the -icount option, some guest operations such as
  booting a Linux kernel take more than 10 times longer than otherwise.
  For example, the following will boot Aboriginal Linux to the login
  prompt about 6 seconds on my system (using TCG, not KVM):

  wget http://landley.net/aboriginal/downloads/old/binaries/1.4.5/system-im=
age-i686.tar.gz
  gunzip <system-image-i686.tar.gz | tar xfv -
  cd system-image-i686
  sh run-emulator.sh

  If I replace the last line with

  QEMU_EXTRA=3D"-icount shift=3Dauto" sh run-emulator.sh

  booting to the login prompt takes about 1 minute 20 seconds.

  I have tried different values for "shift" other than the "auto" used
  above, but have not been able to find one that gives reasonable
  performance.  Specifying "sleep=3Doff" also did not help.

  During the slow boots, qemu appears to spend most of its time
  sleeping, not using the host CPU.

  I see this with multiple versions of qemu, including current git
  sources (c181ddaa176856b3cd2dfd12bbcf25fa9c884a97), and on multiple
  host OSes, including Debian 9 on x86_64.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774677/+subscriptions
