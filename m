Received: from eggs.gnu.org ([2001:4830:134:3::10]:57057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVa2c-0001rt-85
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVa2Z-0001y1-FZ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:42 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Jun 2018 12:08:25 +0200
Message-Id: <20180620100825.22476-8-david@redhat.com>
In-Reply-To: <20180620100825.22476-1-david@redhat.com>
References: <20180620100825.22476-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] s390x/tcg: fix CPU hotplug with
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

Therefore, let's use run_on_cpu() for KVM only - KVM requires it due to
the initial CPU reset ioctl.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 40d6980229..7536dd0f03 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -218,11 +218,12 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
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
2.17.1
