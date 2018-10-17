Received: from eggs.gnu.org ([2001:4830:134:3::10]:47713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCb3B-0002W6-3p
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCb37-0006z3-JL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCb37-0006yW-DQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id g2-v6so11710050pgu.11
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 18:55:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 18:54:54 -0700
Message-Id: <20181017015456.3293-2-richard.henderson@linaro.org>
In-Reply-To: <20181017015456.3293-1-richard.henderson@linaro.org>
References: <20181017015456.3293-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] tests/tcg/multiarch/linux-test: Fix error
 check for shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

The error indicator for this syscall is -1, not 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index e80eccc0ce..6d2c02c5c0 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -503,8 +503,9 @@ static void test_shm(void)
 
     shmid = chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777));
     ptr = shmat(shmid, NULL, 0);
-    if (!ptr)
+    if (ptr == (void *)-1) {
         error("shmat");
+    }
 
     memset(ptr, 0, SHM_SIZE);
 
-- 
2.17.2
