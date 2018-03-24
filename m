Received: from eggs.gnu.org ([2001:4830:134:3::10]:35238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezq6A-0000zO-Fz
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 16:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezq56-0008HX-F4
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 16:49:10 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:43022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezon8-0005uz-GL
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:26 -0400
Received: by mail-pl0-x242.google.com with SMTP id f23-v6so9436658plr.10
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:26 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:54 -0700
Message-Id: <20180324192455.12254-14-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 13/14] timer: ds-rtc model ds1375
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

differences from ds1338

* Has alarms (not modeled)
* different control register (not modeled)
* smaller address space (0x20 vs. 0x40)

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds-rtc.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
index 5a4df1b115..e5da36cae8 100644
--- a/hw/timer/ds-rtc.c
+++ b/hw/timer/ds-rtc.c
@@ -1,8 +1,9 @@
 /*
- * MAXIM DSRTC I2C RTC+NVRAM
+ * MAXIM/Dallas DS1338 and DS1375 I2C RTC+NVRAM
  *
+ * Copyright (c) 2018 Michael Davidsaver
  * Copyright (c) 2009 CodeSourcery.
- * Written by Paul Brook
+ * Written by Paul Brook, Michael Davidsaver
  *
  * This code is licensed under the GNU GPL v2.
  *
@@ -41,6 +42,7 @@
 #define R_YEAR  (0x6)
 
 #define R_DS1338_CTRL (0x7)
+#define R_DS1375_CTRL (0xe)
 
 /* use 12 hour mode when set */
 FIELD(HOUR, SET12, 6, 1)
@@ -296,10 +298,34 @@ static const TypeInfo ds1338_info = {
     .class_init    = ds1338_class_init,
 };
 
+static void ds1375_control_write(DSRTCState *s, uint8_t data)
+{
+    /* just store it, we don't model any features */
+    s->nvram[R_DS1375_CTRL] = data;
+}
+
+static void ds1375_class_init(ObjectClass *klass, void *data)
+{
+    DSRTCClass *k = DSRTC_CLASS(klass);
+
+    k->has_century = true;
+    k->addr_size = 0x20;
+    k->ctrl_offset = R_DS1375_CTRL;
+    k->ctrl_write = ds1375_control_write;
+}
+
+static const TypeInfo ds1375_info = {
+    .name          = "ds1375",
+    .parent        = TYPE_DSRTC,
+    .class_size    = sizeof(DSRTCClass),
+    .class_init    = ds1375_class_init,
+};
+
 static void dsrtc_register_types(void)
 {
     type_register_static(&dsrtc_info);
     type_register_static(&ds1338_info);
+    type_register_static(&ds1375_info);
 }
 
 type_init(dsrtc_register_types)
-- 
2.11.0
