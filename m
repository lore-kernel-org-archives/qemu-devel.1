Received: from eggs.gnu.org ([2001:4830:134:3::10]:55639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfG-0006AZ-ET
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfF-00012u-Bg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:02 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfF-00012g-7h
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:01 -0500
Received: by mail-qk0-x242.google.com with SMTP id c128so1560473qkb.4
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:06:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:05:32 -0300
Message-Id: <20180215220540.6556-4-f4bug@amsat.org>
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/11] sdcard: add a trace event for command
 responses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
