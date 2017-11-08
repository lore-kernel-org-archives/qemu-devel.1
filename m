Received: from eggs.gnu.org ([2001:4830:134:3::10]:36815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVcG-0000g5-KE
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVcA-0000UV-QJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCVcA-0000TI-Hv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:18 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8J25ZD116573
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 14:02:15 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e45t6pfsw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:02:14 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 12:02:13 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 14:01:59 -0500
In-Reply-To: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510167719-4357-6-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/5] tpm: tpm_passthrough: Fail startup if
 FE buffer size < BE buffer size
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

If the requested buffer size of the frontend is smaller than the fixed
buffer size of the host's TPM, fail the startup_tpm() interface function,
which will make the device unusable. We fail it because the backend TPM
could produce larger packets than what the frontend could pass to the OS.

The current combination of TIS frontend and either passthrough or emulator
backend will not lead to this case since the TIS can support any size of
buffer.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 886af9e..487aae2 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -304,6 +304,20 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
     return TPM_BACKEND(obj);
 }
 
+static int tpm_passthrough_startup_tpm(TPMBackend *tb, size_t buffersize)
+{
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
+
+    if (buffersize && buffersize < tpm_pt->tpm_buffersize) {
+        error_report("Requested buffer size of %zu is smaller than host TPM's "
+                     "fixed buffer size of %zu",
+                     buffersize, tpm_pt->tpm_buffersize);
+        return -1;
+    }
+
+    return 0;
+}
+
 static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
 {
     TpmTypeOptions *options = g_new0(TpmTypeOptions, 1);
@@ -362,6 +376,7 @@ static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
     tbc->opts = tpm_passthrough_cmdline_opts;
     tbc->desc = "Passthrough TPM backend driver";
     tbc->create = tpm_passthrough_create;
+    tbc->startup_tpm = tpm_passthrough_startup_tpm;
     tbc->reset = tpm_passthrough_reset;
     tbc->cancel_cmd = tpm_passthrough_cancel_cmd;
     tbc->get_tpm_established_flag = tpm_passthrough_get_tpm_established_flag;
-- 
2.5.5
