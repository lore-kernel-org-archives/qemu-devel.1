Received: from eggs.gnu.org ([2001:4830:134:3::10]:39635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB5F0-0005TZ-OI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB5Ex-0005Cx-Gz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:45:02 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:41835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gB5Ex-0005CT-9J
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:44:59 -0400
Received: by mail-wr1-f53.google.com with SMTP id x12-v6so14834185wru.8
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 14:44:59 -0700 (PDT)
References: <20181012165347.2117-1-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ec6694c9-a8f0-7a9d-ee04-224a1f67e67c@redhat.com>
Date: Fri, 12 Oct 2018 23:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181012165347.2117-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Bootstrap Python venv and
 acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/10/2018 18:53, Cleber Rosa wrote:
> TL;DR
> =====
> 
> Allow acceptance tests to be run with `make check-acceptance`.
> 
> Details
> =======
> 
> This introduces a Python virtual environment that will be setup within
> the QEMU build directory, that will contain the exact environment that
> tests may require.
> 
> There's one current caveat: it requires Python 3, as it's based on the
> venv module.  This was based on some discussions and perception about
> standardizing on Python 3, but can easily be made to accommodate Python
> 2 as well.
> 
> Example of bootstrap and test execution on Travis-CI:
> 
> https://travis-ci.org/qemu/qemu/jobs/439331028#L2508

If you activate Travis on your github account, you can test that in your
namespace without having to open zombie pull requests there... A simple
push to your repository will trigger a full Travis build.

This is how I use it btw, canceling the jobs I'm not interested in, to
quickly run the others.
i.e. https://travis-ci.org/philmd/qemu/jobs/439573299#L5600

> 
>    ...
>       VENV    /home/travis/build/qemu/qemu/tests/venv
>       MKDIR   /home/travis/build/qemu/qemu/tests/results
>       PIP     /home/travis/build/qemu/qemu/tests/venv-requirements.txt
>       AVOCADO tests/acceptance
>     JOB ID     : 920e4fcf55a1782f1ae77bee64b20ccdc2e1111d
>     JOB LOG    : /home/travis/build/qemu/qemu/tests/results/job-2018-10-09T21.42-920e4fc/job.log
>      (1/6) /home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test:  PASS (3.57 s)
>      (2/6) /home/travis/build/qemu/qemu/tests/acceptance/version.py:Version.test_qmp_human_info_version:  PASS (0.04 s)
>      (3/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.04 s)
>      (4/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PASS (0.04 s)
>      (5/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password:  PASS (0.04 s)
>      (6/6) /home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS (0.04 s)
>     RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>     JOB TIME   : 3.90 s
>    ...
> 
> Changes from v3:
> ================
> 
>  * Fixed typo in commit message (s/requiment/requirement/).  (Eric)
> 
> Changes from v2:
> ================
> 
>  * Make the $(TESTS_VENV_DIR) target depend on the
>    venv-requirements.txt file, and touch $(TESTS_VENV_DIR) after venv
>    runs.  With this, updates on the file are reflected on the
>    venv. (Philippe)
> 
>  * Run pip with "python -m pip".  It may have been installed reusing
>    the system wide packages, and then the script may not be available
>    on the venv. (Philippe)
> 
>  * Dropped Python version on Travis, and using the version supplied
>    by the distro (3.4). (Philippe)
> 
>  * Added "python3.4-venv" package requirement on Travis. (Philippe)
> 
>  * Added variable (AVOCADO_SHOW) with logging streams to be shown
>    while running the acceptance tests.  By default it's set to none,
>    the equivalent of the quiet mode used on previous versions.
>    (Philippe)
> 
>  * On Travis, set the AVOCADO_SHOW variable to "app", so that the
>    individual test results can be easily seen.  (Philippe)
> 
> Ideas discussed, but not implemented:
> 
>   * Run pip with "$(PYTHON) -m pip -q install ..." because it points
>     to the system wide Python installation. (Philippe)
> 
>   * Drop the "--system-site-packages" flag.  Waiting on another round
>     of tests to determine if they are really the cause of some package
>     installation problems.
> 
> Changes from v1:
> ================
> 
>  * TESTS_VENV_REQ (the path of "venv-requirements.txt") now points to
>    the source path ($SRC_PATH instead of $BUILD_DIR)
> 
>  * Create the venv with "--system-site-packages", which allows the
>    reuse of packages (and no additional downloads) in case there's a
>    package installed system wide providing the same package and
>    version.
> 
>  * Run Avocado with "python -m avocado".  It may have been installed
>    reusing the system wide packages, and then the script may not
>    be available on the venv.
> 
>  * Improved documentation describing the Python 3, venv and pip
>    requirements.
> 
>  * Updated avocado-framework requirement to latest released version
>    (65.0)
> 
>  * (New commit) Added support for running the acceptance tests on
>    Travis.
> 
> Ideas discussed, but not implemented:
> 
>  * Install external packages such as python3-pip on Debian based
>    systems, deemed too invasive on developer's systems.
> 
>  * Allow the use of Python 2, and consequently the "virtualenv"
>    module.
> 
> Cleber Rosa (3):
>   Bootstrap Python venv for tests
>   Acceptance tests: add make rule for running them
>   Travis support for the acceptance tests
> 
>  .travis.yml                 |  5 +++++
>  docs/devel/testing.rst      | 35 ++++++++++++++++++++++++++++++-----
>  tests/Makefile.include      | 37 +++++++++++++++++++++++++++++++++++++
>  tests/venv-requirements.txt |  4 ++++
>  4 files changed, 76 insertions(+), 5 deletions(-)
>  create mode 100644 tests/venv-requirements.txt
> 
