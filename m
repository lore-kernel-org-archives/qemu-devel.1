Received: from eggs.gnu.org ([2001:4830:134:3::10]:50598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS4J-0003I6-K8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS4D-0004xV-RB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:27 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS4D-0004x6-Kb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:21 -0500
Received: by mail-wr0-x243.google.com with SMTP id 16so15332905wry.12
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:17:13 +0100
Message-Id: <1516112253-14480-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/51] target/i386: hax: Move x86_update_hflags.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>

From: Tao Wu <lepton@google.com>

x86_update_hflags reference env->efer which is updated in hax_get_msrs,
so it has to be called after hax_get_msrs. This fix the bug that sometimes
dump_state show 32 bits regs even in 64 bits mode.

Signed-off-by: Tao Wu <lepton@google.com>
Message-Id: <20180110195056.85403-3-lepton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 07df73e..934ec4a 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -837,9 +837,6 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
             return -1;
         }
     }
-    if (!set) {
-        x86_update_hflags(env);
-    }
     return 0;
 }
 
@@ -1020,6 +1017,7 @@ static int hax_arch_get_registers(CPUArchState *env)
         return ret;
     }
 
+    x86_update_hflags(env);
     return 0;
 }
 
-- 
1.8.3.1
