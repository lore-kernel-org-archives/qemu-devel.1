Received: from eggs.gnu.org ([2001:4830:134:3::10]:44564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn5-0004xV-P7
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn5-0000y2-3z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:27 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:36560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diTn4-0000xc-VB
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:27 -0400
Received: by mail-pg0-x22d.google.com with SMTP id i12so51987893pgr.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:01:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 17 Aug 2017 16:01:12 -0700
Message-Id: <20170817230114.3655-7-richard.henderson@linaro.org>
In-Reply-To: <20170817230114.3655-1-richard.henderson@linaro.org>
References: <20170817230114.3655-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/8] tcg: Add INDEX_op_invalid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

Add with value 0 so that structure zero initialization can
indicate that the field is not present.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-opc.h | 2 ++
 tcg/tcg.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 9162125fac..b1445a4c24 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -26,6 +26,8 @@
  * DEF(name, oargs, iargs, cargs, flags)
  */
 
+DEF(invalid, 0, 0, 0, TCG_OPF_NOT_PRESENT)
+
 /* predefined ops */
 DEF(discard, 1, 0, 0, TCG_OPF_NOT_PRESENT)
 DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3c3cdda938..879b29e81f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -756,6 +756,9 @@ int tcg_check_temp_count(void)
 bool tcg_op_supported(TCGOpcode op)
 {
     switch (op) {
+    case INDEX_op_invalid:
+        return false;
+
     case INDEX_op_discard:
     case INDEX_op_set_label:
     case INDEX_op_call:
-- 
2.13.5
