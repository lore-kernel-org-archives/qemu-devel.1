Received: from eggs.gnu.org ([2001:4830:134:3::10]:59221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRt-0006j5-4V
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRr-00008y-Uz
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRr-000088-Os
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:39 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:50 +0200
Message-Id: <20171006095956.27534-28-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 27/33] s390x/css: fix css migration compat
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Commit e996583eb3 ("s390x/css: activate ChannelSubSys migration",
2017-07-11) was supposed to enable css migration for virtio-ccw
machines starting 2.10, but it ended up effectively enabling it
only for 2.10 as the registration of the appropriate VMStateDescription
happens in ccw_machine_2_10_instance_options which does not get
called for machines more recent than 2_10.

Let us move the corresponding chunk of code (which conditionally enables
the migration based on the value of the corresponding class property) to
ccw_init, which is called for each virtio-ccw machine instance.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20171004110109.16525-1-pasic@linux.vnet.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 14a0545e6f..76156ce873 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -291,6 +291,9 @@ static void ccw_init(MachineState *machine)
         ret = css_create_css_image(VIRTUAL_CSSID, true);
     }
     assert(ret == 0);
+    if (css_migration_enabled()) {
+        css_register_vmstate();
+    }
 
     /* Create VirtIO network adapters */
     s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
@@ -715,9 +718,6 @@ DEFINE_CCW_MACHINE(2_11, "2.11", true);
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
     ccw_machine_2_11_instance_options(machine);
-    if (css_migration_enabled()) {
-        css_register_vmstate();
-    }
 }
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
-- 
2.13.6
