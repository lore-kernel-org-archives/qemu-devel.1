Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB83C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47F72076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YufgOb+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47F72076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdgy-0005yh-Q5
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWd-0004aN-Oq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWS-0004ZL-Tk
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V01QmwyylT+GQs2MhT+/mwQHBZMGEi5RJR8E6uHW5gQ=;
 b=YufgOb+tObqK8tzVCckVG3ivziOWfF86I9BLjdf+Gal0lwbP6UdIN0icQNVl+yM1zOpO51
 Vsjlpe1X/n157BXGZ1/E7dYma2hWcC/137bt9zN0gYIsTNfGPqFOlhzkgim9hY6lX6uFQY
 rntXb+a7b8N2fXzanFXAu/NcDmuIk3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-A1w2BKncM1y5cXX7_S4mRQ-1; Wed, 30 Sep 2020 10:55:57 -0400
X-MC-Unique: A1w2BKncM1y5cXX7_S4mRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC2810BBED1;
 Wed, 30 Sep 2020 14:55:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 817BC5C1C4;
 Wed, 30 Sep 2020 14:55:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/20] s390x/tcg: Implement 64 bit for VECTOR FP LOAD
 LENGTHENED
Date: Wed, 30 Sep 2020 16:55:14 +0200
Message-Id: <20200930145523.71087-12-david@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

64 bit -> 128 bit, there is only a single final element.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/translate_vx.c.inc | 21 ++++++++++++++++-----
 target/s390x/vec_fpu_helper.c   | 13 +++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index ae9f855b05..e643672ec4 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -308,6 +308,7 @@ DEF_HELPER_FLAGS_4(gvec_vfi64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfi128, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfll32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfll32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfll64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vflr64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vflr64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index f6aed65ff5..ff697f3470 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2807,16 +2807,27 @@ static DisasJumpType op_vfll(DisasContext *s, DisasOps *o)
 {
     const uint8_t fpf = get_field(s, m3);
     const uint8_t m4 = get_field(s, m4);
-    gen_helper_gvec_2_ptr *fn = gen_helper_gvec_vfll32;
+    const bool se = extract32(m4, 3, 1);
+    gen_helper_gvec_2_ptr *fn = NULL;
 
-    if (fpf != FPF_SHORT || extract32(m4, 0, 3)) {
+    switch (fpf) {
+    case FPF_SHORT:
+        fn = se ? gen_helper_gvec_vfll32s : gen_helper_gvec_vfll32;
+        break;
+    case FPF_LONG:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = gen_helper_gvec_vfll64;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (!fn || extract32(m4, 0, 3)) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
-    if (extract32(m4, 3, 1)) {
-        fn = gen_helper_gvec_vfll32s;
-    }
     gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env,
                    0, fn);
     return DISAS_NEXT;
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index 9bc7f5c8d7..5ded2ccbcd 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -602,6 +602,19 @@ void HELPER(gvec_vfll32s)(void *v1, const void *v2, CPUS390XState *env,
     vfll32(v1, v2, env, true, GETPC());
 }
 
+void HELPER(gvec_vfll64)(void *v1, const void *v2, CPUS390XState *env,
+                         uint32_t desc)
+{
+    /* load from even element */
+    float128 ret = float64_to_float128(s390_vec_read_float64(v2, 0),
+                                       &env->fpu_status);
+    uint8_t vxc, vec_exc = 0;
+
+    vxc = check_ieee_exc(env, 0, false, &vec_exc);
+    handle_ieee_exc(env, vxc, vec_exc, GETPC());
+    s390_vec_write_float128(v1, 0, ret);
+}
+
 static void vflr64(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
                    bool s, bool XxC, uint8_t erm, uintptr_t retaddr)
 {
-- 
2.26.2


