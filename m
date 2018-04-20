Received: from eggs.gnu.org ([2001:4830:134:3::10]:50794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJH-0005v8-Km
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJE-0005od-E5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:51 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJE-0005my-69
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:48 -0400
Received: by mail-wr0-x242.google.com with SMTP id v60-v6so24200172wrc.7
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:39 +0100
Message-Id: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/6] Convert softmmu-template into normal
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is very much a Friday RFC patch but was born out of a chat I had
with Richard at Connect about our experience in the re-factoring of
softfloat.

The basic premise is we shouldn't need to jump through macro/glue
abuse for stuff a decent compiler should be able to dead code away at
compile time. Instead we can write common functions and use
__flatten__ to force the compiler to evaluate the result of merging
the inlined code as one complete blob. So far I haven't been able to
measure any difference in performance on my system compile benchmark.

Why go through all of this hassle? Some justifications:

  - no more "where is helper_le_stw_mmu defined?"
  - easier debugging in gdb
  - no duplicate code for be/le cases
  - more accessible code

I think there is also scope for more re-factoring and clean-up in the
code generally. I considered looking at the atomic and ldst templates
as well but decided to see what reaction the softmmu conversion got
first.

So far this has had very light testing for aarch64 guests on x86_64
hosts but it seems stable enough.

Any questions/thoughts/comments?

Alex Bennée (6):
  accel/tcg: export some cputlb functions
  accel/tcg: new softmmu.c with DATA_SIZE=1
  accel/tcg: add DATA_SIZE = 2 to softmmu
  accel/tcg: create load_helper
  accel/tcg: create store_helper
  accel/tcg: convert 4/8 byte access and remove softmmu_template

 accel/tcg/Makefile.objs      |   1 +
 accel/tcg/cputlb.c           |  61 +----
 accel/tcg/cputlb.h           |  20 ++
 accel/tcg/softmmu.c          | 497 +++++++++++++++++++++++++++++++++++
 accel/tcg/softmmu_template.h | 435 ------------------------------
 5 files changed, 528 insertions(+), 486 deletions(-)
 create mode 100644 accel/tcg/cputlb.h
 create mode 100644 accel/tcg/softmmu.c
 delete mode 100644 accel/tcg/softmmu_template.h

-- 
2.17.0
