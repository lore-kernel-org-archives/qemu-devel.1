Received: from eggs.gnu.org ([2001:4830:134:3::10]:46472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuNf-00014V-1V
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dhuNc-0004Ey-QP
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dhuNc-0004En-IO
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:12:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7G99MDv024767
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:12:47 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ccepgkw1w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 05:12:47 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 16 Aug 2017 03:12:46 -0600
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 14:42:30 +0530
In-Reply-To: <150287457293.9760.17827532208744487789.stgit@aravinda>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150287475076.9760.5351022965446694044.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v3 3/5] Wrapper function to wait on condition
 for the main loop mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com

Introduce a wrapper function to wait on condition for
the main loop mutex. This function atomically releases
the main loop mutex and causes the calling thread to
block on the condition.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 cpus.c                   |    5 +++++
 include/qemu/main-loop.h |    8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/cpus.c b/cpus.c
index 9bed61e..9712013 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1589,6 +1589,11 @@ void qemu_mutex_unlock_iothread(void)
     qemu_mutex_unlock(&qemu_global_mutex);
 }
 
+void qemu_cond_wait_iothread(QemuCond *cond)
+{
+    qemu_cond_wait(cond, &qemu_global_mutex);
+}
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 6b4b60b..618cb2f 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -279,6 +279,14 @@ void qemu_mutex_lock_iothread(void);
  */
 void qemu_mutex_unlock_iothread(void);
 
+/**
+ * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
+ *
+ * This function atomically releases the main loop mutex and causes
+ * the calling thread to block on the condition.
+ */
+void qemu_cond_wait_iothread(QemuCond *cond);
+
 /* internal interfaces */
 
 void qemu_fd_register(int fd);
