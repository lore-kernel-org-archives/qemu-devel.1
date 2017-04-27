Received: from eggs.gnu.org ([2001:4830:134:3::10]:56598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bqB-0000rJ-IK
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bq9-0002ZG-UR
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38742
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3bq9-0002Z9-O8
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5IbcW139678
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:36 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a3a4e0g6s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:36 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 15:19:33 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 10:48:22 +0530
In-Reply-To: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
References: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170427051824.30194-5-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 4/6] cpus: Fix CPU unplug for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Ensure that the unplugged CPU thread is destroyed and the waiting
thread is notified about it. This is needed for CPU unplug to work
correctly in MTTCG mode.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
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
2.9.3
