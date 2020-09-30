Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD5C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37ED2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNuVu8nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37ED2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdlL-0002kT-QE
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWH-0004Ai-2o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWF-0004XB-8H
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGdkt3398dcvGwdEkRZfwJVGALtt/cPv1clzsspwtEc=;
 b=SNuVu8nt0jIw753fxRol9wFBdr4aUQIjS7b3UeBR7Ktx8YLMYLY2CrcZqOwUbKPY9L7nzW
 KDTNGT3cw/lPJS1Ca68krTu6D/PNqvTR5YrUA/C5pv/WX6gwJH5X3FGooLADyS72BEwgbY
 IoakOKgtJ2MV17gcor6hoXmVl0fEVhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-_hPARnlWOSSJbCn7Nb1pWQ-1; Wed, 30 Sep 2020 10:55:44 -0400
X-MC-Unique: _hPARnlWOSSJbCn7Nb1pWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61BB5807340;
 Wed, 30 Sep 2020 14:55:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B28635C1C4;
 Wed, 30 Sep 2020 14:55:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 MULTIPLY
Date: Wed, 30 Sep 2020 16:55:09 +0200
Message-Id: <20200930145523.71087-7-david@redhat.com>
In-Reply-To: <20200930145523.71087-1-david@redhat.com>
References: <20200930145523.71087-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just like VECTOR FP ADD.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  3 +++
 target/s390x/translate_vx.c.inc | 18 +++++++++++++++++-
 target/s390x/vec_fpu_helper.c   | 28 +++++++++++++++-------------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 3dfd480fc1..a7a902ed9c 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -285,8 +285,11 @@ DEF_HELPER_FLAGS_4(gvec_vfll32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfll32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vflr64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vflr64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfm32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfm32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfm128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index ea1b2732bc..65385ce5ee 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2546,7 +2546,23 @@ static DisasJumpType op_vfa(DisasContext *s, DisasOps *o)
         }
         break;
     case 0xe7:
-        fn = se ? gen_helper_gvec_vfm64s : gen_helper_gvec_vfm64;
+        switch (fpf) {
+        case FPF_SHORT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = se ? gen_helper_gvec_vfm32s : gen_helper_gvec_vfm32;
+            }
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfm64s : gen_helper_gvec_vfm64;
+            break;
+        case FPF_EXT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = gen_helper_gvec_vfm128;
+            }
+            break;
+        default:
+            break;
+        }
         break;
     case 0xe2:
         fn = se ? gen_helper_gvec_vfs64s : gen_helper_gvec_vfs64;
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index cfa143b62a..335d540622 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -531,22 +531,24 @@ void HELPER(gvec_vflr64s)(void *v1, const void *v2, CPUS390XState *env,
     vflr64(v1, v2, env, true, XxC, erm, GETPC());
 }
 
-static uint64_t vfm64(uint64_t a, uint64_t b, float_status *s)
-{
-    return float64_mul(a, b, s);
-}
-
-void HELPER(gvec_vfm64)(void *v1, const void *v2, const void *v3,
-                        CPUS390XState *env, uint32_t desc)
-{
-    vop64_3(v1, v2, v3, env, false, vfm64, GETPC());
+#define DEF_GVEC_FVM(BITS)                                                     \
+void HELPER(gvec_vfm##BITS)(void *v1, const void *v2, const void *v3,          \
+                            CPUS390XState *env, uint32_t desc)                 \
+{                                                                              \
+    vop##BITS##_3(v1, v2, v3, env, false, float##BITS##_mul, GETPC());         \
 }
+DEF_GVEC_FVM(32)
+DEF_GVEC_FVM(64)
+DEF_GVEC_FVM(128)
 
-void HELPER(gvec_vfm64s)(void *v1, const void *v2, const void *v3,
-                         CPUS390XState *env, uint32_t desc)
-{
-    vop64_3(v1, v2, v3, env, true, vfm64, GETPC());
+#define DEF_GVEC_FVM_S(BITS)                                                   \
+void HELPER(gvec_vfm##BITS##s)(void *v1, const void *v2, const void *v3,       \
+                               CPUS390XState *env, uint32_t desc)              \
+{                                                                              \
+    vop##BITS##_3(v1, v2, v3, env, true, float##BITS##_mul, GETPC());          \
 }
+DEF_GVEC_FVM_S(32)
+DEF_GVEC_FVM_S(64)
 
 static void vfma64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
                    const S390Vector *v4, CPUS390XState *env, bool s, int flags,
-- 
2.26.2


