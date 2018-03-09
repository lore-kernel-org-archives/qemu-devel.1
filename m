Received: from eggs.gnu.org ([2001:4830:134:3::10]:47260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5Y-0008E6-Ud
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5V-0003oa-OX
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1euI5V-0003nz-K3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Mar 2018 14:29:19 +0100
Message-Id: <20180309132922.24211-2-pbonzini@redhat.com>
In-Reply-To: <20180309132922.24211-1-pbonzini@redhat.com>
References: <20180309132922.24211-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] rcutorture: remove synchronize_rcu from
 readers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

This gives much worse numbers for readers, especially if synchronize_rcu
is made more expensive as is the case with --enable-membarrier.  Before:

   $ tests/rcutorture 10 stress 10
   n_reads: 98304  n_updates: 529  n_mberror: 0
   rcu_stress_count: 98302 2 0 0 0 0 0 0 0 0 0

After:

   $ tests/rcutorture 10 stress 10
   n_reads: 165158482  n_updates: 429  n_mberror: 0
   rcu_stress_count: 165154364 4118 0 0 0 0 0 0 0 0 0

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/rcutorture.c | 4 ----
 1 file changed, 4 deletion(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 4002ecf123..2a7201549a 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -238,7 +238,6 @@ long long rcu_stress_count[RCU_STRESS_PIPE_LEN + 1];
 static void *rcu_read_stress_test(void *arg)
 {
     int i;
-    int itercnt = 0;
     struct rcu_stress *p;
     int pc;
     long long n_reads_local = 0;
@@ -269,9 +269,6 @@ static void *rcu_read_stress_test(void *arg)
         }
         rcu_stress_local[pc]++;
         n_reads_local++;
-        if ((++itercnt % 0x1000) == 0) {
-            synchronize_rcu();
-        }
     }
     qemu_mutex_lock(&counts_mutex);
     n_reads += n_reads_local;
-- 
2.14.3
