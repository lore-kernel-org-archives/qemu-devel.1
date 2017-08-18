Received: from eggs.gnu.org ([2001:4830:134:3::10]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhG-0001w9-KB
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhE-0007A7-Mh
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhE-00079n-Fn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:39 +0200
Message-Id: <20170818114353.13455-5-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 04/18] target/s390x: simplify
 gs_allowed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

No need for kvm_enabled() as this function is only called from KVM and
there is no reason why it shouldn't be allowed for tcg. It is simply not
available under tcg.

Also, there is no need to check for the machine type anymore. Just like
ri_enabled(), we can directly use the stored flag, which results in
"true" for the "none" machine.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3a674f5..3e9b455 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -288,18 +288,8 @@ bool cpu_model_allowed(void)
 
 bool gs_allowed(void)
 {
-    if (kvm_enabled()) {
-        MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-        if (object_class_dynamic_cast(OBJECT_CLASS(mc),
-                                      TYPE_S390_CCW_MACHINE)) {
-            S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
-
-            return s390mc->gs_allowed;
-        }
-        /* Make sure the "none" machine can have gs */
-        return true;
-    }
-    return false;
+    /* for "none" machine this results in true */
+    return get_machine_class()->gs_allowed;
 }
 
 static char *machine_get_loadparm(Object *obj, Error **errp)
-- 
2.9.4
