Received: from eggs.gnu.org ([2001:4830:134:3::10]:59611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRMJ2-0002nK-40
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 13:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRMIy-0000cp-V4
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 13:35:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:48598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRMIy-0000cC-MF
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 13:35:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRMIx-0007LQ-O6
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:35:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B102E2E80E2
	for <qemu-devel@nongnu.org>; Sat,  1 Jul 2017 17:35:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Jul 2017 17:26:52 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701835 <1701835@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149893001258.15852.11258418521313176097.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701835] [NEW] floating-point operation bugs in
 qemu-alpha
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

When running the gnulib testsuite, I'm seeing test failures in the tests fo=
r libm functions
  cbrt
  cbrtf
  ceil
  ceilf
  coshf
  exp2
  exp2f
  floor
  floorf
  fma
  fmaf
  fmal
  frexp
  frexpf
  hypot
  hypotf
  hypotl
  ilogb
  ilogbf
  isfinite
  isinf
  isnan
  isnand
  isnanf
  ldexp
  ldexpf
  ldexpl
  log1p
  log1pf
  log2
  log2f
  logb
  logbf
  logbl
  rint
  rintf
  rintl
  signbit
  sqrt
  sqrtf
  strtod
that I don't see when running the same (statically linked) executables in a=
 VM, through qemu-system-alpha.

How to reproduce:
- Using gnulib, run ./gnulib-tool --create-testdir --dir=3D../testdir-math =
--single-configure cbrt cbrtf ceil ceilf coshf exp2 exp2f float floor floor=
f fma fmaf fmal frexp frexpf hypot hypotf hypotl ilogb ilogbf isfinite isin=
f isnan isnand isnanf ldexp ldexpf ldexpl log1p log1pf log2 log2f logb logb=
f logbl math printf-frexp rint rintf rintl round roundf signbit sqrt sqrtf =
strtod trunc truncf
- Copy the resulting directory to a VM running Linux 2.6.26 with qemu-syste=
m-alpha.
- There, configure and build the package:
  mkdir build-native-static; cd build-native-static; ../configure CPPFLAGS=
=3D"-Wall" LDFLAGS=3D"-static"; make; make check
  Only 4 tests fail.
- Copy the resulting binaries back to the original x86_64 machine.
- Set environment variables for using qemu-alpha.
- Here, 50 tests fail that did not fail originally:

$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-cbrt
../../gltests/test-cbrt.h:39: assertion 'err > - L_(4.0) * L_(16.0) / TWO_M=
ANT_DIG && err < L_(4.0) * L_(16.0) / TWO_MANT_DIG' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceil1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceil2
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceilf1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceilf2
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-coshf =

../../gltests/test-coshf.c:37: assertion 'y >=3D 1.1854652f && y <=3D 1.185=
4653f' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-float
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floor1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floor2
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floorf1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floorf2
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fma1   =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fma2
../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmaf1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmaf2
../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmal2
../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-frexp
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-frexpf
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypot =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypotf
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypotl
../../gltests/test-hypot.h:41: assertion 'z =3D=3D HUGEVAL' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ilogb =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ilogbf
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isfinite
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isinf   =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnan
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnand-nolibm
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnand       =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnanf-nolibm
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnanf       =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexp =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexpf
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexpl
../../gltests/test-ldexp.h:99: assertion 'y =3D=3D expected' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log1p =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log1pf
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log2  =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log2f
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-logb =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-logbf
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-math =

Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-printf-frexp
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rint        =

../../gltests/test-rint.c:63: assertion 'rint (0.7) =3D=3D 1.0' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rintf
../../gltests/test-rintf.c:63: assertion 'rintf (0.7f) =3D=3D 1.0f' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rintl
../../gltests/test-rintl.c:68: assertion 'rintl (0.7L) =3D=3D 1.0L' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-round1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-roundf1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-signbit
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-sqrt   =

../../gltests/test-sqrt.h:40: assertion 'err > - L_(16.0) / TWO_MANT_DIG &&=
 err < L_(16.0) / TWO_MANT_DIG' failed
