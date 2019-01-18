Received: from eggs.gnu.org ([209.51.188.92]:57475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUol-00077e-0D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUok-0002a4-6G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45364
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUok-0002Yf-0t
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDwjGr034566
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:17 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q3e5k5b4q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:16 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:16 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:54 -0200
In-Reply-To: <20190118140758.829-1-farosas@linux.ibm.com>
References: <20190118140758.829-1-farosas@linux.ibm.com>
Message-Id: <20190118140758.829-4-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 3/7] kvm: support checking for single
 step capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com, aik@ozlabs.ru

For single stepping (via KVM) of a guest vcpu to work, KVM needs not
only to support the SET_GUEST_DEBUG ioctl but to also recognize the
KVM_GUESTDBG_SINGLESTEP bit in the control field of the
kvm_guest_debug struct.

This patch adds support for querying the single step capability so
that QEMU can decide what to do for the platforms that do not have
such support.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 accel/kvm/kvm-all.c  | 7 +++++++
 include/sysemu/kvm.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4e1de942ce..0dc7a32883 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2264,6 +2264,13 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
+/* Whether the KVM_SET_GUEST_DEBUG ioctl supports single stepping */
+int kvm_has_guestdbg_singlestep(void)
+{
+    /* return kvm_check_extension(kvm_state, KVM_CAP_GUEST_DEBUG_SSTEP); */
+    return 0;
+}
+
 #ifdef KVM_CAP_SET_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
                                                  target_ulong pc)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..ca2bbff053 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -214,6 +214,7 @@ int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 int kvm_has_intx_set_mask(void);
+int kvm_has_guestdbg_singlestep(void);
 
 int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
-- 
2.17.1
