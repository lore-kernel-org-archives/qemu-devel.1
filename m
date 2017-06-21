Received: from eggs.gnu.org ([2001:4830:134:3::10]:35276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiS8-00075t-LU
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiS5-0004aO-VN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:00 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com
	([40.107.3.105]:12521
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiS5-0004Z3-K7
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:57 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:13 +0300
Message-Id: <20170621162424.10462-13-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 12/23] hyperv: address HvSintRoute by X86CPU
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

Use X86CPU pointer to refer to the respective HvSintRoute instead of
vp_index.  This is more convenient and also paves the way for future
enhancements.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - was patch 11 in v1
 - pass vp_index to sint_route_create, and lookup X86CPU * inside

 target/i386/hyperv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 84ea228..b5831bf 100644
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
2.9.4
