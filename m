Received: from eggs.gnu.org ([2001:4830:134:3::10]:43422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKg-0006lH-Sn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faIKf-0008PN-PR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:50 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:52035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faIKf-0008OZ-Iq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:14:49 -0400
Received: by mail-wm0-x235.google.com with SMTP id s12-v6so1713134wmc.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:14:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:27 +0100
Message-Id: <20180703101444.23778-4-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/20] build-system: remove per-test GCOV
 reporting
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

I'm not entirely sure who's using this information and certainly in a
CI environment it just washes over as additional noise. Later patches
will provide new reporting options so a user who wants to analyse
individual tests will be able to use that to get the information.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index f33e5a8423..66ef219f69 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -158,12 +158,11 @@ rarely used. See "QEMU iotests" section below for more information.
 GCC gcov support
 ----------------
 
-``gcov`` is a GCC tool to analyze the testing coverage by instrumenting the
-tested code. To use it, configure QEMU with ``--enable-gcov`` option and build.
-Then run ``make check`` as usual. There will be additional ``gcov`` output as
-the testing goes on, showing the test coverage percentage numbers per analyzed
-source file. More detailed reports can be obtained by running ``gcov`` command
-on the output files under ``$build_dir/tests/``, please read the ``gcov``
+``gcov`` is a GCC tool to analyze the testing coverage by
+instrumenting the tested code. To use it, configure QEMU with
+``--enable-gcov`` option and build. Then run ``make check`` as usual.
+Reports can be obtained by running ``gcov`` command on the output
+files under ``$build_dir/tests/``, please read the ``gcov``
 documentation for more information.
 
 QEMU iotests
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e8bb2d8f66..756474814a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -891,26 +891,16 @@ GCOV_OPTIONS = -n $(if $(V),-f,)
 
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu $(check-qtest-y)
-	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
 	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
 		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
 		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
-	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
-	  echo Gcov report for $$f:;\
-	  $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
-	done,)
 
 .PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
 $(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
-	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
 	$(call quiet-command, \
 		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
 		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
-	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(gcov-files-generic-y); do \
-	  echo Gcov report for $$f:;\
-	  $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
-	done,)
 
 # gtester tests with XML output
 
-- 
2.17.1
