Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF944C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96050218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8H2pF4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96050218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtnm-000252-OJ
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihtYp-0006nS-VU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihtYo-0000u0-9G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihtYo-0000lK-2U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMFwKfRm+znqqMiwPzP6tu+VjUIlW/d/JXNoyTC3Vb8=;
 b=Q8H2pF4Q8+/OUWcsoY1V2sbLK3LjGvLo5/AnxMplZQaVU9kxIS9+Tc2ziEg0sN89rcqgZP
 /vwomrbtsWbXBbvGSmBLLJvyS9fIqAqBp7VYVAaGMWw+tXpVwFS66+BUHkCgKOq2ZYVl8r
 HTSSkrO9A+1FEuQIKaKhw1vsO9xUB+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-JbfEo7xaMKqw4YLVz-L-KA-1; Thu, 19 Dec 2019 06:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D98B1005513;
 Thu, 19 Dec 2019 11:01:21 +0000 (UTC)
Received: from localhost (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBD7D10013A1;
 Thu, 19 Dec 2019 11:01:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/6] target/s390x: Split out helper_per_store_real
Date: Thu, 19 Dec 2019 12:01:07 +0100
Message-Id: <20191219110112.8343-2-cohuck@redhat.com>
In-Reply-To: <20191219110112.8343-1-cohuck@redhat.com>
References: <20191219110112.8343-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: JbfEo7xaMKqw4YLVz-L-KA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Split the PER handling for store-to-real-address into its
own helper function, conditionally called when PER is
enabled, just as we do for per_branch and per_ifetch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191211203614.15611-2-richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/mem_helper.c  | 16 ----------------
 target/s390x/misc_helper.c | 10 ++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 56e8149866f4..f5b4bb6a316b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -331,6 +331,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i6=
4, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
=20
 DEF_HELPER_2(xsch, void, env, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2325767f1787..b1b3f406c9e0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2344,27 +2344,11 @@ uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t=
 addr)
 void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
-
-    if ((env->psw.mask & PSW_MASK_PER) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
-        /* PSW is saved just before calling the helper.  */
-        env->per_address =3D env->psw.addr;
-        env->per_perc_atmid =3D PER_CODE_EVENT_STORE_REAL | get_per_atmid(=
env);
-    }
 }
=20
 void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
     cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
-
-    if ((env->psw.mask & PSW_MASK_PER) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE) &&
-        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
-        /* PSW is saved just before calling the helper.  */
-        env->per_address =3D env->psw.addr;
-        env->per_perc_atmid =3D PER_CODE_EVENT_STORE_REAL | get_per_atmid(=
env);
-    }
 }
=20
 /* load real address */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index bfb457fb631a..58dbc023eb54 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -620,6 +620,16 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t a=
ddr)
         }
     }
 }
+
+void HELPER(per_store_real)(CPUS390XState *env)
+{
+    if ((env->cregs[9] & PER_CR9_EVENT_STORE) &&
+        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
+        /* PSW is saved just before calling the helper.  */
+        env->per_address =3D env->psw.addr;
+        env->per_perc_atmid =3D PER_CODE_EVENT_STORE_REAL | get_per_atmid(=
env);
+    }
+}
 #endif
=20
 static uint8_t stfl_bytes[2048];
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 151dfa91fb9f..ef751fefa4e5 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4507,12 +4507,20 @@ static DisasJumpType op_stnosm(DisasContext *s, Dis=
asOps *o)
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
     gen_helper_stura(cpu_env, o->in2, o->in1);
+    if (s->base.tb->flags & FLAG_MASK_PER) {
+        update_psw_addr(s);
+        gen_helper_per_store_real(cpu_env);
+    }
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
 {
     gen_helper_sturg(cpu_env, o->in2, o->in1);
+    if (s->base.tb->flags & FLAG_MASK_PER) {
+        update_psw_addr(s);
+        gen_helper_per_store_real(cpu_env);
+    }
     return DISAS_NEXT;
 }
 #endif
--=20
2.21.0


