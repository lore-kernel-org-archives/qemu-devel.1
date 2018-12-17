Received: from eggs.gnu.org ([2001:4830:134:3::10]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYuOf-0005Th-VN
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYuOe-0006s6-2P
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:29 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYuOd-0006kA-Nf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:27 -0500
Received: by mail-wm1-x344.google.com with SMTP id c126so12926755wmh.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:01:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 15:01:12 +0000
Message-Id: <20181217150116.10446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 0/4] de-macrofy softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is a re-based re-spin of my RFC series with a few minor updates
thanks to updates to the softmmu code. The series is attempting to
achieve the same results we did with softfloat by replacing our nest of
macro expansions with some common helpers. By using __flatten__ to force
the whole function to be un-rolled the compiler can then dead-code away
parts of the common function not used in each particular instantiated
helper.

This is a win from a debugging point of view - no more "where is
helper_le_lduw_mmu defined" questions. I think it will also make
eventual instrumentation easier because there is exactly one slow path
load and store function to instrument.

Although the individual functions are now bigger (__flatten__ stops the
compiler ignoring inline if it wants to) the size of the resulting
binary is slightly smaller!

original - 73027224 bytes demacro - 66913848 bytes

Unfortunately in my simple boot test I see a slight performance
degradation:

original: 10 times (100.00%), avg time 5.358 (0.02 varience/0.13
deviation) demacro: 10 times (100.00%), avg time 5.760 (0.08
varience/0.29 deviation)

Emilio,

Any chance you could run this through your more comprehensive benchmark
suite?

Alex Bennée (4):
  accel/tcg: export some cputlb functions
  accel/tcg: introduce softmmu.c
  accel/tcg: use TLB helpers from softmmu.o
  accel/tcg: remove softmmu_template.h

 accel/tcg/Makefile.objs      |   1 +
 accel/tcg/cputlb.c           |  63 +----
 accel/tcg/cputlb.h           |  21 ++
 accel/tcg/softmmu.c          | 452 +++++++++++++++++++++++++++++++++++
 accel/tcg/softmmu_template.h | 446 ----------------------------------
 5 files changed, 485 insertions(+), 498 deletions(-)
 create mode 100644 accel/tcg/cputlb.h
 create mode 100644 accel/tcg/softmmu.c
 delete mode 100644 accel/tcg/softmmu_template.h

-- 
2.17.1
