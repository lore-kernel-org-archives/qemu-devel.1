Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539FEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1B320B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1B320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hueyQ-0004Jx-FC
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52112)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1huewI-0002kM-KU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1huewH-0000i7-GI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1huewH-0000gD-BJ; Mon, 05 Aug 2019 11:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3F18E8CD8;
 Mon,  5 Aug 2019 15:30:17 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82D1D60F88;
 Mon,  5 Aug 2019 15:30:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:29:43 +0200
Message-Id: <20190805152947.28536-6-david@redhat.com>
In-Reply-To: <20190805152947.28536-1-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 15:30:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 5/9] s390x/mmu: Implement
 access-exception-fetch/store-indication facility
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

We always have to indicate whether it is a fetch or a store for all acces=
s
exceptions. This is only missing for LAP exceptions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 5c9c7d385d..f3e988e4fd 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -333,7 +333,7 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
ddr, int rw, uint64_t asc,
         *flags |=3D PAGE_WRITE_INV;
         if (is_low_address(vaddr) && rw =3D=3D MMU_DATA_STORE) {
             if (exc) {
-                trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO,=
 0);
+                trigger_access_exception(env, PGM_PROTECTION, ilen, tec)=
;
             }
             return -EACCES;
         }
@@ -511,6 +511,8 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintp=
tr_t ra)
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags)
 {
+    uint64_t tec =3D (raddr & TARGET_PAGE_MASK) |
+                   (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ);
     const bool lowprot_enabled =3D env->cregs[0] & CR0_LOWPROT;
=20
     *flags =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -518,7 +520,7 @@ int mmu_translate_real(CPUS390XState *env, target_ulo=
ng raddr, int rw,
         /* see comment in mmu_translate() how this works */
         *flags |=3D PAGE_WRITE_INV;
         if (is_low_address(raddr) && rw =3D=3D MMU_DATA_STORE) {
-            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
+            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, tec=
);
             return -EACCES;
         }
     }
--=20
2.21.0


