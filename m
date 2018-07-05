Received: from eggs.gnu.org ([2001:4830:134:3::10]:54792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jI-0008LV-HC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jH-0007xP-2K
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:36 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:52415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jG-0007x2-Rs
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:34 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w16-v6so12070329wmc.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:13 +0100
Message-Id: <20180705160329.30386-5-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 04/20] build-system: remove per-test GCOV
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
index 0c0f9509f5..a49282704e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -897,26 +897,16 @@ GCOV_OPTIONS = -n $(if $(V),-f,)
 
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
