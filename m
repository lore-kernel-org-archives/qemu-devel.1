Received: from eggs.gnu.org ([2001:4830:134:3::10]:43658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqB-0001yB-P6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqA-00061b-U0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:25 +0200
Message-Id: <20180702111737.18970-4-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] s390x/cpumodel: default enable bpb and
 ppa15 for z196 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Most systems and host kernels provide the necessary building blocks for
bpb and ppa15. We can reverse the logic and default enable those
features, while still allowing to disable it via cpu model.

So let us add bpb and ppa15 to z196 and later default CPU model for the
qemu 3.0 machine. (like -cpu z13).  Older machine types (e.g.
s390-ccw-virtio-2.12) will retain the old value and not provide those
bits in the default model.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20180626123830.18282-1-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  | 2 ++
 target/s390x/gen-features.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7ae5fb38dd..f8f58c8acb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -824,6 +824,8 @@ DEFINE_CCW_MACHINE(3_0, "3.0", true);
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
     ccw_machine_3_0_instance_options(machine);
+    s390_cpudef_featoff_greater(11, 1, S390_FEAT_PPA15);
+    s390_cpudef_featoff_greater(11, 1, S390_FEAT_BPB);
 }
 
 static void ccw_machine_2_12_class_options(MachineClass *mc)
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0cdbc15378..6626b6f565 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -512,6 +512,8 @@ static uint16_t default_GEN11_GA1[] = {
     S390_FEAT_IPTE_RANGE,
     S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
     S390_FEAT_GROUP_MSA_EXT_4,
+    S390_FEAT_PPA15,
+    S390_FEAT_BPB,
 };
 
 #define default_GEN11_GA2 EmptyFeat
-- 
2.14.4
