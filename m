Received: from eggs.gnu.org ([2001:4830:134:3::10]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0I-0000jJ-EW
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0H-0007g1-GF
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:42 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0H-0007fp-Bq
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:41 -0500
Received: by mail-qt0-x241.google.com with SMTP id c2so33613431qtn.9
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:41:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:53 -0300
Message-Id: <20180118204058.5768-10-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 09/14] sdhci: remove the deprecated
 'capareg' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

All SDHCI consumers have been upgraded to set correct properties.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ec7430c83c..651f523089 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1184,7 +1184,6 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
-    uint64_t capab;
     Error *local_err = NULL;
 
     switch (s->spec_version) {
@@ -1196,20 +1195,11 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
 
-    capab = sdhci_init_capareg(s, &local_err);
+    s->capareg = sdhci_init_capareg(s, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-    if (s->capareg == UINT64_MAX) {
-        s->capareg = capab;
-    } else {
-        capab = s->capareg & ~capab;
-        if (capab) {
-            error_setg(errp, "missing capability mask: 0x%" PRIx64, capab);
-            return;
-        }
-    }
 }
 
 /* --- qdev common --- */
@@ -1239,9 +1229,6 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     DEFINE_PROP_UINT8("bus-speed", _state, cap.sdr, 0), \
     DEFINE_PROP_UINT8("driver-strength", _state, cap.strength, 0), \
     \
-    /* deprecated: Capabilities registers provide information on supported
-     * features of this specific host controller implementation */ \
-    DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
     DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
 
 static void sdhci_initfn(SDHCIState *s)
-- 
2.15.1
