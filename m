Received: from eggs.gnu.org ([2001:4830:134:3::10]:59305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB2E-0008Sa-LJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB2D-0001QS-Q4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 25 May 2018 13:37:08 +0200
Message-Id: <20180525113708.29856-8-david@redhat.com>
In-Reply-To: <20180525113708.29856-1-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/7] s390x/tcg: fix CPU hotplug with
 single-threaded TCG
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

run_on_cpu() doesn't seem to work reliably until the CPU has been fully
created if the single-threaded TCG main loop is already running.

Therefore, let's use run_on_cpu() for KVM only - KVM requires it due to
the initial CPU reset ioctl.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e4d7e82a23..5fceed7948 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -220,11 +220,12 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     s390_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
-#if !defined(CONFIG_USER_ONLY)
-    run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
-#else
-    cpu_reset(cs);
-#endif
+
+    if (kvm_enabled()) {
+        run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+    } else {
+        cpu_reset(cs);
+    }
 
     scc->parent_realize(dev, &err);
 out:
-- 
2.17.0
