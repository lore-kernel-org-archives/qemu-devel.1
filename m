Received: from eggs.gnu.org ([2001:4830:134:3::10]:58632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG52-0004qD-Vi
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG52-0003YM-5Y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG52-0003Xj-0F
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:52 -0400
Received: by mail-qt0-x241.google.com with SMTP id m16-v6so43924257qtg.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:58 -0300
Message-Id: <20180509034658.26455-15-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 14/14] hw/sd/ssi-sd: Enable CRC
 validation
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
 hw/sd/ssi-sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 77e446bb94..0375f0b959 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -95,11 +95,11 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
         if (s->arglen == 4) {
             uint8_t request[6];
             uint8_t longresp[16];
-            /* FIXME: Check CRC.  */
 
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, ldl_be_p(s->cmdarg));
             sd_frame48_init(request, sizeof(request), s->cmd,
                             ldl_be_p(s->cmdarg), false);
+            request[5] = sd_frame48_calc_checksum(request);
 
             s->arglen = sdbus_do_command(&s->sdbus, request, longresp);
             if (s->arglen <= 0) {
@@ -257,6 +257,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
     }
     object_property_set_bool(OBJECT(carddev), true, "spi", &err);
+    object_property_set_bool(OBJECT(carddev), true, "validate-crc", &err);
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
-- 
2.17.0
