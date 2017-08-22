Received: from eggs.gnu.org ([2001:4830:134:3::10]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkApZ-00004v-NJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkApY-0004JZ-95
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:11:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkApY-0004J4-0F
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:11:00 -0400
Date: Tue, 22 Aug 2017 17:10:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822171055.5e6ae861.cohuck@redhat.com>
In-Reply-To: <b072b275-b15f-50ee-1282-0df47fa0473c@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
	<17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
	<20170822103955.1cbc0714.cohuck@redhat.com>
	<b7e7810c-7822-2fb8-2a2e-d67c08126639@linux.vnet.ibm.com>
	<20170822113914.3ff24d75.cohuck@redhat.com>
	<ff247730-9d10-352c-b6dc-8d98198181cf@linux.vnet.ibm.com>
	<20170822152434.068b5038.cohuck@redhat.com>
	<4a85cfd0-7b36-175c-4671-f8dbc10f4d9e@linux.vnet.ibm.com>
	<20170822161553.03faaab4.cohuck@redhat.com>
	<b072b275-b15f-50ee-1282-0df47fa0473c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 22 Aug 2017 16:34:48 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> I think we are in agreement. Looking forward to v2.

FWIW, here's what I currently have. I'll test a bit before sending the
next version.

=46rom 45e143bd820fe9c2f4e31dcc9feb5ad324d00077 Mon Sep 17 00:00:00 2001
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 6 Jul 2017 17:13:14 +0200
Subject: [PATCH] s390x/sclp: properly guard pci-specific functions

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

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c  | 14 ++------------
 hw/s390x/s390-pci-bus.h  |  8 --------
 hw/s390x/s390-pci-stub.c |  2 ++
 hw/s390x/sclp.c          | 39 ++++++++++++++++++++++++++++++++++-----
 include/hw/s390x/sclp.h  | 17 +++++++++++++----
 5 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index c57f6ebae0..0a31a4ae88 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -122,16 +122,11 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciSta=
te *s, uint32_t fid)
=20
 void s390_pci_sclp_configure(SCCB *sccb)
 {
-    PciCfgSccb *psccb =3D (PciCfgSccb *)sccb;
+    IoaCfgSccb *psccb =3D (IoaCfgSccb *)sccb;
     S390PCIBusDevice *pbdev =3D s390_pci_find_dev_by_fid(s390_get_phb(),
                                                        be32_to_cpu(psccb->=
aid));
     uint16_t rc;
=20
-    if (be16_to_cpu(sccb->h.length) < 16) {
-        rc =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
-        goto out;
-    }
-
     if (!pbdev) {
         DPRINTF("sclp config no dev found\n");
         rc =3D SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
@@ -155,16 +150,11 @@ out:
=20
 void s390_pci_sclp_deconfigure(SCCB *sccb)
 {
-    PciCfgSccb *psccb =3D (PciCfgSccb *)sccb;
+    IoaCfgSccb *psccb =3D (IoaCfgSccb *)sccb;
     S390PCIBusDevice *pbdev =3D s390_pci_find_dev_by_fid(s390_get_phb(),
                                                        be32_to_cpu(psccb->=
aid));
     uint16_t rc;
=20
-    if (be16_to_cpu(sccb->h.length) < 16) {
-        rc =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
-        goto out;
-    }
-
     if (!pbdev) {
         DPRINTF("sclp deconfig no dev found\n");
         rc =3D SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 5df6292509..bd636abc28 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -244,14 +244,6 @@ typedef struct ChscSeiNt2Res {
     uint8_t ccdf[4016];
 } QEMU_PACKED ChscSeiNt2Res;
=20
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
diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
index cc7278a865..7a642d376c 100644
--- a/hw/s390x/s390-pci-stub.c
+++ b/hw/s390x/s390-pci-stub.c
@@ -20,10 +20,12 @@ int pci_chsc_sei_nt2_have_event(void)
 /* hw/s390x/sclp.c */
 void s390_pci_sclp_configure(SCCB *sccb)
 {
+    sccb->h.response_code =3D cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNI=
ZED);
 }
=20
 void s390_pci_sclp_deconfigure(SCCB *sccb)
 {
+    sccb->h.response_code =3D cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNI=
ZED);
 }
=20
 /* target/s390x/kvm.c */
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9253dbbc64..7ae6a0e37a 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -80,7 +80,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     prepare_cpu_entries(sclp, read_info->entries, cpu_count);
=20
     read_info->facilities =3D cpu_to_be64(SCLP_HAS_CPU_INFO |
-                                        SCLP_HAS_PCI_RECONFIG);
+                                        SCLP_HAS_IOA_RECONFIG);
=20
     /* Memory Hotplug is only supported for the ccw machine type */
     if (mhd) {
@@ -354,6 +354,35 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB =
*sccb)
     sccb->h.response_code =3D cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
 }
=20
+static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
+                                      bool configure)
+{
+    int rc;
+
+    if (be16_to_cpu(sccb->h.length) < 16) {
+        rc =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
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
+        rc =3D SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED;
+    }
+
+ out_err:
+    sccb->h.response_code =3D cpu_to_be16(rc);
+}
+
 static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
 {
     SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
@@ -384,11 +413,11 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb=
, uint32_t code)
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
index e71d526605..a72d096081 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -44,10 +44,10 @@
 #define SCLP_CMDW_DECONFIGURE_CPU               0x00100001
=20
 /* SCLP PCI codes */
-#define SCLP_HAS_PCI_RECONFIG                   0x0000000040000000ULL
-#define SCLP_CMDW_CONFIGURE_PCI                 0x001a0001
-#define SCLP_CMDW_DECONFIGURE_PCI               0x001b0001
-#define SCLP_RECONFIG_PCI_ATPYE                 2
+#define SCLP_HAS_IOA_RECONFIG                   0x0000000040000000ULL
+#define SCLP_CMDW_CONFIGURE_IOA                 0x001a0001
+#define SCLP_CMDW_DECONFIGURE_IOA               0x001b0001
+#define SCLP_RECONFIG_PCI_ATYPE                 2
=20
 /* SCLP response codes */
 #define SCLP_RC_NORMAL_READ_COMPLETION          0x0010
@@ -59,6 +59,7 @@
 #define SCLP_RC_INSUFFICIENT_SCCB_LENGTH        0x0300
 #define SCLP_RC_STANDBY_READ_COMPLETION         0x0410
 #define SCLP_RC_ADAPTER_IN_RESERVED_STATE       0x05f0
+#define SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED     0x06f0
 #define SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED       0x09f0
 #define SCLP_RC_INVALID_FUNCTION                0x40f0
 #define SCLP_RC_NO_EVENT_BUFFERS_STORED         0x60f0
@@ -167,6 +168,14 @@ typedef struct AssignStorage {
     uint16_t rn;
 } QEMU_PACKED AssignStorage;
=20
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
--=20
2.13.5
