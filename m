Received: from eggs.gnu.org ([2001:4830:134:3::10]:52032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6V-0002Bf-JF
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG6P-0003bB-M0
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG6P-0003aq-G9
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:44:37 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 09:44:28 -0500
Message-Id: <20180201144430.14441-5-pbonzini@redhat.com>
In-Reply-To: <20180201144430.14441-1-pbonzini@redhat.com>
References: <20180201144430.14441-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] cpus: tcg: unregister thread with RCU,
 fix exiting of loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzc@zju.edu.cn

Keep running until cpu_can_run(cpu) becomes false, for consistency
with other acceslerators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index 34c86192d1..9f48ccad9e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1468,6 +1468,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
         deal_with_unplugged_cpus();
     }
 
+    rcu_unregister_thread();
     return NULL;
 }
 
@@ -1644,18 +1645,17 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 /* Ignore everything else? */
                 break;
             }
-        } else if (cpu->unplug) {
-            qemu_tcg_destroy_vcpu(cpu);
-            cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
-            qemu_mutex_unlock_iothread();
-            return NULL;
         }
 
         atomic_mb_set(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
-    }
+    } while (!cpu->unplug || cpu_can_run(cpu));
 
+    qemu_tcg_destroy_vcpu(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
2.14.3
