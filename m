Received: from eggs.gnu.org ([2001:4830:134:3::10]:38377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosib-0004my-7m
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosia-0001fQ-8p
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosia-0001dy-0i
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiY-00022i-RO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:46 +0000
Message-Id: <20180222152307.7499-12-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/32] sdcard: add a trace event for command
 responses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180215220540.6556-4-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c         | 27 ++++++++++++++++++++++++---
 hw/sd/trace-events |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 72e9b47e34..8f72cde534 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -153,6 +153,27 @@ static const char *sd_state_name(enum SDCardStates state)
     return state_name[state];
 }
 
+static const char *sd_response_name(sd_rsp_type_t rsp)
+{
+    static const char *response_name[] = {
+        [sd_r0]     = "RESP#0 (no response)",
+        [sd_r1]     = "RESP#1 (normal cmd)",
+        [sd_r2_i]   = "RESP#2 (CID reg)",
+        [sd_r2_s]   = "RESP#2 (CSD reg)",
+        [sd_r3]     = "RESP#3 (OCR reg)",
+        [sd_r6]     = "RESP#6 (RCA)",
+        [sd_r7]     = "RESP#7 (operating voltage)",
+    };
+    if (rsp == sd_illegal) {
+        return "ILLEGAL RESP";
+    }
+    if (rsp == sd_r1b) {
+        rsp = sd_r1;
+    }
+    assert(rsp <= ARRAY_SIZE(response_name));
+    return response_name[rsp];
+}
+
 static uint8_t sd_get_dat_lines(SDState *sd)
 {
     return sd->enable ? sd->dat_lines : 0;
@@ -1596,10 +1617,12 @@ send_response:
 
     case sd_r0:
     case sd_illegal:
-    default:
         rsplen = 0;
         break;
+    default:
+        g_assert_not_reached();
     }
+    trace_sdcard_response(sd_response_name(rtype), rsplen);
 
     if (rtype != sd_illegal) {
         /* Clear the "clear on valid command" status bits now we've
@@ -1616,8 +1639,6 @@ send_response:
             DPRINTF(" %02x", response[i]);
         }
         DPRINTF(" state %d\n", sd->state);
-    } else {
-        DPRINTF("No response %d\n", sd->state);
     }
 #endif
 
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 75dac5a2cd..b2aa19ec0d 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -26,6 +26,7 @@ sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 # hw/sd/sd.c
 sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
 sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 
-- 
2.16.1
