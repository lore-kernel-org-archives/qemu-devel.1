Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoF-0003Hg-G8
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoC-0006RH-Tz
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:55 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cEMoC-0006Nw-QR
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:52 -0500
Received: by mail-yw0-f193.google.com with SMTP id r204so30066879ywb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:57:31 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue,  6 Dec 2016 15:56:26 -0500
Message-Id: <20161206205627.8443-3-bobby.prani@gmail.com>
In-Reply-To: <20161206205627.8443-1-bobby.prani@gmail.com>
References: <20161206205627.8443-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 2/3] tcg: Reuse hashed pc value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, mst@redhat.com, cota@braap.org

Reuse the hashed pc value instead of calculating it again.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index f4a00f5047..13cb15de0e 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -323,7 +323,8 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
        always be the same before a given translated block
        is executed. */
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)]);
+    unsigned int pc_hash = tb_jmp_cache_hash_func(pc);
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[pc_hash]);
     if (unlikely(!tb || tb->pc != pc || tb->cs_base != cs_base ||
                  tb->flags != flags)) {
         tb = tb_htable_lookup(cpu, pc, cs_base, flags);
@@ -350,7 +351,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
         }
 
         /* We add the TB in the virtual pc hash table for the fast lookup */
-        atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)], tb);
+        atomic_set(&cpu->tb_jmp_cache[pc_hash], tb);
     }
 #ifndef CONFIG_USER_ONLY
     /* We don't take care of direct jumps when address mapping changes in
-- 
2.11.0
