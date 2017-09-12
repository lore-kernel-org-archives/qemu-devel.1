Received: from eggs.gnu.org ([2001:4830:134:3::10]:37882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro05-0001fs-77
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro04-00071M-Br
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:25 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:37513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro04-000713-69
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:24 -0400
Received: by mail-pg0-x232.google.com with SMTP id d8so22188704pgt.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:02 -0700
Message-Id: <20170912162513.21694-6-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/16] tcg: Add INDEX_op_invalid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Add with value 0 so that structure zero initialization can
indicate that the field is not present.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-opc.h | 2 ++
 tcg/tcg.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index edfdbf8798..b84cd584fb 100644
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
index 9aea00d9b4..8fca202bec 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -754,6 +754,9 @@ int tcg_check_temp_count(void)
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
