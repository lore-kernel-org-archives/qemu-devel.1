Received: from eggs.gnu.org ([2001:4830:134:3::10]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3H5Y-0004pa-BN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3H5V-0003OF-3R
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:10:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51012
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3H5U-0003Ny-UT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:10:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3Q78k3L122057
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:10:07 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebu2v22-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:10:07 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 17:09:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3Q79FtY3604842
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 17:09:23 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3Q779Oe015294
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 17:07:09 +1000
From: aNikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <4f7766e0-4935-9b2e-8388-ff8f04a43aaf@twiddle.net>
References: <20170425104338.31984-1-rth@twiddle.net>
	<87a87468d5.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<4f7766e0-4935-9b2e-8388-ff8f04a43aaf@twiddle.net>
Date: Wed, 26 Apr 2017 12:36:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k267myv1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize return value after
 exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>

Richard Henderson <rth@twiddle.net> writes:

> On 04/25/2017 01:21 PM, Nikunj A Dadhania wrote:
>> Richard Henderson <rth@twiddle.net> writes:
>> 
>>> Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
>>> the output.  Even though this code is dead, it gets translated, and
>>> without the initialization we encounter a tcg_error.
>>>
>>> Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> 
>> With this the tcg_error goes away.
>> 
>> But then powernv skiboot code [1] enters into infinite loop. Basically,
>> in target/ppc/translate.c:gen_conditional_store(), setcond_tl will
>> always fail, and CRF_EQ_BIT will never be set, the lock will never be
>> taken.
>
> The setcond_tl *shouldn't* always fail.

Correct, in fact we never get here it.

> If that's the case, then we have another bug in the !parallel_cpus
> code path for gen_conditional_store.

Something interesting is happening, I have instrumented the code such
that I get some prints for load with reservation and store conditional:

First case is the success case for 32bit atomic_cmpxchg.

    $ ./configure --target-list=ppc64-softmmu  --cc=clang --host-cc=clang
    $ ./ppc64-softmmu/qemu-system-ppc64  -machine powernv,usb=off  -vga none -nographic
[lwarx]
    helper_myprint: t0 cafe0000 t1 cafe0000
    helper_myprint: t0 cafe0001 t1 cafe0001
    helper_myprint: t0 cafe0002 t1 cafe0002
    helper_myprint: t0 f0 t1 0
[stwcx]
    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 f0 t1 0
    helper_myprint: t0 dead0001 t1 dead0001
    helper_myprint: t0 dead0011 t1 dead0011
    helper_myprint: t0 0 t1 0
[success as t0 and cpu_reserve_val is same]

[ldarx]
    helper_myprint: t0 cafe0000 t1 cafe0000
    helper_myprint: t0 cafe0001 t1 cafe0001
    helper_myprint: t0 cafe0002 t1 cafe0002
    helper_myprint: t0 30200018 t1 0

[ cpu_reserve = 30200018, cpu_reserve_val = 0 after load ]

[stdcx]
    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0001 t1 dead0001

[ That is before atomic_cmpxchg_tl, and suddenly we exit out, we did
not reach setcond_tl ]

    helper_myprint: t0 dead0000 t1 dead0000

**** [ re-entering gen_store_conditional() ] ****

    helper_myprint: t0 ffffffffffffffff t1 0

**** [ cpu_reserve is corrupted ] ****

    helper_myprint: t0 dead0020 t1 dead0020

[ Exit as cpu_reserve_val and EA does not match]

    helper_myprint: t0 cafe0000 t1 cafe0000
    helper_myprint: t0 cafe0001 t1 cafe0001
    helper_myprint: t0 cafe0002 t1 cafe0002
    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0001 t1 dead0001
    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 ffffffffffffffff t1 0
    helper_myprint: t0 dead0020 t1 dead0020

[ Same thing repeats again and again ]

    helper_myprint: t0 cafe0000 t1 cafe0000
    helper_myprint: t0 cafe0001 t1 cafe0001
    helper_myprint: t0 cafe0002 t1 cafe0002
    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 30200018 t1 0
    helper_myprint: t0 dead0001 t1 dead0001
    helper_myprint: t0 dead0000 t1 dead0000
    helper_myprint: t0 ffffffffffffffff t1 0
    helper_myprint: t0 dead0020 t1 dead0020
[...]


Regards,
Nikunj



diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index bb6a94a..afbb901 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -795,3 +795,5 @@ DEF_HELPER_4(dscliq, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+DEF_HELPER_2(myprint, void, tl, tl)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index da4e1a6..f555cb9 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3521,3 +3521,8 @@ target_ulong helper_dlmzb(CPUPPCState *env, target_ulong high,
     }
     return i;
 }
+
+void helper_myprint(target_ulong t0, target_ulong t1)
+{
+    fprintf(stderr, "%s: t0 %lx t1 %lx\n", __func__, t0, t1);
+}
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a1f24a..363369e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3020,10 +3020,16 @@ static void gen_##name(DisasContext *ctx)                            \
 {                                                                    \
     TCGv t0;                                                         \
     TCGv gpr = cpu_gpr[rD(ctx->opcode)];                             \
+    TCGv my;                                                         \
+    my = tcg_temp_local_new();                                       \
+    tcg_gen_movi_tl(my, 0xCAFE0000);                                 \
+    gen_helper_myprint(my, my);                                      \
     int len = MEMOP_GET_SIZE(memop);                                 \
     gen_set_access_type(ctx, ACCESS_RES);                            \
     t0 = tcg_temp_local_new();                                       \
     gen_addr_reg_index(ctx, t0);                                     \
+    tcg_gen_addi_tl(my, my, 1);                                      \
+    gen_helper_myprint(my, my);                                      \
     if ((len) > 1) {                                                 \
         gen_check_align(ctx, t0, (len)-1);                           \
     }                                                                \
@@ -3031,6 +3037,10 @@ static void gen_##name(DisasContext *ctx)                            \
     tcg_gen_mov_tl(cpu_reserve, t0);                                 \
     tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);                           \
+    tcg_gen_addi_tl(my, my, 1);                                      \
+    gen_helper_myprint(my, my);                                      \
+    gen_helper_myprint(cpu_reserve, cpu_reserve_val);                \
+    tcg_temp_free(my);                                               \
     tcg_temp_free(t0);                                               \
 }
 
@@ -3165,13 +3175,23 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
     TCGv t0;
+    TCGv my;
 
+    my = tcg_temp_local_new();
+    tcg_gen_movi_tl(my, 0xDEAD0000);
+    gen_helper_myprint(my, my);
+    gen_helper_myprint(cpu_reserve, cpu_reserve_val);
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
 
+    tcg_gen_addi_tl(my, my, 1);
+    gen_helper_myprint(my, my);
     t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
                               cpu_gpr[reg], ctx->mem_idx,
                               DEF_MEMOP(memop) | MO_ALIGN);
+    tcg_gen_addi_tl(my, my, 0x10);
+    gen_helper_myprint(my, my);
+    gen_helper_myprint(t0, cpu_reserve_val);
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
     tcg_gen_or_tl(t0, t0, cpu_so);
@@ -3180,6 +3200,8 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     tcg_gen_br(l2);
 
     gen_set_label(l1);
+    tcg_gen_addi_tl(my, my, 0x20);
+    gen_helper_myprint(my, my);
 
     /* Address mismatch implies failure.  But we still need to provide the
        memory barrier semantics of the instruction.  */
@@ -3188,6 +3210,7 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
 
     gen_set_label(l2);
     tcg_gen_movi_tl(cpu_reserve, -1);
+    tcg_temp_free(my);
 }
 #endif
 
