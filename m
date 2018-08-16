Received: from eggs.gnu.org ([2001:4830:134:3::10]:59829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrewoates@gmail.com>) id 1fq6wd-0003uh-UM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrewoates@gmail.com>) id 1fq6wZ-00036A-Qs
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:19:23 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:39335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrewoates@gmail.com>)
	id 1fq6wW-00035D-04
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:19:18 -0400
Received: by mail-qt0-x235.google.com with SMTP id q12-v6so3469660qtp.6
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 18:19:14 -0700 (PDT)
Sender: Andrew Oates <andrewoates@gmail.com>
From: andrew@andrewoates.com
Date: Wed, 15 Aug 2018 21:19:03 -0400
Message-Id: <20180816011903.39816-1-andrew@andrewoates.com>
Subject: [Qemu-devel] [PATCH] target-i386: fix segment limit check in ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: Andrew Oates <aoates@google.com>

From: Andrew Oates <aoates@google.com>

The current implementation has three bugs,
 * segment limits are not enforced in protected mode if the L bit is set
   in the target segment descriptor[1]
 * segment limits are not enforced in compatability mode (ljmp to 32-bit
   code segment in long mode)
 * #GP(new_cs) is generated rather than #GP(0)

Now the segment limits are enforced if we're not in long mode OR the
target code segment doesn't have the L bit set.

[1] this is an invalid configuration (in protected mode the L bit is
reserved and should be set to zero), but qemu doesn't enforce that.

Signed-off-by: Andrew Oates <aoates@google.com>
---
The limit check is still incorrect for ljmp-through-call-gate in 64-bit
mode.  That's a larger fix I'm still working on.

 target/i386/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 00301a0c04..975365fd30 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1628,8 +1628,8 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
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
2.17.0
