Received: from eggs.gnu.org ([2001:4830:134:3::10]:39651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dddjG-0005Pw-Fp
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddanr-0003VZ-Jr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddanr-0003U0-2E
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:30:03 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:40 +0200
Message-Id: <20170804112946.5247-4-cohuck@redhat.com>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/9] s390x: chsc nt2 events are pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The nt2 event class is pci-only - don't look for events if pci is
not in the active cpu model.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c  |  4 ++--
 hw/s390x/s390-pci-bus.h  |  4 ++--
 hw/s390x/s390-pci-stub.c |  4 ++--
 target/s390x/ioinst.c    | 16 ++++++++++++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 61cfd2138f..c57f6ebae0 100644
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
index 67af2c12ff..5df6292509 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -319,8 +319,8 @@ typedef struct S390pciState {
 } S390pciState;
 
 S390pciState *s390_get_phb(void);
-int chsc_sei_nt2_get_event(void *res);
-int chsc_sei_nt2_have_event(void);
+int pci_chsc_sei_nt2_get_event(void *res);
+int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
index 2e7e42a2af..cc7278a865 100644
--- a/hw/s390x/s390-pci-stub.c
+++ b/hw/s390x/s390-pci-stub.c
@@ -7,12 +7,12 @@
 #include "s390-pci-bus.h"
 
 /* target/s390x/ioinst.c */
-int chsc_sei_nt2_get_event(void *res)
+int pci_chsc_sei_nt2_get_event(void *res)
 {
     return 1;
 }
 
-int chsc_sei_nt2_have_event(void)
+int pci_chsc_sei_nt2_have_event(void)
 {
     return 0;
 }
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 51fbea620d..3fa3301f50 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -599,6 +599,22 @@ static int chsc_sei_nt0_have_event(void)
     return 0;
 }
 
+static int chsc_sei_nt2_get_event(void *res)
+{
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        return pci_chsc_sei_nt2_get_event(res);
+    }
+    return 1;
+}
+
+static int chsc_sei_nt2_have_event(void)
+{
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        return pci_chsc_sei_nt2_have_event();
+    }
+    return 0;
+}
+
 #define CHSC_SEI_NT0    (1ULL << 63)
 #define CHSC_SEI_NT2    (1ULL << 61)
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
-- 
2.13.3
