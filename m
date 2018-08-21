Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002SW-4T
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4p-0007F4-Cf
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4p-0007D1-4P
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id g33-v6so6432702wrd.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:19 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.04.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:04:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:42 +0200
Message-Id: <1534870966-9287-71-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 70/74] KVM: cleanup unnecessary #ifdef
 KVM_CAP_...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The capability macros are always defined, since they come from kernel
headers that are copied into the QEMU tree.  Remove the unnecessary #ifdefs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 2 --
 target/i386/kvm.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 38f468d..de12f78 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1639,10 +1639,8 @@ static int kvm_init(MachineState *ms)
         s->irq_set_ioctl = KVM_IRQ_LINE_STATUS;
     }
 
-#ifdef KVM_CAP_READONLY_MEM
     kvm_readonly_mem_allowed =
         (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
-#endif
 
     kvm_eventfds_allowed =
         (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9313602..0b2a07d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1381,17 +1381,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     int ret;
     struct utsname utsname;
 
-#ifdef KVM_CAP_XSAVE
     has_xsave = kvm_check_extension(s, KVM_CAP_XSAVE);
-#endif
-
-#ifdef KVM_CAP_XCRS
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
-#endif
-
-#ifdef KVM_CAP_PIT_STATE2
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
-#endif
 
     hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
 
-- 
1.8.3.1
