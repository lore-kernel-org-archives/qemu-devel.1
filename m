Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKl-0006mv-Et
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKk-0008Rr-Gz
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:55 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faIKk-0008RS-9t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:54 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n17-v6so1654675wmh.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:14:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:31 +0100
Message-Id: <20180703101444.23778-8-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/20] build-system: add clean-coverage target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This can be used to remove any stale coverage data before any
particular test run. This is useful for analysing individual tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>---

diff --git a/Makefile b/Makefile
index 7ed9cc4a21..2b3413a5ba 100644
--- a/Makefile
+++ b/Makefile
@@ -723,6 +723,14 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
 	"GEN","$@")
 
+ifdef CONFIG_GCOV
+.PHONY: clean-coverage
+clean-coverage:
+	$(call quiet-command, \
+		find . \( -name '*.gcda' -o -name '*.gcov' \) -type f -exec rm {} +, \
+		"CLEAN", "coverage files")
+endif
+
 clean:
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
@@ -1073,6 +1081,9 @@ endif
 		echo '')
 	@echo  'Cleaning targets:'
 	@echo  '  clean           - Remove most generated files but keep the config'
+ifdef CONFIG_GCOV
+	@echo  '  clean-coverage  - Remove coverage files'
+endif
 	@echo  '  distclean       - Remove all generated files'
 	@echo  '  dist            - Build a distributable tarball'
 	@echo  ''
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 66ef219f69..7f04ca104e 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -161,9 +161,14 @@ GCC gcov support
 ``gcov`` is a GCC tool to analyze the testing coverage by
 instrumenting the tested code. To use it, configure QEMU with
 ``--enable-gcov`` option and build. Then run ``make check`` as usual.
-Reports can be obtained by running ``gcov`` command on the output
-files under ``$build_dir/tests/``, please read the ``gcov``
-documentation for more information.
+
+If you want to gather coverage information on a single test the ``make
+clean-coverage`` target can be used to delete any existing coverage
+information before running a single test.
+
+Reports can be obtained by running ``gcov`` command
+on the output files under ``$build_dir/tests/``, please read the
+``gcov`` documentation for more information.
 
 QEMU iotests
 ============
-- 
2.17.1
