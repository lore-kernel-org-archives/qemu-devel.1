Received: from eggs.gnu.org ([2001:4830:134:3::10]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lck-0002Pm-Rd
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lck-0007mJ-8I
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:00:58 +1000
Message-Id: <20170510070115.13063-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/22] cpus: Fix CPU unplug for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Ensure that the unplugged CPU thread is destroyed and the waiting
thread is notified about it. This is needed for CPU unplug to work
correctly in MTTCG mode.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
