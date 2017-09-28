Received: from eggs.gnu.org ([2001:4830:134:3::10]:53402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYx-0003rX-4Q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYw-00039S-DU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYw-00039A-7L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:38 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:48 +0200
Message-Id: <20170928203708.9376-11-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/30] target/s390x: interpret PSW_MASK_WAIT
 only for TCG
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

KVM handles the wait PSW itself and triggers a WAIT ICPT in case it
really want to sleep (disabled wait).

This will later allow us to change the order of loading a restart
interrupt and setting a CPU to OPERATING on SIGP RESTART without
changing KVM behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.13.5
