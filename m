Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B599C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE97520719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU5sGPkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE97520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5HC-0004il-4f
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0002UU-9m
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0000Lq-7X
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5Ay-0000Kj-3T
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQbtW20VeBRzAfEmdwTdAX4X14E+HlJSxEi4k04fnyQ=;
 b=BU5sGPkJ2TDK40sQdcb8IbQvWuVcp0cHzyZlE+vyNGcB1tZ46qmeSjgxGifXKmosQxgZyX
 hb/h4yD+mcKOAAvABQR9jUrnrHrnBO9y9ifCbxrLKRXWTyCfIum1MRKSGBECDZXSOdkj4f
 GR5uHLvOndnf6rreUDYGBShDw+R10Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-g7J99xCQMyCpt8a7Csgreg-1; Thu, 02 Apr 2020 15:06:49 -0400
X-MC-Unique: g7J99xCQMyCpt8a7Csgreg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A3A107ACC4;
 Thu,  2 Apr 2020 19:06:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58F9E50BEE;
 Thu,  2 Apr 2020 19:06:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] util/bufferiszero: improve avx2 accelerator
Date: Thu,  2 Apr 2020 15:06:32 -0400
Message-Id: <20200402190640.1693-8-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

By increasing avx2 length_to_accel to 128, we can simplify its logic and re=
duce a
branch.

The authorship of this patch actually belongs to Richard Henderson
<richard.henderson@linaro.org>, I just fixed a boundary case on his
original patch.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/bufferiszero.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index b8012532e4..695bb4ce28 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -158,27 +158,19 @@ buffer_zero_avx2(const void *buf, size_t len)
     __m256i *p =3D (__m256i *)(((uintptr_t)buf + 5 * 32) & -32);
     __m256i *e =3D (__m256i *)(((uintptr_t)buf + len) & -32);
=20
-    if (likely(p <=3D e)) {
-        /* Loop over 32-byte aligned blocks of 128.  */
-        do {
-            __builtin_prefetch(p);
-            if (unlikely(!_mm256_testz_si256(t, t))) {
-                return false;
-            }
-            t =3D p[-4] | p[-3] | p[-2] | p[-1];
-            p +=3D 4;
-        } while (p <=3D e);
-    } else {
-        t |=3D _mm256_loadu_si256(buf + 32);
-        if (len <=3D 128) {
-            goto last2;
+    /* Loop over 32-byte aligned blocks of 128.  */
+    while (p <=3D e) {
+        __builtin_prefetch(p);
+        if (unlikely(!_mm256_testz_si256(t, t))) {
+            return false;
         }
-    }
+        t =3D p[-4] | p[-3] | p[-2] | p[-1];
+        p +=3D 4;
+    } ;
=20
     /* Finish the last block of 128 unaligned.  */
     t |=3D _mm256_loadu_si256(buf + len - 4 * 32);
     t |=3D _mm256_loadu_si256(buf + len - 3 * 32);
- last2:
     t |=3D _mm256_loadu_si256(buf + len - 2 * 32);
     t |=3D _mm256_loadu_si256(buf + len - 1 * 32);
=20
@@ -263,7 +255,7 @@ static void init_accel(unsigned cache)
     }
     if (cache & CACHE_AVX2) {
         fn =3D buffer_zero_avx2;
-        length_to_accel =3D 64;
+        length_to_accel =3D 128;
     }
 #endif
 #ifdef CONFIG_AVX512F_OPT
--=20
2.18.2



