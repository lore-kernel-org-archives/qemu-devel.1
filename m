Received: from eggs.gnu.org ([2001:4830:134:3::10]:58464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4W-0004Ph-CE
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4V-0002YP-Bo
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:20 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4V-0002Xh-7K
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:19 -0400
Received: by mail-qk0-x243.google.com with SMTP id d74so26465645qkg.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:48 -0300
Message-Id: <20180509034658.26455-5-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/14] sdcard: Extract
 sd_frame48/136_calc_checksum()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

It will help when moving this around for qtesting in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 27a70896cd..06607115a7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -273,6 +273,21 @@ static uint16_t sd_crc16(const void *message, size_t width)
     return shift_reg;
 }
 
+enum {
+    F48_CONTENT_LENGTH  = 1 /* command */ + 4 /* argument */,
+    F136_CONTENT_LENGTH = 15,
+};
+
+static uint8_t sd_frame48_calc_checksum(const void *content)
+{
+    return sd_crc7(content, F48_CONTENT_LENGTH);
+}
+
+static uint8_t sd_frame136_calc_checksum(const void *content)
+{
+    return (sd_crc7(content, F136_CONTENT_LENGTH) << 1) | 1;
+}
+
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
@@ -352,7 +367,7 @@ static void sd_set_cid(SDState *sd)
     sd->cid[13] = 0x00 |	/* Manufacture date (MDT) */
         ((MDT_YR - 2000) / 10);
     sd->cid[14] = ((MDT_YR % 10) << 4) | MDT_MON;
-    sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
+    sd->cid[15] = sd_frame136_calc_checksum(sd->cid);
 }
 
 #define HWBLOCK_SHIFT	9			/* 512 bytes */
@@ -416,7 +431,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
     }
-    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
+    sd->csd[15] = sd_frame136_calc_checksum(sd->csd);
 }
 
 static void sd_set_rca(SDState *sd)
@@ -491,7 +506,7 @@ static int sd_req_crc_validate(SDRequest *req)
     buffer[0] = 0x40 | req->cmd;
     stl_be_p(&buffer[1], req->arg);
     return 0;
-    return sd_crc7(buffer, 5) != req->crc;	/* TODO */
+    return sd_frame48_calc_checksum(buffer) != req->crc; /* TODO */
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
-- 
2.17.0
