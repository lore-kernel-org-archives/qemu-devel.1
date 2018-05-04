Received: from eggs.gnu.org ([2001:4830:134:3::10]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7Q-0002RM-9K
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7O-0001PB-1v
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:36 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7N-0001Ox-Tm
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id g13-v6so27949892qth.8
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:00 -0300
Message-Id: <20180504155918.21287-3-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/20] sdcard: Extract sd_calc_frame48_crc7()
 from sd_req_crc_validate()
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

Extract calculate() from validate() so we can calculate the CRC
out of the validate() function.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e0518d6..861bba197d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -481,13 +481,18 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
-static int sd_req_crc_validate(SDRequest *req)
+static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg)
 {
     uint8_t buffer[5];
-    buffer[0] = 0x40 | req->cmd;
-    stl_be_p(&buffer[1], req->arg);
+    buffer[0] = 0x40 | cmd;
+    stl_be_p(&buffer[1], arg);
+    return sd_crc7(buffer, sizeof(buffer));
+}
+
+static int sd_req_crc_validate(SDRequest *req)
+{
     return 0;
-    return sd_crc7(buffer, 5) != req->crc;	/* TODO */
+    return sd_calc_frame48_crc7(req->cmd, req->arg) != req->crc; /* TODO */
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
-- 
2.17.0
