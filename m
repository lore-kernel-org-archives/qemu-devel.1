Received: from eggs.gnu.org ([2001:4830:134:3::10]:33941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZAAQ-00061A-PA
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZAAP-0008SR-VX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:47:18 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eZAAP-0008Py-OT
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:47:17 -0500
Received: by mail-pl0-x241.google.com with SMTP id 62so6742546pld.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 22:47:17 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Tue,  9 Jan 2018 22:47:06 -0800
Message-Id: <20180110064706.49777-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH] target/i386: hax: Move hax_setup_qemu_emulator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Tao Wu <lepton@google.com>

hax_setup_qemu_emulator reference env->efer which is updated in
hax_get_msrs, so it has to be called after hax_get_msrs. This fix
the bug that sometimes dump_state show 32 bits regs even in 64 bits
mode.

Signed-off-by: Tao Wu <lepton@google.com>
---
 target/i386/hax-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950296..a933bd462d 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -887,9 +887,6 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
             return -1;
         }
     }
-    if (!set) {
-        hax_setup_qemu_emulator(env);
-    }
     return 0;
 }
 
@@ -1070,6 +1067,7 @@ static int hax_arch_get_registers(CPUArchState *env)
         return ret;
     }
 
+    hax_setup_qemu_emulator(env);
     return 0;
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog
