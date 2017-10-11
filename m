Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhP-0003Td-LB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhK-0003dU-PO
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60622
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2OhK-0003d7-KK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BLYYU0094282
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:46 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dhs4adrft-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:46 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 17:37:45 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 17:37:29 -0400
In-Reply-To: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507757851-12580-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/4] tpm: Introduce condition to notify
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
We will use the signalling to wait for command completion before VM
suspend.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_int.h |  3 +++
 hw/tpm/tpm_tis.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index f2f285b..b766b3d 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -30,6 +30,9 @@ struct TPMState {
     char *backend;
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
+
+    QemuMutex state_lock;
+    QemuCond cmd_complete;
 };
 
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 9bf0bce..b9b9a2f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -367,6 +367,8 @@ static void tpm_tis_receive_bh(void *opaque)
     TPMTISEmuState *tis = &s->s.tis;
     uint8_t locty = s->locty_number;
 
+    qemu_mutex_lock(&s->state_lock);
+
     tpm_tis_sts_set(&tis->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
     tis->loc[locty].state = TPM_TIS_STATE_COMPLETION;
@@ -385,6 +387,10 @@ static void tpm_tis_receive_bh(void *opaque)
     tpm_tis_raise_irq(s, locty,
                       TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID);
 #endif
+
+    /* notify of completed command */
+    qemu_cond_signal(&s->cmd_complete);
+    qemu_mutex_unlock(&s->state_lock);
 }
 
 /*
@@ -404,6 +410,11 @@ static void tpm_tis_receive_cb(TPMState *s, uint8_t locty,
         }
     }
 
+    qemu_mutex_lock(&s->state_lock);
+    /* notify of completed command */
+    qemu_cond_signal(&s->cmd_complete);
+    qemu_mutex_unlock(&s->state_lock);
+
     qemu_bh_schedule(tis->bh);
 }
 
@@ -1083,6 +1094,9 @@ static void tpm_tis_initfn(Object *obj)
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
