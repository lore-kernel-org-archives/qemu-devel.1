Received: from eggs.gnu.org ([2001:4830:134:3::10]:48307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyU-0007Y4-M3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyQ-0006U8-HY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyQ-0006Tg-AM
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id q7-v6so7266343wrr.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:56 +0200
Message-Id: <1539894735-14232-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/48] hyperv: address HvSintRoute by X86CPU
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
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Use X86CPU pointer to refer to the respective HvSintRoute instead of
vp_index.  This is more convenient and also paves the way for future
enhancements.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-7-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hyperv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 11fd1ad..0ce8a7a 100644
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
1.8.3.1
