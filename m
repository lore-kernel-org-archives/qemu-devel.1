Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D73C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692E520872
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692E520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQrY-0005uj-GG
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDQpE-0004GL-I0
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDQpD-0007ga-6B
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDQpD-0007g9-0k; Thu, 26 Sep 2019 06:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 366E3301A3AE;
 Thu, 26 Sep 2019 10:16:38 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD2C60920;
 Thu, 26 Sep 2019 10:16:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/5] s390x/mmu: Implement ESOP-2 and
 access-exception-fetch/store-indication facility
Date: Thu, 26 Sep 2019 12:16:24 +0200
Message-Id: <20190926101627.23376-3-david@redhat.com>
In-Reply-To: <20190926101627.23376-1-david@redhat.com>
References: <20190926101627.23376-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 26 Sep 2019 10:16:38 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already implement ESOP-1. For ESOP-2, we only have to indicate all
protection exceptions properly. Due to EDAT-1, we already indicate DAT
exceptions properly. We don't trigger KCP/ALCP/IEP exceptions yet.

So all we have to do is set the TEID (TEC) to the right values
(bit 56, 60, 61) in case of LAP.

We don't have any side-effects (e.g., no guarded-storage facility),
therefore, bit 64 of the TEID (TEC) is always 0.

We always have to indicate whether it is a fetch or a store for all acces=
s
exceptions. This is only missing for LAP exceptions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 54f54137ec..8abc5d31d8 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -384,7 +384,9 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
ddr, int rw, uint64_t asc,
         *flags |=3D PAGE_WRITE_INV;
         if (is_low_address(vaddr) && rw =3D=3D MMU_DATA_STORE) {
             if (exc) {
-                trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO,=
 0);
+                /* LAP sets bit 56 */
+                tec |=3D 0x80;
+                trigger_access_exception(env, PGM_PROTECTION, ilen, tec)=
;
             }
             return -EACCES;
         }
@@ -540,6 +542,10 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uint=
ptr_t ra)
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags)
 {
+    /* Code accesses have an undefined ilc, let's use 2 bytes. */
+    const int ilen =3D (rw =3D=3D MMU_INST_FETCH) ? 2 : ILEN_AUTO;
+    uint64_t tec =3D (raddr & TARGET_PAGE_MASK) |
+                   (rw =3D=3D MMU_DATA_STORE ? FS_WRITE : FS_READ);
     const bool lowprot_enabled =3D env->cregs[0] & CR0_LOWPROT;
=20
     *flags =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -547,7 +553,9 @@ int mmu_translate_real(CPUS390XState *env, target_ulo=
ng raddr, int rw,
         /* see comment in mmu_translate() how this works */
         *flags |=3D PAGE_WRITE_INV;
         if (is_low_address(raddr) && rw =3D=3D MMU_DATA_STORE) {
-            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
+            /* LAP sets bit 56 */
+            tec |=3D 0x80;
+            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
             return -EACCES;
         }
     }
--=20
2.21.0


