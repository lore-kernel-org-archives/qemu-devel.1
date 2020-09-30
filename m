Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40728C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F532076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQimIMPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F532076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdbn-0000sK-Nf
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdW8-00040C-E2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdW5-0004RB-0e
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3zt8IvjPnzxfdl/vyn/mDfm3I4+w3NVza1ZnFke6G8=;
 b=ZQimIMPR8Z8bwjx0MPmdlQVyJXLLCXGKzcAv0oojBdylqjEUncLNNPR9M0Wg+l4w76aYq5
 xj47YqkZmuUvP1siNmRyOKci4ft1pGrDW4p81a6qxaDc7lrTG+sSwrK7Kv5BkS16jR2RqL
 WJTUWEASvhieHE5xrQZVQkS//obNGlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-UlU9s5lmOr6jhY5UIbhTmw-1; Wed, 30 Sep 2020 10:55:34 -0400
X-MC-Unique: UlU9s5lmOr6jhY5UIbhTmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06CC38015B0;
 Wed, 30 Sep 2020 14:55:33 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD1C35C1C4;
 Wed, 30 Sep 2020 14:55:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/20] softfloat: Implement
 float128_(min|minnum|minnummag|max|maxnum|maxnummag)
Date: Wed, 30 Sep 2020 16:55:04 +0200
Message-Id: <20200930145523.71087-2-david@redhat.com>
In-Reply-To: <20200930145523.71087-1-david@redhat.com>
References: <20200930145523.71087-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementation inspired by minmax_floats(). Unfortuantely, we don't have
any tests we can simply adjust/unlock.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Alex Bennée" <alex.bennee@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fpu/softfloat.c         | 100 ++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |   6 +++
 2 files changed, 106 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9af75b9146..9463c5ea56 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -621,6 +621,8 @@ static inline FloatParts float64_unpack_raw(float64 f)
     return unpack_raw(float64_params, f);
 }
 
+static void float128_unpack(FloatParts128 *p, float128 a, float_status *status);
+
 /* Pack a float from parts, but do not canonicalize.  */
 static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
 {
@@ -3180,6 +3182,89 @@ static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
     }
 }
 
+static float128 float128_minmax(float128 a, float128 b, bool ismin, bool ieee,
+                                bool ismag, float_status *s)
+{
+    FloatParts128 pa, pb;
+    int a_exp, b_exp;
+    bool a_less;
+
+    float128_unpack(&pa, a, s);
+    float128_unpack(&pb, b, s);
+
+    if (unlikely(is_nan(pa.cls) || is_nan(pb.cls))) {
+        /* See comment in minmax_floats() */
+        if (ieee && !is_snan(pa.cls) && !is_snan(pb.cls)) {
+            if (is_nan(pa.cls) && !is_nan(pb.cls)) {
+                return b;
+            } else if (is_nan(pb.cls) && !is_nan(pa.cls)) {
+                return a;
+            }
+        }
+
+        /* Similar logic to pick_nan(), avoiding re-packing. */
+        if (is_snan(pa.cls) || is_snan(pb.cls)) {
+            s->float_exception_flags |= float_flag_invalid;
+        }
+        if (s->default_nan_mode) {
+            return float128_default_nan(s);
+        }
+        if (pickNaN(pa.cls, pb.cls,
+                    pa.frac0 > pb.frac0 ||
+                    (pa.frac0 == pb.frac0 && pa.frac1 > pb.frac1) ||
+                    (pa.frac0 == pb.frac0 && pa.frac1 == pb.frac1 &&
+                     pa.sign < pb.sign), s)) {
+            return is_snan(pb.cls) ? float128_silence_nan(b, s) : b;
+        }
+        return is_snan(pa.cls) ? float128_silence_nan(a, s) : a;
+    }
+
+    switch (pa.cls) {
+    case float_class_normal:
+        a_exp = pa.exp;
+        break;
+    case float_class_inf:
+        a_exp = INT_MAX;
+        break;
+    case float_class_zero:
+        a_exp = INT_MIN;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+    switch (pb.cls) {
+    case float_class_normal:
+        b_exp = pb.exp;
+        break;
+    case float_class_inf:
+        b_exp = INT_MAX;
+        break;
+    case float_class_zero:
+        b_exp = INT_MIN;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    a_less = a_exp < b_exp;
+    if (a_exp == b_exp) {
+        a_less = pa.frac0 < pb.frac0;
+        if (pa.frac0 == pb.frac0) {
+            a_less = pa.frac1 < pb.frac1;
+        }
+    }
+
+    if (ismag &&
+        (a_exp != b_exp || pa.frac0 != pb.frac0 || pa.frac1 != pb.frac1)) {
+        return a_less ^ ismin ? b : a;
+    } else if (pa.sign == pb.sign) {
+        return pa.sign ^ a_less ^ ismin ? b : a;
+    }
+    return pa.sign ^ ismin ? b : a;
+}
+
 #define MINMAX(sz, name, ismin, isiee, ismag)                           \
 float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz b,      \
                                      float_status *s)                   \
@@ -3214,6 +3299,21 @@ MINMAX(64, maxnummag, false, true, true)
 
 #undef MINMAX
 
+#define F128_MINMAX(name, ismin, isiee, ismag)                          \
+float128 float128_ ## name(float128 a, float128 b, float_status *s)     \
+{                                                                       \
+    return float128_minmax(a, b, ismin, isiee, ismag, s);               \
+}
+
+F128_MINMAX(min, true, false, false)
+F128_MINMAX(minnum, true, true, false)
+F128_MINMAX(minnummag, true, true, true)
+F128_MINMAX(max, false, false, false)
+F128_MINMAX(maxnum, false, true, false)
+F128_MINMAX(maxnummag, false, true, true)
+
+#undef F128_MINMAX
+
 #define BF16_MINMAX(name, ismin, isiee, ismag)                          \
 bfloat16 bfloat16_ ## name(bfloat16 a, bfloat16 b, float_status *s)     \
 {                                                                       \
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index a38433deb4..4fab2ef6f4 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1201,6 +1201,12 @@ float128 float128_muladd(float128, float128, float128, int,
 float128 float128_sqrt(float128, float_status *status);
 FloatRelation float128_compare(float128, float128, float_status *status);
 FloatRelation float128_compare_quiet(float128, float128, float_status *status);
+float128 float128_min(float128, float128, float_status *status);
+float128 float128_max(float128, float128, float_status *status);
+float128 float128_minnum(float128, float128, float_status *status);
+float128 float128_maxnum(float128, float128, float_status *status);
+float128 float128_minnummag(float128, float128, float_status *status);
+float128 float128_maxnummag(float128, float128, float_status *status);
 bool float128_is_quiet_nan(float128, float_status *status);
 bool float128_is_signaling_nan(float128, float_status *status);
 float128 float128_silence_nan(float128, float_status *status);
-- 
2.26.2


