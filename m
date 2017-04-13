Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyZY2-0003E0-8U
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyZXy-0004bq-DI
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:52:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cyZXy-0004ac-4Y
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:52:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3D7nUhV052896
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 03:52:02 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29t0e0a5c9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 03:52:02 -0400
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 13 Apr 2017 13:21:59 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 13:21:46 +0530
Message-Id: <1492069906-11300-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] cpus: Fix CPU unplug for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com, nikunj@linux.vnet.ibm.com, alex.bennee@linaro.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

Ensure that the unplugged CPU thread is destroyed and the waiting
thread is notified about it. This is needed for CPU unplug to work
correctly in MTTCG mode.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 cpus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cpus.c b/cpus.c
index 740b8dc..79f780b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1483,6 +1483,12 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 /* Ignore everything else? */
                 break;
             }
+        } else if (cpu->unplug) {
+            qemu_tcg_destroy_vcpu(cpu);
+            cpu->created = false;
+            qemu_cond_signal(&qemu_cpu_cond);
+            qemu_mutex_unlock_iothread();
+            return NULL;
         }
 
         atomic_mb_set(&cpu->exit_request, 0);
-- 
2.7.4
