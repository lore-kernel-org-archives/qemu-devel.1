Received: from eggs.gnu.org ([209.51.188.92]:46503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6u-0004pZ-H6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6t-0003iv-UX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6t-0003hD-Oj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:55 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:38 -0200
Message-Id: <20190117201743.20470-5-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] check-venv: use recorded Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

The current approach works fine, but it runs Python on every make
command (even if it's not related to the venv usage).

This is just an optimization, and not a change of behavior.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181109150710.31085-3-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/Makefile.include | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f403a6571d..f8d4399293 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -958,8 +958,7 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 # information please refer to "avocado --help".
 AVOCADO_SHOW=none
 
-PYTHON3 = $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_info >= (3, 0) else 0)')
-ifeq ($(PYTHON3), 1)
+ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 	$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
-- 
2.18.0.rc1.1.g3f1ff2140
