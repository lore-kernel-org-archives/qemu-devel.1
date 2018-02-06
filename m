Received: from eggs.gnu.org ([2001:4830:134:3::10]:44647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9th-0000b1-HI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9te-00033A-6Z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:21 -0500
Received: from mail-eopbgr00136.outbound.protection.outlook.com
	([40.107.0.136]:40807
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9td-00032o-T8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:18 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:20 +0300
Message-Id: <20180206203048.11096-7-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 06/34] hyperv: address HvSintRoute by
 X86CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Use X86CPU pointer to refer to the respective HvSintRoute instead of
vp_index.  This is more convenient and also paves the way for future
enhancements.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index b2416f9a5b..0ce8a7aa2f 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -18,7 +18,7 @@
 
 struct HvSintRoute {
     uint32_t sint;
-    uint32_t vcpu_id;
+    X86CPU *cpu;
     int gsi;
     EventNotifier sint_set_notifier;
     EventNotifier sint_ack_notifier;
@@ -97,6 +97,12 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
     int r, gsi;
+    X86CPU *cpu;
+
+    cpu = hyperv_find_vcpu(vp_index);
+    if (!cpu) {
+        return NULL;
+    }
 
     sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
@@ -128,7 +134,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     sint_route->gsi = gsi;
     sint_route->sint_ack_clb = sint_ack_clb;
     sint_route->sint_ack_clb_data = sint_ack_clb_data;
-    sint_route->vcpu_id = vp_index;
+    sint_route->cpu = cpu;
     sint_route->sint = sint;
 
     return sint_route;
-- 
2.14.3
