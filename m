Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47779C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183B921734
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183B921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hueyM-0004FD-Vh
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1huewI-0002k5-FN
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1huewH-0000hy-D5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1huewF-0000Wa-DY; Mon, 05 Aug 2019 11:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B52E281DF2;
 Mon,  5 Aug 2019 15:30:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1D7E60F80;
 Mon,  5 Aug 2019 15:30:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:29:40 +0200
Message-Id: <20190805152947.28536-3-david@redhat.com>
In-Reply-To: <20190805152947.28536-1-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 05 Aug 2019 15:30:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 2/9] s390x/tcg: Rework MMU selection
 for instruction fetches
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instructions are always fetched from primary address space, except when
in home address mode. Perform the selection directly in cpu_mmu_index().

get_mem_index() is only used to perform data access, instructions are
fetched via cpu_lduw_code(), which translates to cpu_mmu_index(env, true)=
.

We don't care about restricting the access permissions of the TLB
entries anymore, as we no longer enter PRIMARY entries into the
SECONDARY MMU.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        |  7 +++++++
 target/s390x/mmu_helper.c | 15 ++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a606547b4d..c34992bb2e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -332,6 +332,13 @@ static inline int cpu_mmu_index(CPUS390XState *env, =
bool ifetch)
         return MMU_REAL_IDX;
     }
=20
+    if (ifetch) {
+        if ((env->psw.mask & PSW_MASK_ASC) =3D=3D PSW_ASC_HOME) {
+            return MMU_HOME_IDX;
+        }
+        return MMU_PRIMARY_IDX;
+    }
+
     switch (env->psw.mask & PSW_MASK_ASC) {
     case PSW_ASC_PRIMARY:
         return MMU_PRIMARY_IDX;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 6e9c4d6151..9c0d9b5c5f 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -397,19 +397,8 @@ int mmu_translate(CPUS390XState *env, target_ulong v=
addr, int rw, uint64_t asc,
         break;
     case PSW_ASC_SECONDARY:
         PTE_DPRINTF("%s: asc=3Dsecondary\n", __func__);
-        /*
-         * Instruction: Primary
-         * Data: Secondary
-         */
-        if (rw =3D=3D MMU_INST_FETCH) {
-            r =3D mmu_translate_asce(env, vaddr, PSW_ASC_PRIMARY, env->c=
regs[1],
-                                   raddr, flags, rw, exc);
-            *flags &=3D ~(PAGE_READ | PAGE_WRITE);
-        } else {
-            r =3D mmu_translate_asce(env, vaddr, PSW_ASC_SECONDARY, env-=
>cregs[7],
-                                   raddr, flags, rw, exc);
-            *flags &=3D ~(PAGE_EXEC);
-        }
+        r =3D mmu_translate_asce(env, vaddr, PSW_ASC_SECONDARY, env->cre=
gs[7],
+                               raddr, flags, rw, exc);
         break;
     case PSW_ASC_ACCREG:
     default:
--=20
2.21.0


