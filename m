Received: from eggs.gnu.org ([2001:4830:134:3::10]:33806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8e-00024g-K4
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8b-00010P-5S
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40750
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEj8J-0000lZ-AH
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:52:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAELnhcX057514
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:35 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e87fw3cmq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:34 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 16:52:34 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 16:52:27 -0500
In-Reply-To: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510696349-5151-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 1/3] tpm_emulator: Add a caching
 layer for the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, amarnath.valluri@intel.com
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Add a caching layer for the TPM established flag so that we don't
need to go to the emulator every time the flag is read by accessing
the REG_ACCESS register.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

v1->v2:
 - move the caching to the backend layer since detecting the
   TPM 1.2 TSC_ResetEstablishmentBit() command is easier to do
   here.
---
 hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index e1a6810..b293db7 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -73,6 +73,9 @@ typedef struct TPMEmulator {
     Error *migration_blocker;
 
     QemuMutex mutex;
+
+    unsigned int established_flag:1;
+    unsigned int established_flag_cached:1;
 } TPMEmulator;
 
 
@@ -287,16 +290,22 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_est est;
 
-    DPRINTF("%s", __func__);
+    if (tpm_emu->established_flag_cached) {
+        return tpm_emu->established_flag;
+    }
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
                              0, sizeof(est)) < 0) {
         error_report("tpm-emulator: Could not get the TPM established flag: %s",
                      strerror(errno));
         return false;
     }
-    DPRINTF("established flag: %0x", est.u.resp.bit);
+    DPRINTF("got established flag: %0x", est.u.resp.bit);
+
+    tpm_emu->established_flag_cached = 1;
+    tpm_emu->established_flag = (est.u.resp.bit != 0);
 
-    return (est.u.resp.bit != 0);
+    return tpm_emu->established_flag;
 }
 
 static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
@@ -327,6 +336,8 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
         return -1;
     }
 
+    tpm_emu->established_flag_cached = 0;
+
     return 0;
 }
 
-- 
2.5.5
