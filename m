Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B9EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72CB207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72CB207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69UQ-0004hI-1C
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i6997-0004S2-50
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i6994-0003kS-3w
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i6993-0003is-B3; Fri, 06 Sep 2019 03:59:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B6C730860A8;
 Fri,  6 Sep 2019 07:59:00 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAB11001B00;
 Fri,  6 Sep 2019 07:58:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:49 +0200
Message-Id: <20190906075750.14791-28-david@redhat.com>
In-Reply-To: <20190906075750.14791-1-david@redhat.com>
References: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 06 Sep 2019 07:59:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 27/28] s390x/tcg: MVO: Fault-safe handling
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

Each operand can have a maximum length of 16. Make sure to prepare all
reads/writes before writing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 73b00b582b..7403124763 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -514,31 +514,33 @@ void HELPER(mvn)(CPUS390XState *env, uint32_t l, ui=
nt64_t dest, uint64_t src)
 /* move with offset  */
 void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t=
 src)
 {
+    /* MVO always processes one more byte than specified - maximum is 16=
 */
+    const int len_dest =3D (l >> 4) + 1;
+    const int len_src =3D (l & 0xf) + 1;
     uintptr_t ra =3D GETPC();
-    int len_dest =3D l >> 4;
-    int len_src =3D l & 0xf;
     uint8_t byte_dest, byte_src;
-    int i;
+    S390Access srca, desta;
+    int i, j;
=20
-    src +=3D len_src;
-    dest +=3D len_dest;
+    srca =3D access_prepare(env, src, len_src, MMU_DATA_LOAD, ra);
+    desta =3D access_prepare(env, dest, len_dest, MMU_DATA_STORE, ra);
=20
     /* Handle rightmost byte */
-    byte_src =3D cpu_ldub_data_ra(env, src, ra);
-    byte_dest =3D cpu_ldub_data_ra(env, dest, ra);
+    byte_dest =3D cpu_ldub_data_ra(env, dest + len_dest - 1, ra);
+    byte_src =3D access_get_byte(env, &srca, len_src - 1, ra);
     byte_dest =3D (byte_dest & 0x0f) | (byte_src << 4);
-    cpu_stb_data_ra(env, dest, byte_dest, ra);
+    access_set_byte(env, &desta, len_dest - 1, byte_dest, ra);
=20
     /* Process remaining bytes from right to left */
-    for (i =3D 1; i <=3D len_dest; i++) {
+    for (i =3D len_dest - 2, j =3D len_src - 2; i >=3D 0; i--, j--) {
         byte_dest =3D byte_src >> 4;
-        if (len_src - i >=3D 0) {
-            byte_src =3D cpu_ldub_data_ra(env, src - i, ra);
+        if (j >=3D 0) {
+            byte_src =3D access_get_byte(env, &srca, j, ra);
         } else {
             byte_src =3D 0;
         }
         byte_dest |=3D byte_src << 4;
-        cpu_stb_data_ra(env, dest - i, byte_dest, ra);
+        access_set_byte(env, &desta, i, byte_dest, ra);
     }
 }
=20
--=20
2.21.0


