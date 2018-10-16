Received: from eggs.gnu.org ([2001:4830:134:3::10]:60532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCTV6-0005Vr-3P
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCTUx-00043S-Vq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCTUx-00042I-7F
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:51:15 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue, 16 Oct 2018 13:50:40 -0400
Message-Id: <20181016175042.578-2-crosa@redhat.com>
In-Reply-To: <20181016175042.578-1-crosa@redhat.com>
References: <20181016175042.578-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>

A number of QEMU tests are written in Python, and may benefit
from an untainted Python venv.

By using make rules, tests that depend on specific Python libs
can set that rule as a requirement, along with rules that require
the presence or installation of specific libraries.

The tests/venv-requirements.txt is supposed to contain the
Python requirements that should be added to the venv created
by check-venv.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/Makefile.include      | 26 ++++++++++++++++++++++++++
 tests/venv-requirements.txt |  3 +++
 2 files changed, 29 insertions(+)
 create mode 100644 tests/venv-requirements.txt

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5eadfd52f9..49deb9b3a1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -12,6 +12,7 @@ check-help:
 	@echo " $(MAKE) check-block          Run block tests"
 	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
+	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
 	@echo " $(MAKE) check-clean          Clean the tests"
 	@echo
 	@echo "Please note that HTML reports do not regenerate if the unit test=
s"
@@ -1017,6 +1018,30 @@ check-decodetree:
           ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
           TEST, decodetree.py)
=20
+# Python venv for running tests
+
+.PHONY: check-venv
+
+TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
+TESTS_VENV_REQ=3D$(SRC_PATH)/tests/venv-requirements.txt
+
+PYTHON_VER :=3D $(findstring Python 3,$(shell $(PYTHON) -V))
+ifeq ($(PYTHON_VER),Python 3)
+$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
+	$(call quiet-command, \
+            $(PYTHON) -m venv --system-site-packages $@, \
+            VENV, $@)
+	$(call quiet-command, \
+            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VE=
NV_REQ), \
+            PIP, $(TESTS_VENV_REQ))
+	$(call quiet-command, touch $@)
+else
+$(TESTS_VENV_DIR):
+       $(error "venv directory for tests requires Python 3")
+endif
+
+check-venv: $(TESTS_VENV_DIR)
+
 # Consolidated targets
=20
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
@@ -1030,6 +1055,7 @@ check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
+	rm -rf $(TESTS_VENV_DIR)
=20
 clean: check-clean
=20
diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.txt
new file mode 100644
index 0000000000..d39f9d1576
--- /dev/null
+++ b/tests/venv-requirements.txt
@@ -0,0 +1,3 @@
+# Add Python module requirements, one per line, to be installed
+# in the tests/venv Python virtual environment. For more info,
+# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
--=20
2.17.1
