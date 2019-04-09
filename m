Received: from eggs.gnu.org ([209.51.188.92]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDjgu-0000o0-Hl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hDjgt-0007ng-8m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:53:04 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Tue,  9 Apr 2019 07:43:25 +0200
Message-Id: <20190409054325.22427-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] Fix type of cluster_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <stweil@ub-cluster-01.bib.uni-mannheim.de>

From: Stefan Weil <stweil@ub-cluster-01.bib.uni-mannheim.de>

The type should be the same as the type of cluster_id.

This fixed a runtime error reported by sanitizers:

    /qemu/include/exec/tb-lookup.h:33:35: runtime error: left shift of negative value -1
    /qemu/accel/tcg/translate-all.c:1692:34: runtime error: left shift of negative value -1

Signed-off-by: Stefan Weil <stweil@ub-cluster-01.bib.uni-mannheim.de>
---
 include/qom/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1d6099e5d4..6a753caed7 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -422,7 +422,7 @@ struct CPUState {
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-    int cluster_index;
+    uint32_t cluster_index;
     uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
@@ -1129,6 +1129,6 @@ extern const struct VMStateDescription vmstate_cpu_common;
 #endif /* NEED_CPU_H */
 
 #define UNASSIGNED_CPU_INDEX -1
-#define UNASSIGNED_CLUSTER_INDEX -1
+#define UNASSIGNED_CLUSTER_INDEX UINT32_MAX
 
 #endif
-- 
2.11.0
