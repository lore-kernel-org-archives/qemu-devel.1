Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D545FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03012171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmSW7tlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03012171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw16N-0003ug-Vp
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13q-0005xQ-H9
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13o-0007ZT-NW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13o-0007YZ-GE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id g67so4978981wme.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eEMHgW3CEtVoVhBt+Bh6CcPxxVC+F3D05JqH8hwh+u8=;
 b=cmSW7tlXM+73QMGnVfDLSah8HW6ICyaZ1pinWS9BasGbEScKDipDYS/W1VkSqjNoSZ
 ZcCfX/yQTC83OAFlxzXabGcC8r6uT24v1boiuuNUduar6/W9gpRzE999kMoRyt8+TpzU
 SLof7R6wakknvLMJNeTPbMDLlkN4+Atcv+D72m43hq2dtxgibK6lSnUjcVr7pWQECzbp
 C4vaCbapAw6xczzmjIq5qGxzrxwmId/18jI0oyhzbNxoQyzIoVAXz4fYvZYI3RC0YNlj
 ijMMxCBagCBnHDSVvJCA+qq+z6FM0MYQvUjumXtOpOYrT5iCnhnKhe5yPyY9kA/mtcKf
 cwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eEMHgW3CEtVoVhBt+Bh6CcPxxVC+F3D05JqH8hwh+u8=;
 b=oJ0YXiEqqEYD22vCoSFEpKPpCsW5A4q4JvEd6Wijb5E+pa2upfHQtJ0aCLsPQFRyv9
 IDNGwSR8opxg1R5I71SOVswb4zC9+Ji2YWy6B9UAvGCehDOz412ZmhcsuEzcYnbCEYQN
 oWIo8robFPy5g9Y/lBiLMnu/z7gBbL4Uyhqe5kB4+U/pceeq1MpdknYKzol1MxbXaukM
 a2oVhEPdXYoS064uyfRc3TDScs+0Kva38BcZlQJ1swVMQHXuTjMOOPJEeiCVciWxElmO
 jFVBHp5hxcO1MTxidDVAoXMZAlxm/1pbqxnhSYfBwN4rEMvv/URSh+yS3Rxz676x24vl
 usQw==
X-Gm-Message-State: APjAAAWX1ysiVWTZivx2h3ldMEEQUCiqaEB/mebPqpvwPC0cS/a+zvQX
 f2gNin7wOl9c9NAuOG0Q4RnKt+GUCRY=
X-Google-Smtp-Source: APXvYqwawdB1tStf9Fqh4rGLSR5zBHoz3pYsL79hR/n0AC7C4vkDMAnwOPOvQ2RX3uldQT9C2CjsqQ==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr2697363wmk.148.1565342383302; 
 Fri, 09 Aug 2019 02:19:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a26sm8572727wmg.45.2019.08.09.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:41 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 15B761FF8F;
 Fri,  9 Aug 2019 10:19:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:35 +0100
