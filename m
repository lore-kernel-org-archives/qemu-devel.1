Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3543AC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB3D206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB3D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWtD-0008JG-5e
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWil-0004La-Qs
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWii-0005zy-36
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWih-0005zX-R3; Thu, 10 Oct 2019 07:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C62F3086218;
 Thu, 10 Oct 2019 11:34:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 589795C3FD;
 Thu, 10 Oct 2019 11:34:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 16/31] target/s390x: Use tcg_s390_program_interrupt in TCG
 helpers
Date: Thu, 10 Oct 2019 13:33:41 +0200
Message-Id: <20191010113356.5017-17-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 10 Oct 2019 11:34:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Replace all uses of s390_program_interrupt within files
that are marked CONFIG_TCG.  These are necessarily tcg-only.

This lets each of these users benefit from the QEMU_NORETURN
attribute on tcg_s390_program_interrupt.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-5-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cc_helper.c     |  4 ++--
 target/s390x/crypto_helper.c |  7 +++----
 target/s390x/excp_helper.c   |  2 +-
 target/s390x/fpu_helper.c    |  6 +++---
 target/s390x/int_helper.c    | 15 +++++++-------
 target/s390x/mem_helper.c    | 40 ++++++++++++++++++------------------
 target/s390x/misc_helper.c   | 18 ++++++++--------
 7 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 3cb00bcb09..44731e4a85 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
@@ -588,8 +589,7 @@ void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
         break;
     default:
         HELPER_LOG("unknown sacf mode: %" PRIx64 "\n", a1);
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
-        break;
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 }
 #endif
diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
index 1f83987e9d..ff3fbc3950 100644
--- a/target/s390x/crypto_helper.c
+++ b/target/s390x/crypto_helper.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -34,16 +35,14 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1,=
 uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         if (mod) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-            return 0;
+            tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         }
         break;
     }
=20
     s390_get_feat_block(type, subfunc);
     if (!test_be_bit(fc, subfunc)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        return 0;
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     switch (fc) {
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 089623a248..dbff772d34 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -614,7 +614,7 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vadd=
r addr,
     S390CPU *cpu =3D S390_CPU(cs);
     CPUS390XState *env =3D &cpu->env;
=20
-    s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
+    tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
 }
=20
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 7228eb96e2..8bb9f54fd0 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -825,7 +825,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
     if (fpc_to_rnd[fpc & 0x7] =3D=3D -1 || fpc & 0x03030088u ||
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
=20
     /* Install everything in the main FPC.  */
@@ -843,7 +843,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
=20
     if (fpc_to_rnd[fpc & 0x7] =3D=3D -1 || fpc & 0x03030088u ||
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
=20
     /*
@@ -880,7 +880,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
 void HELPER(srnm)(CPUS390XState *env, uint64_t rnd)
 {
     if (rnd > 0x7 || fpc_to_rnd[rnd & 0x7] =3D=3D -1) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
=20
     env->fpc =3D deposit32(env->fpc, 0, 3, rnd);
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index 1d29a1fc1f..658507dd6d 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
@@ -39,7 +40,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, i=
nt64_t b64)
     int64_t q;
=20
     if (b =3D=3D 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
=20
     ret =3D q =3D a / b;
@@ -47,7 +48,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, i=
nt64_t b64)
=20
     /* Catch non-representable quotient.  */
     if (ret !=3D q) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
=20
     return ret;
@@ -60,7 +61,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a,=
 uint64_t b64)
     uint64_t q;
=20
     if (b =3D=3D 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
=20
     ret =3D q =3D a / b;
@@ -68,7 +69,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a,=
 uint64_t b64)
=20
     /* Catch non-representable quotient.  */
     if (ret !=3D q) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
=20
     return ret;
@@ -79,7 +80,7 @@ int64_t HELPER(divs64)(CPUS390XState *env, int64_t a, i=
nt64_t b)
 {
     /* Catch divide by zero, and non-representable quotient (MIN / -1). =
 */
     if (b =3D=3D 0 || (b =3D=3D -1 && a =3D=3D (1ll << 63))) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
     env->retxl =3D a % b;
     return a / b;
@@ -92,7 +93,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah=
, uint64_t al,
     uint64_t ret;
     /* Signal divide by zero.  */
     if (b =3D=3D 0) {
-        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
     if (ah =3D=3D 0) {
         /* 64 -> 64/64 case */
@@ -106,7 +107,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t =
ah, uint64_t al,
         env->retxl =3D a % b;
         ret =3D q;
         if (ret !=3D q) {
-            s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
         }
 #else
         /* 32-bit hosts would need special wrapper functionality - just =
abort if
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 77d2eb96d4..7d2a652823 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -71,7 +72,7 @@ static inline void check_alignment(CPUS390XState *env, =
uint64_t v,
                                    int wordsize, uintptr_t ra)
 {
     if (v % wordsize) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 }
=20
@@ -730,7 +731,7 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, ui=
nt32_t r2)
=20
     /* Bits 32-55 must contain all 0.  */
     if (env->regs[0] & 0xffffff00u) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     str =3D get_address(env, r2);
@@ -767,7 +768,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, u=
int32_t r2)
=20
     /* Bits 32-47 of R0 must be zero.  */
     if (env->regs[0] & 0xffff0000u) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     str =3D get_address(env, r2);
@@ -846,7 +847,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0=
, uint64_t r1, uint64_t r2)
     S390Access srca, desta;
=20
     if ((f && s) || extract64(r0, 12, 4)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
=20
     r1 =3D wrap_address(env, r1 & TARGET_PAGE_MASK);
@@ -879,7 +880,7 @@ uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1=
, uint32_t r2)
     int i;
=20
     if (env->regs[0] & 0xffffff00ull) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     /*
@@ -911,7 +912,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uin=
t64_t a2, uint32_t r3)
     int i;
=20
     if (a2 & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     for (i =3D r1;; i =3D (i + 1) % 16) {
@@ -931,7 +932,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, ui=
nt64_t a2, uint32_t r3)
     int i;
=20
     if (a2 & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     for (i =3D r1;; i =3D (i + 1) % 16) {
@@ -1887,8 +1888,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_=
t r3, uint64_t a1,
     return cc;
=20
  spec_exception:
-    s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-    g_assert_not_reached();
+    tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
 }
=20
 uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint=
64_t a2)
@@ -1911,7 +1911,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1,=
 uint64_t a2, uint32_t r3)
     uint32_t i;
=20
     if (src & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     for (i =3D r1;; i =3D (i + 1) % 16) {
@@ -1944,7 +1944,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, =
uint64_t a2, uint32_t r3)
     uint32_t i;
=20
     if (src & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     for (i =3D r1;; i =3D (i + 1) % 16) {
@@ -1975,7 +1975,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1,=
 uint64_t a2, uint32_t r3)
     uint32_t i;
=20
     if (dest & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     for (i =3D r1;; i =3D (i + 1) % 16) {
@@ -1995,7 +1995,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1,=
 uint64_t a2, uint32_t r3)
     uint32_t i;
=20
     if (dest & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     for (i =3D r1;; i =3D (i + 1) % 16) {
@@ -2225,7 +2225,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, =
uint64_t r2, uint32_t m4)
     uint16_t entries, i, index =3D 0;
=20
     if (r2 & 0xff000) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     if (!(r2 & 0x800)) {
@@ -2369,7 +2369,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t a=
ddr)
=20
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
     }
=20
     old_exc =3D cs->exception_index;
@@ -2538,7 +2538,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t=
 dest, uint64_t src,
                __func__, dest, src, len);
=20
     if (!(env->psw.mask & PSW_MASK_DAT)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
=20
     /* OAC (operand access control) for the first operand -> dest */
@@ -2569,14 +2569,14 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64=
_t dest, uint64_t src,
     }
=20
     if (dest_a && dest_as =3D=3D AS_HOME && (env->psw.mask & PSW_MASK_PS=
TATE)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
     if (!(env->cregs[0] & CR0_SECONDARY) &&
         (dest_as =3D=3D AS_SECONDARY || src_as =3D=3D AS_SECONDARY)) {
-        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
     }
     if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
-        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
+        tcg_s390_program_interrupt(env, PGM_PRIVILEGED, ra);
     }
=20
     len =3D wrap_length32(env, len);
@@ -2590,7 +2590,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t=
 dest, uint64_t src,
         (env->psw.mask & PSW_MASK_PSTATE)) {
         qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing=
\n",
                       __func__);
-        s390_program_interrupt(env, PGM_ADDRESSING, ra);
+        tcg_s390_program_interrupt(env, PGM_ADDRESSING, ra);
     }
