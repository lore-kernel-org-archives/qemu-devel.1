Received: from eggs.gnu.org ([2001:4830:134:3::10]:48020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyF-0007H5-EI
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy8-0006Dg-SS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:56234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy7-00067j-VJ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id 206-v6so1556464wmb.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:25 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	a12-v6sm14270952wrr.71.2018.10.18.13.32.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 13:32:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:33 +0200
Message-Id: <1539894735-14232-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/48] target-i386: kvm: do not initialize
 padding fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The exception.pad field is going to be renamed to pending in an upcoming
header file update.  Remove the unnecessary initialization; it was
introduced to please valgrind (commit 7e680753cfa2) but they were later
rendered unnecessary by commit 076796f8fd27f4d, which added the "= {}"
initializer to the declaration of "events".  Therefore the patch does
not change behavior in any way.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dc4047b..302f420 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2686,7 +2686,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.exception.nr = env->exception_injected;
     events.exception.has_error_code = env->has_error_code;
     events.exception.error_code = env->error_code;
-    events.exception.pad = 0;
 
     events.interrupt.injected = (env->interrupt_injected >= 0);
     events.interrupt.nr = env->interrupt_injected;
@@ -2695,7 +2694,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.nmi.injected = env->nmi_injected;
     events.nmi.pending = env->nmi_pending;
     events.nmi.masked = !!(env->hflags2 & HF2_NMI_MASK);
-    events.nmi.pad = 0;
 
     events.sipi_vector = env->sipi_vector;
     events.flags = 0;
-- 
1.8.3.1
