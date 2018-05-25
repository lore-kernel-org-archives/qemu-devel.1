Received: from eggs.gnu.org ([2001:4830:134:3::10]:59302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB2E-0008SE-E4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB2B-0001Pm-QN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 25 May 2018 13:37:07 +0200
Message-Id: <20180525113708.29856-7-david@redhat.com>
In-Reply-To: <20180525113708.29856-1-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/7] s390x/tcg: rearm the CKC timer during
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>, david@redhat.com

If the CPU data is migrated after the TOD clock, the CKC timer of a CPU
is not rearmed. Let's rearm it when loading the CPU state.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/machine.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 84b4928755..53d226ff48 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -34,6 +34,13 @@ static int cpu_post_load(void *opaque, int version_id)
         return kvm_s390_vcpu_interrupt_post_load(cpu);
     }
 
+#ifdef CONFIG_TCG
+    if (tcg_enabled()) {
+        /* Rearm the CKC timer if necessary */
+        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
+    }
+#endif
+
     return 0;
 }
 
-- 
2.17.0
