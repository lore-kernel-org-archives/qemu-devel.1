Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A8C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC3F214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC3F214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rkL-0000Mn-Jo
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i9rWv-00032O-8O
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i9rWu-0000Lc-28
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i9rWt-0000LF-NV; Mon, 16 Sep 2019 09:58:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E677789F39E;
 Mon, 16 Sep 2019 13:58:58 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAD1110013A1;
 Mon, 16 Sep 2019 13:58:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:57:49 +0200
Message-Id: <20190916135806.1269-13-david@redhat.com>
In-Reply-To: <20190916135806.1269-1-david@redhat.com>
References: <20190916135806.1269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 16 Sep 2019 13:58:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 12/29] s390x/tcg: MVCS/MVCP: Properly wrap
 the length
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

... and don't perform any move in case the length is zero.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 320e9ee65c..41d7336a1a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1980,10 +1980,13 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_=
t l, uint64_t a1, uint64_t a2)
         s390_program_interrupt(env, PGM_SPECIAL_OP, ILEN_AUTO, ra);
     }
=20
+    l =3D wrap_length32(env, l);
     if (l > 256) {
         /* max 256 */
         l =3D 256;
         cc =3D 3;
+    } else if (!l) {
+        return cc;
     }
=20
     /* XXX replace w/ memcpy */
@@ -2009,10 +2012,13 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_=
t l, uint64_t a1, uint64_t a2)
         s390_program_interrupt(env, PGM_SPECIAL_OP, ILEN_AUTO, ra);
     }
=20
+    l =3D wrap_length32(env, l);
     if (l > 256) {
         /* max 256 */
         l =3D 256;
         cc =3D 3;
+    } else if (!l) {
+        return cc;
     }
=20
     /* XXX replace w/ memcpy */
--=20
2.21.0


