Received: from eggs.gnu.org ([2001:4830:134:3::10]:57396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GZ-0002y5-Dw
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GV-0005cL-IJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6GV-0005bp-BL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:34 +0200
Message-Id: <20170830165252.13421-27-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 26/44] target/s390x: simplify gs_allowed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

No need for kvm_enabled() as this function is only called from KVM and
there is no reason why it shouldn't be allowed for tcg. It is simply not
available under tcg.

Also, there is no need to check for the machine type anymore. Just like
ri_enabled(), we can directly use the stored flag, which results in
"true" for the "none" machine.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-5-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cdf7fa042b..3a718953a2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -290,18 +290,8 @@ bool cpu_model_allowed(void)
 
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
2.13.5
