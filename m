Received: from eggs.gnu.org ([209.51.188.92]:57628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISz4-0006fG-7e
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISz2-0005Dx-PY
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hISz0-0005B8-AY
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M6rn2k112768
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:15 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s12t428pt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:15 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:03:14 +0100
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2019 12:33:07 +0530
In-Reply-To: <155591636364.20338.844048953355207313.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155591658718.20338.10108476276907741991.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v8 2/6] Wrapper function to wait on condition
 for the main loop mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com

Introduce a wrapper function to wait on condition for
the main loop mutex. This function atomically releases
the main loop mutex and causes the calling thread to
block on the condition. This wrapper is required because
qemu_global_mutex is a static variable.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 cpus.c                   |    5 +++++
 include/qemu/main-loop.h |    8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/cpus.c b/cpus.c
index e83f72b..d9379e7 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1858,6 +1858,11 @@ void qemu_mutex_unlock_iothread(void)
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
index f6ba78e..a6d20b0 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line);
  */
 void qemu_mutex_unlock_iothread(void);
 
+/*
+ * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
+ *
+ * This function atomically releases the main loop mutex and causes
+ * the calling thread to block on the condition.
+ */
+void qemu_cond_wait_iothread(QemuCond *cond);
+
 /* internal interfaces */
 
 void qemu_fd_register(int fd);
