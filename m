Received: from eggs.gnu.org ([2001:4830:134:3::10]:58644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtP-0002X1-8p
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtL-00035o-Di
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:44 +0200
Message-Id: <20171020115418.2050-13-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 12/46] target/s390x: interpret PSW_MASK_WAIT
 only for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

KVM handles the wait PSW itself and triggers a WAIT ICPT in case it
really wants to sleep (disabled wait).

This will later allow us to change the order of loading a restart
interrupt and setting a CPU to OPERATING on SIGP RESTART without
changing KVM behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-11-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 2d7df83c59..baa18777f1 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -147,7 +147,8 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
         s390_cpu_recompute_watchpoints(CPU(s390_env_get_cpu(env)));
     }
 
-    if (mask & PSW_MASK_WAIT) {
+    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
+    if (tcg_enabled() && (mask & PSW_MASK_WAIT)) {
         s390_handle_wait(s390_env_get_cpu(env));
     }
 }
-- 
2.13.6
