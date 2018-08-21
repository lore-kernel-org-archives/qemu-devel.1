Received: from eggs.gnu.org ([2001:4830:134:3::10]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IO-V9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4W-0006o0-45
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4V-0006NL-6r
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id v16-v6so2038087wro.11
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:07 +0200
Message-Id: <1534870966-9287-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/74] target-i386: fix segment limit check in
 ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrew Oates <aoates@google.com>

From: Andrew Oates <aoates@google.com>

The current implementation has three bugs,
 * segment limits are not enforced in protected mode if the L bit is set
   in the target segment descriptor
 * segment limits are not enforced in compatibility mode (ljmp to 32-bit
   code segment in long mode)
 * #GP(new_cs) is generated rather than #GP(0)

Now the segment limits are enforced if we're not in long mode OR the
target code segment doesn't have the L bit set.

Signed-off-by: Andrew Oates <aoates@google.com>
Message-Id: <20180816011903.39816-1-andrew@andrewoates.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index b2adddc..d1cbc6e 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1633,8 +1633,8 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         }
         limit = get_seg_limit(e1, e2);
         if (new_eip > limit &&
-            !(env->hflags & HF_LMA_MASK) && !(e2 & DESC_L_MASK)) {
-            raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
+            (!(env->hflags & HF_LMA_MASK) || !(e2 & DESC_L_MASK))) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
         }
         cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
                        get_seg_base(e1, e2), limit, e2);
-- 
1.8.3.1
