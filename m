Received: from eggs.gnu.org ([2001:4830:134:3::10]:59485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AQ-0007xb-Qm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AM-00048c-VQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:10 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com
	([40.107.8.98]:13312
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AM-00047o-IS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:06 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:41 +0300
Message-Id: <20180702165842.11423-6-rkagan@virtuozzo.com>
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/6] hyperv: address HvSintRoute by X86CPU
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

Use X86CPU pointer to refer to the respective HvSintRoute instead of
vp_index.  This is more convenient and also paves the way for future
enhancements.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 11fd1add2c..0ce8a7aa2f 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -18,7 +18,7 @@
 
 struct HvSintRoute {
     uint32_t sint;
-    uint32_t vp_index;
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
-    sint_route->vp_index = vp_index;
+    sint_route->cpu = cpu;
     sint_route->sint = sint;
 
     return sint_route;
-- 
2.17.1
