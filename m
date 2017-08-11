Received: from eggs.gnu.org ([2001:4830:134:3::10]:36273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4fA-0001lW-2f
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4f6-0003FK-55
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg4f5-0003FD-VO
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Aug 2017 09:46:50 +0200
Message-Id: <20170811074652.31474-4-david@redhat.com>
In-Reply-To: <20170811074652.31474-1-david@redhat.com>
References: <20170811074652.31474-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/5] s390x: avoid calling kvm_ functions
 outside of target/s390x/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Let's just introduce an helper.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +---
 target/s390x/cpu.c         | 6 ++++++
 target/s390x/cpu.h         | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1c7af39..ac087ab 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -142,9 +142,7 @@ static void ccw_init(MachineState *machine)
     /* register hypercalls */
     virtio_ccw_register_hcalls();
 
-    if (kvm_enabled()) {
-        kvm_s390_enable_css_support(s390_cpu_addr2state(0));
-    }
+    s390_enable_css_support(s390_cpu_addr2state(0));
     /*
      * Non mcss-e enabled guests only see the devices from the default
      * css, which is determined by the value of the squash_mcss property.
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 81165e8..c834bfb 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -472,6 +472,12 @@ bool s390_get_squash_mcss(void)
 
     return false;
 }
+void s390_enable_css_support(S390CPU *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_s390_enable_css_support(cpu);
+    }
+}
 #endif
 
 static gchar *s390_gdb_arch_name(CPUState *cs)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a9acef6..87dea80 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -404,6 +404,7 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo,
 
 #ifndef CONFIG_USER_ONLY
 
+void s390_enable_css_support(S390CPU *cpu);
 int s390_virtio_hypercall(CPUS390XState *env);
 
 #ifdef CONFIG_KVM
-- 
2.9.4
