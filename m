Received: from eggs.gnu.org ([2001:4830:134:3::10]:52309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edVCJ-0000TB-Ub
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edVCG-0004Xq-1m
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edVCF-0004Xl-SP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:07 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 22 Jan 2018 14:02:42 +0800
Message-Id: <20180122060244.29368-3-peterx@redhat.com>
In-Reply-To: <20180122060244.29368-1-peterx@redhat.com>
References: <20180122060244.29368-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] arm: postpone device listener unregister
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com

It's a preparation for follow-up patch to call region_del() in
memory_listener_unregister(), otherwise all device addr attached with
kvm_devices_head will be reset before calling kvm_arm_set_device_addr.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 211a7bf7be..1219d0062b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -266,7 +266,6 @@ static void kvm_arm_machine_init_done(Notifier *notifier, void *data)
 {
     KVMDevice *kd, *tkd;
 
-    memory_listener_unregister(&devlistener);
     QSLIST_FOREACH_SAFE(kd, &kvm_devices_head, entries, tkd) {
         if (kd->kda.addr != -1) {
             kvm_arm_set_device_addr(kd);
@@ -274,6 +273,7 @@ static void kvm_arm_machine_init_done(Notifier *notifier, void *data)
         memory_region_unref(kd->mr);
         g_free(kd);
     }
+    memory_listener_unregister(&devlistener);
 }
 
 static Notifier notify = {
-- 
2.14.3
