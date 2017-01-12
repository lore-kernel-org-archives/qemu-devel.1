Received: from eggs.gnu.org ([2001:4830:134:3::10]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3V-0001HQ-4h
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3T-0002eX-Cz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRk3T-0002di-4G
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:55 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B48C04B947
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 18:24:55 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:44 +0100
Message-Id: <20170112182446.9600-2-lersek@redhat.com>
In-Reply-To: <20170112182446.9600-1-lersek@redhat.com>
References: <20170112182446.9600-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 2 1/3] hw/isa/lpc_ich9: add SMI feature
 negotiation via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Introduce the following fw_cfg files:

- "etc/smi/supported-features": a little endian uint64_t feature bitmap,
  presenting the features known by the host to the guest. Read-only for
  the guest.

  The content of this file will be determined via bit-granularity ICH9-LPC
  device properties, to be introduced later. For now, the bitmask is left
  zeroed. The bits will be set from machine type compat properties and on
  the QEMU command line, hence this file is not migrated.

- "etc/smi/requested-features": a little endian uint64_t feature bitmap,
  representing the features the guest would like to request. Read-write
  for the guest.

  The guest can freely (re)write this file, it has no direct consequence.
  Initial value is zero. A nonzero value causes the SMI-related fw_cfg
  files and fields that are under guest influence to be migrated.

- "etc/smi/features-ok": contains a uint8_t value, and it is read-only for
  the guest. When the guest selects the associated fw_cfg key, the guest
  features are validated against the host features. In case of error, the
  negotiation doesn't proceed, and the "features-ok" file remains zero. In
  case of success, the "features-ok" file becomes (uint8_t)1, and the
  negotiated features are locked down internally (to which no further
  changes are possible until reset).

  The initial value is zero.  A nonzero value causes the SMI-related
  fw_cfg files and fields that are under guest influence to be migrated.

The C-language fields backing the "supported-features" and
"requested-features" files are uint8_t arrays. This is because they carry
guest-side representation (our choice is little endian), while
VMSTATE_UINT64() assumes / implies host-side endianness for any uint64_t
fields. If we migrate a guest between hosts with different endiannesses
(which is possible with TCG), then the host-side value is preserved, and
the host-side representation is translated. This would be visible to the
guest through fw_cfg, unless we used plain byte arrays. So we do.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes:
    v6:
    - no changes, pick up Michael's R-b
    
    v5:
    - rename the "etc/smi/host-features" fw_cfg file to
      "etc/smi/supported-features" [Igor]
    
    - rename the "etc/smi/guest-features" fw_cfg file to
      "etc/smi/requested-features" [Igor]
    
    - suffix the names of the "ICH9LPCState.smi_host_features" and
      "ICH9LPCState.smi_guest_features" array fields with "_le" for
      representing their guest-visible encoding [Igor]
    
    - Replace the "smi_host_features" parameter of ich9_lpc_pm_init() --
      which was meant in v4 to be set by  board code -- with a new
      "ICH9LPCState.smi_host_features" field, of type uint64_t.
      Bit-granularity ICH9-LPC device properties will be carved out of this
      field. [Igor]
    
    - Given the "ICH9LPCState.smi_host_features" uint64_t field, we can now
      use that directly for feature validation in
      smi_features_ok_callback(). Converting the (otherwise guest-read-only)
      "ICH9LPCState.smi_host_features_le" array back to CPU endianness just
      for this is no longer necessary.

 include/hw/i386/ich9.h | 10 +++++++
 hw/isa/lpc_ich9.c      | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 5fd7e97d2347..da1118727146 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -64,6 +64,16 @@ typedef struct ICH9LPCState {
     uint8_t rst_cnt;
     MemoryRegion rst_cnt_mem;
 
+    /* SMI feature negotiation via fw_cfg */
+    uint64_t smi_host_features;       /* guest-invisible, host endian */
+    uint8_t smi_host_features_le[8];  /* guest-visible, read-only, little
+                                       * endian uint64_t */
+    uint8_t smi_guest_features_le[8]; /* guest-visible, read-write, little
+                                       * endian uint64_t */
+    uint8_t smi_features_ok;          /* guest-visible, read-only; selecting it
+                                       * triggers feature lockdown */
+    uint64_t smi_negotiated_features; /* guest-invisible, host endian */
+
     /* isa bus */
     ISABus *isa_bus;
     MemoryRegion rcrb_mem; /* root complex register block */
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 10d1ee8b9310..376b7801a42c 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -48,6 +48,8 @@
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "qom/cpu.h"
+#include "hw/nvram/fw_cfg.h"
+#include "qemu/cutils.h"
 
 /*****************************************************************************/
 /* ICH9 LPC PCI to ISA bridge */
@@ -360,13 +362,62 @@ static void ich9_set_sci(void *opaque, int irq_num, int level)
     }
 }
 
