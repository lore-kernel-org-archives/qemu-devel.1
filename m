Received: from eggs.gnu.org ([2001:4830:134:3::10]:58618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnD-0005WV-7M
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnC-0005SR-EW
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:15 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnC-0005SI-A2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:14 -0500
Received: by mail-qt0-x241.google.com with SMTP id d14so1648005qtg.1
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:19 -0300
Message-Id: <20180215221325.7611-15-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/20] sdcard: warn if host uses an
 incorrect address for APP CMD (CMD55)
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
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c2f01a5fa3..5827379d0f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1395,6 +1395,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         case sd_identification_state:
         case sd_inactive_state:
             return sd_illegal;
+        case sd_idle_state:
+            if (rca) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
+            }
         default:
             break;
         }
-- 
2.16.1
