Received: from eggs.gnu.org ([209.51.188.92]:51404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3Na-0000Sq-8Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NY-000588-DY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:34 -0400
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 12 Apr 2019 23:06:17 +0200
Message-Id: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH 3/4] target/ppc: improve performance of large
 BAT invalidations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Performing a complete flush is ~ 100 times faster than flushing
256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
flush afterwards.

This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/ppc/mmu_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 4a6be4d..d7eed3a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1809,6 +1809,13 @@ static inline void do_invalidate_BAT(CPUPPCState *env, target_ulong BATu,
 
     base = BATu & ~0x0001FFFF;
     end = base + mask + 0x00020000;
+    if (((end - base) >> TARGET_PAGE_BITS) > 1024) {
+        /* Flushing 1024 4K pages is slower than a complete flush */
+        LOG_BATS("Flush all BATs\n");
+        tlb_flush(CPU(cs));
+        LOG_BATS("Flush done\n");
+        return;
+    }
     LOG_BATS("Flush BAT from " TARGET_FMT_lx " to " TARGET_FMT_lx " ("
              TARGET_FMT_lx ")\n", base, end, mask);
     for (page = base; page != end; page += TARGET_PAGE_SIZE) {
-- 
2.7.2
