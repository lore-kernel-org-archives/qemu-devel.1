Received: from eggs.gnu.org ([2001:4830:134:3::10]:34506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9E-0003CJ-UX
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9E-0000GX-5v
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:00 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9E-0000GH-0y
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:35:00 -0400
Received: by mail-qk0-x244.google.com with SMTP id j73so20514459qke.6
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 08:34:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Mar 2018 12:34:38 -0300
Message-Id: <20180326153441.32641-3-f4bug@amsat.org>
In-Reply-To: <20180326153441.32641-1-f4bug@amsat.org>
References: <20180326153441.32641-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.13 2/5] hw/dma/i8257: Define
 I8257_CHANNEL_COUNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Nageswara Sastry <nasastry@in.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>

The 8257 has 4 DMA channels, reflect that to denote than when 8 channels
are used, this is not a single 8257 (but probably two cascaded).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/dma/i8257.h | 4 +++-
 hw/dma/i8257.c         | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 2cab50bb6c..3053f18797 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -7,6 +7,8 @@
 
 #define TYPE_I8257 "i8257"
 
+#define I8257_CHANNEL_COUNT 4
+
 typedef struct I8257Regs {
     int now[2];
     uint16_t base[2];
@@ -33,7 +35,7 @@ typedef struct I8257State {
     uint8_t command;
     uint8_t mask;
     uint8_t flip_flop;
-    I8257Regs regs[4];
+    I8257Regs regs[I8257_CHANNEL_COUNT];
     MemoryRegion channel_io;
     MemoryRegion cont_io;
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 52675e97c9..df030f934c 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -361,7 +361,7 @@ static void i8257_dma_run(void *opaque)
         d->running = 1;
     }
 
-    for (ichan = 0; ichan < 4; ichan++) {
+    for (ichan = 0; ichan < I8257_CHANNEL_COUNT; ichan++) {
         int mask;
 
         mask = 1 << ichan;
@@ -536,8 +536,8 @@ static const VMStateDescription vmstate_i8257 = {
         VMSTATE_UINT8(mask, I8257State),
         VMSTATE_UINT8(flip_flop, I8257State),
         VMSTATE_INT32(dshift, I8257State),
-        VMSTATE_STRUCT_ARRAY(regs, I8257State, 4, 1, vmstate_i8257_regs,
-                             I8257Regs),
+        VMSTATE_STRUCT_ARRAY(regs, I8257State, I8257_CHANNEL_COUNT, 1,
+                             vmstate_i8257_regs, I8257Regs),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.16.3
