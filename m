Received: from eggs.gnu.org ([2001:4830:134:3::10]:34062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAkG-0006Q7-Su
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAkF-0005QB-NX
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:28 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Jun 2018 15:44:10 +0200
Message-Id: <20180627134410.4901-10-david@redhat.com>
In-Reply-To: <20180627134410.4901-1-david@redhat.com>
References: <20180627134410.4901-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 9/9] s390x/tcg: fix CPU hotplug with
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

run_on_cpu() doesn't seem to work reliably until the CPU has been fully
created if the single-threaded TCG main loop is already running.

Therefore, hotplugging a CPU under single-threaded TCG does currently
not work. We should use the direct call instead of going via
run_on_cpu().

So let's use run_on_cpu() for KVM only - KVM requires it due to the initial
CPU reset ioctl. As a nice side effect, we get rid of the ifdef.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 40d6980229..271c5ce652 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -218,11 +218,18 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     s390_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
-#if !defined(CONFIG_USER_ONLY)
-    run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
-#else
-    cpu_reset(cs);
-#endif
+
+    /*
+     * KVM requires the initial CPU reset ioctl to be executed on the target
+     * CPU thread. CPU hotplug under single-threaded TCG will not work with
+     * run_on_cpu(), as run_on_cpu() will not work properly if called while
+     * the main thread is already running but the CPU hasn't been realized.
+     */
+    if (kvm_enabled()) {
+        run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+    } else {
+        cpu_reset(cs);
+    }
 
     scc->parent_realize(dev, &err);
 out:
-- 
2.17.1
