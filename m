Received: from eggs.gnu.org ([2001:4830:134:3::10]:58998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoF-0003Hh-GQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoC-0006R5-Cp
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:55 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cEMoC-0006Ns-8u
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:52 -0500
Received: by mail-yw0-f193.google.com with SMTP id b66so29935695ywh.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:57:30 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue,  6 Dec 2016 15:56:25 -0500
Message-Id: <20161206205627.8443-2-bobby.prani@gmail.com>
In-Reply-To: <20161206205627.8443-1-bobby.prani@gmail.com>
References: <20161206205627.8443-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 1/3] tcg: Release tb_lock in the order
 acquired
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

We acquire mmap lock and tb lock in one order and release them in a
different order. This does not need to be that way.

This patch was inspired by a previous patch by Emilio G. Cota
(https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03785.html).

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index aa8318d864..f4a00f5047 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -318,7 +318,6 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
-    bool have_tb_lock = false;
 
     /* we record a subset of the CPU state. It will
        always be the same before a given translated block
@@ -336,7 +335,6 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
              */
             mmap_lock();
             tb_lock();
-            have_tb_lock = true;
 
             /* There's a chance that our desired tb has been translated while
              * taking the locks so we check again inside the lock.
@@ -347,6 +345,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
                 tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
             }
 
+            tb_unlock();
             mmap_unlock();
         }
 
@@ -364,17 +363,12 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
 #endif
     /* See if we can patch the calling TB. */
     if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        if (!have_tb_lock) {
-            tb_lock();
-            have_tb_lock = true;
-        }
         if (!tb->invalid) {
+            tb_lock();
             tb_add_jump(last_tb, tb_exit, tb);
+            tb_unlock();
         }
     }
-    if (have_tb_lock) {
-        tb_unlock();
-    }
     return tb;
 }
 
-- 
2.11.0
