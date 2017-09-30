Received: from eggs.gnu.org ([2001:4830:134:3::10]:60530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5WO-00050N-UN
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5WL-0006QS-Os
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:44 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com
	([104.47.38.81]:34543
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dy5WL-0006QE-Ip
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:41 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 29 Sep 2017 17:16:46 -0700
Message-ID: <e953982c31117859f7892dff8f391ca20d176742.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 35/47] hw/sd: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

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
---
V2:
 - Split hw patch into individual directories

 hw/sd/pl181.c |  5 +++--
 hw/sd/sd.c    | 14 +++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 55c8098ecd..2b878a0c5e 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/sysbus.h"
@@ -146,7 +147,7 @@ static void pl181_fifo_push(PL181State *s, uint32_t value)
     int n;
 
     if (s->fifo_len == PL181_FIFO_LEN) {
-        fprintf(stderr, "pl181: FIFO overflow\n");
+        error_report("pl181: FIFO overflow");
         return;
     }
     n = (s->fifo_pos + s->fifo_len) & (PL181_FIFO_LEN - 1);
@@ -160,7 +161,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
     uint32_t value;
 
     if (s->fifo_len == 0) {
-        fprintf(stderr, "pl181: FIFO underflow\n");
+        error_report("pl181: FIFO underflow");
         return 0;
     }
     value = s->fifo[s->fifo_pos];
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff4db..e467d74fc8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -700,7 +700,7 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &= ~CARD_IS_LOCKED;
         sd->pwd_len = 0;
         /* Erasing the entire card here! */
-        fprintf(stderr, "SD: Card force-erased by CMD42\n");
+        error_report("SD: Card force-erased by CMD42");
         return;
     }
 
@@ -1282,7 +1282,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_r1;
 
     case 56:	/* CMD56:  GEN_CMD */
-        fprintf(stderr, "SD: GEN_CMD 0x%08x\n", req.arg);
+        error_report("SD: GEN_CMD 0x%08x", req.arg);
 
         switch (sd->state) {
         case sd_transfer_state:
@@ -1565,10 +1565,10 @@ send_response:
         int i;
         DPRINTF("Response:");
         for (i = 0; i < rsplen; i++)
-            fprintf(stderr, " %02x", response[i]);
-        fprintf(stderr, " state %d\n", sd->state);
+            error_report(" %02x", response[i]);
+        error_report(" state %d", sd->state);
     } else {
-        DPRINTF("No response %d\n", sd->state);
+        DPRINTF("No response %d", sd->state);
     }
 #endif
 
@@ -1580,14 +1580,14 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
     DPRINTF("sd_blk_read: addr = 0x%08llx, len = %d\n",
             (unsigned long long) addr, len);
     if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
-        fprintf(stderr, "sd_blk_read: read error on host side\n");
+        error_report("sd_blk_read: read error on host side");
     }
 }
 
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     if (!sd->blk || blk_pwrite(sd->blk, addr, sd->data, len, 0) < 0) {
-        fprintf(stderr, "sd_blk_write: write error on host side\n");
+        error_report("sd_blk_write: write error on host side");
     }
 }
 
-- 
2.11.0
