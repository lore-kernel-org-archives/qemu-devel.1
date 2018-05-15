Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabt-0003uW-Tb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabn-0002y4-VI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabn-0002wj-Ow
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabm-0001Tk-St
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:07:06 +0100
Message-Id: <20180515140707.15957-16-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/16] sdcard: Correct CRC16 offset in
 sd_function_switch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Per the Physical Layer Simplified Spec. "4.3.10.4 Switch Function Status":

  The block length is predefined to 512 bits

and "4.10.2 SD Status":

  The SD Status contains status bits that are related to the SD Memory Card
  proprietary features and may be used for future application-specific usage.
  The size of the SD Status is one data block of 512 bit. The content of this
  register is transmitted to the Host over the DAT bus along with a 16-bit CRC.

Thus the 16-bit CRC goes at offset 64.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180509060104.4458-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e0518d6..7af19fa06c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -787,7 +787,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
         sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
     }
     memset(&sd->data[17], 0, 47);
-    stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
+    stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
 }
 
 static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
-- 
2.17.0
