Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH16-00073B-Bd
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH15-0000YC-Az
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diH15-0000XZ-5H
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2017 11:22:23 +0200
Message-Id: <20170817092225.4264-9-david@redhat.com>
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 08/10] s390x: avoid calling kvm_
 functions outside of target/s390x/
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +---
 target/s390x/cpu.c         | 7 +++++++
 target/s390x/cpu.h         | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

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
index 43c274d..0aeab06 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -471,6 +471,13 @@ bool s390_get_squash_mcss(void)
 
     return false;
 }
+
+void s390_enable_css_support(S390CPU *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_s390_enable_css_support(cpu);
+    }
+}
 #endif
 
 static gchar *s390_gdb_arch_name(CPUState *cs)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4318eb7..74d5b35 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -404,6 +404,7 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo,
 
 #ifndef CONFIG_USER_ONLY
 
+void s390_enable_css_support(S390CPU *cpu);
 int s390_virtio_hypercall(CPUS390XState *env);
 
 #ifdef CONFIG_KVM
-- 
2.9.4
