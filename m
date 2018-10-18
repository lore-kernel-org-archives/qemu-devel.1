Received: from eggs.gnu.org ([2001:4830:134:3::10]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyx-0008LJ-WA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyo-0006oR-Cw
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyk-0006iJ-GW
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id 193-v6so1615628wme.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:14 +0200
Message-Id: <1539894735-14232-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/48] target/i386: kvm: just return after
 migrate_add_blocker failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

When migrate_add_blocker failed, the invtsc_mig_blocker is not
appended so no need to remove. This can save several instructions.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20181006091816.7659-1-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7b7a565..115d8b4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1198,7 +1198,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             if (local_err) {
                 error_report_err(local_err);
                 error_free(invtsc_mig_blocker);
-                goto fail;
+                return r;
             }
             /* for savevm */
             vmstate_x86_cpu.unmigratable = 1;
-- 
1.8.3.1
