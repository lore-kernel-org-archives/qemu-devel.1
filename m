Received: from eggs.gnu.org ([2001:4830:134:3::10]:42446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8bC-0001CG-39
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8b8-0002xu-PG
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL8b6-0002eD-VI
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:25 -0500
Received: by mail-wr1-x441.google.com with SMTP id y3-v6so2274575wrh.10
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:21:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Nov 2018 15:21:12 +0000
Message-Id: <20181109152119.9242-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/7] KVM Guest Debug fixes (plus TCG EL2
 debug tweaks)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I missed a fix I'd applied locally from v2 so this is a resend with
some additional tags, some changes suggested by rth and one more fix
for the test case.

So these are fixes for guest debug when running under KVM. While
re-spinning these I came across an anomaly which pointed to a kernel bug
that caused the 1st single-step to fail. This is being discussed at on
the kvm-arm list:

  Subject: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
  Date: Wed, 7 Nov 2018 17:10:31 +0000
  Message-Id: <20181107171031.22573-1-alex.bennee@linaro.org>

It looks like there will be another patch series on its way to address
this.

As debugging HYP mode code is next to impossible on real hardware I
tried re-creating the single-step bug under TCG. As a result I ran into
some debug and EL2 cases that failed. The final two patches are some
fixes but I'm still seeing some weird behaviour although it is currently
obscured by timer interrupts constantly firing as I enter the to be
single-stepped guest EL1 instruction so they can probably be skipped for
3.1.

The following patches still need review:
 0001/target arm64 properly handle DBGVR RESS bits.patch
 0005/tests guest debug don t use symbol resolution for.patch
 0007/arm fix aa64_generate_debug_exceptions to work wi.patch

Alex Bennée (7):
  target/arm64: properly handle DBGVR RESS bits
  target/arm64: hold BQL when calling do_interrupt()
  target/arm64: kvm debug set target_el when passing exception to guest
  tests/guest-debug: fix scoping of failcount
  tests/guest-debug: don't use symbol resolution for PC checks
  arm: use symbolic MDCR_TDE in arm_debug_target_el
  arm: fix aa64_generate_debug_exceptions to work with EL2

 target/arm/cpu.h                  | 41 +++++++++++++++++++------------
 target/arm/kvm64.c                | 20 +++++++++++++--
 tests/guest-debug/test-gdbstub.py | 24 +++++++++++-------
 3 files changed, 58 insertions(+), 27 deletions(-)

-- 
2.17.1
