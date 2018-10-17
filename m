Received: from eggs.gnu.org ([2001:4830:134:3::10]:59469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCoKq-0008Ep-Oc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCoKk-0003cq-Oj
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCoKh-0003NL-GF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:06:05 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 17 Oct 2018 12:05:36 -0400
Message-Id: <20181017160539.12316-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/3] Bootstrap Python venv and
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

TL;DR
=3D=3D=3D=3D=3D

Allow acceptance tests to be run with `make check-acceptance`.

Details
=3D=3D=3D=3D=3D=3D=3D

This introduces a Python virtual environment that will be setup within
the QEMU build directory, that will contain the exact environment that
tests may require.

There's one current caveat: it requires Python 3, as it's based on the
venv module.  This was based on some discussions and perception about
standardizing on Python 3, but can easily be made to accommodate Python
2 as well.

Example of bootstrap and test execution on Travis-CI:

https://travis-ci.org/qemu/qemu/jobs/439331028#L2508

   ...
      VENV    /home/travis/build/qemu/qemu/tests/venv
      MKDIR   /home/travis/build/qemu/qemu/tests/results
      PIP     /home/travis/build/qemu/qemu/tests/venv-requirements.txt
      AVOCADO tests/acceptance
    JOB ID     : 920e4fcf55a1782f1ae77bee64b20ccdc2e1111d
    JOB LOG    : /home/travis/build/qemu/qemu/tests/results/job-2018-10-0=
9T21.42-920e4fc/job.log
     (1/6) /home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test:  PASS (3.57 s)
     (2/6) /home/travis/build/qemu/qemu/tests/acceptance/version.py:Versi=
on.test_qmp_human_info_version:  PASS (0.04 s)
     (3/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
no_vnc:  PASS (0.04 s)
     (4/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
no_vnc_change_password:  PASS (0.04 s)
     (5/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
vnc_change_password_requires_a_password:  PASS (0.04 s)
     (6/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
vnc_change_password:  PASS (0.04 s)
    RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
    JOB TIME   : 3.90 s
   ...

Changes from v5:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Renamed tests/venv-requirements.txt to tests/requirements.txt
   (Caio).

 * Moved the Travis package dependencies (python3-pip and Python3.4-venv)
   to the specific job block  (Philippe / Alex).

Changes from v4:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Added Python 3 version check and error message when running under
   Python 2.  (Philippe)

 * Added notes about using Avocado from the virtual environment
   without previous activation. (Philippe)

Ideas discussed, but not implemented:

 * Instructions to activate/deactivate the venv: the idea is to be
   use the venv as transparently as possible.

 * Move/rename tests/venv-requirements: the ideal, as per the first
   commit is to provide one venv for all Python based tests to run.

 * Changed the Travis package requirements (python3-pip,
   python3.4-venv) from the global setting to the job specific one:
   waiting on further feedback from'Alex Benn=C3=A9e.

Changes from v3:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Fixed typo in commit message (s/requiment/requirement/).  (Eric)

Changes from v2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Make the $(TESTS_VENV_DIR) target depend on the
   venv-requirements.txt file, and touch $(TESTS_VENV_DIR) after venv
   runs.  With this, updates on the file are reflected on the
   venv. (Philippe)

 * Run pip with "python -m pip".  It may have been installed reusing
   the system wide packages, and then the script may not be available
   on the venv. (Philippe)

 * Dropped Python version on Travis, and using the version supplied
   by the distro (3.4). (Philippe)

 * Added "python3.4-venv" package requirement on Travis. (Philippe)

 * Added variable (AVOCADO_SHOW) with logging streams to be shown
   while running the acceptance tests.  By default it's set to none,
   the equivalent of the quiet mode used on previous versions.
   (Philippe)

 * On Travis, set the AVOCADO_SHOW variable to "app", so that the
   individual test results can be easily seen.  (Philippe)

Ideas discussed, but not implemented:

  * Run pip with "$(PYTHON) -m pip -q install ..." because it points
    to the system wide Python installation. (Philippe)

  * Drop the "--system-site-packages" flag.  Waiting on another round
    of tests to determine if they are really the cause of some package
    installation problems.

Changes from v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

 .travis.yml            |  8 ++++++++
 docs/devel/testing.rst | 43 +++++++++++++++++++++++++++++++++++++-----
 tests/Makefile.include | 43 ++++++++++++++++++++++++++++++++++++++++++
 tests/requirements.txt |  4 ++++
 4 files changed, 93 insertions(+), 5 deletions(-)
 create mode 100644 tests/requirements.txt

--=20
2.17.1
