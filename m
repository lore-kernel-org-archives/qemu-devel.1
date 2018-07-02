Received: from eggs.gnu.org ([2001:4830:134:3::10]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fa27j-0005ZT-Qp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fa27f-0002Av-Qd
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:56:23 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:39969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fa27f-00029S-J2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:56:19 -0400
Received: from player696.ha.ovh.net (unknown [10.109.108.102])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id C5D541AB1B
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 18:56:17 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 02 Jul 2018 18:56:06 +0200
Message-ID: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] i386: fix '-cpu ?' output for host cpu type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Since commit d6dcc5583e7, '-cpu ?' shows the description of the
X86_CPU_TYPE_NAME("max") for the host CPU model:

Enables all features supported by the accelerator in the current host

instead of the expected:

KVM processor with all supported host features

or

HVF processor with all supported host features

This is caused by the early use of kvm_enabled() and hvf_enabled() in
a class_init function. Since the accelerator isn't configured yet, both
helpers return false unconditionally.

A QEMU binary will only be compiled with one of these accelerators, not
both. The appropriate description can thus be decided at build time.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/i386/cpu.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e6a7d0a7504..e5da60b28973 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2838,13 +2838,13 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
     xcc->host_cpuid_required = true;
     xcc->ordering = 8;
 
-    if (kvm_enabled()) {
-        xcc->model_description =
-            "KVM processor with all supported host features ";
-    } else if (hvf_enabled()) {
-        xcc->model_description =
-            "HVF processor with all supported host features ";
-    }
+#if defined(CONFIG_KVM)
+    xcc->model_description =
+        "KVM processor with all supported host features ";
+#elif defined(CONFIG_HVF)
+    xcc->model_description =
+        "HVF processor with all supported host features ";
+#endif
 }
 
 static const TypeInfo host_x86_cpu_type_info = {