Aborted (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-trunc1
Floating point exception (core dumped)
$ ~/inst-qemu/2.9.0/bin/qemu-alpha test-truncf1
Floating point exception (core dumped)

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "tarball that contains the sources and the statically =
linked binaries"
   https://bugs.launchpad.net/bugs/1701835/+attachment/4907484/+files/testd=
ir-math.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701835

Title:
  floating-point operation bugs in qemu-alpha

Status in QEMU:
  New

Bug description:
  When running the gnulib testsuite, I'm seeing test failures in the tests =
for libm functions
    cbrt
    cbrtf
    ceil
    ceilf
    coshf
    exp2
    exp2f
    floor
    floorf
    fma
    fmaf
    fmal
    frexp
    frexpf
    hypot
    hypotf
    hypotl
    ilogb
    ilogbf
    isfinite
    isinf
    isnan
    isnand
    isnanf
    ldexp
    ldexpf
    ldexpl
    log1p
    log1pf
    log2
    log2f
    logb
    logbf
    logbl
    rint
    rintf
    rintl
    signbit
    sqrt
    sqrtf
    strtod
  that I don't see when running the same (statically linked) executables in=
 a VM, through qemu-system-alpha.

  How to reproduce:
  - Using gnulib, run ./gnulib-tool --create-testdir --dir=3D../testdir-mat=
h --single-configure cbrt cbrtf ceil ceilf coshf exp2 exp2f float floor flo=
orf fma fmaf fmal frexp frexpf hypot hypotf hypotl ilogb ilogbf isfinite is=
inf isnan isnand isnanf ldexp ldexpf ldexpl log1p log1pf log2 log2f logb lo=
gbf logbl math printf-frexp rint rintf rintl round roundf signbit sqrt sqrt=
f strtod trunc truncf
  - Copy the resulting directory to a VM running Linux 2.6.26 with qemu-sys=
tem-alpha.
  - There, configure and build the package:
    mkdir build-native-static; cd build-native-static; ../configure CPPFLAG=
S=3D"-Wall" LDFLAGS=3D"-static"; make; make check
    Only 4 tests fail.
  - Copy the resulting binaries back to the original x86_64 machine.
  - Set environment variables for using qemu-alpha.
  - Here, 50 tests fail that did not fail originally:

  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-cbrt
  ../../gltests/test-cbrt.h:39: assertion 'err > - L_(4.0) * L_(16.0) / TWO=
_MANT_DIG && err < L_(4.0) * L_(16.0) / TWO_MANT_DIG' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceil1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceil2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceilf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ceilf2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-coshf =

  ../../gltests/test-coshf.c:37: assertion 'y >=3D 1.1854652f && y <=3D 1.1=
854653f' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-float
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floor1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floor2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floorf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-floorf2
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fma1   =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fma2
  ../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmaf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmaf2
  ../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-fmal2
  ../../gltests/test-fma2.h:116: assertion 'result =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-frexp
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-frexpf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypot =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypotf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-hypotl
  ../../gltests/test-hypot.h:41: assertion 'z =3D=3D HUGEVAL' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ilogb =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ilogbf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isfinite
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isinf   =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnan
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnand-nolibm
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnand       =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnanf-nolibm
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-isnanf       =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexp =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexpf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-ldexpl
  ../../gltests/test-ldexp.h:99: assertion 'y =3D=3D expected' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log1p =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log1pf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log2  =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-log2f
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-logb =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-logbf
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-math =

  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-printf-frexp
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rint        =

  ../../gltests/test-rint.c:63: assertion 'rint (0.7) =3D=3D 1.0' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rintf
  ../../gltests/test-rintf.c:63: assertion 'rintf (0.7f) =3D=3D 1.0f' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-rintl
  ../../gltests/test-rintl.c:68: assertion 'rintl (0.7L) =3D=3D 1.0L' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-round1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-roundf1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-signbit
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-sqrt   =

  ../../gltests/test-sqrt.h:40: assertion 'err > - L_(16.0) / TWO_MANT_DIG =
&& err < L_(16.0) / TWO_MANT_DIG' failed
  Aborted (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-trunc1
  Floating point exception (core dumped)
  $ ~/inst-qemu/2.9.0/bin/qemu-alpha test-truncf1
  Floating point exception (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701835/+subscriptions
