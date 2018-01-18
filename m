Received: from eggs.gnu.org ([2001:4830:134:3::10]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEzC-0007L6-57
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEz6-0003S8-Cl
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:26 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEz6-0003Rz-8Y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:20 -0500
Received: by mail-qt0-x242.google.com with SMTP id u10so32638212qtg.2
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:32:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 15:31:01 -0300
Message-Id: <20180118183108.16009-10-f4bug@amsat.org>
In-Reply-To: <20180118183108.16009-1-f4bug@amsat.org>
References: <20180118183108.16009-1-f4bug@amsat.org>
In-Reply-To: <20180118182510.15630-1-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 10/17] sdhci: add max-block-length
 capability (Spec v1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h |  1 -
 include/hw/sd/sdhci.h  |  2 ++
 hw/sd/sdhci.c          | 36 +++++++++++-------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9acafe7b01..c5e26bf8f3 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -188,7 +188,6 @@ FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
 #define SDHC_64_BIT_BUS_SUPPORT        (1 << 28)
-#define SDHC_CAPAB_BLOCKSIZE(x)        (((x) >> 16) & 0x3)
 FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
 FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
 FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index bc80f59d3c..d3d438879c 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -96,6 +96,8 @@ typedef struct SDHCIState {
         /***********
          * Spec v1
          ***********/
+        /* Maximum host controller R/W buffers size (512, 1024, 2048 bytes) */
+        uint16_t max_blk_len;
         /* Suspend/resume */
         bool suspend;
         bool high_speed;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e56ee7778c..ced2f66aee 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -48,9 +48,6 @@
 #define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Support */
 #define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
 #define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
-/* Maximum host controller R/W buffers size
- * Possible values: 512, 1024, 2048 bytes */
-#define SDHC_CAPAB_MAXBLOCKLENGTH 512ul
 /* Maximum clock frequency for SDclock in MHz
  * value in range 10-63 MHz, 0 - not defined */
 #define SDHC_CAPAB_BASECLKFREQ    52ul
@@ -64,16 +61,6 @@
 #error Capabilities features can have value 0 or 1 only!
 #endif
 
-#if SDHC_CAPAB_MAXBLOCKLENGTH == 512
-#define MAX_BLOCK_LENGTH 0ul
-#elif SDHC_CAPAB_MAXBLOCKLENGTH == 1024
-#define MAX_BLOCK_LENGTH 1ul
-#elif SDHC_CAPAB_MAXBLOCKLENGTH == 2048
-#define MAX_BLOCK_LENGTH 2ul
-#else
-#error Max host controller block size can have value 512, 1024 or 2048 only!
-#endif
-
 #if (SDHC_CAPAB_BASECLKFREQ > 0 && SDHC_CAPAB_BASECLKFREQ < 10) || \
     SDHC_CAPAB_BASECLKFREQ > 63
 #error SDclock frequency can have value in range 0, 10-63 only!
@@ -85,7 +72,7 @@
 
 #define SDHC_CAPAB_REG_DEFAULT                                 \
    ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_ADMA1 << 20) |   \
-    (SDHC_CAPAB_ADMA2 << 19) | (MAX_BLOCK_LENGTH << 16) |      \
+    (SDHC_CAPAB_ADMA2 << 19) |                                 \
     (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
     (SDHC_CAPAB_TOCLKFREQ))
 
@@ -94,12 +81,20 @@
 static uint64_t sdhci_init_capareg(SDHCIState *s, Error **errp)
 {
     uint64_t capareg = 0;
+    uint32_t val;
 
     switch (s->spec_version) {
     case 2: /* default version */
 
     /* fallback */
     case 1:
+        val = ctz32(s->cap.max_blk_len >> 9);
+        if (val >= 0b11) {
+            error_setg(errp, "block size can be 512, 1024 or 2048 only");
+            return 0;
+        }
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, MAXBLOCKLENGTH, val);
+
         capareg = FIELD_DP64(capareg, SDHC_CAPAB, HIGHSPEED, s->cap.high_speed);
         capareg = FIELD_DP64(capareg, SDHC_CAPAB, SDMA, s->cap.sdma);
         capareg = FIELD_DP64(capareg, SDHC_CAPAB, SUSPRESUME, s->cap.suspend);
@@ -1176,17 +1171,7 @@ static const MemoryRegionOps sdhci_mmio_ops = {
 
 static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 {
-    switch (SDHC_CAPAB_BLOCKSIZE(s->capareg)) {
-    case 0:
-        return 512;
-    case 1:
-        return 1024;
-    case 2:
-        return 2048;
-    default:
-        hw_error("SDHC: unsupported value for maximum block size\n");
-        return 0;
-    }
+    return 1 << (9 + FIELD_EX32(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH));
 }
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
@@ -1221,6 +1206,7 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     DEFINE_PROP_UINT8("sd-spec-version", _state, spec_version, 2), \
     \
     /* Spec v1 properties */ \
+    DEFINE_PROP_UINT16("max-block-length", _state, cap.max_blk_len, 512), \
     DEFINE_PROP_BOOL("sdma", _state, cap.sdma, true), \
     DEFINE_PROP_BOOL("suspend", _state, cap.suspend, false), \
     DEFINE_PROP_BOOL("high-speed", _state, cap.high_speed, true), \
-- 
2.15.1
