Received: from eggs.gnu.org ([209.51.188.92]:58977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmIvw-0007IY-4r
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmIlu-0004qh-9m
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:40:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:35528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmIlu-0004q5-3F
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:40:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmIls-0007nC-Oi
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B543A2E80C7
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Jan 2019 13:32:27 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1813010 <1813010@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154824790547.2554.12417850699297619175.malonedeb@wampee.canonical.com>
Message-Id: <154825034772.29817.15781991924908785975.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813010] Re: Parallel builds fail (make -j >=2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It seems the --save-temps is what breaks things for me, the following
works:

  ../qemu.git/configure --target-list=3Driscv64-softmmu --enable-debug
--extra-cflags=3D"-O0 -g3" && make -j9

rm -rf and start again with:

  ../qemu.git/configure --target-list=3Driscv64-softmmu --enable-debug
--extra-cflags=3D"-O0 -g3 --save-temps"

falls over with lines like:

  block/trace.h: In function =E2=80=98_nocheck__trace_nbd_co_request_fail=
=E2=80=99:
block/trace.h:3141:73: error: =E2=80=98_TRACE_NBD_CO_REQUEST_FAIL_DSTATE=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98TRACE=
_NBD_CO_REQUEST_FAIL_BACKEND_DSTATE=E2=80=99?
     if (trace_event_get_state(TRACE_NBD_CO_REQUEST_FAIL) && qemu_loglevel_=
mask(LOG_TRACE)) {
                                                                         ^~=
~~~~~~~~~~~~~~~~~~
                                                                         TR=
ACE_NBD_CO_REQUEST_FAIL_BACKEND_DSTATE

which implies something getting in the way of making the trace files.


** Summary changed:

- Parallel builds fail (make -j >=3D2)
+ Parallel builds fail (make -j >=3D2) when using --extrac-cflags "--save-t=
emps"

** Summary changed:

- Parallel builds fail (make -j >=3D2) when using --extrac-cflags "--save-t=
emps"
+ Parallel builds fail (make -j >=3D2) when using --extra-cflags "--save-te=
mps"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813010

Title:
  Parallel builds fail (make -j >=3D2) when using --extra-cflags "--save-
  temps"

Status in QEMU:
  Confirmed

Bug description:
  specs:
  QEMU commit: 9f33051abce238ab43a23125e237aac8b0931b88
  # of Cores: 8
  Host kernel: Linux 4.19.16-1-lts
  Host type: x86_64 GNU/Linux
  Host distro: Archlinux
  Guest: we never get that far

  =

  steps:
  # fresh copy of the latest commit
  > git clone https://git.qemu.org/git/qemu.git

  # separate build dir
  > mkdir build
  > cd build

  # sample configuration for riscv (this happens for other targets as well)
  > ../qemu/configure --target-list=3Driscv64-softmmu --enable-debug --extr=
a-cflags=3D'-O0 -g3 -save-temps' --prefix=3D/install/riscv-qemu

  # this will fail (see attached log file)
  > make -j 2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813010/+subscriptions
