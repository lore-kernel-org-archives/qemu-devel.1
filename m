Received: from eggs.gnu.org ([2001:4830:134:3::10]:50973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcLJR-0007gU-Oi
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 21:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcLJN-0005Az-HX
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 21:50:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fcLJN-00059H-A0
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 21:49:57 -0400
Received: by mail-pg1-x544.google.com with SMTP id n15-v6so924719pgv.4
	for <qemu-devel@nongnu.org>; Sun, 08 Jul 2018 18:49:56 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-126-112-211.tukw.qwest.net.
	[97.126.112.211]) by smtp.gmail.com with ESMTPSA id
	i17-v6sm26399965pfj.95.2018.07.08.18.49.54
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 08 Jul 2018 18:49:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  8 Jul 2018 18:49:53 -0700
Message-Id: <20180709014953.26230-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tests/tcg/multiarch/linux-test: Fix error
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
2.17.1
