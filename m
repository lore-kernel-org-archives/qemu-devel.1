Received: from eggs.gnu.org ([2001:4830:134:3::10]:37873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIv-0003eM-Se
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIs-00088A-L6
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:21 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIs-00087t-HP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:18 -0500
Received: by mail-qt0-x244.google.com with SMTP id d54so26496163qtd.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:28 -0300
Message-Id: <20180123033034.29493-13-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/18] sdcard: warn if host uses an
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 434d1fbc47..b5c947df62 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1394,6 +1394,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
2.15.1
