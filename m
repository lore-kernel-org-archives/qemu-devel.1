Received: from eggs.gnu.org ([2001:4830:134:3::10]:54806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7Q-0002RL-9J
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7O-0001Pf-I6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:36 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7O-0001PL-DK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:34 -0400
Received: by mail-qk0-x243.google.com with SMTP id h19so16976164qkj.10
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:58:59 -0300
Message-Id: <20180504155918.21287-2-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/20] sdcard: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>

The load/store API will ease further code movement.

Per the Physical Layer Simplified Spec. "3.6 Bus Protocol":

  "In the CMD line the Most Significant Bit (MSB) is transmitted
   first, the Least Significant Bit (LSB) is the last."

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 3 +--
 hw/sd/ssi-sd.c            | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5570c1e9a0..ff2b92dc64 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -100,8 +100,7 @@ static void memcard_sd_command(MilkymistMemcardState *s)
     SDRequest req;
 
     req.cmd = s->command[0] & 0x3f;
-    req.arg = (s->command[1] << 24) | (s->command[2] << 16)
-              | (s->command[3] << 8) | s->command[4];
+    req.arg = ldl_be_p(s->command + 1);
     req.crc = s->command[5];
 
     s->response[0] = req.cmd;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index ae04b6641b..0bb26e596d 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -97,8 +97,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
             uint8_t longresp[16];
             /* FIXME: Check CRC.  */
             request.cmd = s->cmd;
-            request.arg = (s->cmdarg[0] << 24) | (s->cmdarg[1] << 16)
-                           | (s->cmdarg[2] << 8) | s->cmdarg[3];
+            request.arg = ldl_be_p(s->cmdarg);
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
             s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
             if (s->arglen <= 0) {
-- 
2.17.0
