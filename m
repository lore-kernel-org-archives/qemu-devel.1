Received: from eggs.gnu.org ([2001:4830:134:3::10]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fv8uO-0006Fn-6B
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 18:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fv8uK-0003IB-Sn
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 18:25:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:56876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fv8uK-0003GS-JQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 18:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fv8uH-0006wS-Va
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 22:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 611152E80D6
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 22:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Aug 2018 22:12:53 -0000
From: Jim White <1789751@bugs.launchpad.net>
Reply-To: Bug 1789751 <1789751@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153558077352.6448.1092429650643921786.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1789751] [NEW] Using -overcommit flag leads to
 qemu crashing
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

Running the following leads to a qemu crash on startup:

jwhite@laptop:~/os$ qemu-system-i386 -overcommit cpu-pm=3Don
qemu-system-i386: -overcommit cpu-pm=3Don: There is no option group 'overco=
mmit'
Segmentation fault (core dumped)
jwhite@laptop:~/os$ =



This fixes the issue:

--- ../tmp/qemu-3.0.0/vl.c	2018-08-14 12:10:35.000000000 -0700
+++ vl.c	2018-08-29 14:59:30.151554120 -0700
@@ -2987,6 +2987,7 @@
     qemu_add_opts(&qemu_object_opts);
     qemu_add_opts(&qemu_tpmdev_opts);
     qemu_add_opts(&qemu_realtime_opts);
+    qemu_add_opts(&qemu_overcommit_opts);
     qemu_add_opts(&qemu_msg_opts);
     qemu_add_opts(&qemu_name_opts);
     qemu_add_opts(&qemu_numa_opts);

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1789751

Title:
  Using -overcommit flag leads to qemu crashing

Status in QEMU:
  New

Bug description:
  Running the following leads to a qemu crash on startup:

  jwhite@laptop:~/os$ qemu-system-i386 -overcommit cpu-pm=3Don
  qemu-system-i386: -overcommit cpu-pm=3Don: There is no option group 'over=
commit'
  Segmentation fault (core dumped)
  jwhite@laptop:~/os$ =


  =

  This fixes the issue:

  --- ../tmp/qemu-3.0.0/vl.c	2018-08-14 12:10:35.000000000 -0700
  +++ vl.c	2018-08-29 14:59:30.151554120 -0700
  @@ -2987,6 +2987,7 @@
       qemu_add_opts(&qemu_object_opts);
       qemu_add_opts(&qemu_tpmdev_opts);
       qemu_add_opts(&qemu_realtime_opts);
  +    qemu_add_opts(&qemu_overcommit_opts);
       qemu_add_opts(&qemu_msg_opts);
       qemu_add_opts(&qemu_name_opts);
       qemu_add_opts(&qemu_numa_opts);

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1789751/+subscriptions
