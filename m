Received: from eggs.gnu.org ([2001:4830:134:3::10]:36736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGu-0008Gq-El
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGt-0005q1-BZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSGt-0005pa-55
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  7 Jul 2017 14:21:54 +0200
Message-Id: <20170707122159.24714-3-cohuck@redhat.com>
In-Reply-To: <20170707122159.24714-1-cohuck@redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/7] s390x: chsc nt2 events are pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The nt2 event class is pci-only and therefore implemented in
the s390x pci code. Properly stub it out for non-pci builds.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c |  4 ++--
 hw/s390x/s390-pci-bus.h |  4 ++--
 target/s390x/ioinst.c   | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5651483781..eee9a04eac 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -47,7 +47,7 @@ S390pciState *s390_get_phb(void)
     return phb;
 }
 
-int chsc_sei_nt2_get_event(void *res)
+int pci_chsc_sei_nt2_get_event(void *res)
 {
     ChscSeiNt2Res *nt2_res = (ChscSeiNt2Res *)res;
     PciCcdfAvail *accdf;
@@ -87,7 +87,7 @@ int chsc_sei_nt2_get_event(void *res)
     return rc;
 }
 
-int chsc_sei_nt2_have_event(void)
+int pci_chsc_sei_nt2_have_event(void)
 {
     S390pciState *s = s390_get_phb();
 
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index cf142a3e68..29d3da10f6 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -318,8 +318,8 @@ typedef struct S390pciState {
 } S390pciState;
 
 S390pciState *s390_get_phb(void);
-int chsc_sei_nt2_get_event(void *res);
-int chsc_sei_nt2_have_event(void);
+int pci_chsc_sei_nt2_get_event(void *res);
+int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index d5e6b8066b..a552f53167 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -599,6 +599,24 @@ static int chsc_sei_nt0_have_event(void)
     return 0;
 }
 
+static int chsc_sei_nt2_get_event(void *res)
+{
+#ifdef CONFIG_PCI
+    return pci_chsc_sei_nt2_get_event(res);
+#else
+    return 1;
+#endif
+}
+
+static int chsc_sei_nt2_have_event(void)
+{
+#ifdef CONFIG_PCI
+    return pci_chsc_sei_nt2_have_event();
+#else
+    return 0;
+#endif
+}
+
 #define CHSC_SEI_NT0    (1ULL << 63)
 #define CHSC_SEI_NT2    (1ULL << 61)
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
-- 
2.13.0
