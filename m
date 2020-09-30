Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D14C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCC22076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="any9ZRfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCC22076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNde4-0002WT-Vh
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWd-0004YI-1I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWX-0004Zu-7j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCN2lwrwkPXBMuFOknK2YW9Gs7NFIK9CeOOmM+HiQaU=;
 b=any9ZRfhM4v+z5UrMuX0vEjsDQ5+pe7ZCElt15eqFz18TuKwPKmIGz0ZEoNYNZEGhX5c1J
 Qs7V0kv+r9Gi0VWPg4U3qUgYs8dN8y7TDkvK2IEDmB9vqtqCeQ5QspaqkRCa6Z87PsSot8
 4D1yo58RBk6V1j1/yOLIBOeubDzQyVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-OggmO_OqNASDF32vGJzT4A-1; Wed, 30 Sep 2020 10:56:01 -0400
X-MC-Unique: OggmO_OqNASDF32vGJzT4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325801891E87;
 Wed, 30 Sep 2020 14:56:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 998775C1C4;
 Wed, 30 Sep 2020 14:55:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 13/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 PERFORM SIGN OPERATION
Date: Wed, 30 Sep 2020 16:55:16 +0200
Message-Id: <20200930145523.71087-14-david@redhat.com>
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate_vx.c.inc | 100 +++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 0b21e8789f..ee79d97e19 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2872,48 +2872,82 @@ static DisasJumpType op_vfpso(DisasContext *s, DisasOps *o)
     const uint8_t fpf = get_field(s, m3);
     const uint8_t m4 = get_field(s, m4);
     const uint8_t m5 = get_field(s, m5);
+    const bool se = extract32(m4, 3, 1);
     TCGv_i64 tmp;
 
-    if (fpf != FPF_LONG || extract32(m4, 0, 3) || m5 > 2) {
+    if ((fpf != FPF_LONG && !s390_has_feat(S390_FEAT_VECTOR_ENH)) ||
+        extract32(m4, 0, 3) || m5 > 2) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
-    if (extract32(m4, 3, 1)) {
-        tmp = tcg_temp_new_i64();
-        read_vec_element_i64(tmp, v2, 0, ES_64);
-        switch (m5) {
-        case 0:
-            /* sign bit is inverted (complement) */
-            tcg_gen_xori_i64(tmp, tmp, 1ull << 63);
-            break;
-        case 1:
-            /* sign bit is set to one (negative) */
-            tcg_gen_ori_i64(tmp, tmp, 1ull << 63);
-            break;
-        case 2:
-            /* sign bit is set to zero (positive) */
-            tcg_gen_andi_i64(tmp, tmp, (1ull << 63) - 1);
-            break;
+    switch (fpf) {
+    case FPF_SHORT:
+        if (!se) {
+            switch (m5) {
+            case 0:
+                /* sign bit is inverted (complement) */
+                gen_gvec_fn_2i(xori, ES_32, v1, v2, 1ull << 31);
+                break;
+            case 1:
+                /* sign bit is set to one (negative) */
+                gen_gvec_fn_2i(ori, ES_32, v1, v2, 1ull << 31);
+                break;
+            case 2:
+                /* sign bit is set to zero (positive) */
+                gen_gvec_fn_2i(andi, ES_32, v1, v2, (1ull << 31) - 1);
+                break;
+            }
+            return DISAS_NEXT;
         }
-        write_vec_element_i64(tmp, v1, 0, ES_64);
-        tcg_temp_free_i64(tmp);
-    } else {
-        switch (m5) {
-        case 0:
-            /* sign bit is inverted (complement) */
-            gen_gvec_fn_2i(xori, ES_64, v1, v2, 1ull << 63);
-            break;
-        case 1:
-            /* sign bit is set to one (negative) */
-            gen_gvec_fn_2i(ori, ES_64, v1, v2, 1ull << 63);
-            break;
-        case 2:
-            /* sign bit is set to zero (positive) */
-            gen_gvec_fn_2i(andi, ES_64, v1, v2, (1ull << 63) - 1);
-            break;
+        break;
+    case FPF_LONG:
+        if (!se) {
+            switch (m5) {
+            case 0:
+                /* sign bit is inverted (complement) */
+                gen_gvec_fn_2i(xori, ES_64, v1, v2, 1ull << 63);
+                break;
+            case 1:
+                /* sign bit is set to one (negative) */
+                gen_gvec_fn_2i(ori, ES_64, v1, v2, 1ull << 63);
+                break;
+            case 2:
+                /* sign bit is set to zero (positive) */
+                gen_gvec_fn_2i(andi, ES_64, v1, v2, (1ull << 63) - 1);
+                break;
+            }
+            return DISAS_NEXT;
         }
+        break;
+    case FPF_EXT:
+        /* Only a single element. */
+        break;
+    default:
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* With a single element, we are only interested in bit 0. */
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, v2, 0, ES_64);
+    switch (m5) {
+    case 0:
+        /* sign bit is inverted (complement) */
+        tcg_gen_xori_i64(tmp, tmp, 1ull << 63);
+        break;
+    case 1:
+        /* sign bit is set to one (negative) */
+        tcg_gen_ori_i64(tmp, tmp, 1ull << 63);
+        break;
+    case 2:
+        /* sign bit is set to zero (positive) */
+        tcg_gen_andi_i64(tmp, tmp, (1ull << 63) - 1);
+        break;
     }
+    write_vec_element_i64(tmp, v1, 0, ES_64);
+    tcg_temp_free_i64(tmp);
+
     return DISAS_NEXT;
 }
 
-- 
2.26.2


