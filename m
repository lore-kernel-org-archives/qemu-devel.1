Received: from eggs.gnu.org ([2001:4830:134:3::10]:47803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZMPj-0003Os-B6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZMPi-0001n0-HW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:55 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eZMPi-0001m4-7w
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:54 -0500
Received: by mail-pg0-x242.google.com with SMTP id m17so206498pgd.8
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 11:51:54 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Wed, 10 Jan 2018 11:50:56 -0800
Message-Id: <20180110195056.85403-3-lepton@google.com>
In-Reply-To: <20180110195056.85403-1-lepton@google.com>
References: <20180110064706.49777-1-lepton@google.com>
	<20180110195056.85403-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH v2 3/3] target/i386: hax: Move
 x86_update_hflags.
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

x86_update_hflags reference env->efer which is updated in hax_get_msrs,
so it has to be called after hax_get_msrs. This fix the bug that sometimes
dump_state show 32 bits regs even in 64 bits mode.

Signed-off-by: Tao Wu <lepton@google.com>
---
 target/i386/hax-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index dc379373f7..5a4a5025b9 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -838,9 +838,6 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
             return -1;
         }
     }
-    if (!set) {
-        x86_update_hflags(env);
-    }
     return 0;
 }
 
@@ -1021,6 +1018,7 @@ static int hax_arch_get_registers(CPUArchState *env)
         return ret;
     }
 
+    x86_update_hflags(env);
     return 0;
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog
