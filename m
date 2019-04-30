Received: from eggs.gnu.org ([209.51.188.92]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW28-00048Z-WF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzq-0000pV-Au
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzp-0000oZ-WB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id v16so19428732wrp.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:34 +0100
Message-Id: <20190430165234.32272-16-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 15/15] Makefile.target: support per-target
 coverage reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Add support for generating a single targets coverage report. Execute:

  make coverage-report

In the target build directory. This coverage report only cares about
target specific blobs so only searches the target build subdirectory.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile.target | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index ae02495951..aa5d9d6ba6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -238,3 +238,19 @@ endif
 
 GENERATED_FILES += config-target.h
 Makefile: $(GENERATED_FILES)
+
+# Reports/Analysis
+#
+# The target specific coverage report only cares about target specific
+# blobs and not the shared code.
+#
+
+%/coverage-report.html:
+	@mkdir -p $*
+	$(call quiet-command,\
+		gcovr -r $(SRC_PATH) --object-directory $(CURDIR) \
+		-p --html --html-details -o $@, \
+		"GEN", "coverage-report.html")
+
+.PHONY: coverage-report
+coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-- 
2.20.1
