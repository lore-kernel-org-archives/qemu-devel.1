Received: from eggs.gnu.org ([2001:4830:134:3::10]:49306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvZBZ-0000Qf-9H
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvZBW-0002FQ-84
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:52:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:54964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvZBV-0002Eu-E9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:52:30 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 5 Apr 2017 00:52:25 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A4E842@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH]Enable kvmvapic only when host doesn't support
 VAPIC capability in KVM mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Stefan Hajnoczi' <stefanha@gmail.com>

In KVM mode, enable kvmvapic only when host doesn't support=20
VAPIC capability.

Save the time to set up kvmvapic in some hosts.


Signed-off -by: Anthony Xu <anthony.xu@intel.com>


diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index c3829e3..d5c53af 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -317,8 +317,11 @@ static void apic_common_realize(DeviceState *dev, Erro=
r **errp)
     info =3D APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
=20
-    /* Note: We need at least 1M to map the VAPIC option ROM */
+    /* Note: We need at least 1M to map the VAPIC option ROM,
+       if it is KVM, enable kvmvapic only when KVM doesn't have=20
+       VAPIC capability                */=20
     if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
+        (!kvm_enabled() || (kvm_enabled() && !kvm_has_vapic())) &&
         !hax_enabled() && ram_size >=3D 1024 * 1024) {
         vapic =3D sysbus_create_simple("kvmvapic", -1, NULL);
     }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 24281fc..43e0e4c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -215,6 +215,7 @@ extern KVMState *kvm_state;
=20
 bool kvm_has_free_slot(MachineState *ms);
 int kvm_has_sync_mmu(void);
+int kvm_has_vapic(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..edcb6ea 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2232,6 +2232,10 @@ int kvm_has_sync_mmu(void)
     return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
 }
=20
+int kvm_has_vapic(void){
+    return !kvm_check_extension(kvm_state, KVM_CAP_VAPIC);
+}
+
 int kvm_has_vcpu_events(void)
 {
     return kvm_state->vcpu_events;
