Received: from eggs.gnu.org ([2001:4830:134:3::10]:41724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lV-0002Sv-Mo
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lU-0006YT-Ql
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:49 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:52247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lU-0006Xb-LO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:48 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k62so1426464wrc.9
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:16 +0100
Message-Id: <20171013162438.32458-9-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 08/30] softfloat: add half-precision
 expansions for MINMAX fns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Expand the current helpers to include half-precision functions. The
includes having f16 version of the compare functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c         |  2 ++
 include/fpu/softfloat.h | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3a4ab1355f..013b223947 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7579,6 +7579,7 @@ int float ## s ## _compare_quiet(float ## s a, float ## s b,                 \
     return float ## s ## _compare_internal(a, b, 1, status);                 \
 }
 
+COMPARE(16, 0x1f)
 COMPARE(32, 0xff)
 COMPARE(64, 0x7ff)
 
@@ -7779,6 +7780,7 @@ float ## s float ## s ## _maxnummag(float ## s a, float ## s b,         \
     return float ## s ## _minmax(a, b, 0, 1, 1, status);                \
 }
 
+MINMAX(16)
 MINMAX(32)
 MINMAX(64)
 
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index edf402d422..d89fdf7675 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -381,6 +381,17 @@ static inline float16 float16_abs(float16 a)
      */
     return make_float16(float16_val(a) & 0x7fff);
 }
+
+/* Expanded by the MINMAX macro in softfloat.c */
+int float16_compare(float16, float16, float_status *status);
+int float16_compare_quiet(float16, float16, float_status *status);
+float16 float16_min(float16, float16, float_status *status);
+float16 float16_max(float16, float16, float_status *status);
+float16 float16_minnum(float16, float16, float_status *status);
+float16 float16_maxnum(float16, float16, float_status *status);
+float16 float16_minnummag(float16, float16, float_status *status);
+float16 float16_maxnummag(float16, float16, float_status *status);
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.14.1
