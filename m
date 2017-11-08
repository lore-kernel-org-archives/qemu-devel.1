Received: from eggs.gnu.org ([2001:4830:134:3::10]:46396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCWIs-0007jW-EP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCWIj-0004Qk-FR
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:46:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCWIj-0004PH-6C
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:46:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8JiGK7082524
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 14:46:09 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e45b82meu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:46:08 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 14:46:07 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 14:45:56 -0500
Message-Id: <1510170356-16953-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tpm: Add a caching layer for the TPM
 Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Add a caching layer for the TPM established flag so that we don't
need to go to the backend every time the flag is read by accessing
the REG_ACCESS register.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7402528..6b81bbf 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -95,6 +95,9 @@ struct TPMState {
     char *backend;
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
+
+    unsigned int established_flag:1;
+    unsigned int established_flag_cached:1;
 };
 
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -529,6 +532,26 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
 }
 #endif
 
+static void tpm_tis_reset_tpm_established_flag(TPMState *s,
+                                               uint8_t locty)
+{
+    s->established_flag_cached = 0;
+
+    tpm_backend_reset_tpm_established_flag(s->be_driver, locty);
+}
+
+static unsigned int tpm_tis_get_tpm_established_flag(TPMState *s)
+{
+    if (s->established_flag_cached) {
+        return s->established_flag;
+    }
+
+    s->established_flag = !tpm_backend_get_tpm_established_flag(s->be_driver);
+    s->established_flag_cached = 1;
+
+    return s->established_flag;
+}
+
 /*
  * Read a register of the TIS interface
  * See specs pages 33-63 for description of the registers
@@ -556,7 +579,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
         if (tpm_tis_check_request_use_except(s, locty)) {
             val |= TPM_TIS_ACCESS_PENDING_REQUEST;
         }
-        val |= !tpm_backend_get_tpm_established_flag(s->be_driver);
+        val |= tpm_tis_get_tpm_established_flag(s);
         break;
     case TPM_TIS_REG_INT_ENABLE:
         val = s->loc[locty].inte;
@@ -840,7 +863,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
 
             if (val & TPM_TIS_STS_RESET_ESTABLISHMENT_BIT) {
                 if (locty == 3 || locty == 4) {
-                    tpm_backend_reset_tpm_established_flag(s->be_driver, locty);
+                    tpm_tis_reset_tpm_established_flag(s, locty);
                 }
             }
         }
-- 
2.5.5
