Received: from eggs.gnu.org ([2001:4830:134:3::10]:43712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dstet-0004fa-NS
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dstes-00074c-Tq
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dstes-00073Q-Nv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:40:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 15 Sep 2017 18:39:52 +0200
Message-Id: <20170915163952.32147-2-cohuck@redhat.com>
In-Reply-To: <20170915163952.32147-1-cohuck@redhat.com>
References: <20170915163952.32147-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 1/1] s390x/ccw: create s390 phb for
 compat reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
registering the s390 pci host bridge conditional on presense
of the zpci facility bit. Sadly, that breaks migration from
machines that did not use the cpu model (2.7 and previous).

Create the s390 phb for pre-cpu model machines as well.

Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 ++
 target/s390x/cpu_models.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0471407187..907abc7a32 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -269,6 +269,8 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
     }
 }
 
+static S390CcwMachineClass *get_machine_class(void);
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c295e641e6..5169379db5 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -196,6 +196,9 @@ bool s390_has_feat(S390Feat feat)
             }
         }
 #endif
+        if (feat == S390_FEAT_ZPCI) {
+            return true;
+        }
         return 0;
     }
     return test_bit(feat, cpu->model->features);
-- 
2.13.5
