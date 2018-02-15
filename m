Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn9-0005Py-Q6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn8-0005Oa-Oy
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:11 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn8-0005Ni-LL
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:10 -0500
Received: by mail-qk0-x242.google.com with SMTP id n198so1571204qke.7
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:18 -0300
Message-Id: <20180215221325.7611-14-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 13/20] sdcard: check the card is in correct
 state for APP CMD (CMD55)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0ecb446fdb..c2f01a5fa3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1390,6 +1390,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Application specific commands (Class 8) */
     case 55:	/* CMD55:  APP_CMD */
+        switch (sd->state) {
+        case sd_ready_state:
+        case sd_identification_state:
+        case sd_inactive_state:
+            return sd_illegal;
+        default:
+            break;
+        }
         if (!sd->spi) {
             if (sd->rca != rca) {
                 return sd_r0;
-- 
2.16.1
