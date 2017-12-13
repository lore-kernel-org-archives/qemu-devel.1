Received: from eggs.gnu.org ([2001:4830:134:3::10]:57859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDCK-0003Ji-Pe
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDCH-0005oM-4l
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:00:08 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDCH-0005oE-0P
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:00:05 -0500
Received: by mail-qt0-x241.google.com with SMTP id g9so5224810qth.9
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:00:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 16:58:51 -0300
Message-Id: <20171213195852.30439-14-f4bug@amsat.org>
In-Reply-To: <20171213195852.30439-1-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/14] sdhci: add sdhci_init_capareg() to
 initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

following patches modifying CAPAB will be easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index dadc4787b2..78bb8e8e89 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -100,6 +100,13 @@
 
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
+static void sdhci_init_capareg(SDHCIState *s, Error **errp)
+{
+    if (s->capareg == UINT32_MAX) {
+        s->capareg = SDHC_CAPAB_REG_DEFAULT;
+    }
+}
+
 static uint8_t sdhci_slotint(SDHCIState *s)
 {
     return (s->norintsts & s->norintsigen) || (s->errintsts & s->errintsigen) ||
@@ -1158,6 +1165,8 @@ static void sdhci_initfn(SDHCIState *s)
 
 static void sdhci_realizefn(SDHCIState *s, Error **errp)
 {
+    sdhci_init_capareg(s, errp);
+
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
@@ -1244,8 +1253,7 @@ const VMStateDescription sdhci_vmstate = {
 /* Capabilities registers provide information on supported features of this
  * specific host controller implementation */
 static Property sdhci_properties[] = {
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
-            SDHC_CAPAB_REG_DEFAULT),
+    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, UINT32_MAX),
     DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
-- 
2.15.1