+static void smi_features_ok_callback(void *opaque)
+{
+    ICH9LPCState *lpc = opaque;
+    uint64_t guest_features;
+
+    if (lpc->smi_features_ok) {
+        /* negotiation already complete, features locked */
+        return;
+    }
+
+    memcpy(&guest_features, lpc->smi_guest_features_le, sizeof guest_features);
+    le64_to_cpus(&guest_features);
+    if (guest_features & ~lpc->smi_host_features) {
+        /* guest requests invalid features, leave @features_ok at zero */
+        return;
+    }
+
+    /* valid feature subset requested, lock it down, report success */
+    lpc->smi_negotiated_features = guest_features;
+    lpc->smi_features_ok = 1;
+}
+
 void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(lpc_pci);
     qemu_irq sci_irq;
+    FWCfgState *fw_cfg = fw_cfg_find();
 
     sci_irq = qemu_allocate_irq(ich9_set_sci, lpc, 0);
     ich9_pm_init(lpc_pci, &lpc->pm, smm_enabled, sci_irq);
+
+    if (lpc->smi_host_features && fw_cfg) {
+        uint64_t host_features_le;
+
+        host_features_le = cpu_to_le64(lpc->smi_host_features);
+        memcpy(lpc->smi_host_features_le, &host_features_le,
+               sizeof host_features_le);
+        fw_cfg_add_file(fw_cfg, "etc/smi/supported-features",
+                        lpc->smi_host_features_le,
+                        sizeof lpc->smi_host_features_le);
+
+        /* The other two guest-visible fields are cleared on device reset, we
+         * just link them into fw_cfg here.
+         */
+        fw_cfg_add_file_callback(fw_cfg, "etc/smi/requested-features",
+                                 NULL, NULL,
+                                 lpc->smi_guest_features_le,
+                                 sizeof lpc->smi_guest_features_le,
+                                 false);
+        fw_cfg_add_file_callback(fw_cfg, "etc/smi/features-ok",
+                                 smi_features_ok_callback, lpc,
+                                 &lpc->smi_features_ok,
+                                 sizeof lpc->smi_features_ok,
+                                 true);
+    }
+
     ich9_lpc_reset(&lpc->d.qdev);
 }
 
@@ -507,6 +558,10 @@ static void ich9_lpc_reset(DeviceState *qdev)
 
     lpc->sci_level = 0;
     lpc->rst_cnt = 0;
+
+    memset(lpc->smi_guest_features_le, 0, sizeof lpc->smi_guest_features_le);
+    lpc->smi_features_ok = 0;
+    lpc->smi_negotiated_features = 0;
 }
 
 /* root complex register block is mapped into memory space */
@@ -668,6 +723,29 @@ static const VMStateDescription vmstate_ich9_rst_cnt = {
     }
 };
 
+static bool ich9_smi_feat_needed(void *opaque)
+{
+    ICH9LPCState *lpc = opaque;
+
+    return !buffer_is_zero(lpc->smi_guest_features_le,
+                           sizeof lpc->smi_guest_features_le) ||
+           lpc->smi_features_ok;
+}
+
+static const VMStateDescription vmstate_ich9_smi_feat = {
+    .name = "ICH9LPC/smi_feat",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ich9_smi_feat_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(smi_guest_features_le, ICH9LPCState,
+                            sizeof(uint64_t)),
+        VMSTATE_UINT8(smi_features_ok, ICH9LPCState),
+        VMSTATE_UINT64(smi_negotiated_features, ICH9LPCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ich9_lpc = {
     .name = "ICH9LPC",
     .version_id = 1,
@@ -683,6 +761,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_ich9_rst_cnt,
+        &vmstate_ich9_smi_feat,
         NULL
     }
 };
-- 
2.9.3
