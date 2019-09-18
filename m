Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF7C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC5220578
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC5220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcmQ-000806-FW
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iAbth-000077-JF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iAbtg-0007ae-CW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iAbtg-0007Zk-7P; Wed, 18 Sep 2019 11:29:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30E96191864A;
 Wed, 18 Sep 2019 15:29:35 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-119.ams2.redhat.com [10.36.117.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B985D6A5;
 Wed, 18 Sep 2019 15:29:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 17:28:55 +0200
Message-Id: <20190918152922.18949-3-david@redhat.com>
In-Reply-To: <20190918152922.18949-1-david@redhat.com>
References: <20190918152922.18949-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 18 Sep 2019 15:29:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 02/29] s390x/tcg: MVCL: Zero out
 unused bits of address
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

We have to zero out unused bits in 24 and 31-bit addressing mode.
Provide a new helper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 39ee9b3175..b02ad148e5 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -469,6 +469,25 @@ static inline uint64_t get_address(CPUS390XState *en=
v, int reg)
     return wrap_address(env, env->regs[reg]);
 }
=20
+/*
+ * Store the address to the given register, zeroing out unused leftmost
+ * bits in bit positions 32-63 (24-bit and 31-bit mode only).
+ */
+static inline void set_address_zero(CPUS390XState *env, int reg,
+                                    uint64_t address)
+{
+    if (env->psw.mask & PSW_MASK_64) {
+        env->regs[reg] =3D address;
+    } else {
+        if (!(env->psw.mask & PSW_MASK_32)) {
+            address &=3D 0x00ffffff;
+        } else {
+            address &=3D 0x7fffffff;
+        }
+        env->regs[reg] =3D deposit64(env->regs[reg], 0, 32, address);
+    }
+}
+
 static inline void set_address(CPUS390XState *env, int reg, uint64_t add=
ress)
 {
     if (env->psw.mask & PSW_MASK_64) {
@@ -772,8 +791,8 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1=
, uint32_t r2)
=20
     env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destlen);
     env->regs[r2 + 1] =3D deposit64(env->regs[r2 + 1], 0, 24, srclen);
-    set_address(env, r1, dest);
-    set_address(env, r2, src);
+    set_address_zero(env, r1, dest);
+    set_address_zero(env, r2, src);
=20
     return cc;
 }
--=20
2.21.0


