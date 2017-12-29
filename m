Received: from eggs.gnu.org ([2001:4830:134:3::10]:57433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyo8-0003l3-NX
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyo5-00077i-L0
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:00 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyo5-00077M-GK
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:57 -0500
Received: by mail-qk0-x242.google.com with SMTP id d202so29035465qkc.9
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:15 -0300
Message-Id: <20171229174933.1781-25-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 24/42] sdhci: add a 'dma' shortcut property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

disabling it disables all DMAs at once.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h | 1 +
 hw/sd/sdhci.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 4a9c3e9175..bac37f9e11 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -101,6 +101,7 @@ typedef struct SDHCIState {
     bool     pending_insert_state;
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
+    bool dma; /* shortcut for sdma + adma* */
     uint8_t spec_version;
     struct {
         /* v1 */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index dac5c48196..9d9cad81ea 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1178,6 +1178,10 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
 
+    if (!s->dma) {
+        s->cap.sdma = s->cap.adma1 = s->cap.adma2 = false;
+    }
+
     if (s->capareg == UINT64_MAX) {
         sdhci_init_capareg(s, errp);
     }
@@ -1306,6 +1310,7 @@ static Property sdhci_properties[] = {
      * Possible values: 512, 1024, 2048 bytes */
     DEFINE_PROP_UINT16("max-block-length", SDHCIState, cap.max_blk_len, 512),
     /* DMA */
+    DEFINE_PROP_BOOL("dma", SDHCIState, dma, true), /* shortcut */
     DEFINE_PROP_BOOL("sdma", SDHCIState, cap.sdma, true),
     DEFINE_PROP_BOOL("adma1", SDHCIState, cap.adma1, false),
     DEFINE_PROP_BOOL("adma2", SDHCIState, cap.adma2, true),
-- 
2.15.1
