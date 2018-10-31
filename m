Received: from eggs.gnu.org ([2001:4830:134:3::10]:43248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQh-0002SG-Uw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQg-0004BQ-F8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:32:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:17 -0300
Message-Id: <20181031003120.26771-13-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] Acceptance tests: add make rule for
 running them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Cleber Rosa <crosa@redhat.com>

The acceptance (aka functional, aka Avocado-based) tests are
Python files located in "tests/acceptance" that need to be run
with the Avocado libs and test runner.

Let's provide a convenient way for QEMU developers to run them,
by making use of the tests-venv with the required setup.

Also, while the Avocado test runner will take care of creating a
location to save test results to, it was understood that it's better
if the results are kept within the build tree.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Message-Id: <20181018153134.8493-3-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/testing.rst | 43 +++++++++++++++++++++++++++++++++++++-----
 tests/requirements.txt |  1 +
 tests/Makefile.include | 21 +++++++++++++++++++--
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index a227754f86..18e2c0868a 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -545,10 +545,39 @@ Tests based on ``avocado_qemu.Test`` can easily:
    - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
    - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html
 
-Installation
-------------
+Running tests
+-------------
+
+You can run the acceptance tests simply by executing:
+
+.. code::
+
+  make check-acceptance
+
+This involves the automatic creation of Python virtual environment
+within the build tree (at ``tests/venv``) which will have all the
+right dependencies, and will save tests results also within the
+build tree (at ``tests/results``).
 
-To install Avocado and its dependencies, run:
+Note: the build environment must be using a Python 3 stack, and have
+the ``venv`` and ``pip`` packages installed.  If necessary, make sure
+``configure`` is called with ``--python=`` and that those modules are
+available.  On Debian and Ubuntu based systems, depending on the
+specific version, they may be on packages named ``python3-venv`` and
+``python3-pip``.
+
+The scripts installed inside the virtual environment may be used
+without an "activation".  For instance, the Avocado test runner
+may be invoked by running:
+
+ .. code::
+
+  tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/acceptance/
+
+Manual Installation
+-------------------
+
+To manually install Avocado and its dependencies, run:
 
 .. code::
 
@@ -689,11 +718,15 @@ The exact QEMU binary to be used on QEMUMachine.
 Uninstalling Avocado
 --------------------
 
-If you've followed the installation instructions above, you can easily
-uninstall Avocado.  Start by listing the packages you have installed::
+If you've followed the manual installation instructions above, you can
+easily uninstall Avocado.  Start by listing the packages you have
+installed::
 
   pip list --user
 
 And remove any package you want with::
 
   pip uninstall <package_name>
+
+If you've used ``make check-acceptance``, the Python virtual environment where
+Avocado is installed will be cleaned up as part of ``make check-clean``.
diff --git a/tests/requirements.txt b/tests/requirements.txt
index d39f9d1576..64c6e27a94 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,3 +1,4 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
+avocado-framework==65.0
diff --git a/tests/Makefile.include b/tests/Makefile.include
index eabc1da2f3..d2e577eabb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -11,6 +11,7 @@ check-help:
 	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 	@echo " $(MAKE) check-block          Run block tests"
 	@echo " $(MAKE) check-tcg            Run TCG tests"
+	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
 	@echo " $(MAKE) check-clean          Clean the tests"
@@ -902,10 +903,15 @@ check-decodetree:
 
 # Python venv for running tests
 
-.PHONY: check-venv
+.PHONY: check-venv check-acceptance
 
 TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
 TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
+TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
+# Controls the output generated by Avocado when running tests.
+# Any number of command separated loggers are accepted.  For more
+# information please refer to "avocado --help".
+AVOCADO_SHOW=none
 
 $(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
 ifeq ($(.SHELLSTATUS),0)
@@ -922,8 +928,19 @@ $(TESTS_VENV_DIR):
 	$(error "venv directory for tests requires Python 3")
 endif
 
+$(TESTS_RESULTS_DIR):
+	$(call quiet-command, mkdir -p $@, \
+            MKDIR, $@)
+
 check-venv: $(TESTS_VENV_DIR)
 
+check-acceptance: check-venv $(TESTS_RESULTS_DIR)
+	$(call quiet-command, \
+            $(TESTS_VENV_DIR)/bin/python -m avocado \
+            --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
+            --failfast=on $(SRC_PATH)/tests/acceptance, \
+            "AVOCADO", "tests/acceptance")
+
 # Consolidated targets
 
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
@@ -937,7 +954,7 @@ check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
-	rm -rf $(TESTS_VENV_DIR)
+	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
 clean: check-clean
 
-- 
2.18.0.rc1.1.g3f1ff2140
