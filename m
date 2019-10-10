Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B4C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5FD208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5FD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX5p-00074q-TA
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWjn-0005Sz-Mq
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWjm-0006QO-Ja
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWjm-0006QE-AK; Thu, 10 Oct 2019 07:36:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F27010CC1E3;
 Thu, 10 Oct 2019 11:36:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9B9B5E1C2;
 Thu, 10 Oct 2019 11:35:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 22/31] target/s390x: Return exception from translate_pages
Date: Thu, 10 Oct 2019 13:33:47 +0200
Message-Id: <20191010113356.5017-23-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 10 Oct 2019 11:36:05 +0000 (UTC)
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

Do not raise the exception directly within translate_pages,
but pass it back so that caller may do so.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-11-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 001d0a9c8a..869debd30a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -451,25 +451,22 @@ nodat:
  * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
-                           target_ulong *pages, bool is_write)
+                           target_ulong *pages, bool is_write, uint64_t =
*tec)
 {
     uint64_t asc =3D cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env =3D &cpu->env;
     int ret, i, pflags;
=20
     for (i =3D 0; i < nr_pages; i++) {
-        uint64_t tec;
-
-        ret =3D mmu_translate(env, addr, is_write, asc, &pages[i], &pfla=
gs, &tec);
+        ret =3D mmu_translate(env, addr, is_write, asc, &pages[i], &pfla=
gs, tec);
         if (ret) {
-            trigger_access_exception(env, ret, ILEN_AUTO, tec);
-            return -EFAULT;
+            return ret;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write,
                                         MEMTXATTRS_UNSPECIFIED)) {
-            trigger_access_exception(env, PGM_ADDRESSING, ILEN_AUTO, 0);
-            return -EFAULT;
+            *tec =3D 0; /* unused */
+            return PGM_ADDRESSING;
         }
         addr +=3D TARGET_PAGE_SIZE;
     }
@@ -497,6 +494,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, u=
int8_t ar, void *hostbuf,
 {
     int currlen, nr_pages, i;
     target_ulong *pages;
+    uint64_t tec;
     int ret;
=20
     if (kvm_enabled()) {
@@ -510,8 +508,10 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, =
uint8_t ar, void *hostbuf,
                + 1;
     pages =3D g_malloc(nr_pages * sizeof(*pages));
=20
-    ret =3D translate_pages(cpu, laddr, nr_pages, pages, is_write);
-    if (ret =3D=3D 0 && hostbuf !=3D NULL) {
+    ret =3D translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec)=
;
+    if (ret) {
+        trigger_access_exception(&cpu->env, ret, ILEN_AUTO, tec);
+    } else if (hostbuf !=3D NULL) {
         /* Copy data by stepping through the area page by page */
         for (i =3D 0; i < nr_pages; i++) {
             currlen =3D MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE=
_SIZE));
--=20
2.21.0


