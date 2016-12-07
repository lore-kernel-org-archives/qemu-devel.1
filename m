Received: from eggs.gnu.org ([2001:4830:134:3::10]:42881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEeK1-0001Uh-9U
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEeJy-0007cx-6Y
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:39:53 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cEeJy-0007cW-2s
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:39:50 -0500
Received: by mail-yw0-f195.google.com with SMTP id r204so32400300ywb.3
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 07:39:49 -0800 (PST)
References: <20161206205627.8443-1-bobby.prani@gmail.com>
	<20161206205627.8443-2-bobby.prani@gmail.com>
	<87a8c8yvxh.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <87a8c8yvxh.fsf@linaro.org>
Date: Wed, 07 Dec 2016 10:38:46 -0500
Message-ID: <8760mv92bd.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tcg: Release tb_lock in the order
 acquired
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, mst@redhat.com, cota@braap.org


Hi Alex,

Alex Bennée writes:

>
> Do you have any numbers for this? The main reason being we are trying to
> avoid bouncing the lock too much and while this is cleaner it could
> cause more contention.

I did not really consider performance while cleaning this up. However, I
looked closer and I think we can remove the tb lock acquisition while adding
the jump by using atomics. I've attached the patch below. This should remove
any concern for a negative performance impact.

I will include this patch if you think it's okay.

Thanks,

diff --git a/cpu-exec.c b/cpu-exec.c
index 13cb15de0e..93debe64b6 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -365,9 +365,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     /* See if we can patch the calling TB. */
     if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         if (!tb->invalid) {
-            tb_lock();
             tb_add_jump(last_tb, tb_exit, tb);
-            tb_unlock();
         }
     }
     return tb;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 84a3240df6..60597cb07e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -336,7 +336,7 @@ static inline void tb_set_jmp_target(TranslationBlock *tb,
 static inline void tb_add_jump(TranslationBlock *tb, int n,
                                TranslationBlock *tb_next)
 {
-    if (tb->jmp_list_next[n]) {
+    if (atomic_cmpxchg(&tb->jmp_list_next[n], 0, tb_next->jmp_list_first)) {
         /* Another thread has already done this while we were
          * outside of the lock; nothing to do in this case */
         return;
@@ -351,7 +351,6 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
     tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc_ptr);
 
     /* add in TB jmp circular list */
-    tb->jmp_list_next[n] = tb_next->jmp_list_first;
     tb_next->jmp_list_first = (uintptr_t)tb | n;
 }
 

-- 
Pranith
