Received: from eggs.gnu.org ([209.51.188.92]:44681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrc-00064H-RA
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkCrL-0007Hx-FD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:58:04 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 17 Jan 2019 13:56:16 -0500
Message-Id: <20190117185628.21862-7-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/18] Acceptance tests: use "arch:" tag to
 filter target specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Currently, the only test that contains some target architecture
information is "boot_linux_console.py" which test contains a "x86_64"
tag.  But that tag is not respected in the default execution, that is,
"make check-acceptance" doesn't do anything with it.

That said, even the target architecture handling currently present in
the "avocado_qemu.Test" class, class is pretty limited.  For instance,
by default, it chooses a target based on the host architecture.

Because the original implementation of the tags feature in Avocado did
not include any time of namespace or "key:val" mechanism, no tag has
relation to another tag.  The new implementation of the tags feature
from version 67.0 onwards, allows "key:val" tags, and because of that,
a test can be classified with a tag in a given key.  For instance, the
new proposed version of the "boot_linux_console.py" test, which
downloads and attempts to run a x86_64 kernel, is now tagged as:

  :avocado: tags=3Darch:x86_64

This means that it can be filtered (out) when no x86_64 target is
available.  At the same time, tests that don't have a "arch:" tag,
will not be filtered out.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/Makefile.include                 | 3 +++
 tests/acceptance/boot_linux_console.py | 2 +-
 tests/requirements.txt                 | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c73298740d..af00c35ff5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -957,6 +957,7 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
 AVOCADO_SHOW=3Dapp
+AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARG=
ET_DIRS)))
=20
 PYTHON3 =3D $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_inf=
o >=3D (3, 0) else 0)')
 ifeq ($(PYTHON3), 1)
@@ -983,6 +984,8 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 	$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
+            --filter-by-tags-include-empty --filter-by-tags-include-empt=
y-key \
+            $(AVOCADO_TAGS) \
             --failfast=3Don $(SRC_PATH)/tests/acceptance, \
             "AVOCADO", "tests/acceptance")
=20
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 98324f7591..46b20bdfe2 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,7 +19,7 @@ class BootLinuxConsole(Test):
     and the kernel command line is properly passed from QEMU to the kern=
el
=20
     :avocado: enable
-    :avocado: tags=3Dx86_64
+    :avocado: tags=3Darch:x86_64
     """
=20
     timeout =3D 60
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 64c6e27a94..426a9e8a9a 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,4 +1,4 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D65.0
+avocado-framework=3D=3D67.0
--=20
2.20.1
