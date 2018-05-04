Received: from eggs.gnu.org ([2001:4830:134:3::10]:54839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7R-0002SR-GF
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7Q-0001RO-Qz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:37 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7Q-0001Qx-Mn
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:36 -0400
Received: by mail-qt0-x243.google.com with SMTP id d3-v6so27912864qtp.11
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:01 -0300
Message-Id: <20180504155918.21287-4-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/20] sdcard: Rename the SDRequest as SDFrame48
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

SD requests are 48-bit SD frames, while SD responses can be
48-bit or 136-bit frames. The 48-bit response frames share
the same CRC logic than request frames.
Unify the 48-bit framing to reuse the same CRC logic between
requests and responses.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 9bdb3c9285..f0b41232f7 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -76,11 +76,22 @@ typedef enum {
     sd_adtc,	/* addressed with data transfer */
 } sd_cmd_type_t;
 
-typedef struct {
+/**
+ * SDFrame48: 48 bits commands or responses
+ *
+ * @cmd: request:  command
+ *       response: mirrored command
+ * @arg: request:  address information or parameter
+ *       response: status information, OCR register, RCA
+ * @crc: 7-bit CRC checksum
+ */
+typedef struct SDFrame48 {
     uint8_t cmd;
     uint32_t arg;
     uint8_t crc;
-} SDRequest;
+} SDFrame48;
+
+typedef struct SDFrame48 SDRequest;
 
 typedef struct SDState SDState;
 typedef struct SDBus SDBus;
-- 
2.17.0