=20
     /* FIXME: Access using correct keys and AR-mode */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 9fbb37cfb9..bfb457fb63 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -106,7 +106,7 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r=
1, uint64_t r2)
     int r =3D sclp_service_call(env, r1, r2);
     qemu_mutex_unlock_iothread();
     if (r < 0) {
-        s390_program_interrupt(env, -r, GETPC());
+        tcg_s390_program_interrupt(env, -r, GETPC());
     }
     return r;
 }
@@ -143,7 +143,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, ui=
nt32_t r3, uint32_t num)
     }
=20
     if (r) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 }
=20
@@ -222,7 +222,7 @@ void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
     uint32_t val =3D r0;
=20
     if (val & 0xffff0000) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
     env->todpr =3D val;
 }
@@ -266,7 +266,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0=
, uint64_t r0, uint64_t r1)
     }
=20
     if ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK)) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     if ((r0 & STSI_R0_FC_MASK) =3D=3D STSI_R0_FC_CURRENT) {
@@ -276,7 +276,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0=
, uint64_t r0, uint64_t r1)
     }
=20
     if (a0 & ~TARGET_PAGE_MASK) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     /* count the cpus and split them into configured and reserved ones *=
/
@@ -509,7 +509,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t add=
r)
     LowCore *lowcore;
=20
     if (addr & 0x3) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     qemu_mutex_lock_iothread();
@@ -574,7 +574,7 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 void HELPER(per_check_exception)(CPUS390XState *env)
 {
     if (env->per_perc_atmid) {
-        s390_program_interrupt(env, PGM_PER, GETPC());
+        tcg_s390_program_interrupt(env, PGM_PER, GETPC());
     }
 }
=20
@@ -664,7 +664,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t a=
ddr)
     int i;
=20
     if (addr & 0x7) {
-        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
=20
     prepare_stfl();
@@ -737,7 +737,7 @@ void HELPER(sic)(CPUS390XState *env, uint64_t r1, uin=
t64_t r3)
     qemu_mutex_unlock_iothread();
     /* css_do_sic() may actually return a PGM_xxx value to inject */
     if (r) {
-        s390_program_interrupt(env, -r, GETPC());
+        tcg_s390_program_interrupt(env, -r, GETPC());
     }
 }
=20
--=20
2.21.0


