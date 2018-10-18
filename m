Received: from eggs.gnu.org ([2001:4830:134:3::10]:48014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyF-0007H4-D8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy9-0006E7-Gp
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy8-00069r-OY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e4-v6so35109887wrs.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:36 +0200
Message-Id: <1539894735-14232-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/48] target-i386: add rtc 0x70 port as
 coalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peng Hao <peng.hao2@zte.com.cn>

From: Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Message-Id: <1539890353-30273-1-git-send-email-peng.hao2@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index acee47d..e4e4de8 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -34,6 +34,7 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
+#include "exec/address-spaces.h"
 
 #ifdef TARGET_I386
 #include "hw/i386/apic.h"
@@ -70,6 +71,7 @@ typedef struct RTCState {
     ISADevice parent_obj;
 
     MemoryRegion io;
+    MemoryRegion coalesced_io;
     uint8_t cmos_data[128];
     uint8_t cmos_index;
     int32_t base_year;
@@ -990,6 +992,13 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
     isa_register_ioport(isadev, &s->io, base);
 
+    /* register rtc 0x70 port for coalesced_pio */
+    memory_region_set_flush_coalesced(&s->io);
+    memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
+                          s, "rtc-index", 1);
+    memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
+    memory_region_add_coalescing(&s->coalesced_io, 0, 1);
+
     qdev_set_legacy_instance_id(dev, base, 3);
     qemu_register_reset(rtc_reset, s);
 
-- 
1.8.3.1
