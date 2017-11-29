Received: from eggs.gnu.org ([2001:4830:134:3::10]:43588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eK0Yb-0005yL-Bq
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eK0YY-0006Us-5H
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:29:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:40976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eK0YX-0006U4-Uj
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:29:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eK0YW-0001dh-74
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 11:29:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 32ED12E80CC
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 11:29:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2017 11:19:47 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 645662 <645662@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100923002702.20683.97345.malonedeb@soybean.canonical.com>
Message-Id: <151195438769.20240.298943476282304594.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 645662] Re: Python 3.1.2 math errors with Qemu
 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

softfloat deals with doing the basic IEEE ops (add, subtract, multiply,
etc) at the correct 80 bit precision, but it doesn't provide
implementations of the x87's more complex operations (sin, cos, log,
etc), so QEMU is still doing those by converting from 80 bit to host
double and using the host C math library routines. Fixing this would
require writing hand-coded routines for all these operations, which is
quite a tricky bit of work. (Sadly we can't just use the bochs
implementations, because they're under the softfloat2b license which
isn't GPL2 compatible.)


** Changed in: qemu
       Status: Triaged =3D> Confirmed

** Summary changed:

- Python 3.1.2 math errors with Qemu 0.12.5
+ QEMU x87 emulation of trig and other complex ops is only at 64-bit precis=
ion, not 80-bit

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/645662

Title:
  QEMU x87 emulation of trig and other complex ops is only at 64-bit
  precision, not 80-bit

Status in QEMU:
  Confirmed

Bug description:
  When doing the regression tests for Python 3.1.2 with Qemu 0.12.5, (Linux=
 version 2.6.26-2-686 (Debian 2.6.26-25lenny1)),
  gcc (Debian 4.3.2-1.1) 4.3.2, Python compiled from sources within qemu,
  3 math tests fail, apparently because the floating point unit is buggy. Q=
meu was compiled from original sources
  on Debian Lenny with kernel  2.6.34.6 from kernel.org, gcc  (Debian 4.3.2=
-1.1) 4.3. =


  Regression testing errors:

  test_cmath
  test test_cmath failed -- Traceback (most recent call last):
    File "/root/tools/python3/Python-3.1.2/Lib/test/test_cmath.py", line 36=
4, in
      self.fail(error_message)
  AssertionError: acos0034: acos(complex(-1.0000000000000002, 0.0))
  Expected: complex(3.141592653589793, -2.1073424255447014e-08)
  Received: complex(3.141592653589793, -2.1073424338879928e-08)
  Received value insufficiently close to expected value.

  =

  test_float
  test test_float failed -- Traceback (most recent call last):
    File "/root/tools/python3/Python-3.1.2/Lib/test/test_float.py", line 47=
9, in
      self.assertEqual(s, repr(float(s)))
  AssertionError: '8.72293771110361e+25' !=3D '8.722937711103609e+25'

  =

  test_math
  test test_math failed -- multiple errors occurred; run in verbose mode fo=
r deta

  =3D>

  runtests.sh -v test_math

  le01:~/tools/python3/Python-3.1.2# ./runtests.sh -v test_math
  test_math BAD
   1 BAD
   0 GOOD
   0 SKIPPED
   1 total
  le01:~/tools/python3/Python-3.1.2#

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/645662/+subscriptions
