Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDAB206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDAB206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69Jx-0000YM-E3
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i698k-0004Dt-LB
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i698j-0003Ut-Ah
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i698j-0003UR-5U; Fri, 06 Sep 2019 03:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 707DA875220;
 Fri,  6 Sep 2019 07:58:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C449B1001955;
 Fri,  6 Sep 2019 07:58:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:40 +0200
Message-Id: <20190906075750.14791-19-david@redhat.com>
In-Reply-To: <20190906075750.14791-1-david@redhat.com>
References: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 06 Sep 2019 07:58:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 18/28] s390x/tcg: MVC: Fault-safe handling
 on destructive overlaps
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last remaining bit for MVC is handling destructive overlaps in a
fault-safe way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2607dd1677..f636f3a011 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -145,6 +145,14 @@ static S390Access access_prepare_idx(CPUS390XState *=
env, vaddr vaddr, int size,
     return access;
 }
=20
+static S390Access access_prepare(CPUS390XState *env, vaddr vaddr, int si=
ze,
+                                 MMUAccessType access_type, uintptr_t ra=
)
+{
+    int mmu_idx =3D cpu_mmu_index(env, false);
+
+    return access_prepare_idx(env, vaddr, size, access_type, mmu_idx, ra=
);
+}
+
 static void access_memset_idx(CPUS390XState *env, vaddr vaddr, uint8_t b=
yte,
                               int size, int mmu_idx, uintptr_t ra)
 {
@@ -420,9 +428,13 @@ static uint32_t do_helper_mvc(CPUS390XState *env, ui=
nt32_t l, uint64_t dest,
     } else if (!is_destructive_overlap(env, dest, src, l)) {
         access_memmove(env, dest, src, l, ra);
     } else {
+        S390Access srca =3D access_prepare(env, src, l, MMU_DATA_LOAD, r=
a);
+        S390Access desta =3D access_prepare(env, dest, l, MMU_DATA_STORE=
, ra);
+
         for (i =3D 0; i < l; i++) {
-            uint8_t x =3D cpu_ldub_data_ra(env, src + i, ra);
-            cpu_stb_data_ra(env, dest + i, x, ra);
+            uint8_t byte =3D access_get_byte(env, &srca, i, ra);
+
+            access_set_byte(env, &desta, i, byte, ra);
         }
     }
=20
--=20
2.21.0


