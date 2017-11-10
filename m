Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2Y-0003t1-37
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2T-0004oG-5R
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2S-0004lm-P1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:09 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEAAd5068995
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:03 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5atk8tta-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:03 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:02 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:41 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 02/13] tpm_tis: limit size of buffer from
 backend
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

This is a preparatory patch for the subsequent ones where we
get rid of the flexibility of supporting any kind of buffer size
that the backend may support. We keep the size at 4096, which is
also the size the external emulator supports. So, limit the size
of the buffer we can support and pass it back to the backend.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 69fe531..90c6df2 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1008,7 +1008,8 @@ static void tpm_tis_reset(DeviceState *dev)
     int c;
 
     s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
-    s->be_buffer_size = tpm_backend_get_buffer_size(s->be_driver);
+    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
+                            TPM_TIS_BUFFER_MAX);
 
     tpm_backend_reset(s->be_driver);
 
@@ -1040,7 +1041,7 @@ static void tpm_tis_reset(DeviceState *dev)
         tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
 
-    tpm_tis_do_startup_tpm(s, 0);
+    tpm_tis_do_startup_tpm(s, s->be_buffer_size);
 }
 
 static const VMStateDescription vmstate_tpm_tis = {
-- 
2.5.5
