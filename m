Received: from eggs.gnu.org ([2001:4830:134:3::10]:40011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Dec-0002eW-Ck
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8DeX-0003vL-VI
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e8DeX-0003tR-Mn
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RN0l6B019360
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:57 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv9sej1tt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:56 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:02:54 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 19:02:35 -0400
In-Reply-To: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1509145361-11218-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/7] tpm: Introduce condition to notify
 waiters of completed command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Introduce a lock and a condition to notify anyone waiting for the completion
of the execution of a TPM command by the backend (thread). The backend
uses the condition to signal anyone waiting for command completion.
We need to place the condition in two locations: one is invoked by the
backend thread, the other by the bottom half thread.
We will use the signaling to wait for command completion before VM
suspend.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 9a94051..90dca4e 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -90,6 +90,9 @@ typedef struct TPMState {
     char *backend;
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
+
+    QemuMutex state_lock;
+    QemuCond cmd_complete;
 } TPMState;
 
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -421,6 +424,8 @@ static void tpm_tis_request_completed(TPMIf *ti)
         }
     }
 
+    qemu_mutex_lock(&s->state_lock);
+
     tpm_tis_sts_set(&s->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
@@ -435,6 +440,10 @@ static void tpm_tis_request_completed(TPMIf *ti)
 
     tpm_tis_raise_irq(s, locty,
                       TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID);
+
+    /* notify of completed command */
+    qemu_cond_signal(&s->cmd_complete);
+    qemu_mutex_unlock(&s->state_lock);
 }
 
 /*
@@ -1088,6 +1097,9 @@ static void tpm_tis_initfn(Object *obj)
     memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
                           TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
+
+    qemu_mutex_init(&s->state_lock);
+    qemu_cond_init(&s->cmd_complete);
 }
 
 static void tpm_tis_class_init(ObjectClass *klass, void *data)
-- 
2.5.5
