Received: from eggs.gnu.org ([2001:4830:134:3::10]:57382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD7Uk-0002WP-Fe
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD7Uf-0005SC-Gj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD7Ue-0005P8-JT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61E08653C7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 12:33:34 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD40537A7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 12:33:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 14:33:32 +0200
Message-Id: <20181018123332.23518-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target-i386: kvm: do not initialize padding
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The exception.pad field is going to be renamed to pending in an upcoming header
file update.  Remove the unnecessary initialization.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-x86/kvm.h | 5 +----
 target/i386/kvm.c           | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 7a7acf9e47..dabfcf7c39 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -300,10 +300,7 @@ struct kvm_vcpu_events {
 		__u8 injected;
 		__u8 nr;
 		__u8 has_error_code;
-               union {
-       		__u8 pad;
-       		__u8 pending;
-               }
+		__u8 pending;
 		__u32 error_code;
 	} exception;
 	struct {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6e5f951f4f..74193b1b9d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2696,7 +2696,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.exception.nr = env->exception_injected;
     events.exception.has_error_code = env->has_error_code;
     events.exception.error_code = env->error_code;
-    events.exception.pad = 0;
 
     events.interrupt.injected = (env->interrupt_injected >= 0);
     events.interrupt.nr = env->interrupt_injected;
@@ -2705,7 +2704,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.nmi.injected = env->nmi_injected;
     events.nmi.pending = env->nmi_pending;
     events.nmi.masked = !!(env->hflags2 & HF2_NMI_MASK);
-    events.nmi.pad = 0;
 
     events.sipi_vector = env->sipi_vector;
     events.flags = 0;
-- 
2.17.1
