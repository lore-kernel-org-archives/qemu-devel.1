Received: from eggs.gnu.org ([2001:4830:134:3::10]:34624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g9jTm-0001PL-57
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 00:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g9jTi-0007rs-4R
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 00:18:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g9jTh-0007qs-TU
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 00:18:38 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 00:18:23 -0400
Message-Id: <20181009041826.19462-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Bootstrap Python venv and
 acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

TL;DR
=====

Allow acceptance tests to be run with `make check-acceptance`.

Details
=======

This introduces a Python virtual environment that will be setup within
the QEMU build directory, that will contain the exact environment that
tests may require.

There's one current caveat: it requires Python 3, as it's based on the
venv module.  This was based on some discussions and perception about
standardizing on Python 3, but can easily be made to accommodate Python
2 as well.

Changes from v1:
================

 * TESTS_VENV_REQ (the path of "venv-requirements.txt") now points to
   the source path ($SRC_PATH instead of $BUILD_DIR)

 * Create the venv with "--system-site-packages", which allows the
   reuse of packages (and no additional downloads) in case there's a
   package installed system wide providing the same package and
   version.

 * Run Avocado with "python -m avocado".  It may have been installed
   reusing the system wide packages, and then the script may not
   be available on the venv.

 * Improved documentation describing the Python 3, venv and pip
   requirements.

 * Updated avocado-framework requirement to latest released version
   (65.0)

 * (New commit) Added support for running the acceptance tests on
   Travis.

Ideas discussed, but not implemented:

 * Install external packages such as python3-pip on Debian based
   systems, deemed too invasive on developer's systems.

 * Allow the use of Python 2, and consequently the "virtualenv"
   module.

Cleber Rosa (3):
  Bootstrap Python venv for tests
  Acceptance tests: add make rule for running them
  Travis support for the acceptance tests

 .travis.yml                 |  6 ++++++
 docs/devel/testing.rst      | 35 ++++++++++++++++++++++++++++++-----
 tests/Makefile.include      | 32 ++++++++++++++++++++++++++++++++
 tests/venv-requirements.txt |  4 ++++
 4 files changed, 72 insertions(+), 5 deletions(-)
 create mode 100644 tests/venv-requirements.txt

-- 
2.17.1
