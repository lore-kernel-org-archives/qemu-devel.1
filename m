Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAECC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FE4214DE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FE4214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rZG-0004nI-Mg
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i9rWc-0002pD-TF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i9rWb-0000Bf-4X
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i9rWa-0000BV-Se; Mon, 16 Sep 2019 09:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2268A30832E1;
 Mon, 16 Sep 2019 13:58:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26EB110013A1;
 Mon, 16 Sep 2019 13:58:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:57:41 +0200
Message-Id: <20190916135806.1269-5-david@redhat.com>
In-Reply-To: <20190916135806.1269-1-david@redhat.com>
References: <20190916135806.1269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 16 Sep 2019 13:58:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 04/29] s390x/tcg: MVCL: Process max 4k bytes
 at a time
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
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Process max 4k bytes at a time, writing back registers between the
accesses. The instruction is interruptible.
    "For operands longer than 2K bytes, access exceptions are not
    recognized for locations more than 2K bytes beyond the current locati=
on
    being processed."
Note that on z/Architecture, 2k vs. 4k access cannot get differentiated a=
s
long as pages are not crossed. This seems to be a leftover from ESA/390.
Simply stay within single pages.

MVCL handling is quite different than MVCLE/MVCLU handling, so split up
the handlers.

Defer interrupt handling, as that will require more thought, add a TODO
for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 44 +++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 223312a4b1..58ab2e48e3 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -798,19 +798,51 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t =
r1, uint32_t r2)
     uint64_t srclen =3D env->regs[r2 + 1] & 0xffffff;
     uint64_t src =3D get_address(env, r2);
     uint8_t pad =3D env->regs[r2 + 1] >> 24;
-    uint32_t cc;
+    uint32_t cc, cur_len;
=20
     if (is_destructive_overlap(env, dest, src, MIN(srclen, destlen))) {
         cc =3D 3;
+    } else if (srclen =3D=3D destlen) {
+        cc =3D 0;
+    } else if (destlen < srclen) {
+        cc =3D 1;
     } else {
-        cc =3D do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
+        cc =3D 2;
     }
=20
-    env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destlen);
-    env->regs[r2 + 1] =3D deposit64(env->regs[r2 + 1], 0, 24, srclen);
-    set_address_zero(env, r1, dest);
-    set_address_zero(env, r2, src);
+    /* We might have to zero-out some bits even if there was no action. =
*/
+    if (unlikely(!destlen || cc =3D=3D 3)) {
+        set_address_zero(env, r2, src);
+        set_address_zero(env, r1, dest);
+        return cc;
+    } else if (!srclen) {
+        set_address_zero(env, r2, src);
+    }
=20
+    /*
+     * Only perform one type of type of operation (move/pad) in one step=
.
+     * Stay within single pages.
+     */
+    while (destlen) {
+        cur_len =3D MIN(destlen, -(dest | TARGET_PAGE_MASK));
+        if (!srclen) {
+            fast_memset(env, dest, pad, cur_len, ra);
+        } else {
+            cur_len =3D MIN(MIN(srclen, -(src | TARGET_PAGE_MASK)), cur_=
len);
+
+            fast_memmove(env, dest, src, cur_len, ra);
+            src =3D wrap_address(env, src + cur_len);
+            srclen -=3D cur_len;
+            env->regs[r2 + 1] =3D deposit64(env->regs[r2 + 1], 0, 24, sr=
clen);
+            set_address_zero(env, r2, src);
+        }
+        dest =3D wrap_address(env, dest + cur_len);
+        destlen -=3D cur_len;
+        env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destle=
n);
+        set_address_zero(env, r1, dest);
+
+        /* TODO: Deliver interrupts. */
+    }
     return cc;
 }
=20
--=20
2.21.0


