Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qt-0004ym-7P
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qq-0003vP-V7
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:07 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qq-0003ui-OF
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:04 -0500
Received: by mail-wj0-x242.google.com with SMTP id ip10so5994154wjb.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:19 +0100
Message-Id: <1485524749-118532-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/41] hw/isa/lpc_ich9: add broadcast SMI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

The generic edk2 SMM infrastructure prefers
EFI_SMM_CONTROL2_PROTOCOL.Trigger() to inject an SMI on each processor. If
Trigger() only brings the current processor into SMM, then edk2 handles it
in the following ways:

(1) If Trigger() is executed by the BSP (which is guaranteed before
    ExitBootServices(), but is not necessarily true at runtime), then:

    (a) If edk2 has been configured for "traditional" SMM synchronization,
        then the BSP sends directed SMIs to the APs with APIC delivery,
        bringing them into SMM individually. Then the BSP runs the SMI
        handler / dispatcher.

    (b) If edk2 has been configured for "relaxed" SMM synchronization,
        then the APs that are not already in SMM are not brought in, and
        the BSP runs the SMI handler / dispatcher.

(2) If Trigger() is executed by an AP (which is possible after
    ExitBootServices(), and can be forced e.g. by "taskset -c 1
    efibootmgr"), then the AP in question brings in the BSP with a
    directed SMI, and the BSP runs the SMI handler / dispatcher.

The smaller problem with (1a) and (2) is that the BSP and AP
synchronization is slow. For example, the "taskset -c 1 efibootmgr"
command from (2) can take more than 3 seconds to complete, because
efibootmgr accesses non-volatile UEFI variables intensively.

The larger problem is that QEMU's current behavior diverges from the
behavior usually seen on physical hardware, and that keeps exposing
obscure corner cases, race conditions and other instabilities in edk2,
which generally expects / prefers a software SMI to affect all CPUs at
once.

Therefore introduce the "broadcast SMI" feature that causes QEMU to inject
the SMI on all VCPUs.

While the original posting of this patch
<http://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05658.html>
only intended to speed up (2), based on our recent "stress testing" of SMM
this patch actually provides functional improvements.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20170126014416.11211-3-lersek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/lpc_ich9.c      | 10 +++++++++-
 include/hw/i386/ich9.h |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 376b780..ced6f80 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -437,7 +437,15 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
 
     /* SMI_EN = PMBASE + 30. SMI control and enable register */
     if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
-        cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
+        if (lpc->smi_negotiated_features &
+            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
+            CPUState *cs;
+            CPU_FOREACH(cs) {
+                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
+            }
+        } else {
+            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
+        }
     }
 }
 
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index da11187..18dcca7 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -250,4 +250,7 @@ Object *ich9_lpc_find(void);
 #define ICH9_SMB_HST_D1                         0x06
 #define ICH9_SMB_HOST_BLOCK_DB                  0x07
 
+/* bit positions used in fw_cfg SMI feature negotiation */
+#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
+
 #endif /* HW_ICH9_H */
-- 
1.8.3.1
