Received: from eggs.gnu.org ([2001:4830:134:3::10]:55008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCX69-0000R4-7M
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCX64-0004uI-Ay
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:37:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCX64-0004tc-2P
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:37:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8Ka2wJ107046
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 15:37:09 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e48abtf33-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 15:37:09 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 13:37:08 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 15:37:01 -0500
Message-Id: <1510173421-19895-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] tpm_emulator: Add a caching layer for the
 TPM Established flag
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
index 9aaec8e..507e2cb 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -71,6 +71,9 @@ typedef struct TPMEmulator {
     ptm_cap caps; /* capabilities of the TPM */
     uint8_t cur_locty_number; /* last set locality */
     Error *migration_blocker;
+
+    unsigned int established_flag:1;
+    unsigned int established_flag_cached:1;
 } TPMEmulator;
 
 
@@ -277,16 +280,22 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_est est;
 
-    DPRINTF("%s", __func__);
+    if (tpm_emu->established_flag_cached) {
+        return tpm_emu->established_flag;
+    }
+
     if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLISHED, &est,
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
@@ -317,6 +326,8 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
         return -1;
     }
 
+    tpm_emu->established_flag_cached = 0;
+
     return 0;
 }
 
-- 
2.5.5
