Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMr-0000oK-MJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMo-0003ht-HQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:45 -0500
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com
	([104.47.32.57]:31808
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZMo-0003hX-Ab
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:42 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:30 -0800
Message-ID: <f9f4c5804dc51c7f33c7470f92c522d452ed13bb.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 34/45] hw/sd: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

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

Some of the prints in hw/sd/sd.c were manually converted to using
DPRINTF() instead.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud <f4bug@amsat.org>
---
V3:
 - Fixup some DPRINTF() prints being wrong
V2:
 - Split hw patch into individual directories

 hw/sd/pl181.c |  5 +++--
 hw/sd/sd.c    | 15 ++++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

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
index 35347a5bbc..5d7fa3e418 100644
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
@@ -1564,9 +1564,10 @@ send_response:
     if (rsplen) {
         int i;
         DPRINTF("Response:");
-        for (i = 0; i < rsplen; i++)
-            fprintf(stderr, " %02x", response[i]);
-        fprintf(stderr, " state %d\n", sd->state);
+        for (i = 0; i < rsplen; i++) {
+            DPRINTF(" %02x", response[i]);
+        }
+        DPRINTF(" state %d\n", sd->state);
     } else {
         DPRINTF("No response %d\n", sd->state);
     }
@@ -1580,14 +1581,14 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
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
2.14.1
