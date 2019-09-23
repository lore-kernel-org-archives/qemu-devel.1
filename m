Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E56C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A868B20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJZt-0004Hq-GM
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJNU-0001XA-QH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJNT-0003wE-Kt
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iCJNT-0003w1-Fi; Mon, 23 Sep 2019 04:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C938783F40;
 Mon, 23 Sep 2019 08:07:22 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A11419C78;
 Mon, 23 Sep 2019 08:07:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 03/30] s390x/tcg: MVCL: Detect destructive overlaps
Date: Mon, 23 Sep 2019 10:06:45 +0200
Message-Id: <20190923080712.23951-4-david@redhat.com>
In-Reply-To: <20190923080712.23951-1-david@redhat.com>
References: <20190923080712.23951-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 23 Sep 2019 08:07:22 +0000 (UTC)
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

We'll have to zero-out unused bit positions, so make sure to write the
addresses back.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b02ad148e5..223312a4b1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -52,6 +52,19 @@ static inline bool psw_key_valid(CPUS390XState *env, u=
int8_t psw_key)
     return true;
 }
=20
+static bool is_destructive_overlap(CPUS390XState *env, uint64_t dest,
+                                   uint64_t src, uint32_t len)
+{
+    if (!len || src =3D=3D dest) {
+        return false;
+    }
+    /* Take care of wrapping at the end of address space. */
+    if (unlikely(wrap_address(env, src + len - 1) < src)) {
+        return dest > src || dest <=3D wrap_address(env, src + len - 1);
+    }
+    return dest > src && dest <=3D src + len - 1;
+}
+
 /* Reduce the length so that addr + len doesn't cross a page boundary.  =
*/
 static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
 {
@@ -787,7 +800,11 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r=
1, uint32_t r2)
     uint8_t pad =3D env->regs[r2 + 1] >> 24;
     uint32_t cc;
=20
-    cc =3D do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
+    if (is_destructive_overlap(env, dest, src, MIN(srclen, destlen))) {
+        cc =3D 3;
+    } else {
+        cc =3D do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
+    }
=20
     env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destlen);
     env->regs[r2 + 1] =3D deposit64(env->regs[r2 + 1], 0, 24, srclen);
--=20
2.21.0


