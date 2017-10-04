Received: from eggs.gnu.org ([2001:4830:134:3::10]:59747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzhQd-0000S2-Ow
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzhQY-000805-Td
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:01:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzhQY-0007zj-IP
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:01:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94B01CA142035
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 07:01:18 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcx4ugupd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 07:01:17 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 12:01:15 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 13:01:09 +0200
Message-Id: <20171004110109.16525-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/css: fix css migration compat
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Commit e996583eb3 ("s390x/css: activate ChannelSubSys migration",
2017-07-11) was supposed to enable css migration for virtio-ccw
machines starting 2.10, but it ended up effectively enabling it
only for 2.10 as the registration of the appropriate VMStateDescription
happens in ccw_machine_2_10_instance_options which does not get
called for machines more recent than 2_10.

Let us move the corresponding chunk of code (which conditionally enables
the migration based on the value of the corresponding class property) to
a ccw_init, which is called for each virtio-ccw machine instance.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fafbc6d4fe..3b5dfdb48d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -313,6 +313,9 @@ static void ccw_init(MachineState *machine)
         ret = css_create_css_image(VIRTUAL_CSSID, true);
     }
     assert(ret == 0);
+    if (css_migration_enabled()) {
+        css_register_vmstate();
+    }
 
     /* Create VirtIO network adapters */
     s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
@@ -731,9 +734,6 @@ DEFINE_CCW_MACHINE(2_11, "2.11", true);
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
     ccw_machine_2_11_instance_options(machine);
-    if (css_migration_enabled()) {
-        css_register_vmstate();
-    }
 }
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
-- 
2.13.5
