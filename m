Received: from eggs.gnu.org ([2001:4830:134:3::10]:59610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZx-00045R-Cg
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZw-00031W-9V
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:09:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  2 Jun 2018 21:08:27 -0300
Message-Id: <20180603000827.30872-9-f4bug@amsat.org>
In-Reply-To: <20180603000827.30872-1-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/8] sdcard: Disable CMD19/CMD23 for Spec v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

These commands got introduced by Spec v3.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 83426da133..ac202e05a1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1178,6 +1178,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
+        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+            break;
+        }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_offset = 0;
@@ -1186,6 +1189,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 23:    /* CMD23: SET_BLOCK_COUNT */
+        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+            break;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->multi_blk_cnt = req.arg;
-- 
2.17.1
