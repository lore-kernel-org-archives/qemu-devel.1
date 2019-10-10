Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F6BC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEACB206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEACB206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX0H-0000g3-LI
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWjY-000539-20
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWjW-0006Ky-FD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWjW-0006Kn-7H; Thu, 10 Oct 2019 07:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7100D4E8AC;
 Thu, 10 Oct 2019 11:35:49 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E33655C22C;
 Thu, 10 Oct 2019 11:35:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 21/31] target/s390x: Return exception from mmu_translate
Date: Thu, 10 Oct 2019 13:33:46 +0200
Message-Id: <20191010113356.5017-22-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 10 Oct 2019 11:35:49 +0000 (UTC)
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

Do not raise the exception directly within mmu_translate,
but pass it back so that caller may do so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-10-richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c |  4 +--
 target/s390x/helper.c      |  3 ++-
 target/s390x/internal.h    |  2 +-
 target/s390x/mem_helper.c  | 13 +++++++---
 target/s390x/mmu_helper.c  | 51 +++++++++++++++-----------------------
 5 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 906b87c071..6a0728b65f 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -140,8 +140,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &=3D 0x7fffffff;
         }
-        fail =3D mmu_translate(env, vaddr, access_type, asc, &raddr, &pr=
ot, true);
-        excp =3D 0; /* exception already raised */
+        excp =3D mmu_translate(env, vaddr, access_type, asc, &raddr, &pr=
ot, &tec);
+        fail =3D excp;
     } else if (mmu_idx =3D=3D MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index bf503b56ee..a3a49164e4 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -52,6 +52,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr=
 vaddr)
     target_ulong raddr;
     int prot;
     uint64_t asc =3D env->psw.mask & PSW_MASK_ASC;
+    uint64_t tec;
=20
     /* 31-Bit mode */
     if (!(env->psw.mask & PSW_MASK_64)) {
@@ -67,7 +68,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr=
 vaddr)
      * We want to read code even if IEP is active. Use MMU_DATA_LOAD ins=
tead
      * of MMU_INST_FETCH.
      */
-    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, fal=
se)) {
+    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, &te=
c)) {
         return -1;
     }
     return raddr;
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c4388aaf23..c993c3ef40 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -360,7 +360,7 @@ void probe_write_access(CPUS390XState *env, uint64_t =
addr, uint64_t len,
=20
 /* mmu_helper.c */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64=
_t asc,
-                  target_ulong *raddr, int *flags, bool exc);
+                  target_ulong *raddr, int *flags, uint64_t *tec);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags, uint64_t *tec);
=20
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7d2a652823..e15aa296dd 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2364,8 +2364,8 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t a=
ddr)
     CPUState *cs =3D env_cpu(env);
     uint32_t cc =3D 0;
     uint64_t asc =3D env->psw.mask & PSW_MASK_ASC;
-    uint64_t ret;
-    int old_exc, flags;
+    uint64_t ret, tec;
+    int old_exc, flags, exc;
=20
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
@@ -2373,7 +2373,14 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t =
addr)
     }
=20
     old_exc =3D cs->exception_index;
-    if (mmu_translate(env, addr, 0, asc, &ret, &flags, true)) {
+    exc =3D mmu_translate(env, addr, 0, asc, &ret, &flags, &tec);
+    if (exc) {
+        /*
+         * We don't care about ILEN or TEC, as we're not going to
+         * deliver the exception -- thus resetting exception_index below=
.
+         * TODO: clean this up.
+         */
+        trigger_pgm_exception(env, exc, ILEN_UNWIND);
         cc =3D 3;
     }
     if (cs->exception_index =3D=3D EXCP_PGM) {
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index e57d762f45..001d0a9c8a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -365,20 +365,18 @@ static void mmu_handle_skey(target_ulong addr, int =
rw, int *flags)
  * @param raddr  the translated address is stored to this pointer
  * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this point=
er
  * @param exc    true =3D inject a program check if a fault occurred
- * @return       0 if the translation was successful, -1 if a fault occu=
rred
+ * @return       0 =3D success, !=3D 0, the exception to raise
  */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64=
_t asc,
-                  target_ulong *raddr, int *flags, bool exc)
+                  target_ulong *raddr, int *flags, uint64_t *tec)
 {
-    /* Code accesses have an undefined ilc, let's use 2 bytes. */
-    const int ilen =3D (rw =3D=3D MMU_INST_FETCH) ? 2 : ILEN_AUTO;
-    uint64_t tec =3D (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
-                   (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ);
     uint64_t asce;
     int r;
=20
-
+    *tec =3D (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
+            (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ);
     *flags =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
     if (is_low_address(vaddr & TARGET_PAGE_MASK) && lowprot_enabled(env,=
 asc)) {
         /*
          * If any part of this page is currently protected, make sure th=
e
@@ -390,12 +388,9 @@ int mmu_translate(CPUS390XState *env, target_ulong v=
addr, int rw, uint64_t asc,
          */
         *flags |=3D PAGE_WRITE_INV;
         if (is_low_address(vaddr) && rw =3D=3D MMU_DATA_STORE) {
-            if (exc) {
-                /* LAP sets bit 56 */
-                tec |=3D 0x80;
-                trigger_access_exception(env, PGM_PROTECTION, ilen, tec)=
;
-            }
-            return -EACCES;
+            /* LAP sets bit 56 */
+            *tec |=3D 0x80;
+            return PGM_PROTECTION;
         }
     }
=20
@@ -425,30 +420,21 @@ int mmu_translate(CPUS390XState *env, target_ulong =
vaddr, int rw, uint64_t asc,
     /* perform the DAT translation */
     r =3D mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw);
     if (unlikely(r)) {
-        if (exc) {
-            trigger_access_exception(env, r, ilen, tec);
-        }
-        return -1;
+        return r;
     }
=20
     /* check for DAT protection */
     if (unlikely(rw =3D=3D MMU_DATA_STORE && !(*flags & PAGE_WRITE))) {
-        if (exc) {
-            /* DAT sets bit 61 only */
-            tec |=3D 0x4;
-            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-        }
-        return -1;
+        /* DAT sets bit 61 only */
+        *tec |=3D 0x4;
+        return PGM_PROTECTION;
     }
=20
     /* check for Instruction-Execution-Protection */
     if (unlikely(rw =3D=3D MMU_INST_FETCH && !(*flags & PAGE_EXEC))) {
-        if (exc) {
-            /* IEP sets bit 56 and 61 */
-            tec |=3D 0x84;
-            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-        }
-        return -1;
+        /* IEP sets bit 56 and 61 */
+        *tec |=3D 0x84;
+        return PGM_PROTECTION;
     }
=20
 nodat:
@@ -472,9 +458,12 @@ static int translate_pages(S390CPU *cpu, vaddr addr,=
 int nr_pages,
     int ret, i, pflags;
=20
     for (i =3D 0; i < nr_pages; i++) {
-        ret =3D mmu_translate(env, addr, is_write, asc, &pages[i], &pfla=
gs, true);
+        uint64_t tec;
+
+        ret =3D mmu_translate(env, addr, is_write, asc, &pages[i], &pfla=
gs, &tec);
         if (ret) {
-            return ret;
+            trigger_access_exception(env, ret, ILEN_AUTO, tec);
+            return -EFAULT;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write,
--=20
2.21.0


