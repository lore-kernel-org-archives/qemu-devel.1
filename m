Received: from eggs.gnu.org ([2001:4830:134:3::10]:56935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRLK6-0003Jh-C6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRLJx-0001qp-Il
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:04:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:46720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRLJx-0001ns-5Y
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:04:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRLJw-0001x7-2S
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0FA162E80C3
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2017 16:51:24 -0000
From: Thomas Huth <1211910@bugs.launchpad.net>
Reply-To: Bug 1211910 <1211910@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130813175222.16219.80463.malonedeb@gac.canonical.com>
Message-Id: <151370228492.17365.5946540764926870257.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1211910] Re: Logical to linear address
 translation is wrong for 32-bit guests on a 64-bit hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1211910

Title:
  Logical to linear address translation is wrong for 32-bit guests on a
  64-bit hypervisor

Status in QEMU:
  Incomplete

Bug description:
  I run a 64-bit hypervisor in qemu-system-x86_64 (without KVM) and on top =
of that I have a 32-bit guest. The guest configures the code-segment to hav=
e a base of 0x4000_0000 and a limit of 0xFFFF_FFFF with paging disabled. Th=
us, if a logical address of e.g. 0xC000_0000 is used, it should be translat=
ed to 0x0000_0000 (linear and physical), because of the overflow that happe=
ns.
  But this does not happen with the described setup. Instead, qemu seems to=
 calculate the logical to linear translation with 64-bit addresses so that =
no overflow happens. Consequently, the resulting address is 0x1_0000_0000 a=
nd this gets written to exitinfo2 in the VMCB structure. This causes troubl=
e for hypervisors that expect the upper 32 bits of exitinfo2 to be 0 for 32=
-bit guests.

  Note also that the exact same setup runs fine on real AMD machines
  with SVM. That is, the upper 32 bits in exitinfo2 are always 0 because
  of the overflow.

  I've tested that with the latest development version of QEMU (commit
  328465fd9f3a628ab320b5959d68d3d49df58fa6).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1211910/+subscriptions
