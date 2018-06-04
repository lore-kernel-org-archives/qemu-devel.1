Received: from eggs.gnu.org ([2001:4830:134:3::10]:49216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPhFC-0001iC-Ey
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPhF9-0004jo-4G
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:37:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fPhF8-0004ji-UA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:37:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fPhF5-00020G-D8
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 04:37:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B34BF2E88E1
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 04:37:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Jun 2018 04:17:47 -0000
From: Launchpad Bug Tracker <1426092@bugs.launchpad.net>
Reply-To: Bug 1426092 <1426092@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150226192349.17124.43439.malonedeb@gac.canonical.com>
Message-Id: <152808586750.32120.3527616756051774205.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1426092] Re: virtio-balloon-device locks up Guest
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
https://bugs.launchpad.net/bugs/1426092

Title:
  virtio-balloon-device locks up Guest

Status in QEMU:
  Expired

Bug description:
  Setting arbitrary balloon target values locks up the guest in some cases =
crashes it, if the target memory is < used +~5% free.  =

  Found while testing aggressive memory over-commit, scenarios.
  You get messages like:

  [  155.827448] [<c002060c>] (show_stack) from [<c041c518>] (dump_stack+0x=
6c/0x88)
  [  155.837076] [<c041c518>] (dump_stack) from [<c0091994>] (warn_alloc_fa=
iled+0xe0/0x120)
  [  155.847075] [<c0091994>] (warn_alloc_failed) from [<c0094480>] (__allo=
c_pages_nodemask+0x600/0x91c)
  [  155.859039] [<c0094480>] (__alloc_pages_nodemask) from [<c00da414>] (b=
alloon_page_enqueue+0x20/0xbc)
  [  155.870556] [<c00da414>] (balloon_page_enqueue) from [<c025d794>] (bal=
loon+0x140/0x2cc)
  [  155.881377] [<c025d794>] (balloon) from [<c0043b38>] (kthread+0xd8/0xf=
4)

  page dumped bacause: nonzero _count
  BUG: BAad page state in process Xorg pfn:396e5

  Test Environment:
  x86_64
  Ubuntu 13.10, Guest Linux Kernel 3.19, qemu 2.2.0 with following patches =
applied - balloon OOM enhancement
  commit 5a10b7dbf904bfe01bb9fcc6298f7df09eed77d5
  Author: Raushaniya Maksudova <rmaksudova@parallels.com>

  Boot guest with '-balloon virtio', -qmp .... -hmp access
  1. sudo info balloon | socat - tcp4-connect:127.0.0.1:4444
     - or over qmp interface
  {"execute":"qom-get", "arguments": { "path": "/machine/peripheral-anon/de=
vice[1]","property": "guest-stats" }}
  {"return": {"stats": {"stat-swap-out": 0, "stat-free-memory": 513454080, =
"stat-minor-faults": 1261, "stat-major-faults": 0, "stat-total-memory": 526=
073856, "stat-swap-in": 0}, "last-update": 11109}}

  2. Take memory down check free memory using (1)
  3. Issue "sudo echo balloon XXX | socat - tcp4-connect:127.0.0.1:4444" - =
XXX is value in threshold mentioned above
     and you get Guest lockup

  ARM - samething except '-device virtio-balloon-device' used

  Libvirt - virsh setmem causes same issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1426092/+subscriptions
