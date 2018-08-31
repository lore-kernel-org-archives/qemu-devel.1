Received: from eggs.gnu.org ([2001:4830:134:3::10]:45507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fvXv9-0003KQ-SO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 21:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fvXf6-0004iw-Nz
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:51:47 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:55048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fvXf6-0004i8-CX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:51:44 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 31 Aug 2018 17:05:04 +0800
Message-Id: <1535706305-118115-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1535706305-118115-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535706305-118115-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V5 3/4] target-i386: add rtc 0x70 port as
 coalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/timer/mc146818rtc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6f1f723..b19ef51 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -70,6 +70,7 @@ typedef struct RTCState {
     ISADevice parent_obj;
 
     MemoryRegion io;
+    MemoryRegion coalesced_io;
     uint8_t cmos_data[128];
     uint8_t cmos_index;
     int32_t base_year;
@@ -990,6 +991,13 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
     isa_register_ioport(isadev, &s->io, base);
 
+    /* register rtc 0x70 port as coalesced_pio */
+    memory_region_set_flush_coalesced(&s->io);
+    memory_region_init_io(&s->coalesced_io, OBJECT(s), &cmos_ops,
+                          s, "rtc1", 1);
+    isa_register_ioport(isadev, &s->coalesced_io, base);
+    memory_region_add_coalescing(&s->coalesced_io, 0, 1);
+
     qdev_set_legacy_instance_id(dev, base, 3);
     qemu_register_reset(rtc_reset, s);
 
-- 
1.8.3.1
