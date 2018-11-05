Received: from eggs.gnu.org ([2001:4830:134:3::10]:51815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJWY5-0006Ua-E0
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJWXK-0008Ul-V2
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:39674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gJWXK-0007ch-LO
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gJWWr-0001wv-Ta
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:30:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D7DFF2E805B
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 04:30:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Nov 2018 04:17:16 -0000
From: Launchpad Bug Tracker <1497479@bugs.launchpad.net>
Reply-To: Bug 1497479 <1497479@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150918235853.1773.80469.malonedeb@gac.canonical.com>
Message-Id: <154139143815.4655.3153797710824720473.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1497479] Re: memory corruption with
 migrate/savevm in TCG mode
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
https://bugs.launchpad.net/bugs/1497479

Title:
  memory corruption with migrate/savevm in TCG mode

Status in QEMU:
  Expired

Bug description:
  [ISSUE]

  QEMU releases 2.3.1 and lower are forgetting to flush TLBs before
  enabling the global dirty pages log and entering the final stage of
  saving the VM.

  [DESCRIPTION]

  The situation is the following:
  1. TLB misses is the only way for page dirtying in the TCG mode.
  2. If TLB is always hit by a running VM code during the execution of the =
`ram_save_iterate' by migration thread then these pages are missing in the =
dirty log. The TLB is always hit for instance when the VM is mostly idling =
and the Kernel only handles APIC timer interrupts.
  3. These pages are then missed during `ram_save_complete' stage.
  4. This makes memory content in a saved VM state differ from the actual V=
M memory.
  5. If the affected memory pages contain some Kernel data structures these=
 can be corrupted by this memory inconsistency, causing Kernel to Oops afte=
r loading the saved state.

  [SOLUTION]

  A proposed solution is to flush TLB when `log_global_start' is called.
  Here is the patch: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/14=
93049/+attachment/4459905/+files/tcg-commit-on-log-global-start.patch

  [LINKS]

  Ubuntu bug:
  https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1493049

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1497479/+subscriptions
