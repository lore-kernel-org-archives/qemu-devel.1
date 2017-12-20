Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyB-0004TR-9I
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyA-000796-8H
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:51 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyA-00078i-1J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:50 -0500
Received: by mail-wr0-x242.google.com with SMTP id l19so10549638wrc.2
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:26 +0100
Message-Id: <1513790098-9815-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/46] target/i386: Fix compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>

From: Stefan Weil <sw@weilnetz.de>

These gcc warnings are fixed:

target/i386/translate.c:4461:12: warning:
 variable 'prefixes' might be clobbered by 'longjmp' or 'vfork' [-Wclobbered]
target/i386/translate.c:4466:9: warning:
 variable 'rex_w' might be clobbered by 'longjmp' or 'vfork' [-Wclobbered]
target/i386/translate.c:4466:16: warning:
 variable 'rex_r' might be clobbered by 'longjmp' or 'vfork' [-Wclobbered]

Tested with x86_64-w64-mingw32-gcc from Debian stretch.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20171113064845.29142-1-sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 088a9d9..f410938 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4467,10 +4467,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     target_ulong pc_start = s->base.pc_next;
 
     s->pc_start = s->pc = pc_start;
-    prefixes = 0;
     s->override = -1;
-    rex_w = -1;
-    rex_r = 0;
 #ifdef TARGET_X86_64
     s->rex_x = 0;
     s->rex_b = 0;
@@ -4484,6 +4481,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         return s->pc;
     }
 
+    prefixes = 0;
+    rex_w = -1;
+    rex_r = 0;
+
  next_byte:
     b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
-- 
1.8.3.1
