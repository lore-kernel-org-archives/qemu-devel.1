Received: from eggs.gnu.org ([2001:4830:134:3::10]:46431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zL-0004RH-7s
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-00031h-CE
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-000301-Q3
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:11 -0400
Message-Id: <1499586614-20507-20-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 19/22] tcg: introduce tcg_context_clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Before we make TCGContext thread-local.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h |  1 +
 tcg/tcg.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2a64ee2..be5f3fd 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -778,6 +778,7 @@ static inline void *tcg_malloc(int size)
 }
 
 void tcg_context_init(TCGContext *s);
+void tcg_context_clone(TCGContext *s);
 void tcg_prologue_init(TCGContext *s);
 void tcg_register_thread(void);
 void tcg_func_start(TCGContext *s);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2f003a0..8febf53 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -117,6 +117,7 @@ static bool tcg_out_tb_finalize(TCGContext *s);
 
 #define TCG_HIGHWATER 1024
 
+static const TCGContext *tcg_init_ctx;
 static QemuMutex tcg_lock;
 
 /*
@@ -353,6 +354,7 @@ void tcg_context_init(TCGContext *s)
     TCGArgConstraint *args_ct;
     int *sorted_args;
 
+    tcg_init_ctx = s;
     memset(s, 0, sizeof(*s));
     s->nb_globals = 0;
 
@@ -409,6 +411,18 @@ void tcg_context_init(TCGContext *s)
 }
 
 /*
+ * Clone the initial TCGContext. Used by TCG threads to copy the TCGContext
+ * set up by their parent thread via tcg_context_init().
+ */
+void tcg_context_clone(TCGContext *s)
+{
+    if (unlikely(tcg_init_ctx == NULL || tcg_init_ctx == s)) {
+        tcg_abort();
+    }
+    memcpy(s, tcg_init_ctx, sizeof(*s));
+}
+
+/*
  * Allocate TBs right before their corresponding translated code, making
  * sure that TBs and code are on different cache lines.
  */
-- 
2.7.4
