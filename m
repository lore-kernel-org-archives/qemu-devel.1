Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F28C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CC02064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CC02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJrr-00060G-U7
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJOX-0002qr-Hg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJOW-0004UA-E4
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iCJOW-0004Tr-8Y; Mon, 23 Sep 2019 04:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 895A718C8921;
 Mon, 23 Sep 2019 08:08:27 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB92119C78;
 Mon, 23 Sep 2019 08:08:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 27/30] s390x/tcg: MVST: Fault-safe handling
Date: Mon, 23 Sep 2019 10:07:09 +0200
Message-Id: <20190923080712.23951-28-david@redhat.com>
In-Reply-To: <20190923080712.23951-1-david@redhat.com>
References: <20190923080712.23951-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 23 Sep 2019 08:08:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Access at most single pages and document why. Using the access helpers
might over-indicate watchpoints within the same page, I guess we can
live with that.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b781362e16..4a4b4ea0b7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -866,23 +866,33 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t =
r0, uint64_t r1, uint64_t r2)
 /* string copy */
 uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
+    const int mmu_idx =3D cpu_mmu_index(env, false);
     const uint64_t d =3D get_address(env, r1);
     const uint64_t s =3D get_address(env, r2);
     const uint8_t c =3D env->regs[0];
+    const int len =3D MIN(-(d | TARGET_PAGE_MASK), -(s | TARGET_PAGE_MAS=
K));
+    S390Access srca, desta;
     uintptr_t ra =3D GETPC();
-    uint32_t len;
+    int i;
=20
     if (env->regs[0] & 0xffffff00ull) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
     }
=20
-    /* Lest we fail to service interrupts in a timely manner, limit the
-       amount of work we're willing to do.  For now, let's cap at 8k.  *=
/
-    for (len =3D 0; len < 0x2000; ++len) {
-        uint8_t v =3D cpu_ldub_data_ra(env, s + len, ra);
-        cpu_stb_data_ra(env, d + len, v, ra);
+    /*
+     * Our access should not exceed single pages, as we must not report =
access
+     * exceptions exceeding the actually copied range (which we don't kn=
ow at
+     * this point). We might over-indicate watchpoints within the pages
+     * (if we ever care, we have to limit processing to a single byte).
+     */
+    srca =3D access_prepare(env, s, len, MMU_DATA_LOAD, mmu_idx, ra);
+    desta =3D access_prepare(env, d, len, MMU_DATA_STORE, mmu_idx, ra);
+    for (i =3D 0; i < len; i++) {
+        const uint8_t v =3D access_get_byte(env, &srca, i, ra);
+
+        access_set_byte(env, &desta, i, v, ra);
         if (v =3D=3D c) {
-            set_address_zero(env, r1, d + len);
+            set_address_zero(env, r1, d + i);
             return 1;
         }
     }
--=20
2.21.0


