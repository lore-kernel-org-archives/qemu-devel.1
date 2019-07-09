Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82EC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07B1214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trkqt1kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07B1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48083 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmLl-0001bi-69
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJP-0006vw-2F
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJG-0001rf-9u
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:18 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkmJE-0001qA-EI
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:13 -0400
Received: by mail-io1-xd42.google.com with SMTP id o9so26057535iom.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dbK9HyZ7CrS/6xw2w7TzA9aDBiINtJqhGyy8umr2lq4=;
 b=trkqt1kPmMKQLRaasTj1fzewMkw7nS4Js9xD9izCmpbx/j2WZV60vLcqedForf2ukm
 ZPz1M8D4rMxSxXdefUnLldepZhf9yuZDudjF4wL3yjqn/PCkAFx1eBDQHnT0XMn59qpX
 NTaBuzn3v51FX3mQMUkL75/ZwUYPSTgFpLly7ulWhOImpHgue/os9EK8jIYjTQ09HrWe
 j2bmM0cr4enxaXFtvbtm3J8NvZ6zqizqDU4TxhzF6nN1SNXc0Crnp5BWcdSQFRJvOUig
 JNtQczUvrEQZHWKS7eKnMo9RvMr527N8Ap1hSs3p81HEr/R7pmZnV/ZEFSvbs21rE/sz
 oHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dbK9HyZ7CrS/6xw2w7TzA9aDBiINtJqhGyy8umr2lq4=;
 b=e3r1y+u8Lzu1ny/fbiHkyLUd4RnJAqmAKQ1Fq+xrcl8Zp2Fw7DckNt+nXlUy+ozKV/
 qGVG7MUC/HboEH71tdROrO/yseOS9DnZycR3IxRyeK5VeHjCM0w8B8aAoRZzWS3QhrDx
 NxGMjJ/v6haC7BK8JCVA54zvG+/fJu8BmUxRPi35FNqylxddqfcHOQJiCloFugw4Zypj
 Kz7edTnCQ8nJbGw8yDOLaazDugzVC5Uv6G+/D166rcHwZ59JkX6m/1y6lwV8AI5OClfB
 7WEdcgxyQ9zKdpsNpGzgZFIGCIJnweQn2y9KtNKCTxDyVnei9nIKfsOxqdy18Xnd8AMb
 hJkQ==
X-Gm-Message-State: APjAAAXmqIE3z7ge8SFCZJAovO5jDNktTirbdXrME7J2d0Vuk/1UOhXK
 JxKGGYlVj4W25gsy93Yy4Nt1HJsaXK4=
X-Google-Smtp-Source: APXvYqx5FlIuFOC35ysMORL9/Bn9KUuFTv3d3H3+q1sKq9RSDqsKAy4mTc0S9lSf++jbo79GTDvchQ==
X-Received: by 2002:a02:77d4:: with SMTP id
 g203mr21312915jac.144.1562664071412; 
 Tue, 09 Jul 2019 02:21:11 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id c17sm17613817ioo.82.2019.07.09.02.21.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:21:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 11:20:46 +0200
Message-Id: <20190709092049.13771-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709092049.13771-1-richard.henderson@linaro.org>
References: <20190709092049.13771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: [Qemu-devel] [PATCH 2/5] tcg: Introduce set/clear_helper_retaddr
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present we have a potential error in that helper_retaddr contains
data for handle_cpu_signal, but we have not ensured that those stores
will be scheduled properly before the operation that may fault.

It might be that these races are not in practice observable, due to
our use of -fno-strict-aliasing, but better safe than sorry.

Adjust all of the setters of helper_retaddr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h                   | 20 +++++++++++
 include/exec/cpu_ldst_useronly_template.h | 12 +++----
 accel/tcg/user-exec.c                     | 11 +++---
 target/arm/helper-a64.c                   |  8 ++---
 target/arm/sve_helper.c                   | 43 +++++++++++------------
 5 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a08b11bd2c..9de8c93303 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -89,6 +89,26 @@ typedef target_ulong abi_ptr;
 
 extern __thread uintptr_t helper_retaddr;
 
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+
 /* In user-only mode we provide only the _code and _data accessors. */
 
 #define MEMSUFFIX _data
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index bc45e2b8d4..e65733f7e2 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -78,9 +78,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   uintptr_t retaddr)
 {
     RES_TYPE ret;
-    helper_retaddr = retaddr;
+    set_helper_retaddr(retaddr);
     ret = glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
     return ret;
 }
 
@@ -102,9 +102,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   uintptr_t retaddr)
 {
     int ret;
-    helper_retaddr = retaddr;
+    set_helper_retaddr(retaddr);
     ret = glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
     return ret;
 }
 #endif
@@ -128,9 +128,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   RES_TYPE v,
                                                   uintptr_t retaddr)
 {
-    helper_retaddr = retaddr;
+    set_helper_retaddr(retaddr);
     glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 }
 #endif
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index cb5f4b19c5..4384b59a4d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -134,7 +134,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
              * currently executing TB was modified and must be exited
              * immediately.  Clear helper_retaddr for next execution.
              */
-            helper_retaddr = 0;
+            clear_helper_retaddr();
             cpu_exit_tb_from_sighandler(cpu, old_set);
             /* NORETURN */
 
