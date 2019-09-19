Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77580C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B78821907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B78821907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwEM-0003qj-32
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsd-0006Le-FD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvl7-0000Iz-GJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvl5-0000D4-Pi; Thu, 19 Sep 2019 08:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9328B2026F;
 Thu, 19 Sep 2019 12:42:01 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 863076013A;
 Thu, 19 Sep 2019 12:41:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:50 +0200
Message-Id: <20190919124115.11510-10-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 19 Sep 2019 12:42:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/34] s390x/tcg: MVCLU/MVCLE: Process max 4k
 bytes at a time
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's stay within single pages.

... and indicate cc=3D3 in case there is work remaining. Keep unicode
padding simple.

While reworking, properly wrap the addresses.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 54 ++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 746f64730302..86238e0163c8 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -768,8 +768,8 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
                                uint64_t *src, uint64_t *srclen,
                                uint16_t pad, int wordsize, uintptr_t ra)
 {
-    uint64_t len =3D MIN(*srclen, *destlen);
-    uint32_t cc;
+    int len =3D MIN(*destlen, -(*dest | TARGET_PAGE_MASK));
+    int i, cc;
=20
     if (*destlen =3D=3D *srclen) {
         cc =3D 0;
@@ -779,32 +779,40 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
         cc =3D 2;
     }
=20
-    /* Copy the src array */
-    fast_memmove(env, *dest, *src, len, ra);
-    *src +=3D len;
-    *srclen -=3D len;
-    *dest +=3D len;
-    *destlen -=3D len;
+    if (!*destlen) {
+        return cc;
+    }
=20
-    /* Pad the remaining area */
-    if (wordsize =3D=3D 1) {
-        fast_memset(env, *dest, pad, *destlen, ra);
-        *dest +=3D *destlen;
-        *destlen =3D 0;
+    /*
+     * Only perform one type of type of operation (move/pad) at a time.
+     * Stay within single pages.
+     */
+    if (*srclen) {
+        /* Copy the src array */
+        len =3D MIN(MIN(*srclen, -(*src | TARGET_PAGE_MASK)), len);
+        *destlen -=3D len;
+        *srclen -=3D len;
+        fast_memmove(env, *dest, *src, len, ra);
+        *src =3D wrap_address(env, *src + len);
+        *dest =3D wrap_address(env, *dest + len);
+    } else if (wordsize =3D=3D 1) {
+        /* Pad the remaining area */
+        *destlen -=3D len;
+        fast_memset(env, *dest, pad, len, ra);
+        *dest =3D wrap_address(env, *dest + len);
     } else {
-        /* If remaining length is odd, pad with odd byte first.  */
-        if (*destlen & 1) {
-            cpu_stb_data_ra(env, *dest, pad & 0xff, ra);
-            *dest +=3D 1;
-            *destlen -=3D 1;
-        }
-        /* The remaining length is even, pad using words.  */
-        for (; *destlen; *dest +=3D 2, *destlen -=3D 2) {
-            cpu_stw_data_ra(env, *dest, pad, ra);
+        /* The remaining length selects the padding byte. */
+        for (i =3D 0; i < len; (*destlen)--, i++) {
+            if (*destlen & 1) {
+                cpu_stb_data_ra(env, *dest, pad, ra);
+            } else {
+                cpu_stb_data_ra(env, *dest, pad >> 8, ra);
+            }
+            *dest =3D wrap_address(env, *dest + 1);
         }
     }
=20
-    return cc;
+    return *destlen ? 3 : cc;
 }
=20
 /* move long */
--=20
2.20.1


