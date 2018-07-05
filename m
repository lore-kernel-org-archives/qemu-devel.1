Received: from eggs.gnu.org ([2001:4830:134:3::10]:58133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rs-0004Xx-Dr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rr-0006J3-4n
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:36 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:41729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rq-0006I1-QB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:35 -0400
Received: by mail-pf0-x22a.google.com with SMTP id c21-v6so1515461pfn.8
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:34 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:59 -0700
Message-Id: <20180705182001.16537-13-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 12/14] timer: ds-rtc handle CENTURY bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/ds-rtc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
index 6d3a8b5586..9abac38628 100644
--- a/hw/timer/ds-rtc.c
+++ b/hw/timer/ds-rtc.c
@@ -70,6 +70,7 @@ typedef struct DSRTCState {
 typedef struct DSRTCClass {
     I2CSlaveClass parent_obj;
 
+    bool has_century;
     /* actual address space size must be <= NVRAM_SIZE */
     unsigned addr_size;
     unsigned ctrl_offset;
@@ -93,6 +94,7 @@ static const VMStateDescription vmstate_dsrtc = {
 
 static void capture_current_time(DSRTCState *s)
 {
+    DSRTCClass *k = DSRTC_GET_CLASS(s);
     /* Capture the current time into the secondary registers
      * which will be actually read by the data transfer operation.
      */
@@ -125,7 +127,10 @@ static void capture_current_time(DSRTCState *s)
     }
     s->nvram[R_DATE] = to_bcd(now.tm_mday);
     s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
-    s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
+    s->nvram[R_YEAR] = to_bcd(now.tm_year % 100u);
+
+    ARRAY_FIELD_DP32(s->nvram, MONTH, CENTURY,
+                     k->has_century && now.tm_year >= 100)
 }
 
 static void inc_regptr(DSRTCState *s)
@@ -282,6 +287,7 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
 {
     DSRTCClass *k = DSRTC_CLASS(klass);
 
+    k->has_century = false;
     k->addr_size = 0x40;
     k->ctrl_offset = R_DS1338_CTRL;
     k->ctrl_write = ds1338_control_write;
-- 
2.11.0
