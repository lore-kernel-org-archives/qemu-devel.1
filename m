Received: from eggs.gnu.org ([2001:4830:134:3::10]:50294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIAA-0008TB-DM
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA9-0005VM-JZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:18 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA9-0005UH-F2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:17 -0400
Received: by mail-qk0-x244.google.com with SMTP id z75so26655339qkb.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 23:01:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 03:01:02 -0300
Message-Id: <20180509060104.4458-3-f4bug@amsat.org>
In-Reply-To: <20180509060104.4458-1-f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/4] sdcard: Correct CRC16 offset in
 sd_function_switch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Per the Physical Layer Simplified Spec. "4.3.10.4 Switch Function Status":

  The block length is predefined to 512 bits

and "4.10.2 SD Status":

  The SD Status contains status bits that are related to the SD Memory Card
  proprietary features and may be used for future application-specific usage.
  The size of the SD Status is one data block of 512 bit. The content of this
  register is transmitted to the Host over the DAT bus along with a 16-bit CRC.

Thus the 16-bit CRC goes at offset 64.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5fb4787671..24aaf0c767 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -791,7 +791,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
         sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
     }
     memset(&sd->data[17], 0, 47);
-    stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
+    stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
 }
 
 static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
-- 
2.17.0
