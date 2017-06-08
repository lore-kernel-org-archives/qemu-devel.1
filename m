Received: from eggs.gnu.org ([2001:4830:134:3::10]:57282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUW-0000Tx-Kn
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUV-0007eI-GQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:24 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu,  8 Jun 2017 17:03:49 +1000
Message-Id: <20170608070351.1434-4-sjitindarsingh@gmail.com>
In-Reply-To: <20170608070351.1434-1-sjitindarsingh@gmail.com>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH 3/5] target/ppc: Implement migration support
 for large decrementer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Implement support to migrate a guest which is using the large
decrementer.

We need to save the decrementer width to the migration stream.
On incoming migration we then need to check that the hypervisor is
capable of letting the guest use the large decrementer and that the
decrementer width is the same on the receiving side. Since there is no
way to tell the guest when the width of the decrementer changes we have
to terminate if the decrementer width is not what the guest expects.
If we can use the large decrementer then we have to tell the hypervisor
to enable it.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5d10366..6ba869a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1420,6 +1420,45 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
     }
 }
 
+static int spapr_import_large_decr_bits(sPAPRMachineState *spapr)
+{
+    /*
+     * If the guest uses the large decrementer then this hypervisor must also
+     * support it and have the exact same width. We must also enable the large
+     * decrementer because we have no way to tell the guest to stop using it.
+     */
+    if (spapr->large_decr_bits) {
+        uint32_t dec_bits = 32;
+        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+        CPUState *cs = CPU(cpu);
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+
+        if (kvm_enabled()) {
+            if (!kvmppc_has_cap_large_decr()) {
+                error_report("Host doesn't support large decrementer and guest requires it");
+                return -EINVAL;
+            }
+            dec_bits = kvmppc_get_dec_bits();
+        } else {
+            dec_bits = pcc->large_decr_bits;
+        }
+
+        if (spapr->large_decr_bits != dec_bits) {
+            error_report("Host large decrementer size [%u] doesn't match what guest expects [%u]",
+                         dec_bits, spapr->large_decr_bits);
+            return -EINVAL;
+        }
+
+        if (kvm_enabled()) {
+            CPU_FOREACH(cs) {
+                kvmppc_configure_large_decrementer(cs, true);
+            }
+        }
+    }
+
+    return 0;
+}
+
 static int spapr_post_load(void *opaque, int version_id)
 {
     sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
@@ -1439,8 +1478,13 @@ static int spapr_post_load(void *opaque, int version_id)
      * value into the RTC device */
     if (version_id < 3) {
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
+        if (err) {
+            return err;
+        }
     }
 
+    err = spapr_import_large_decr_bits(spapr);
+
     return err;
 }
 
@@ -1529,6 +1573,24 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
     },
 };
 
+static bool spapr_large_decr_entry_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    return !!spapr->large_decr_bits;
+}
+
+static const VMStateDescription vmstate_spapr_large_decr_entry = {
+    .name = "spapr_large_decr_entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_large_decr_entry_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(large_decr_bits, sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -1547,6 +1609,7 @@ static const VMStateDescription vmstate_spapr = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
+        &vmstate_spapr_large_decr_entry,
         NULL
     }
 };
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 98fb78b..4ba9b89 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -91,6 +91,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     bool cas_reboot;
     bool cas_legacy_guest_workaround;
+    uint32_t large_decr_bits; /* Large decrementer width (0 -> not in use) */
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
-- 
2.9.4