Message-Id: <20190809091940.1223-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
References: <20190809091940.1223-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 2/7] fpu: move inline helpers into a
 separate header
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a bunch of users of the inline helpers who do not need
access to the entire softfloat API. Move those inline helpers into a
new header file which can be included without bringing in the rest of
the world.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - don't squash up quite so much
---
 include/fpu/softfloat-helpers.h | 132 ++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h         |  63 +--------------
 2 files changed, 133 insertions(+), 62 deletions(-)
 create mode 100644 include/fpu/softfloat-helpers.h

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
new file mode 100644
index 00000000000..e0baf24c8f5
--- /dev/null
+++ b/include/fpu/softfloat-helpers.h
@@ -0,0 +1,132 @@
+/*
+ * QEMU float support - standalone helpers
+ *
+ * This is provided for files that don't need the access to the full
+ * set of softfloat functions. Typically this is cpu initialisation
+ * code which wants to set default rounding and exceptions modes.
+ *
+ * The code in this source file is derived from release 2a of the SoftFloat
+ * IEC/IEEE Floating-point Arithmetic Package. Those parts of the code (and
+ * some later contributions) are provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file after December 1st 2014 will be
+ * taken to be licensed under the Softfloat-2a license unless specifically
+ * indicated otherwise.
+ */
+
+/*
+===============================================================================
+This C header file is part of the SoftFloat IEC/IEEE Floating-point
+Arithmetic Package, Release 2a.
+
+Written by John R. Hauser.  This work was made possible in part by the
+International Computer Science Institute, located at Suite 600, 1947 Center
+Street, Berkeley, California 94704.  Funding was partially provided by the
+National Science Foundation under grant MIP-9311980.  The original version
+of this code was written as part of a project to build a fixed-point vector
+processor in collaboration with the University of California at Berkeley,
+overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
+is available through the Web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
+arithmetic/SoftFloat.html'.
+
+THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
+has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
+TIMES RESULT IN INCORRECT BEHAVIOR.  USE OF THIS SOFTWARE IS RESTRICTED TO
+PERSONS AND ORGANIZATIONS WHO CAN AND WILL TAKE FULL RESPONSIBILITY FOR ANY
+AND ALL LOSSES, COSTS, OR OTHER PROBLEMS ARISING FROM ITS USE.
+
+Derivative works are acceptable, even for commercial purposes, so long as
+(1) they include prominent notice that the work is derivative, and (2) they
+include prominent notice akin to these four paragraphs for those parts of
+this code that are retained.
+
+===============================================================================
+*/
+
+#ifndef _SOFTFLOAT_HELPERS_H_
+#define _SOFTFLOAT_HELPERS_H_
+
+#include "fpu/softfloat-types.h"
+
+static inline void set_float_detect_tininess(int val, float_status *status)
+{
+    status->float_detect_tininess = val;
+}
+
+static inline void set_float_rounding_mode(int val, float_status *status)
+{
+    status->float_rounding_mode = val;
+}
+
+static inline void set_float_exception_flags(int val, float_status *status)
+{
+    status->float_exception_flags = val;
+}
+
+static inline void set_floatx80_rounding_precision(int val,
+                                                   float_status *status)
+{
+    status->floatx80_rounding_precision = val;
+}
+
+static inline void set_flush_to_zero(flag val, float_status *status)
+{
+    status->flush_to_zero = val;
+}
+
+static inline void set_flush_inputs_to_zero(flag val, float_status *status)
+{
+    status->flush_inputs_to_zero = val;
+}
+
+static inline void set_default_nan_mode(flag val, float_status *status)
+{
+    status->default_nan_mode = val;
+}
+
+static inline void set_snan_bit_is_one(flag val, float_status *status)
+{
+    status->snan_bit_is_one = val;
+}
+
+static inline int get_float_detect_tininess(float_status *status)
+{
+    return status->float_detect_tininess;
+}
+
+static inline int get_float_rounding_mode(float_status *status)
+{
+    return status->float_rounding_mode;
+}
+
+static inline int get_float_exception_flags(float_status *status)
+{
+    return status->float_exception_flags;
+}
+
+static inline int get_floatx80_rounding_precision(float_status *status)
+{
+    return status->floatx80_rounding_precision;
+}
+
+static inline flag get_flush_to_zero(float_status *status)
+{
+    return status->flush_to_zero;
+}
+
+static inline flag get_flush_inputs_to_zero(float_status *status)
+{
+    return status->flush_inputs_to_zero;
+}
+
+static inline flag get_default_nan_mode(float_status *status)
+{
+    return status->default_nan_mode;
+}
+
+#endif /* _SOFTFLOAT_HELPERS_H_ */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index d9333eb65b8..ecb8ba01149 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -93,68 +93,7 @@ enum {
 };
 
 #include "fpu/softfloat-types.h"
-
-static inline void set_float_detect_tininess(int val, float_status *status)
-{
-    status->float_detect_tininess = val;
-}
-static inline void set_float_rounding_mode(int val, float_status *status)
-{
-    status->float_rounding_mode = val;
-}
-static inline void set_float_exception_flags(int val, float_status *status)
-{
-    status->float_exception_flags = val;
-}
-static inline void set_floatx80_rounding_precision(int val,
-                                                   float_status *status)
-{
-    status->floatx80_rounding_precision = val;
-}
-static inline void set_flush_to_zero(flag val, float_status *status)
-{
-    status->flush_to_zero = val;
-}
-static inline void set_flush_inputs_to_zero(flag val, float_status *status)
-{
-    status->flush_inputs_to_zero = val;
-}
-static inline void set_default_nan_mode(flag val, float_status *status)
-{
-    status->default_nan_mode = val;
-}
-static inline void set_snan_bit_is_one(flag val, float_status *status)
-{
-    status->snan_bit_is_one = val;
-}
-static inline int get_float_detect_tininess(float_status *status)
-{
-    return status->float_detect_tininess;
-}
-static inline int get_float_rounding_mode(float_status *status)
-{
-    return status->float_rounding_mode;
-}
-static inline int get_float_exception_flags(float_status *status)
-{
-    return status->float_exception_flags;
-}
-static inline int get_floatx80_rounding_precision(float_status *status)
-{
-    return status->floatx80_rounding_precision;
-}
-static inline flag get_flush_to_zero(float_status *status)
-{
-    return status->flush_to_zero;
-}
-static inline flag get_flush_inputs_to_zero(float_status *status)
-{
-    return status->flush_inputs_to_zero;
-}
-static inline flag get_default_nan_mode(float_status *status)
-{
-    return status->default_nan_mode;
-}
+#include "fpu/softfloat-helpers.h"
 
 /*----------------------------------------------------------------------------
 | Routine to raise any or all of the software IEC/IEEE floating-point
-- 
2.20.1


