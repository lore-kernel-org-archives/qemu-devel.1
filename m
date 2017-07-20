Received: from eggs.gnu.org ([2001:4830:134:3::10]:55644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD88-0003FH-Ao
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD83-0004Kn-IV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:44 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD83-0004KE-64
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:39 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v105so41927509wrb.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:23 +0100
Message-Id: <20170720150426.12393-21-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 20/23] fpu/softfloat2a: add
 half-precision expansions for MINMAX fns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

As SoftFloat3c doesn't have helpers for min/max and we already
implemented it in 2a lets just expand the current helpers to include
half-precision functions. The includes having f16 version of the
compare functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat2a/softfloat.c         |  2 ++
 include/fpu/softfloat2a/softfloat.h | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fpu/softfloat2a/softfloat.c b/fpu/softfloat2a/softfloat.c
index 4f1abbe08f..67115298bd 100644
--- a/fpu/softfloat2a/softfloat.c
+++ b/fpu/softfloat2a/softfloat.c
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
 
diff --git a/include/fpu/softfloat2a/softfloat.h b/include/fpu/softfloat2a/softfloat.h
index 3cb41977d8..dd1293d802 100644
--- a/include/fpu/softfloat2a/softfloat.h
+++ b/include/fpu/softfloat2a/softfloat.h
@@ -386,6 +386,17 @@ static inline float16 float16_abs(float16 a)
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
2.13.0
