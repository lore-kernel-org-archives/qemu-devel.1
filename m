Received: from eggs.gnu.org ([2001:4830:134:3::10]:45896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcUrJ-0004h9-1m
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcUrE-0000A5-RC
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:01:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:57316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fcUrE-00009D-LH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:01:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fcUrC-000309-LX
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 12:01:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E5ABE2E81A0
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 12:01:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jul 2018 11:54:30 -0000
From: Pavel Dovgalyuk <1774677@bugs.launchpad.net>
Reply-To: Bug 1774677 <1774677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152787131775.31828.3557775502793493947.malonedeb@soybean.canonical.com>
Message-Id: <153113727103.18448.9241465897870365878.malone@chaenomeles.canonical.com>
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

Yes, I tried to revert (with some updates to the current code base) and
the bug was fixed:

diff --git a/cpus.c b/cpus.c
index 181ce33..e2fc972 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1172,6 +1172,13 @@ static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 {
     while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
+
+        qemu_mutex_unlock_iothread();
+        replay_mutex_lock();
+        qemu_mutex_lock_iothread();
+        qemu_start_warp_timer();
+        replay_mutex_unlock();
+
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }

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
