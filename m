Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssG-0005qQ-BW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssF-0000iD-9o
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fKssF-0000hl-1k
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 21 May 2018 19:01:32 -0300
Message-Id: <20180521220133.17445-3-ehabkost@redhat.com>
In-Reply-To: <20180521220133.17445-1-ehabkost@redhat.com>
References: <20180521220133.17445-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] i386: Define the Virt SSBD MSR and handling
 of it (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

"Some AMD processors only support a non-architectural means of enabling
speculative store bypass disable (SSBD).  To allow a simplified view of
this to a guest, an architectural definition has been created through a n=
ew
CPUID bit, 0x80000008_EBX[25], and a new MSR, 0xc001011f.  With this, a
hypervisor can virtualize the existence of this definition and provide an
architectural method for using SSBD to a guest.

Add the new CPUID feature, the new MSR and update the existing SSBD
support to use this MSR when present." (from x86/speculation: Add virtual=
ized
speculative store bypass disable support in Linux).

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180521215424.13520-4-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h     |  2 ++
 target/i386/kvm.c     | 16 ++++++++++++++--
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f0b68905de..8ac13f6c2c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -351,6 +351,7 @@ typedef enum X86Seg {
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
+#define MSR_VIRT_SSBD                   0xc001011f
 #define MSR_IA32_TSCDEADLINE            0x6e0
=20
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -1210,6 +1211,7 @@ typedef struct CPUX86State {
     uint32_t pkru;
=20
     uint64_t spec_ctrl;
+    uint64_t virt_ssbd;
=20
     /* End of state preserved by INIT (dummy marker).  */
     struct {} end_init_save;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d6666a4b19..0c656a91a4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -93,6 +93,7 @@ static bool has_msr_hv_frequencies;
 static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
 static bool has_msr_spec_ctrl;
+static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
=20
 static uint32_t has_architectural_pmu_version;
@@ -1233,6 +1234,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case MSR_IA32_SPEC_CTRL:
                     has_msr_spec_ctrl =3D true;
                     break;
+                case MSR_VIRT_SSBD:
+                    has_msr_virt_ssbd =3D true;
+                    break;
                 }
             }
         }
@@ -1721,6 +1725,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
     }
+    if (has_msr_virt_ssbd) {
+        kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
+    }
+
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
         kvm_msr_entry_add(cpu, MSR_CSTAR, env->cstar);
@@ -2100,8 +2108,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
     }
-
-
+    if (has_msr_virt_ssbd) {
+        kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, 0);
+    }
     if (!env->tsc_valid) {
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
         env->tsc_valid =3D !runstate_is_running();
@@ -2481,6 +2490,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_SPEC_CTRL:
             env->spec_ctrl =3D msrs[i].data;
             break;
+        case MSR_VIRT_SSBD:
+            env->virt_ssbd =3D msrs[i].data;
+            break;
         case MSR_IA32_RTIT_CTL:
             env->msr_rtit_ctrl =3D msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index fd99c0bbb4..4d98d367c1 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -916,6 +916,25 @@ static const VMStateDescription vmstate_msr_intel_pt=
 =3D {
     }
 };
=20
+static bool virt_ssbd_needed(void *opaque)
+{
+    X86CPU *cpu =3D opaque;
+    CPUX86State *env =3D &cpu->env;
+
+    return env->virt_ssbd !=3D 0;
+}
+
+static const VMStateDescription vmstate_msr_virt_ssbd =3D {
+    .name =3D "cpu/virt_ssbd",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D virt_ssbd_needed,
+    .fields =3D (VMStateField[]){
+        VMSTATE_UINT64(env.virt_ssbd, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu =3D {
     .name =3D "cpu",
     .version_id =3D 12,
@@ -1039,6 +1058,7 @@ VMStateDescription vmstate_x86_cpu =3D {
         &vmstate_spec_ctrl,
         &vmstate_mcg_ext_ctl,
         &vmstate_msr_intel_pt,
+        &vmstate_msr_virt_ssbd,
         NULL
     }
 };
--=20
2.14.3
