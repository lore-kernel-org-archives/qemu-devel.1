Received: from eggs.gnu.org ([2001:4830:134:3::10]:46399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zK-0004RB-H0
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zE-00030g-Nm
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42939)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002zM-AB
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:02 -0400
Message-Id: <1499586614-20507-11-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 10/22] exec-all: move tb->invalid to the end of
 the struct
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

This opens up a 4-byte hole to be used by upcoming work.

Note that moving this field to the 2nd cache line of the struct
does not affect performance: tb->page_addr is in the 2nd cache
line as well, and both are accessed during code lookup. Besides,
the tb->invalid check is easily predicted.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a388756..fd20bca 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -327,8 +327,6 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
 
-    uint8_t invalid;
-
     void *tc_ptr;    /* pointer to the translated code */
     uint8_t *tc_search;  /* pointer to search data */
     /* original tb when cflags has CF_NOCACHE */
@@ -366,6 +364,7 @@ struct TranslationBlock {
      */
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_list_first;
+    uint8_t invalid;
 };
 
 void tb_free(TranslationBlock *tb);
-- 
2.7.4
