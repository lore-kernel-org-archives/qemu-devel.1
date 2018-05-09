Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4f-0004X9-K7
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4e-0002s3-TO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:29 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4e-0002rb-OW
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:28 -0400
Received: by mail-qt0-x241.google.com with SMTP id m16-v6so43923535qtg.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:51 -0300
Message-Id: <20180509034658.26455-8-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/14] sdcard: Invert the
 sd_req_crc_is_valid() logic
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

Let's return TRUE when the CRC is valid.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d8dad94fc4..6fc8daa5b8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -467,13 +467,13 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
-static int sd_req_crc_validate(SDRequest *req)
+static bool sd_req_crc_is_valid(SDRequest *req)
 {
     uint8_t buffer[5];
     buffer[0] = 0x40 | req->cmd;
     stl_be_p(&buffer[1], req->arg);
-    return 0;
-    return sd_frame48_calc_checksum(buffer) != req->crc; /* TODO */
+    return true;
+    return sd_frame48_calc_checksum(buffer) == req->crc; /* TODO */
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
@@ -1631,7 +1631,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
         return 0;
     }
 
-    if (sd_req_crc_validate(req)) {
+    if (!sd_req_crc_is_valid(req)) {
         sd->card_status |= COM_CRC_ERROR;
         rtype = sd_illegal;
         goto send_response;
-- 
2.17.0
