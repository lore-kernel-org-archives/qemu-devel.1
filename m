Received: from eggs.gnu.org ([2001:4830:134:3::10]:50727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dB0J9-0001lW-9q
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dB0J8-0004fT-4Q
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:11 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dB0J7-0004f6-VL
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:10 -0400
Received: by mail-wr0-x232.google.com with SMTP id w50so12426487wrc.0
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:52:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 17 May 2017 15:52:57 +0100
Message-Id: <20170517145259.28979-5-alex.bennee@linaro.org>
In-Reply-To: <20170517145259.28979-1-alex.bennee@linaro.org>
References: <20170517145259.28979-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/6] cputlb: remove tlb_flush_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Flushing of the CPU TLB is no longer a simple count. The ratio of
self-flushes to cross-flushes and if they need to synchronise across
vCPUs has more of an impact. To correctly capture this we'll replace
the simple count with trace points in a future patch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cputlb.c              | 4 ----
 include/exec/cputlb.h | 1 -
 translate-all.c       | 1 -
 3 files changed, 6 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index f5d056cc08..d1859c3f37 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -92,9 +92,6 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
     }
 }
 
-/* statistics */
-int tlb_flush_count;
-
 /* This is OK because CPU architectures generally permit an
  * implementation to drop entries from the TLB at any time, so
  * flushing more entries than required is only an efficiency issue,
@@ -112,7 +109,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     }
 
     assert_cpu_is_self(cpu);
-    tlb_debug("(count: %d)\n", tlb_flush_count++);
 
     tb_lock();
 
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3f941783c5..dac9901da5 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -23,7 +23,6 @@
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-extern int tlb_flush_count;
 
 #endif
 #endif
diff --git a/translate-all.c b/translate-all.c
index b3ee876526..eeb3807242 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1927,7 +1927,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
             atomic_read(&tcg_ctx.tb_ctx.tb_flush_count));
     cpu_fprintf(f, "TB invalidate count %d\n",
             tcg_ctx.tb_ctx.tb_phys_invalidate_count);
-    cpu_fprintf(f, "TLB flush count     %d\n", tlb_flush_count);
     tcg_dump_info(f, cpu_fprintf);
 
     tb_unlock();
-- 
2.11.0
