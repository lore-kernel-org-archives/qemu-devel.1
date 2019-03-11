Received: from eggs.gnu.org ([209.51.188.92]:34413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qb0-0004H6-6I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007WT-7P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:41572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007Uy-UK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:59 +0100
Message-Id: <20190311191602.25796-9-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] target/hppa: allow multiple itlbp
 without itlba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

The ODE software calls itlbp on existing TLB entries without
calling itlba first, so this seems to be valid.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 26da953185..fc1b6a4fcd 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -277,7 +277,7 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
     hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
 
-    if (unlikely(ent == NULL || ent->entry_valid)) {
+    if (unlikely(ent == NULL)) {
         qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
         return;
     }
-- 
2.20.1