@@ -152,7 +152,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
      * an exception.  Undo signal and retaddr state prior to longjmp.
      */
     sigprocmask(SIG_SETMASK, old_set, NULL);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 
     cc = CPU_GET_CLASS(cpu);
     access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
@@ -682,14 +682,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     if (unlikely(addr & (size - 1))) {
         cpu_loop_exit_atomic(env_cpu(env), retaddr);
     }
-    helper_retaddr = retaddr;
-    return g2h(addr);
+    void *ret = g2h(addr);
+    set_helper_retaddr(retaddr);
+    return ret;
 }
 
 /* Macro to call the above, with local variables from the use context.  */
 #define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
-#define ATOMIC_MMU_CLEANUP do { helper_retaddr = 0; } while (0)
+#define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
 
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 44e45a8037..060699b901 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -554,7 +554,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
     /* ??? Enforce alignment.  */
     uint64_t *haddr = g2h(addr);
 
-    helper_retaddr = ra;
+    set_helper_retaddr(ra);
     o0 = ldq_le_p(haddr + 0);
     o1 = ldq_le_p(haddr + 1);
     oldv = int128_make128(o0, o1);
@@ -564,7 +564,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
         stq_le_p(haddr + 0, int128_getlo(newv));
         stq_le_p(haddr + 1, int128_gethi(newv));
     }
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 #else
     int mem_idx = cpu_mmu_index(env, false);
     TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
@@ -624,7 +624,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
     /* ??? Enforce alignment.  */
     uint64_t *haddr = g2h(addr);
 
-    helper_retaddr = ra;
+    set_helper_retaddr(ra);
     o1 = ldq_be_p(haddr + 0);
     o0 = ldq_be_p(haddr + 1);
     oldv = int128_make128(o0, o1);
@@ -634,7 +634,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
         stq_be_p(haddr + 0, int128_gethi(newv));
         stq_be_p(haddr + 1, int128_getlo(newv));
     }
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 #else
     int mem_idx = cpu_mmu_index(env, false);
     TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fd434c66ea..fc0c1755d2 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4125,12 +4125,11 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
     return MIN(split, mem_max - mem_off) + mem_off;
 }
 
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-#ifdef CONFIG_USER_ONLY
-    helper_retaddr = ra;
+#ifndef CONFIG_USER_ONLY
+/* These are normally defined only for CONFIG_USER_ONLY in <exec/cpu_ldst.h> */
+static inline void set_helper_retaddr(uintptr_t ra) { }
+static inline void clear_helper_retaddr(void) { }
 #endif
-}
 
 /*
  * The result of tlb_vaddr_to_host for user-only is just g2h(x),
@@ -4188,7 +4187,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
         if (test_host_page(host)) {
             mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
             tcg_debug_assert(mem_off == mem_max);
-            set_helper_retaddr(0);
+            clear_helper_retaddr();
             /* After having taken any fault, zero leading inactive elements. */
             swap_memzero(vd, reg_off);
             return;
@@ -4239,7 +4238,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
     }
 #endif
 
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
     memcpy(vd, &scratch, reg_max);
 }
 
@@ -4312,7 +4311,7 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 2 * size;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4341,7 +4340,7 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 3 * size;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4372,7 +4371,7 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 4 * size;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4494,7 +4493,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
         if (test_host_page(host)) {
             mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
             tcg_debug_assert(mem_off == mem_max);
-            set_helper_retaddr(0);
+            clear_helper_retaddr();
             /* After any fault, zero any leading inactive elements.  */
             swap_memzero(vd, reg_off);
             return;
@@ -4537,7 +4536,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     }
 #endif
 
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
     record_fault(env, reg_off, reg_max);
 }
 
@@ -4740,7 +4739,7 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4766,7 +4765,7 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 2 * msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4794,7 +4793,7 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 3 * msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4824,7 +4823,7 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 4 * msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 #define DO_STN_1(N, NAME, ESIZE) \
@@ -4932,7 +4931,7 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
             i += 4, pg >>= 4;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(vd, &scratch, oprsz);
@@ -4955,7 +4954,7 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
             tlb_fn(env, &scratch, i * 8, base + (off << scale), oi, ra);
         }
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(vd, &scratch, oprsz * 8);
@@ -5133,7 +5132,7 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         tlb_fn(env, vd, reg_off, addr, oi, ra);
 
         /* The rest of the reads will be non-faulting.  */
-        set_helper_retaddr(0);
+        clear_helper_retaddr();
     }
 
     /* After any fault, zero the leading predicated false elements.  */
@@ -5175,7 +5174,7 @@ static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         tlb_fn(env, vd, reg_off, addr, oi, ra);
 
         /* The rest of the reads will be non-faulting.  */
-        set_helper_retaddr(0);
+        clear_helper_retaddr();
     }
 
     /* After any fault, zero the leading predicated false elements.  */
@@ -5299,7 +5298,7 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
             i += 4, pg >>= 4;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
@@ -5318,7 +5317,7 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
             tlb_fn(env, vd, i * 8, base + (off << scale), oi, ra);
         }
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 #define DO_ST1_ZPZ_S(MEM, OFS) \
-- 
2.17.1


