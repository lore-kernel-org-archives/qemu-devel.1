Received: from eggs.gnu.org ([2001:4830:134:3::10]:55509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBsEa-0005NY-1q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBsEW-0003pZ-RP
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:59:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42918
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBsEW-0003pD-M4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:59:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA70sDDd019429
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 19:59:10 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e306j6pch-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:59:10 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 19:59:09 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  6 Nov 2017 19:58:56 -0500
In-Reply-To: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510016336-4086-6-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/5] tpm: tpm_passthrough: Fail startup if FE
 buffer size < BE buffer size
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
index ec755fe..66d5098 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -304,6 +304,20 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
     return TPM_BACKEND(obj);
 }
 
+static int tpm_passthrough_startup_tpm(TPMBackend *tb, uint32_t buffersize)
+{
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
+
+    if (buffersize && buffersize < tpm_pt->tpm_buffersize) {
+        error_report("Requested buffer size of %u is smaller than host TPM's "
+                     "fixed buffer size of %u",
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
