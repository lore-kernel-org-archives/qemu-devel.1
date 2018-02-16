Received: from eggs.gnu.org ([2001:4830:134:3::10]:55913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emkUS-0004ZV-6B
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emkUP-0003JR-26
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:12:08 -0500
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1emkUO-0003IX-QB
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 13:12:04 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id EFC6714F8F5
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 19:12:02 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 16 Feb 2018 19:11:50 +0100
Message-ID: <151880471076.4588.45148319107456140.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] kvm: add stubs for kvm_vcpu_id_is_valid() and
 kvm_arch_vcpu_id()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

These two functions are essentially called by code that is only
compiled when CONFIG_KVM=y, with the notable exception of the
two users in the sPAPR code:

$ git grep -E -l 'kvm_arch_vcpu_id|kvm_vcpu_id_is_valid'
accel/kvm/kvm-all.c
hw/intc/openpic_kvm.c
hw/intc/xics_kvm.c
hw/ppc/spapr.c
include/sysemu/kvm.h
target/arm/kvm.c
target/i386/kvm.c
target/mips/kvm.c
target/ppc/kvm.c
target/s390x/kvm.c

In hw/ppc/spapr.c:

    if (kvm_enabled()) {
        return kvm_arch_vcpu_id(cs);
    } else {
        return cs->cpu_index;
    }

and

        if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
            ...
        }

This code happens to compile without CONFIG_KVM=y simply because
kvm_enabled() expands to (0) and the compiler optimizes the dead
code away. Unless this was done on purpose to indicate no stubs
are required, and we'd rather break the build if calling these
from KVM agnostic code, it seems better practice to have stubs.

It doesn't really make sense to call these when kvm_enabled() is
false, since they were introduced to allow the architecture to
control VCPU ids passed to the KVM_CREATE_VCPU ioctl.

This being said, I see no reason for not giving the stub a friendly
default behaviour:
- VCPU id is cpu_index
- a VCPU id is always valid

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 accel/stubs/kvm-stub.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c964af3e1c97..d3e7d39ff9a9 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -160,4 +160,14 @@ bool kvm_arm_supports_user_irq(void)
 {
     return false;
 }
+
+bool kvm_vcpu_id_is_valid(int vcpu_id)
+{
+    return true;
+}
+
+unsigned long kvm_arch_vcpu_id(CPUState *cpu)
+{
+    return cpu->cpu_index;
+}
 #endif
