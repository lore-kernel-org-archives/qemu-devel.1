Received: from eggs.gnu.org ([2001:4830:134:3::10]:48366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyY-0007bl-9H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyV-0006Xu-Cc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyV-0006Wr-1r
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id 61-v6so35110496wrb.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:00 +0200
Message-Id: <1539894735-14232-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/48] hyperv: make hyperv_vp_index inline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Also make the inverse function, hyperv_find_vcpu, static as it's not
used outside hyperv.c

This paves the way to making hyperv.c built optionally.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082041.29380-3-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hyperv.c | 11 ++++-------
 target/i386/hyperv.h |  6 ++++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index fc537e7..6881664 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -27,14 +27,11 @@ struct HvSintRoute {
     unsigned refcount;
 };
 
-uint32_t hyperv_vp_index(X86CPU *cpu)
+static X86CPU *hyperv_find_vcpu(uint32_t vp_index)
 {
-    return CPU(cpu)->cpu_index;
-}
-
-X86CPU *hyperv_find_vcpu(uint32_t vp_index)
-{
-    return X86_CPU(qemu_get_cpu(vp_index));
+    X86CPU *cpu = X86_CPU(qemu_get_cpu(vp_index));
+    assert(hyperv_vp_index(cpu) == vp_index);
+    return cpu;
 }
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 59e9f9a..8d4619c 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -30,7 +30,9 @@ void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
 int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
 
-uint32_t hyperv_vp_index(X86CPU *cpu);
-X86CPU *hyperv_find_vcpu(uint32_t vp_index);
+static inline uint32_t hyperv_vp_index(X86CPU *cpu)
+{
+    return CPU(cpu)->cpu_index;
+}
 
 #endif
-- 
1.8.3.1
