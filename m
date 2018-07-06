Received: from eggs.gnu.org ([2001:4830:134:3::10]:51051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK4-0001D6-7n
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK2-0000lo-Lb
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:08 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUK2-0000lZ-DK
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:06 -0400
Received: by mail-wm0-x244.google.com with SMTP id v3-v6so11526944wmh.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:24 +0200
Message-Id: <1530897268-22932-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] i386: fix '-cpu ?' output for host cpu type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

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
Message-Id: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b0b87c3..e0e2f2e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2836,13 +2836,13 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
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
-- 
1.8.3.1
