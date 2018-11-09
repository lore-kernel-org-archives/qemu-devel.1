Received: from eggs.gnu.org ([2001:4830:134:3::10]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Nu-0007KW-Hj
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Nn-0006qq-GR
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8Nf-0006k7-6T
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:32 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:07:08 -0500
Message-Id: <20181109150710.31085-3-crosa@redhat.com>
In-Reply-To: <20181109150710.31085-1-crosa@redhat.com>
References: <20181109150710.31085-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] check-venv: use recorded Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>

The current approach works fine, but it runs Python on every make
command (even if it's not related to the venv usage).

This is just an optimization, and not a change of behavior.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/Makefile.include | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 074eece558..c0a341c923 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -913,8 +913,7 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 # information please refer to "avocado --help".
 AVOCADO_SHOW=3Dnone
=20
-PYTHON3 =3D $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_inf=
o >=3D (3, 0) else 0)')
-ifeq ($(PYTHON3), 1)
+ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 	$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
--=20
2.19.1
