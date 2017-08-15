Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dhiSc-0003Ur-Sz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dhiSY-0003M9-Po
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:29:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dhiSY-0003Ln-H8
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:29:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7FKSqcb134616
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 16:29:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cc6f3c2jy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 16:29:04 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 15 Aug 2017 16:29:01 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 15 Aug 2017 17:28:46 -0300
Message-Id: <20170815202846.24749-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hw/ppc: disable hotplug before CAS is completed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, lvivier@redhat.com

This patch is a follow up on the discussions that started with
Laurent's patch series "spapr: disable hotplugging without OS" [1]
and discussions made at patch "spapr: reset DRCs on migration
pre_load" [2].

At this moment, we do not support CPU/memory hotplug in early
boot stages, before CAS. The reason is that the hotplug event
can't be handled at SLOF level (or even in PRELAUNCH runstate) and
at the same time can't be canceled. This leads to devices being
unable to be hot unplugged and, in some cases, guest kernel Ooops.
After CAS, with the FDT in place, the guest can handle the hotplug
events and everything works as usual.

An attempt to try to support hotplug before CAS was made, but not
successful. The key difference in the current code flow between a
coldplugged and a hotplugged device, in the PRELAUNCH state, is that
the coldplugged device is registered at the base FDT, allowing its
DRC to go straight to CONFIGURED state. In theory, this can also be
done with a hotplugged device if we can add it to the base of the
existing FDT. However, tampering with the FDT after writing in the
guest memory, besides being a dubitable idea, is also not
possible. The FDT is written in ppc_spapr_reset and there is no
way to retrieve it - we can calculate the fdt_address but the
fdt_size isn't stored. Storing the fdt_size to allow for
later retrieval is yet another state that would need to be
migrated. In short, it is not worth the trouble.

All this said, this patch opted to disable CPU/mem hotplug at early
boot stages. CAS detection is made by checking if there are
any bits set in ov5_cas to avoid adding an extra state that
would need tracking/migration. The patch also makes sure that
it doesn't interfere with hotplug in the INMIGRATE state.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05226.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01989.html

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c              | 26 ++++++++++++++++++++++++++
 hw/ppc/spapr_ovec.c         |  7 +++++++
 include/hw/ppc/spapr_ovec.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7a1972..bdcc813 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2803,6 +2803,19 @@ out:
     error_propagate(errp, local_err);
 }
 
+/*
+ * 'h_client_architecture_support' will set at least OV5_FORM1_AFFINITY
+ * in ov5_cas when intersecting it with spapr->ov5 and ov5_guest. It's safe
+ * then to assume that CAS ov5_cas will have something set after CAS.
+ */
+static bool spapr_cas_completed(sPAPRMachineState *spapr)
+{
+    if (spapr->ov5_cas == NULL) {
+        return false;
+    }
+    return !spapr_ovec_is_unset(spapr->ov5_cas);
+}
+
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
@@ -3256,6 +3269,19 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
+    sPAPRMachineState *spapr;
+    Error *local_err = NULL;
+
+    if (dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE)) {
+        spapr = SPAPR_MACHINE(hotplug_dev);
+        if (!spapr_cas_completed(spapr)) {
+            error_setg(&local_err,
+                       "CPU/memory hotplug not supported at early boot");
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         spapr_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 41df4c3..fe7bc85 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -134,6 +134,13 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
     return test_bit(bitnr, ov->bitmap) ? true : false;
 }
 
+bool spapr_ovec_is_unset(sPAPROptionVector *ov)
+{
+    unsigned long lastbit;
+    lastbit = find_last_bit(ov->bitmap, OV_MAXBITS);
+    return (lastbit == OV_MAXBITS);
+}
+
 static void guest_byte_to_bitmap(uint8_t entry, unsigned long *bitmap,
                                  long bitmap_offset)
 {
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 9edfa5f..8126374 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -71,6 +71,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov);
 void spapr_ovec_set(sPAPROptionVector *ov, long bitnr);
 void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr);
 bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr);
+bool spapr_ovec_is_unset(sPAPROptionVector *ov);
 sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector);
 int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
                            sPAPROptionVector *ov, const char *name);
-- 
2.9.4
