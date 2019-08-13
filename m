Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FB8C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3FA206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTcOsbxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3FA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWJY-0001TH-Vk
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFQ-0002Rq-Eq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFO-0000jL-Sv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:33514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFO-0000iQ-M9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id p77so1010401wme.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/yOiUc7McAJurUllCeBlwbQ9U0BZqqFm4utO3aBw4R0=;
 b=kTcOsbxYn8DqQhSDR+gKVh0Gs0wkwxDoe7mO6VwvMn6T6yn3dQWq6XVkoZ8Ws9hxNZ
 SSOy3kbfKCBdGJ/JAPzqjd4wm2mUe738rv6cuape55o8iMU3woDP+L4PXNyuKrzzaneN
 g1gqtlBUKRbbIiQ3FY4lXWlculL1TDLtdT0dvWdGvU+4YLvziTL89lLaeTLaXiSUGOQ3
 U2eRZ5NLoiZMI8yAXB9uhSM/tH3YLBBw5FV/DueNMOS7HUgwd8eHHnM/rgxgE5MQHDtr
 ICrcJ5HDA2sVZJ+1vcsQoimOXCbpNonCJPbMthgSwn3d5Kg1pVa1hh4oBiOk0EZk+GwB
 7ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/yOiUc7McAJurUllCeBlwbQ9U0BZqqFm4utO3aBw4R0=;
 b=dEXYR79cxbUIo4x2Xyv1kIWzfxjZLlyuVwmQ/97qzVKkoEWXQZn9m02tyFPXJm8+UN
 2L0cFf53fd2Sw8T8InPM+otQYgGL4GK1Og0nFSKtjryrPvHZ1RVLCz+8cjpX+iu0kr4N
 oeJvirQtqszfacdIHYJMbg973BcMKNPy43n7sHsFUzH+ksDQd6SPE0b4v2Bx2tE6e6a7
 UExTwaOkEp3OoJlRypSn4Ny3nwJ2U2+/Bb2AFSVqsWeb7eiFxOvIEo5k1kPWKjLYdWQl
 THTtK/WX0ktML4/O7/sdvCerpNxh/0BLXRmD6UgiGKiMLDnAc5lAz5vQFLwoI6ZNNvM2
 Zzdg==
X-Gm-Message-State: APjAAAVfcdBKrMjRMoMpmf2KMQosnoY80jnj0nAm0L9a5w15EwDRSJQB
 4cvstEiGbUgdomnp6/qziYBG0g==
X-Google-Smtp-Source: APXvYqx2Q/MFrsVdhJoE1djCy9r1Nf0KMJAOiPC21kEdtAaVMy43GpJkPCsnL07ZNyAAr41vq/uiLw==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr2945142wml.25.1565700593472;
 Tue, 13 Aug 2019 05:49:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u130sm2417719wmg.28.2019.08.13.05.49.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:50 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CDDC1FF98;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:41 +0100
Message-Id: <20190813124946.25322-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH v3 08/13] fpu: move inline helpers into a
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, armbru@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a bunch of users of the inline helpers who do not need
access to the entire softfloat API. Move those inline helpers into a
new header file which can be included without bringing in the rest of
the world.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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


