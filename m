Received: from eggs.gnu.org ([2001:4830:134:3::10]:39210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDMdu-00078u-PD
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 22:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDMdp-0007Ax-UM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 22:39:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51154
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDMdp-0007AY-Pt
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 22:39:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAB3dSSm026395
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 22:39:29 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e5ppkx2td-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 22:39:28 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 20:39:22 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 22:39:13 -0500
In-Reply-To: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510371554-29833-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] tpm_tis: Return TPM_VERSION_UNSPEC in case
 of BE failure
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
index c0a0204..eca3374 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -970,6 +970,10 @@ static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
 {
     TPMState *s = TPM(ti);
 
+    if (tpm_backend_had_startup_error(s->be_driver)) {
+        return TPM_VERSION_UNSPEC;
+    }
+
     return tpm_backend_get_tpm_version(s->be_driver);
 }
 
-- 
2.5.5
