Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8h-00025x-Ed
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8b-00010T-4l
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEj8N-0000pB-Le
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:52:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAELngO4051719
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e88dch0fr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:39 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 16:52:36 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 16:52:28 -0500
In-Reply-To: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510696349-5151-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 2/3] tpm_tis: Return
 TPM_VERSION_UNSPEC in case of BE failure
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

In case the backend has a failure, such as the tpm_emulator's CMD_INIT
failing, the TIS goes into failure mode and does not respond to reads
or writes to MMIO registers. In this case we need to prevent the ACPI
table from being added and the straight-forward way is to indicate that
there's no known TPM version being used.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7402528..fec2fc6 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1008,6 +1008,10 @@ TPMVersion tpm_tis_get_tpm_version(Object *obj)
 {
     TPMState *s = TPM(obj);
 
+    if (tpm_backend_had_startup_error(s->be_driver)) {
+        return TPM_VERSION_UNSPEC;
+    }
+
     return tpm_backend_get_tpm_version(s->be_driver);
 }
 
-- 
2.5.5
