Received: from eggs.gnu.org ([209.51.188.92]:59090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1grgPR-0003O6-7H
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1grgPN-0008GS-BB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:55:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:37210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1grgPL-00089B-Ay
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:55:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1grgPA-0005nM-LJ
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:55:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A00372E8050
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 09:55:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Feb 2019 09:46:07 -0000
From: Giovanni Mascellani <gio@debian.org>
Reply-To: Bug 1815024 <1815024@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck" under
 qemu-s390x in user mode
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

qemu-s390x in user mode crashes with SIGILL (under host architecture
x86_64, running Debian unstable) when executing target instruction
"stck" ("STORE CLOCK", see
https://www-01.ibm.com/support/docview.wss?uid=3Disg26480faec85f44e2385256d=
5200627dee&aid=3D1),
which is basically a kind of equivalent of Intel "rdtsc". The same
instruction works fine under qemu-s390x in system mode. The bug is
reproducible with both the qemu version distributed in Debian unstable
and with the latest upstream master (commit
47994e16b1d66411953623e7c0bf0cdcd50bd507).

This bug manifested itself as a crash of ssh-keygen program, which uses
"stck" to obtain some bits of randomness during key creation. Bisection
of the code led to the attached minimal example. Compile with (inside an
s390x system):

 $ gcc -c -o test.o test.c
 $ gcc -c -o rdtsc.o rdtsc.S
 $ gcc -o test test.o rdtsc.o

Then run test. It will crash with SIGILL in user mode and run fine in
system mode. Also, compare with the original file at
https://github.com/openssl/openssl/blob/master/crypto/s390xcpuid.pl#L139
(there the instruction "stckf" is also used; it is probable that it has
the same problem if it is supported altogether, but it did not test for
this).

Running qemu-s390x with options -d
in_asm,out_asm,op,op_opt,exec,nochain,cpu gives the trace attached in
log.txt.

Thanks, Giovanni.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "test.c"
   https://bugs.launchpad.net/bugs/1815024/+attachment/5236687/+files/test.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815024

Title:
  SIGILL on instruction "stck" under qemu-s390x in user mode

Status in QEMU:
  New

Bug description:
  qemu-s390x in user mode crashes with SIGILL (under host architecture
  x86_64, running Debian unstable) when executing target instruction
  "stck" ("STORE CLOCK", see
  https://www-01.ibm.com/support/docview.wss?uid=3Disg26480faec85f44e238525=
6d5200627dee&aid=3D1),
  which is basically a kind of equivalent of Intel "rdtsc". The same
  instruction works fine under qemu-s390x in system mode. The bug is
  reproducible with both the qemu version distributed in Debian unstable
  and with the latest upstream master (commit
  47994e16b1d66411953623e7c0bf0cdcd50bd507).

  This bug manifested itself as a crash of ssh-keygen program, which
  uses "stck" to obtain some bits of randomness during key creation.
  Bisection of the code led to the attached minimal example. Compile
  with (inside an s390x system):

   $ gcc -c -o test.o test.c
   $ gcc -c -o rdtsc.o rdtsc.S
   $ gcc -o test test.o rdtsc.o

  Then run test. It will crash with SIGILL in user mode and run fine in
  system mode. Also, compare with the original file at
  https://github.com/openssl/openssl/blob/master/crypto/s390xcpuid.pl#L139
  (there the instruction "stckf" is also used; it is probable that it
  has the same problem if it is supported altogether, but it did not
  test for this).

  Running qemu-s390x with options -d
  in_asm,out_asm,op,op_opt,exec,nochain,cpu gives the trace attached in
  log.txt.

  Thanks, Giovanni.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815024/+subscriptions
