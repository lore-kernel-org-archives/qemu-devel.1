Received: from eggs.gnu.org ([2001:4830:134:3::10]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYuOk-0005V9-T6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYuOe-0006sB-3M
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:34 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYuOd-0006lV-Ob
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so12923383wmd.2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:01:21 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 15:01:15 +0000
Message-Id: <20181217150116.10446-4-alex.bennee@linaro.org>
In-Reply-To: <20181217150116.10446-1-alex.bennee@linaro.org>
References: <20181217150116.10446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/4] accel/tcg: use TLB helpers from
 softmmu.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/Makefile.objs |  1 +
 accel/tcg/cputlb.c      | 42 -----------------------------------------
 2 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..6b0b96633d 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-$(CONFIG_SOFTMMU) += softmmu.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3cae7335d0..ab07689d0e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -983,28 +983,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
 }
 
-#ifdef TARGET_WORDS_BIGENDIAN
-# define TGT_BE(X)  (X)
-# define TGT_LE(X)  BSWAP(X)
-#else
-# define TGT_BE(X)  BSWAP(X)
-# define TGT_LE(X)  (X)
-#endif
-
-#define MMUSUFFIX _mmu
-
-#define DATA_SIZE 1
-#include "softmmu_template.h"
-
-#define DATA_SIZE 2
-#include "softmmu_template.h"
-
-#define DATA_SIZE 4
-#include "softmmu_template.h"
-
-#define DATA_SIZE 8
-#include "softmmu_template.h"
-
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
 
@@ -1061,23 +1039,3 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define DATA_SIZE 8
 #include "atomic_template.h"
 #endif
-
-/* Code access functions.  */
-
-#undef MMUSUFFIX
-#define MMUSUFFIX _cmmu
-#undef GETPC
-#define GETPC() ((uintptr_t)0)
-#define SOFTMMU_CODE_ACCESS
-
-#define DATA_SIZE 1
-#include "softmmu_template.h"
-
-#define DATA_SIZE 2
-#include "softmmu_template.h"
-
-#define DATA_SIZE 4
-#include "softmmu_template.h"
-
-#define DATA_SIZE 8
-#include "softmmu_template.h"
-- 
2.17.1
