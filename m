Received: from eggs.gnu.org ([2001:4830:134:3::10]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0ToE-0007n7-Aa
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0ToB-0002zP-6D
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:41:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:47324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e0ToB-0002xw-01
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e0To8-0008P2-Sw
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 14:40:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D24232E80CC
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 14:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Oct 2017 14:28:37 -0000
From: Daniel Berrange <1721788@bugs.launchpad.net>
Reply-To: Bug 1721788 <1721788@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
Message-Id: <150730011794.1539.12869692950017908242.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721788] Re: Failed to get shared "write" lock
 with 'qemu-img info'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The QEMU process that has the disk image open may be doing I/O that
causes qcow2 metadata to be changed. Such changes could confuse the
'qemu-img' process it is was reading the metadata at the same time it
was being changed, causing bad data to be printed or worse. So requiring
a write lock is the 'safe' thing to do for reliability in the worst
case. You can override this by passing '--force-share' arg though.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721788

Title:
  Failed to get shared "write" lock with 'qemu-img info'

Status in QEMU:
  New

Bug description:
  When running 'qemu-img info test.qcow2' while test.qcow2 is currently
  used by a Qemu process, I get the error

  qemu-img: Could not open 'test.qcow2': Failed to get shared "write"
  lock.

  =

  Why does displaying information about a disk image need a write lock for =
the file?

  Steps to reproduce:

  qemu-img create -f qcow2 test.qcow2 10M
  qemu-system-x86_64 -nographic -drive file=3Dtest.qcow2
  qemu-img info test.qcow2

  The above was tested with Qemu version 2.10.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721788/+subscriptions
