Received: from eggs.gnu.org ([2001:4830:134:3::10]:57095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6G2-0002P5-Dz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6G1-0005Qm-9B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6G0-0005QV-Vp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:25 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:27 +0200
Message-Id: <20170830165252.13421-20-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 19/44] s390x/sclp: properly guard pci-specific
 functions
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

If we do not provide zpci, pci reconfiguration via sclp is not available
either. I/O adapter configuration, however, should always be present.

Rename the values that refer to I/O adapter configuration (instead of only
pci) to make things clearer.

Move length checking of the sccb for I/O adapter configuration into the
common sclp code (out of the pci code). This also fixes an issue that
the pci code would refer to a field in the sccb before checking whether
it was actually long enough.

Check for the adapter type in the sccb and return unrecognized adapter
type if the guest tries to issue I/O adapter configure/deconfigure for
a type other than pci or for pci if the zpci facility is not provided.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 14 ++------------
 hw/s390x/s390-pci-bus.h |  8 --------
 hw/s390x/sclp.c         | 39 ++++++++++++++++++++++++++++++++++-----
 include/hw/s390x/sclp.h | 16 ++++++++++++----
 4 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index c57f6ebae0..0a31a4ae88 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -122,16 +122,11 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid)
 
 void s390_pci_sclp_configure(SCCB *sccb)
 {
-    PciCfgSccb *psccb = (PciCfgSccb *)sccb;
+    IoaCfgSccb *psccb = (IoaCfgSccb *)sccb;
     S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(s390_get_phb(),
                                                        be32_to_cpu(psccb->aid));
     uint16_t rc;
 
-    if (be16_to_cpu(sccb->h.length) < 16) {
-        rc = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
-        goto out;
-    }
-
     if (!pbdev) {
         DPRINTF("sclp config no dev found\n");
         rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
@@ -155,16 +150,11 @@ out:
 
 void s390_pci_sclp_deconfigure(SCCB *sccb)
 {
-    PciCfgSccb *psccb = (PciCfgSccb *)sccb;
+    IoaCfgSccb *psccb = (IoaCfgSccb *)sccb;
     S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(s390_get_phb(),
                                                        be32_to_cpu(psccb->aid));
     uint16_t rc;
 
-    if (be16_to_cpu(sccb->h.length) < 16) {
-        rc = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
-        goto out;
-    }
-
     if (!pbdev) {
         DPRINTF("sclp deconfig no dev found\n");
         rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 5df6292509..bd636abc28 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -244,14 +244,6 @@ typedef struct ChscSeiNt2Res {
     uint8_t ccdf[4016];
 } QEMU_PACKED ChscSeiNt2Res;
 
-typedef struct PciCfgSccb {
-    SCCBHeader header;
-    uint8_t atype;
-    uint8_t reserved1;
-    uint16_t reserved2;
-    uint32_t aid;
-} QEMU_PACKED PciCfgSccb;
-
 typedef struct S390MsixInfo {
     bool available;
     uint8_t table_bar;
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9253dbbc64..7ae6a0e37a 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -80,7 +80,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     prepare_cpu_entries(sclp, read_info->entries, cpu_count);
 
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
-                                        SCLP_HAS_PCI_RECONFIG);
+                                        SCLP_HAS_IOA_RECONFIG);
 
     /* Memory Hotplug is only supported for the ccw machine type */
     if (mhd) {
@@ -354,6 +354,35 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
 }
 
+static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
+                                      bool configure)
+{
+    int rc;
+
+    if (be16_to_cpu(sccb->h.length) < 16) {
+        rc = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
+        goto out_err;
+    }
+
+    switch (((IoaCfgSccb *)sccb)->atype) {
+    case SCLP_RECONFIG_PCI_ATYPE:
+        if (s390_has_feat(S390_FEAT_ZPCI)) {
+            if (configure) {
+                s390_pci_sclp_configure(sccb);
+            } else {
+                s390_pci_sclp_deconfigure(sccb);
+            }
+            return;
+        }
+        /* fallthrough */
+    default:
+        rc = SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED;
+    }
+
+ out_err:
+    sccb->h.response_code = cpu_to_be16(rc);
+}
+
 static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
 {
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
@@ -384,11 +413,11 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
     case SCLP_UNASSIGN_STORAGE:
         sclp_c->unassign_storage(sclp, sccb);
         break;
-    case SCLP_CMDW_CONFIGURE_PCI:
-        s390_pci_sclp_configure(sccb);
+    case SCLP_CMDW_CONFIGURE_IOA:
+        sclp_configure_io_adapter(sclp, sccb, true);
         break;
-    case SCLP_CMDW_DECONFIGURE_PCI:
-        s390_pci_sclp_deconfigure(sccb);
+    case SCLP_CMDW_DECONFIGURE_IOA:
+        sclp_configure_io_adapter(sclp, sccb, false);
         break;
     default:
         efc->command_handler(ef, sccb, code);
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index fe54442ecd..a72d096081 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -44,10 +44,10 @@
 #define SCLP_CMDW_DECONFIGURE_CPU               0x00100001
 
 /* SCLP PCI codes */
-#define SCLP_HAS_PCI_RECONFIG                   0x0000000040000000ULL
-#define SCLP_CMDW_CONFIGURE_PCI                 0x001a0001
-#define SCLP_CMDW_DECONFIGURE_PCI               0x001b0001
-#define SCLP_RECONFIG_PCI_ATPYE                 2
+#define SCLP_HAS_IOA_RECONFIG                   0x0000000040000000ULL
+#define SCLP_CMDW_CONFIGURE_IOA                 0x001a0001
+#define SCLP_CMDW_DECONFIGURE_IOA               0x001b0001
+#define SCLP_RECONFIG_PCI_ATYPE                 2
 
 /* SCLP response codes */
 #define SCLP_RC_NORMAL_READ_COMPLETION          0x0010
@@ -168,6 +168,14 @@ typedef struct AssignStorage {
     uint16_t rn;
 } QEMU_PACKED AssignStorage;
 
+typedef struct IoaCfgSccb {
+    SCCBHeader header;
+    uint8_t atype;
+    uint8_t reserved1;
+    uint16_t reserved2;
+    uint32_t aid;
+} QEMU_PACKED IoaCfgSccb;
+
 typedef struct SCCB {
     SCCBHeader h;
     char data[SCCB_DATA_LEN];
-- 
2.13.5
