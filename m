Received: from eggs.gnu.org ([2001:4830:134:3::10]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyw-00075M-GU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyv-0003NW-Mc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:10 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyv-0003NK-I0
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:09 -0500
Received: by mail-qt0-x243.google.com with SMTP id u10so32636798qtg.2
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:32:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 15:30:58 -0300
Message-Id: <20180118183108.16009-7-f4bug@amsat.org>
In-Reply-To: <20180118183108.16009-1-f4bug@amsat.org>
References: <20180118183108.16009-1-f4bug@amsat.org>
In-Reply-To: <20180118182510.15630-1-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 07/17] sdhci: add init_readonly_registers()
 to initialize the CAPAB register
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
---
 hw/sd/sdhci.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8c9c0fbc2a..caf5e5a1b4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1174,12 +1174,19 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
     }
 }
 
+static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
+{
+    if (s->capareg == UINT64_MAX) {
+        s->capareg = SDHC_CAPAB_REG_DEFAULT;
+    }
+}
+
 /* --- qdev common --- */
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
-    /* Capabilities registers provide information on supported features
-     * of this specific host controller implementation */ \
-    DEFINE_PROP_UINT64("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAULT), \
+    /* deprecated: Capabilities registers provide information on supported
+     * features of this specific host controller implementation */ \
+    DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
     DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
 
 static void sdhci_initfn(SDHCIState *s)
@@ -1204,6 +1211,13 @@ static void sdhci_uninitfn(SDHCIState *s)
 
 static void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
+    Error *local_err = NULL;
+
+    sdhci_init_readonly_registers(s, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-- 
2.15.1
