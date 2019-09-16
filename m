Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A44C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A995720830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A995720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rzU-0008Ar-Ew
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i9rXR-0003oM-71
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i9rXP-0000aM-Hk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i9rXP-0000Zn-2Q; Mon, 16 Sep 2019 09:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 178073083362;
 Mon, 16 Sep 2019 13:59:30 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE1FB10013A1;
 Mon, 16 Sep 2019 13:59:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:58:02 +0200
Message-Id: <20190916135806.1269-26-david@redhat.com>
In-Reply-To: <20190916135806.1269-1-david@redhat.com>
References: <20190916135806.1269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 16 Sep 2019 13:59:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 25/29] s390x/tcg: MVN: Fault-safe handling
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can process a maximum of 256 bytes, crossing two pages.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4f46d0be90..fbf65ac42b 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -494,13 +494,22 @@ void HELPER(mvcin)(CPUS390XState *env, uint32_t l, =
uint64_t dest, uint64_t src)
 /* move numerics  */
 void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t=
 src)
 {
+    const int mmu_idx =3D cpu_mmu_index(env, false);
+    S390Access srca1, srca2, desta;
     uintptr_t ra =3D GETPC();
     int i;
=20
-    for (i =3D 0; i <=3D l; i++) {
-        uint8_t v =3D cpu_ldub_data_ra(env, dest + i, ra) & 0xf0;
-        v |=3D cpu_ldub_data_ra(env, src + i, ra) & 0x0f;
-        cpu_stb_data_ra(env, dest + i, v, ra);
+    /* MVN always copies one more byte than specified - maximum is 256 *=
/
+    l++;
+
+    srca1 =3D access_prepare(env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
+    srca2 =3D access_prepare(env, dest, l, MMU_DATA_LOAD, mmu_idx, ra);
+    desta =3D access_prepare(env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+    for (i =3D 0; i < l; i++) {
+        const uint8_t x =3D (access_get_byte(env, &srca1, i, ra) & 0x0f)=
 |
+                          (access_get_byte(env, &srca2, i, ra) & 0xf0);
+
+        access_set_byte(env, &desta, i, x, ra);
     }
 }
=20
--=20
2.21.0


