Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PP-0004I8-Us
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PM-0001ab-Px
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PM-0001Yu-Fg
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BE13Y046107
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:16:54 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nfmgsbdg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:16:53 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:16:51 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:37 +0200
In-Reply-To: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Message-Id: <20170406111646.12624-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 01/10] s390x: introduce 2.10 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 include/hw/compat.h        |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 40914fde6f..5ac315ac78 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -336,6 +336,9 @@ static const TypeInfo ccw_machine_info = {
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_9 \
+        HW_COMPAT_2_9
+
 #define CCW_COMPAT_2_8 \
         HW_COMPAT_2_8 \
         {\
@@ -402,14 +405,26 @@ static const TypeInfo ccw_machine_info = {
             .value    = "0",\
         },
 
+static void ccw_machine_2_10_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_2_10_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(2_10, "2.10", true);
+
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
+    ccw_machine_2_10_instance_options(machine);
 }
 
 static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
+    ccw_machine_2_10_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
 }
-DEFINE_CCW_MACHINE(2_9, "2.9", true);
+DEFINE_CCW_MACHINE(2_9, "2.9", false);
 
 static void ccw_machine_2_8_instance_options(MachineState *machine)
 {
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 5d5be91daf..846b90eb67 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_9 \
+    /* empty */
+
 #define HW_COMPAT_2_8 \
     {\
         .driver   = "fw_cfg_mem",\
-- 
2.11.0
