Received: from eggs.gnu.org ([2001:4830:134:3::10]:43479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dA7ew-0003ZG-1s
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dA7es-0001Py-SF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:49906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dA7es-0001O0-HJ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:30:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dA7ep-0007sH-OZ
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 04:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E6B42E80DD
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 04:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 May 2017 04:17:25 -0000
From: Launchpad Bug Tracker <720657@bugs.launchpad.net>
Reply-To: Bug 720657 <720657@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110217115121.6900.44475.malonedeb@wampee.canonical.com>
Message-Id: <20170515041725.14553.7068.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 720657] Re: SVM intercept for VINTR exits too
 early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/720657

Title:
  SVM intercept for VINTR exits too early

Status in QEMU:
  Expired

Bug description:
  The following happens with QEMU-0.14-rc2. QEMU-0.13 did not have this
  problem.

  A guest operating system running inside an SVM VM contains the following =
code sequence:
  c000002b:       fb                      sti    =

  c000002c:       0f 35                   sysexit =


  The following is a list of exits that occur at guest RIP 0xc000002c
  (other exits omitted for clarity):

  exit=3D0x60 int_shadow=3D0x1 int_control=3D0x1000000 inj=3D0x600000000 ri=
p=3D0xc000002c
  entry: int_shadow=3D0x1 int_control=3D0x1000000 inj=3D0x600000000

  (exit due to physical interrupt, correctly reports STI blocking, entry
  does not inject anything)

  exit=3D0x60 int_shadow=3D0x1 int_control=3D0x1000000 inj=3D0x600000000 ri=
p=3D0xc000002c
  entry: int_shadow=3D0x1 int_control=3D0x1100100 inj=3D0x600000000

  (exit due to physical interrupt, correctly reports STI blocking, entry
  pends a VINTR to cause a VM exit when interrupt window opens. VINTR is
  being intercepted by the hypervisor.)

  exit=3D0x64 int_shadow=3D0x0 int_control=3D0x1100100 inj=3D0x600000000 ri=
p=3D0xc000002c
  entry: int_shadow=3D0x0 int_control=3D0x1000000 inj=3D0x6800000a0

  (exit due to VINTR. At this point STI blocking is still effective -
  though not reported. Actually, the VINTR exit should occur AFTER the
  SYSEXIT instruction, not after STI. Due to this bug, the hypervisor
  injects vector 0xa0 into an interrupt shadow, and things break).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/720657/+subscriptions
