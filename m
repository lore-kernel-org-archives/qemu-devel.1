Received: from eggs.gnu.org ([2001:4830:134:3::10]:44781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSL-0004WS-El
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSK-00051s-EN
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:33 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSK-00051K-6o
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:32 -0500
Received: by mail-wm0-x241.google.com with SMTP id i186so28241972wmi.4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:36 +0100
Message-Id: <1517858941-5538-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/47] arm: postpone device listener unregister
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It's a preparation for follow-up patch to call region_del() in
memory_listener_unregister(), otherwise all device addr attached with
kvm_devices_head will be reset before calling kvm_arm_set_device_addr.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180122060244.29368-3-peterx@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 211a7bf..1219d00 100644
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
1.8.3.1
