Received: from eggs.gnu.org ([2001:4830:134:3::10]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ2-0007hA-D9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ1-0005jZ-CQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:00 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ1-0005if-50
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:59 -0500
Received: by mail-wr0-x242.google.com with SMTP id e41so4698068wre.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:57 +0100
Message-Id: <1515756676-3860-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/52] target/i386: hax: Move x86_update_hflags.
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
