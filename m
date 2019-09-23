Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E7C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F80920835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F80920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJYO-000347-Bo
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJNp-0001yK-ST
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJNo-00045m-Oc
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iCJNo-00045M-IS; Mon, 23 Sep 2019 04:07:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7704309BDF2;
 Mon, 23 Sep 2019 08:07:43 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE26819C78;
 Mon, 23 Sep 2019 08:07:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 11/30] s390x/tcg: MVCOS: Lengths are 32 bit in 24/31-bit mode
Date: Mon, 23 Sep 2019 10:06:53 +0200
Message-Id: <20190923080712.23951-12-david@redhat.com>
In-Reply-To: <20190923080712.23951-1-david@redhat.com>
References: <20190923080712.23951-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 08:07:43 +0000 (UTC)
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

Triggered by a review comment from Richard, also MVCOS has a 32-bit
length in 24/31-bit addressing mode. Add a new helper.

Rename wrap_length() to wrap_length31().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 20e1ac0ea9..320e9ee65c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -528,7 +528,15 @@ static inline void set_address(CPUS390XState *env, i=
nt reg, uint64_t address)
     }
 }
=20
-static inline uint64_t wrap_length(CPUS390XState *env, uint64_t length)
+static inline uint64_t wrap_length32(CPUS390XState *env, uint64_t length=
)
+{
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        return (uint32_t)length;
+    }
+    return length;
+}
+
+static inline uint64_t wrap_length31(CPUS390XState *env, uint64_t length=
)
 {
     if (!(env->psw.mask & PSW_MASK_64)) {
         /* 24-Bit and 31-Bit mode */
@@ -539,7 +547,7 @@ static inline uint64_t wrap_length(CPUS390XState *env=
, uint64_t length)
=20
 static inline uint64_t get_length(CPUS390XState *env, int reg)
 {
-    return wrap_length(env, env->regs[reg]);
+    return wrap_length31(env, env->regs[reg]);
 }
=20
 static inline void set_length(CPUS390XState *env, int reg, uint64_t leng=
th)
@@ -2378,7 +2386,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t=
 dest, uint64_t src,
         s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
     }
=20
-    len =3D wrap_length(env, len);
+    len =3D wrap_length32(env, len);
     if (len > 4096) {
         cc =3D 3;
         len =3D 4096;
--=20
2.21.0


