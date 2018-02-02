Received: from eggs.gnu.org ([208.118.235.92]:43480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgFm-0008Ro-Cs
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgDO-0005ZM-EG
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:39:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehgDO-0005XW-2X
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:37:34 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 19:37:19 +0100
Message-Id: <20180202183731.29990-4-armbru@redhat.com>
In-Reply-To: <20180202183731.29990-1-armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v7 03/15] hw/dma: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/dma/soc_dma.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 9bb499bf9c..45516241c6 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/soc_dma.h"
@@ -270,11 +271,11 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwaddr virt_base,
         if (entry->type == soc_dma_port_mem) {
             if (entry->addr <= virt_base &&
                             entry->addr + entry->u.mem.size > virt_base) {
-                fprintf(stderr, "%s: FIFO at %"PRIx64
-                                " collides with RAM region at %"PRIx64
-                                "-%"PRIx64 "\n", __func__,
-                                virt_base, entry->addr,
-                                (entry->addr + entry->u.mem.size));
+                error_report("%s: FIFO at %"PRIx64
+                             " collides with RAM region at %"PRIx64
+                             "-%"PRIx64, __func__,
+                             virt_base, entry->addr,
+                             (entry->addr + entry->u.mem.size));
                 exit(-1);
             }
 
@@ -284,9 +285,9 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwaddr virt_base,
             while (entry < dma->memmap + dma->memmap_size &&
                             entry->addr <= virt_base) {
                 if (entry->addr == virt_base && entry->u.fifo.out == out) {
-                    fprintf(stderr, "%s: FIFO at %"PRIx64
-                                    " collides FIFO at %"PRIx64 "\n",
-                                    __func__, virt_base, entry->addr);
+                    error_report("%s: FIFO at %"PRIx64
+                                 " collides FIFO at %"PRIx64,
+                                 __func__, virt_base, entry->addr);
                     exit(-1);
                 }
 
@@ -321,11 +322,11 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
             if ((entry->addr >= virt_base && entry->addr < virt_base + size) ||
                             (entry->addr <= virt_base &&
                              entry->addr + entry->u.mem.size > virt_base)) {
-                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
-                                " collides with RAM region at %"PRIx64
-                                "-%"PRIx64 "\n", __func__,
-                                virt_base, virt_base + size,
-                                entry->addr, entry->addr + entry->u.mem.size);
+                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
+                             " collides with RAM region at %"PRIx64
+                             "-%"PRIx64, __func__,
+                             virt_base, virt_base + size,
+                             entry->addr, entry->addr + entry->u.mem.size);
                 exit(-1);
             }
 
@@ -334,11 +335,10 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
         } else {
             if (entry->addr >= virt_base &&
                             entry->addr < virt_base + size) {
-                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
-                                " collides with FIFO at %"PRIx64
-                                "\n", __func__,
-                                virt_base, virt_base + size,
-                                entry->addr);
+                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
+                             " collides with FIFO at %"PRIx64,
+                             __func__, virt_base, virt_base + size,
+                             entry->addr);
                 exit(-1);
             }
 
-- 
2.13.6
