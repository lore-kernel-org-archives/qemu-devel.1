Received: from eggs.gnu.org ([2001:4830:134:3::10]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cF4mV-0003kf-53
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 14:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cF4mR-0007JM-95
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 14:55:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:32907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cF4mR-0007J9-3G
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 14:54:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cF4mP-00059d-Kb
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 19:54:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7467E2E80AF
	for <qemu-devel@nongnu.org>; Thu,  8 Dec 2016 19:54:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Dec 2016 19:45:01 -0000
From: Max Reitz <1592590@bugs.launchpad.net>
Reply-To: Bug 1592590 <1592590@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160614222715.31715.16305.malonedeb@soybean.canonical.com>
Message-Id: <20161208194501.16600.21360.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1592590] Re: Prevent qemu-img resize from causing
 "Active L1 table too large"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the report, sorry for the late reply: This has been fixed in
commit 84c26520d3c1c9ff4a10455748139463278816d5 (included in the 2.7.0
release).

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1592590

Title:
  Prevent qemu-img resize from causing "Active L1 table too large"

Status in QEMU:
  Fix Released

Bug description:
  This commit prevents qemu from overallocating if qcow2 image is too
  big (whatever that means): https://lists.gnu.org/archive/html/qemu-
  devel/2014-07/msg01481.html

  However, `qemu-img resize` isn't protected by the same code and allows
  to go beyond that.

  root@nwkr-laptop ~virtkick/hdd # qemu-img resize 33_test_609dffde-eb51-4b=
75-918d-b814f1bcb526.qcow2 +100000T
  Image resized.

  Which then causes "Active L1 table too large" error that cannot be
  reversed.

  root@nwkr-laptop ~virtkick/hdd # qemu-img info 33_test_609dffde-eb51-4b75=
-918d-b814f1bcb526.qcow2
  qemu-img: Could not open '33_test_609dffde-eb51-4b75-918d-b814f1bcb526.qc=
ow2': Active L1 table too large

  root@nwkr-laptop ~virtkick/hdd # qemu-img resize 33_test_609dffde-eb51-4b=
75-918d-b814f1bcb526.qcow2 -100000T
  qemu-img: Could not open '33_test_609dffde-eb51-4b75-918d-b814f1bcb526.qc=
ow2': Active L1 table too large

  =

  I originally faces this bug when I passed wrong parameters to qemu-img in=
 a programatic way which caused an image to go corrupt. It's good to protec=
t user's images from being resized too much.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1592590/+subscriptions
