Received: from eggs.gnu.org ([2001:4830:134:3::10]:58617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG50-0004nn-0o
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4z-0003T6-23
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:50 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4y-0003SY-TG
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:48 -0400
Received: by mail-qt0-x243.google.com with SMTP id f1-v6so43975283qtj.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:57 -0300
Message-Id: <20180509034658.26455-14-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/14] sdcard: Add a "validate-crc" property
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
 hw/sd/sd.c                | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 94bb1ffc6f..f7b6d3b140 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -273,6 +273,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
+    object_property_set_bool(OBJECT(carddev), true, "validate-crc", &err);
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaf3a6806a..0170eb832b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -93,6 +93,7 @@ struct SDState {
     /* Configurable properties */
     BlockBackend *blk;
     bool spi;
+    bool validate_crc;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
@@ -467,10 +468,12 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
-static bool sd_req_crc_is_valid(const void *buffer)
+static bool sd_req_crc_is_valid(SDState *sd, const void *request)
 {
+    if (sd->validate_crc) {
+        return sd_frame48_verify_checksum(request);
+    }
     return true;
-    return sd_frame48_verify_checksum(buffer); /* TODO */
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
@@ -1631,7 +1634,7 @@ int sd_do_command(SDState *sd, const uint8_t *request,
     cmd = request[0];
     arg = ldl_be_p(&request[1]);
 
-    if (!sd_req_crc_is_valid(request)) {
+    if (!sd_req_crc_is_valid(sd, request)) {
         sd->card_status |= COM_CRC_ERROR;
         rtype = sd_illegal;
         goto send_response;
@@ -2079,6 +2082,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_BOOL("validate-crc", SDState, validate_crc, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.17.0
