Received: from eggs.gnu.org ([209.51.188.92]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC9-0001Qv-Ow
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC8-0002ZP-N5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:41 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:33904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC8-0002Xz-EA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:40 -0500
Received: by mail-pf1-x432.google.com with SMTP id u9so12138361pfn.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:40 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:22 -0800
Message-Id: <20190307185622.29026-13-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 12/12] decodetree: Properly diagnose fields
 overflowing an insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Previously this would result in an exception for shifting
the field mask by a negative number.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py          | 2 ++
 tests/decode/err_width1.decode | 5 +++++
 tests/decode/err_width2.decode | 5 +++++
 tests/decode/err_width3.decode | 5 +++++
 tests/decode/err_width4.decode | 5 +++++
 5 files changed, 22 insertions(+)
 create mode 100644 tests/decode/err_width1.decode
 create mode 100644 tests/decode/err_width2.decode
 create mode 100644 tests/decode/err_width3.decode
 create mode 100644 tests/decode/err_width4.decode

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index f8df89e072..7e890ecf1a 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -622,6 +622,8 @@ def parse_generic(lineno, is_format, name, toks):
                 sign = True
                 flen = flen[1:]
             shift = int(flen, 10)
+            if shift + width > insnwidth:
+                error(lineno, 'field {0} exceeds insnwidth'.format(fname))
             f = Field(sign, insnwidth - width - shift, shift)
             flds = add_field(lineno, flds, fname, f)
             fixedbits <<= shift
diff --git a/tests/decode/err_width1.decode b/tests/decode/err_width1.decode
new file mode 100644
index 0000000000..0c14f6d73b
--- /dev/null
+++ b/tests/decode/err_width1.decode
@@ -0,0 +1,5 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose too many bits (33 of 32)
+one	000000000000000000000000000000000
diff --git a/tests/decode/err_width2.decode b/tests/decode/err_width2.decode
new file mode 100644
index 0000000000..47f0acf322
--- /dev/null
+++ b/tests/decode/err_width2.decode
@@ -0,0 +1,5 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose too few bits (31 of 32)
+one	0000000000000000000000000000000
diff --git a/tests/decode/err_width3.decode b/tests/decode/err_width3.decode
new file mode 100644
index 0000000000..c5fb6b3699
--- /dev/null
+++ b/tests/decode/err_width3.decode
@@ -0,0 +1,5 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose too many bits (33 of 32)
+one	0 s:32
diff --git a/tests/decode/err_width4.decode b/tests/decode/err_width4.decode
new file mode 100644
index 0000000000..1588a63698
--- /dev/null
+++ b/tests/decode/err_width4.decode
@@ -0,0 +1,5 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose too few bits (31 of 32)
+one	0 s:30
-- 
2.17.2
