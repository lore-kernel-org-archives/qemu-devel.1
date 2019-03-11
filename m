Received: from eggs.gnu.org ([209.51.188.92]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qb1-0004Gr-MM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007W2-4E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:32790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007TP-L6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:53 +0100
Message-Id: <20190311191602.25796-3-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] target/hppa: fix TLB handling for page 0
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

Assume the following sequence:

pitlbe r0(sr0,r0)
iitlba r4,(sr0,r0)
ldil L%3000000,r5
iitlbp r5,(sr0,r0)

This will purge the whole TLB and add an entry for page 0. However
the current TLB implementation in helper_iitlba() will store to
the last empty TLB entry, while helper_iitlbp() will write to the
first empty entry. That is because an empty entry will match address
0 in helper_iitlba()

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/mem_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index aecf3075f6..f30824f4e1 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -238,15 +238,17 @@ void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
     hppa_tlb_entry *empty = NULL;
     int i;
-
     /* Zap any old entries covering ADDR; notice empty entries on the way.  */
     for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
         hppa_tlb_entry *ent = &env->tlb[i];
-        if (!ent->entry_valid) {
-            empty = ent;
-        } else if (ent->va_b <= addr && addr <= ent->va_e) {
-            hppa_flush_tlb_ent(env, ent);
-            empty = ent;
+        if (ent->va_b <= addr && addr <= ent->va_e) {
+            if (ent->entry_valid) {
+                hppa_flush_tlb_ent(env, ent);
+            }
+
+            if (!empty) {
+                empty = ent;
+            }
         }
     }
 
-- 
2.20.1
