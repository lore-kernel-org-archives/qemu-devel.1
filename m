Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzPs5-0003vh-Ji
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzPrx-0000Oo-13
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:21:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:39204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fzPru-0000GQ-VQ
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:20:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fzPrp-000384-HK
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 17:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 70C432E80E1
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 17:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Sep 2018 17:07:29 -0000
From: Sandra Loosemore <1791763@bugs.launchpad.net>
Reply-To: Bug 1791763 <1791763@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153659924985.31926.8442483749515675177.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1791763] [NEW] broken signal handling in nios2
 user-mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

This bug is against the 3.0 release.

It appears that the signal handling parts of the nios2 user-mode
emulation have never really been completed or tested.  Some examples of
failing tests from the GCC testsuite are gcc.dg/pr78185.c and
gcc.dg/cleanup-10.c.

Some problems I've identified and tried to fix with the attached patch
are:

- Code copied from the Linux kernel wasn't adjusted to differentiate
between host and target data types and address spaces.

- The sigaltstack() system call returns EINVAL because fields are listed
in the wrong order in struct target_sigaltstack.

With this patch, the system calls to set up the signal handler are
returning successfully, but the handler isn't being invoked, so
something is still wrong.  I think I need another pair of eyes to look
over this code.

** Affects: qemu
     Importance: Undecided
         Status: New

** Patch added: "partial patch"
   https://bugs.launchpad.net/bugs/1791763/+attachment/5187164/+files/wip-q=
emu.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1791763

Title:
  broken signal handling in nios2 user-mode emulation

Status in QEMU:
  New

Bug description:
  This bug is against the 3.0 release.

  It appears that the signal handling parts of the nios2 user-mode
  emulation have never really been completed or tested.  Some examples
  of failing tests from the GCC testsuite are gcc.dg/pr78185.c and
  gcc.dg/cleanup-10.c.

  Some problems I've identified and tried to fix with the attached patch
  are:

  - Code copied from the Linux kernel wasn't adjusted to differentiate
  between host and target data types and address spaces.

  - The sigaltstack() system call returns EINVAL because fields are
  listed in the wrong order in struct target_sigaltstack.

  With this patch, the system calls to set up the signal handler are
  returning successfully, but the handler isn't being invoked, so
  something is still wrong.  I think I need another pair of eyes to look
  over this code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1791763/+subscriptions
