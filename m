Received: from eggs.gnu.org ([2001:4830:134:3::10]:55151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7z-00037T-FC
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7u-0001hW-KS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7u-0001hK-Gi
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id h2-v6so27974637qtp.7
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:11 -0300
Message-Id: <20180504155918.21287-14-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/20] sdcard: Expose sd_prepare_frame48() for
 QTest use
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h     | 16 ++++++++++++++++
 hw/sd/sdmmc-internal.c |  4 ++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index b1f865fe20..13de1b30c3 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -168,6 +168,22 @@ void sd_prepare_request(SDRequest *req, uint8_t cmd, uint32_t arg,
 void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
                                  uint8_t crc);
 
+/**
+ * sd_prepare_response48: Initialize a SD response buffer
+ *
+ * If @gen_crc the frame checksum will be calculated
+ * and filled in the request buffer.
+ *
+ * @req: the #SDRequest to be filled
+ * @cmd: the SD command
+ * @arg: the SD command argument
+ * @is_response: whether the frame is a command request or response
+ * @gen_crc: generates the frame CRC7 if true, else fill with zeroes
+ */
+
+void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
+                        bool is_response, bool gen_crc);
+
 /**
  * sd_update_frame48_checksum:
  * @frame: the #SDFrame48 to verify
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 04da81e665..c990cc9e8e 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -129,8 +129,8 @@ void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response)
     frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
 }
 
-static void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
-                               bool is_response, bool gen_crc)
+void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
+                        bool is_response, bool gen_crc)
 {
     frame->cmd = cmd;
     frame->arg = arg;
-- 
2.17.0
