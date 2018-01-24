Received: from eggs.gnu.org ([2001:4830:134:3::10]:51334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURs-000512-7H
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURr-00022k-AK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:20 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURr-00022T-4T
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:19 -0500
Received: by mail-pg0-x242.google.com with SMTP id q67so3809701pga.9
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:13 -0800
Message-Id: <20180124232625.30105-34-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 33/45] qom: Add MMU_DEBUG_LOAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

This lets us tell bottom levels of virtual memory translation
routines that the access is from within QEMU itself and bypass
certain tests.

Cc: Andreas Färber <afaerber@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h      | 3 ++-
 target/sh4/op_helper.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 93bd546879..6367acca97 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -64,7 +64,8 @@ typedef uint64_t vaddr;
 typedef enum MMUAccessType {
     MMU_DATA_LOAD  = 0,
     MMU_DATA_STORE = 1,
-    MMU_INST_FETCH = 2
+    MMU_INST_FETCH = 2,
+    MMU_DEBUG_LOAD = 3
 } MMUAccessType;
 
 typedef struct CPUWatchpoint CPUWatchpoint;
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index d798f239cf..8fa7cb6b42 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -36,6 +36,8 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     case MMU_DATA_STORE:
         cs->exception_index = 0x100;
         break;
+    default:
+        g_assert_not_reached();
     }
     cpu_loop_exit_restore(cs, retaddr);
 }
-- 
2.14.3
