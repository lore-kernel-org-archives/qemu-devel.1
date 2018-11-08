Received: from eggs.gnu.org ([2001:4830:134:3::10]:40740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKnFf-00083F-CP
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKnFd-0004tQ-7U
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gKnFc-0004an-S8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id r63-v6so1906058wma.4
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 08:33:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Nov 2018 16:33:23 +0000
Message-Id: <20181108163329.19940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/6] KVM Guest Debug fixes (plus TCG EL2
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

These are fixes for guest debug when running under KVM. While
re-spinning these I came across an anomaly which pointed to a kernel
bug that caused the 1st single-step to fail. This is being discussed
on the kvm-arm list:

  Subject: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
  Date: Wed, 7 Nov 2018 17:10:31 +0000
  Message-Id: <20181107171031.22573-1-alex.bennee@linaro.org>

As debugging HYP mode code is next to impossible on real hardware I
tried re-creating the single-step bug under TCG. As a result I ran into
some debug and EL2 cases that failed. The final two patches are some
fixes but I'm still seeing some weird behaviour although it is currently
obscured by timer interrupts constantly firing as I enter the to be
single-stepped guest EL1 instruction so they can probably be skipped for
3.1.

Alex Bennée (6):
  target/arm64: properly handle DBGVR RESS bits
  target/arm64: hold BQL when calling do_interrupt()
  target/arm64: kvm debug set target_el when passing exception to guest
  tests/guest-debug: fix scoping of failcount
  arm: use symbolic MDCR_TDE in arm_debug_target_el
  arm: fix aa64_generate_debug_exceptions to work with EL2

 target/arm/cpu.h                  | 29 ++++++++++++++++++-----------
 target/arm/kvm64.c                | 20 ++++++++++++++++++--
 tests/guest-debug/test-gdbstub.py |  1 +
 3 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.17.1
