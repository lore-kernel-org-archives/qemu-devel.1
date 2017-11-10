Received: from eggs.gnu.org ([2001:4830:134:3::10]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2g-0003yo-SI
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2c-00058J-Bq
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39338
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2c-00056q-6D
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAE9rld064218
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:14 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e59xau85x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:14 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:13 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:48 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-10-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 09/13] tpm: Introduce condition to notify
 waiters of completed command
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
index 035c6ef..86e9a92 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -80,6 +80,9 @@ typedef struct TPMState {
     TPMVersion be_tpm_version;
 
     size_t be_buffer_size;
+
+    QemuMutex state_lock;
+    QemuCond cmd_complete;
 } TPMState;
 
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -405,6 +408,8 @@ static void tpm_tis_request_completed(TPMIf *ti)
         }
     }
 
+    qemu_mutex_lock(&s->state_lock);
+
     tpm_tis_sts_set(&s->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
@@ -419,6 +424,10 @@ static void tpm_tis_request_completed(TPMIf *ti)
 
     tpm_tis_raise_irq(s, locty,
                       TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID);
+
+    /* notify of completed command */
+    qemu_cond_signal(&s->cmd_complete);
+    qemu_mutex_unlock(&s->state_lock);
 }
 
 /*
@@ -1046,6 +1055,9 @@ static void tpm_tis_initfn(Object *obj)
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
