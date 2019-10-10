Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC6C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5992C206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5992C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWw1-0003Pd-DQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWiz-0004RW-He
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWix-000669-Ha
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWiq-00061S-Sl; Thu, 10 Oct 2019 07:35:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 528E23CA00;
 Thu, 10 Oct 2019 11:35:03 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 647DA5C231;
 Thu, 10 Oct 2019 11:34:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 17/31] target/s390x: Push trigger_pgm_exception lower in
 s390_cpu_tlb_fill
Date: Thu, 10 Oct 2019 13:33:42 +0200
Message-Id: <20191010113356.5017-18-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 10 Oct 2019 11:35:03 +0000 (UTC)
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

Delay triggering an exception until the end, after we have
determined ultimate success or failure, and also taken into
account whether this is a non-faulting probe.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-6-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index dbff772d34..552098be5f 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -127,7 +127,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
     CPUS390XState *env =3D &cpu->env;
     target_ulong vaddr, raddr;
     uint64_t asc;
-    int prot, fail;
+    int prot, fail, excp;
=20
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx=
 %d\n",
                   __func__, address, access_type, mmu_idx);
@@ -141,12 +141,14 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address,=
 int size,
             vaddr &=3D 0x7fffffff;
         }
         fail =3D mmu_translate(env, vaddr, access_type, asc, &raddr, &pr=
ot, true);
+        excp =3D 0; /* exception already raised */
     } else if (mmu_idx =3D=3D MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &=3D 0x7fffffff;
         }
         fail =3D mmu_translate_real(env, vaddr, access_type, &raddr, &pr=
ot);
+        excp =3D 0; /* exception already raised */
     } else {
         g_assert_not_reached();
     }
@@ -159,7 +161,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
-        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
+        excp =3D PGM_ADDRESSING;
         fail =3D 1;
     }
=20
@@ -175,6 +177,9 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
         return false;
     }
=20
+    if (excp) {
+        trigger_pgm_exception(env, excp, ILEN_AUTO);
+    }
     cpu_restore_state(cs, retaddr, true);
=20
     /*
--=20
2.21.0


