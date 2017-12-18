Received: from eggs.gnu.org ([2001:4830:134:3::10]:36386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQw5W-0001fu-UW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQw5U-0002UI-8b
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:08:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57308
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQw5U-0002Tm-39
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:08:12 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIE6DPn028695
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:08:08 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exc279cr5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:08:08 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 07:08:07 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 09:07:58 -0500
Message-Id: <1513606078-728-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tpm: Fix linker error when using --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, thuth@redhat.com
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Commit 493b7830 extends core/qdev-properties-system.c with a property
to lookup a TPM backend, which calls into TPM related functions.
Unfortunately this breaks the build when --disable-tpm is used. To
fix this we extend stubs/tpm.c with the missing stub functions.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 stubs/tpm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/stubs/tpm.c b/stubs/tpm.c
index c18aac1..bb1db44 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -6,6 +6,7 @@
  */
 #include "qemu/osdep.h"
 #include "sysemu/tpm.h"
+#include "sysemu/tpm_backend.h"
 #include "qmp-commands.h"
 
 int tpm_init(void)
@@ -31,3 +32,18 @@ TpmModelList *qmp_query_tpm_models(Error **errp)
 {
     return NULL;
 }
+
+void tpm_backend_reset(TPMBackend *s)
+{
+    return;
+}
+
+int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp)
+{
+    return 0;
+}
+
+TPMBackend *qemu_find_tpm_be(const char *id)
+{
+    return NULL;
+}
\ No newline at end of file
-- 
2.5.5
