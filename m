Received: from eggs.gnu.org ([2001:4830:134:3::10]:42044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYY-000497-Ss
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYU-0001ll-0c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aYT-0001lL-OK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:44 -0300
Message-Id: <20171006215244.27104-8-ehabkost@redhat.com>
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] target/i386: Enable kvm_pv_unhalt by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>

Original description of a patch by Alexander Graf that did
something similar:

  Commit f010bc643a (target-i386: add feature kvm_pv_unhalt) introduced the
  kvm_pv_unhalt feature but didn't enable it by default.

  Without kvm_pv_unhalt we see a measurable degradation in scheduling
  performance, so enabling it by default does make sense IMHO. This patch
  just flips it to default to on by default.

    [With kvm_pv_unhalt disabled]
    $ perf bench sched messaging -l 10000
      Total time: 8.573 [sec]

    [With kvm_pv_unhalt enabled]
    $ perf bench sched messaging -l 10000
      Total time: 4.416 [sec]

This patch does the same as that patch, but using a
kvm_auto_enable_pv_unhalt flag to keep compatibility on older
machine-types.

kvm_pv_unhalt support was added to Linux on v3.12 (Linux commit
6aef266c6e17b798a1740cf70cd34f90664740b3), so update the system
requirements section in qemu-doc.texi accordingly.

Suggested-by: Alexander Graf <agraf@suse.de>
Cc: Alexander Graf <agraf@suse.de>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 4 ++++
 target/i386/cpu.h    | 3 +++
 target/i386/cpu.c    | 7 +++++++
 qemu-doc.texi        | 2 +-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d2742dd0bc..19b42de224 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -375,6 +375,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "x-hv-max-vps",\
         .value    = "0x40",\
+    },{\
+        .driver = TYPE_X86_CPU,\
+        .property = "x-kvm-auto-enable-pv-unhalt",\
+        .value = "off",\
     },
 
 #define PC_COMPAT_2_9 \
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e5bf86921..db1eecff00 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1276,6 +1276,9 @@ struct X86CPU {
     /* KVM automatically enables kvm-pv-eoi if not explicitly disabled by user */
     bool kvm_auto_enable_pv_eoi;
 
+    /* KVM automatically enables kvm-pv-unhalt if not explicitly disabled */
+    bool kvm_auto_enable_pv_unhalt;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2160738a37..7461c2a25e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3515,6 +3515,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_expand_feature(cpu, FEAT_KVM, (1 << KVM_FEATURE_PV_EOI),
                                    (1 << KVM_FEATURE_PV_EOI));
         }
+
+        if (cpu->kvm_auto_enable_pv_unhalt) {
+            x86_cpu_expand_feature(cpu, FEAT_KVM, (1 << KVM_FEATURE_PV_UNHALT),
+                                   (1 << KVM_FEATURE_PV_UNHALT));
+        }
     }
 
     /*TODO: Now cpu->max_features doesn't overwrite features
@@ -4164,6 +4169,8 @@ static Property x86_cpu_properties[] = {
                      X86CPU, kvm_auto_enable_x2apic, true),
     DEFINE_PROP_BOOL("x-kvm-auto-enable-pv-eoi",
                      X86CPU, kvm_auto_enable_pv_eoi, true),
+    DEFINE_PROP_BOOL("x-kvm-auto-enable-pv-unhalt",
+                     X86CPU, kvm_auto_enable_pv_unhalt, true),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index be45b6b6f6..73c831383a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2355,7 +2355,7 @@ Run the emulation in single step mode.
 @section KVM kernel module
 
 On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
-require the host to be running Linux v3.6 or newer.
+require the host to be running Linux v3.12 or newer.
 
 
 @include qemu-tech.texi
-- 
2.13.6
