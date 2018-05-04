Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7b-0002bI-OD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7Z-0001Wu-SL
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:47 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7Z-0001Wj-Nf
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:45 -0400
Received: by mail-qt0-x243.google.com with SMTP id f1-v6so27972559qtj.6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:04 -0300
Message-Id: <20180504155918.21287-7-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/20] sdcard: Add a "validate-crc" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>

Since not all modelled controllers use the CRC verification (which is
somehow expensive), let the controller have a configurable property
to enable verification.

So far only the Milkymist controller uses it.

This silent the Coverity warning:

  "Code block is unreachable because of the syntactic structure of the code (CWE-561)"

and fixes the following issue:

- CID1005332 (hw/sd/sd.c::sd_req_crc_validate) Structurally dead code

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c |  1 +
 hw/sd/sd.c                | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index d8cbb7b681..04babc092f 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -278,6 +278,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
+    object_property_set_bool(OBJECT(carddev), true, "validate-crc", &err);
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index be75e118c0..801ddc2cb5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -93,6 +93,7 @@ struct SDState {
     /* Configurable properties */
     BlockBackend *blk;
     bool spi;
+    bool validate_crc;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
@@ -496,10 +497,12 @@ static bool sd_verify_frame48_checksum(SDFrame48 *frame)
     return crc == frame->crc;
 }
 
-static int sd_req_crc_validate(SDRequest *req)
+static bool sd_req_crc_validate(SDState *sd, SDRequest *req)
 {
-    return 0;
-    return !sd_verify_frame48_checksum(req); /* TODO */
+    if (sd->validate_crc) {
+        return sd_verify_frame48_checksum(req);
+    }
+    return true;
 }
 
 static void sd_update_frame48_checksum(SDFrame48 *frame)
@@ -1685,7 +1688,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
         return 0;
     }
 
-    if (sd_req_crc_validate(req)) {
+    if (!sd_req_crc_validate(sd, req)) {
         sd->card_status |= COM_CRC_ERROR;
         rtype = sd_illegal;
         goto send_response;
@@ -2134,6 +2137,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_BOOL("validate-crc", SDState, validate_crc, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.17.0
