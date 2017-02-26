Received: from eggs.gnu.org ([2001:4830:134:3::10]:50710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chx2S-0003RQ-Jm
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chx2P-0005HQ-FD
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:30:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:49136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1chx2P-0005HB-97
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:30:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1chx2N-0005xa-Jv
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 11:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B0DB2E80C8
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 11:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Feb 2017 11:23:49 -0000
From: Nadav Har'El <nyh@math.technion.ac.il>
Reply-To: Bug 1668041 <1668041@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170226112349.20229.38263.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1668041] [NEW] x86 Floating point exceptions -
 incorrect support?
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

It seems that qemu does not correctly emulate the x86 support for
optionally causing a floating-point exception (#FP) when, for example,
dividing by zero. Reports such as:

https://github.com/cloudius-systems/osv/issues/855
http://stackoverflow.com/questions/15134189/qemu-div-by-zero-mxcsr-register

suggest that setting the exception mask in the fpu cw or mxcsr (e.g.,
using a function like feenableexcept() in the guest OS) does not
generate floating point exceptions on divide by zero. The problem only
happens on pure QEMU - when a QEMU/KVM combination is used, the actual
hardware does the floating point work, and does throw the exception on
divide by zero if so requested.

Looking at the qemu (2.8.0) source code, it seems to me it really lacks
support for generating fpu exceptions: For example, helper_fdiv() in
target-i386/fpu_helper.c, when it notices the divisor is zero, seems to
set the divide-by-zero exception bit, but doesn't seem to check whether
it needs to trigger an exception (when the right bits on the x87 or SSE
control words are enabled).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1668041

Title:
  x86 Floating point exceptions - incorrect support?

Status in QEMU:
  New

Bug description:
  It seems that qemu does not correctly emulate the x86 support for
  optionally causing a floating-point exception (#FP) when, for example,
  dividing by zero. Reports such as:

  https://github.com/cloudius-systems/osv/issues/855
  http://stackoverflow.com/questions/15134189/qemu-div-by-zero-mxcsr-regist=
er

  suggest that setting the exception mask in the fpu cw or mxcsr (e.g.,
  using a function like feenableexcept() in the guest OS) does not
  generate floating point exceptions on divide by zero. The problem only
  happens on pure QEMU - when a QEMU/KVM combination is used, the actual
  hardware does the floating point work, and does throw the exception on
  divide by zero if so requested.

  Looking at the qemu (2.8.0) source code, it seems to me it really
  lacks support for generating fpu exceptions: For example,
  helper_fdiv() in target-i386/fpu_helper.c, when it notices the divisor
  is zero, seems to set the divide-by-zero exception bit, but doesn't
  seem to check whether it needs to trigger an exception (when the right
  bits on the x87 or SSE control words are enabled).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1668041/+subscriptions
