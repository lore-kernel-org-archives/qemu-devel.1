Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difht-0002Zt-TP
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhs-0007So-N9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhs-0007SZ-Gj
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:51 +0200
Message-Id: <20170818114353.13455-17-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.11 16/18] s390x: avoid calling kvm_
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
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Let's just introduce an helper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +---
 target/s390x/cpu.c         | 7 +++++++
 target/s390x/cpu.h         | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f19fab5..ce0c4bb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -142,9 +142,7 @@ static void ccw_init(MachineState *machine)
     /* register hypercalls */
     virtio_ccw_register_hcalls();
=20
-    if (kvm_enabled()) {
-        kvm_s390_enable_css_support(s390_cpu_addr2state(0));
-    }
+    s390_enable_css_support(s390_cpu_addr2state(0));
     /*
      * Non mcss-e enabled guests only see the devices from the default
      * css, which is determined by the value of the squash_mcss property=
.
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 90e2db7..c538a95 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -471,6 +471,13 @@ bool s390_get_squash_mcss(void)
=20
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
=20
 static gchar *s390_gdb_arch_name(CPUState *cs)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a2cefb7..77b2977 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -404,6 +404,7 @@ int cpu_s390x_signal_handler(int host_signum, void *p=
info,
=20
 #ifndef CONFIG_USER_ONLY
=20
+void s390_enable_css_support(S390CPU *cpu);
 int s390_virtio_hypercall(CPUS390XState *env);
=20
 #ifdef CONFIG_KVM
--=20
2.9.4
