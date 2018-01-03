Received: from eggs.gnu.org ([2001:4830:134:3::10]:50131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWmj8-0007Ch-VA
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWmj3-0003If-U7
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:21:18 -0500
Received: from indium.canonical.com ([91.189.90.7]:42946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWmj3-0003I4-Nv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:21:13 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWmj2-0005zx-3m
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 17:21:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 198522E80C7
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 17:21:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jan 2018 17:15:29 -0000
From: =?utf-8?q?Murilo_Opsfelder_Ara=C3=BAjo?= <1729623@bugs.launchpad.net>
Reply-To: Bug 1729623 <1729623@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150963549061.4171.11895725981979057755.malonedeb@gac.canonical.com>
Message-Id: <151499972999.26499.3163836928009626208.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1729623] Re: test-aio-multithread fails with
 'Co-routine re-entered recursively'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I confirmed with Stefan and this bug was fixed by
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dfb0c43f34eed8b18678c6=
e1f481d8564b35c99ed

commit fb0c43f34eed8b18678c6e1f481d8564b35c99ed
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Mon Nov 6 19:02:33 2017 +0000

    tests-aio-multithread: fix /aio/multi/schedule race condition

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1729623

Title:
  test-aio-multithread fails with 'Co-routine re-entered recursively'

Status in QEMU:
  Fix Released

Bug description:
  git head is at fa73e146250181852c0915aa65df8d54d35485fa

  configure with the following

  ./configure --enable-attr --enable-bsd-user --enable-cap-ng\
   --enable-coroutine-pool  --enable-crypto-afalg --enable-curl\
   --enable-curses --enable-debug --enable-debug-info\
   --enable-debug-tcg      --enable-fdt      --enable-gcrypt \
   --enable-gnutls      --enable-gprof      --enable-gtk  \
   --enable-guest-agent      --enable-kvm      --enable-libiscsi \
   --enable-libssh2      --enable-linux-aio      --enable-linux-user \
   --enable-live-block-migration      --enable-modules   \
   --enable-numa      --enable-pie      --enable-profiler \
   --enable-qom-cast-debug      --enable-rbd      --enable-replication  \
   --enable-seccomp      --enable-smartcard      --enable-stack-protector \
   --enable-system      --enable-tcg      --enable-tcg-interpreter  \
   --enable-tools      --enable-tpm      --enable-trace-backend=3Dftrace \
   --enable-user      --enable-vhost-net      --enable-vhost-scsi  \
   --enable-vhost-user      --enable-vhost-vsock      --enable-virtfs  \ =

   --enable-vnc      --enable-tpm      --enable-vnc-png   \
   --enable-vnc-sasl      --enable-werror      --enable-xfsctl \
   --enable-gcov --enable-debug-stack-usage

  make -j 32

  make test-aio-multithread V=3D1

  ...
  File '/home/nasastry/qemu/include/qapi/qmp/qobject.h'
  No executable lines

  MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gteste=
r -k --verbose -m=3Dquick tests/test-aio-multithread
  TEST: tests/test-aio-multithread... (pid=3D86877)
    /aio/multi/lifecycle:                                                OK
    /aio/multi/schedule:                                                 Co=
-routine re-entered recursively
  FAIL
  GTester: last random seed: R02S681209ce87fc22715b41223212d9f6f0
  (pid=3D86891)
    /aio/multi/mutex/contended:                                          OK
    /aio/multi/mutex/handoff:                                            OK
    /aio/multi/mutex/mcs:                                                OK
    /aio/multi/mutex/pthread:                                            OK
  FAIL: tests/test-aio-multithread
  make: *** [check-tests/test-aio-multithread] Error 1

  Full log will be attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1729623/+subscriptions
