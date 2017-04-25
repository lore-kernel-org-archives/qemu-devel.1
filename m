Received: from eggs.gnu.org ([2001:4830:134:3::10]:34044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIs-0008VN-Om
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIo-0000p2-FJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:50 -0400
Message-Id: <1493106839-10438-5-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 04/13] tcg: keep TCGContext's read-mostly
 fields in a separate cache line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Upcoming changes will require reading from TCGContext from a
parallel fast path. Prepare for this by keeping the struct's
read-mostly fields in a separate cache line, thereby preventing
false cache line sharing.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5fdbfe3..b26f0ef 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -642,6 +642,20 @@ QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
 QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
 
 struct TCGContext {
+    /* Read-mostly fields go here to prevent false sharing */
+    struct {
+        GHashTable *helpers;
+
+        void *code_gen_prologue;
+        void *code_gen_buffer;
+        size_t code_gen_buffer_size;
+
+        /* Threshold to flush the translated code buffer.  */
+        void *code_gen_highwater;
+
+        int code_gen_max_blocks;
+    } QEMU_ALIGNED(64);
+
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
     int nb_labels;
@@ -663,8 +677,6 @@ struct TCGContext {
 
     tcg_insn_unit *code_ptr;
 
-    GHashTable *helpers;
-
 #ifdef CONFIG_PROFILER
     /* profiling info */
     int64_t tb_count1;
@@ -697,15 +709,8 @@ struct TCGContext {
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
        extension that allows arithmetic on void*.  */
-    int code_gen_max_blocks;
-    void *code_gen_prologue;
-    void *code_gen_buffer;
-    size_t code_gen_buffer_size;
     void *code_gen_ptr;
 
-    /* Threshold to flush the translated code buffer.  */
-    void *code_gen_highwater;
-
     TBContext tb_ctx;
 
     /* Track which vCPU triggers events */
-- 
2.7.4
