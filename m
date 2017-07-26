Received: from eggs.gnu.org ([2001:4830:134:3::10]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRBE-00041t-CT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRBB-0003p3-8j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daRBA-0003oh-Vz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 26 Jul 2017 15:36:46 -0300
Message-Id: <20170726183646.14088-4-ehabkost@redhat.com>
In-Reply-To: <20170726183646.14088-1-ehabkost@redhat.com>
References: <20170726183646.14088-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] target/i386: Don't use x86_cpu_load_def()
 on "max" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

When commit 0bacd8b3046f ('i386: Don't set CPUClass::cpu_def on
"max" model') removed the CPUClass::cpu_def field, we kept using
the x86_cpu_load_def() helper directly in max_x86_cpu_initfn(),
emulating the previous behavior when CPUClass::cpu_def was set.

However, x86_cpu_load_def() is intended to help initialization of
CPU models from the builtin_x86_defs table, and does lots of
other steps that are not necessary for "max".

One of the things x86_cpu_load_def() do is to set the properties
listed at tcg_default_props/kvm_default_props.  We must not do
that on the "max" CPU model, otherwise under KVM we will
incorrectly report all KVM features as always available, and the
"svm" feature as always unavailable.  The latter caused the bug
reported at:

  https://bugzilla.redhat.com/show_bug.cgi?id=1467599
  ("Unable to start domain: the CPU is incompatible with host CPU:
  Host CPU does not provide required features: svm")

Replace x86_cpu_load_def() with simple object_property_set*()
calls.  In addition to fixing the above bug, this makes the KVM
branch in max_x86_cpu_initfn() very similar to the existing TCG
branch.

For reference, the full list of steps performed by
x86_cpu_load_def() is:

* Setting min-level and min-xlevel.  Already done by
  max_x86_cpu_initfn().
* Setting family/model/stepping/model-id.  Done by the code added
  to max_x86_cpu_initfn() in this patch.
* Copying def->features.  Wrong because "-cpu max" features need to
  be calculated at realize time.  This was not a problem in the
  current code because host_cpudef.features was all zeroes.
* x86_cpu_apply_props() calls.  This causes the bug above, and
  shouldn't be done.
* Setting CPUID_EXT_HYPERVISOR.  Not needed because it is already
  reported by x86_cpu_get_supported_feature_word(), and because
  "-cpu max" features need to be calculated at realize time.
* Setting CPU vendor to host CPU vendor if on KVM mode.
  Redundant, because max_x86_cpu_initfn() already sets it to the
  host CPU vendor.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170712162058.10538-5-ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8558c60..ddc45ab 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1644,15 +1644,21 @@ static void max_x86_cpu_initfn(Object *obj)
     cpu->max_features = true;
 
     if (kvm_enabled()) {
-        X86CPUDefinition host_cpudef = { };
-        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
+        char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
+        char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
+        int family, model, stepping;
 
-        host_vendor_fms(host_cpudef.vendor, &host_cpudef.family,
-                        &host_cpudef.model, &host_cpudef.stepping);
+        host_vendor_fms(vendor, &family, &model, &stepping);
 
-        cpu_x86_fill_model_id(host_cpudef.model_id);
+        cpu_x86_fill_model_id(model_id);
 
-        x86_cpu_load_def(cpu, &host_cpudef, &error_abort);
+        object_property_set_str(OBJECT(cpu), vendor, "vendor", &error_abort);
+        object_property_set_int(OBJECT(cpu), family, "family", &error_abort);
+        object_property_set_int(OBJECT(cpu), model, "model", &error_abort);
+        object_property_set_int(OBJECT(cpu), stepping, "stepping",
+                                &error_abort);
+        object_property_set_str(OBJECT(cpu), model_id, "model-id",
+                                &error_abort);
 
         env->cpuid_min_level =
             kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
-- 
2.9.4
