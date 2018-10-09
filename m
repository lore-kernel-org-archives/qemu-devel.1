Received: from eggs.gnu.org ([2001:4830:134:3::10]:56751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9uiR-0001jS-9n
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9uiO-00042a-0X
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:18:35 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9uiN-00041q-NH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:18:31 -0400
Received: by mail-wr1-f52.google.com with SMTP id y16so2488069wrw.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 09:18:31 -0700 (PDT)
References: <20181009041826.19462-1-crosa@redhat.com>
	<20181009041826.19462-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d9fea54-67ea-3cc5-6766-dd759710faab@redhat.com>
Date: Tue, 9 Oct 2018 18:18:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181009041826.19462-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] Acceptance tests: add make rule for
 running them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 09/10/2018 06:18, Cleber Rosa wrote:
> The acceptance (aka functional, aka Avocado-based) tests are
> Python files located in "tests/acceptance" that need to be run
> with the Avocado libs and test runner.
> 
> Let's provide a convenient way for QEMU developers to run them,
> by making use of the tests-venv with the required setup.
> 
> Also, while the Avocado test runner will take care of creating a
> location to save test results to, it was understood that it's better
> if the results are kept within the build tree.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/testing.rst      | 35 ++++++++++++++++++++++++++++++-----
>  tests/Makefile.include      | 17 +++++++++++++++--
>  tests/venv-requirements.txt |  1 +
>  3 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 727c4019b5..b992a2961d 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -545,10 +545,31 @@ Tests based on ``avocado_qemu.Test`` can easily:
>     - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
>     - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html
>  
> -Installation
> -------------
> +Running tests
> +-------------
>  
> -To install Avocado and its dependencies, run:
> +You can run the acceptance tests simply by executing:
> +
> +.. code::
> +
> +  make check-acceptance
> +
> +This involves the automatic creation of Python virtual environment
> +within the build tree (at ``tests/venv``) which will have all the
> +right dependencies, and will save tests results also within the
> +build tree (at ``tests/results``).
> +
> +Note: the build environment must be using a Python 3 stack, and have
> +the ``venv`` and ``pip`` packages installed.  If necessary, make sure
> +``configure`` is called with ``--python=`` and that those modules are
> +available.  On Debian and Ubuntu based systems, depending on the
> +specific version, they may be on packages named ``python3-venv`` and
> +``python3-pip``.
> +
> +Manual Installation
> +-------------------
> +
> +To manually install Avocado and its dependencies, run:
>  
>  .. code::
>  
> @@ -689,11 +710,15 @@ The exact QEMU binary to be used on QEMUMachine.
>  Uninstalling Avocado
>  --------------------
>  
> -If you've followed the installation instructions above, you can easily
> -uninstall Avocado.  Start by listing the packages you have installed::
> +If you've followed the manual installation instructions above, you can
> +easily uninstall Avocado.  Start by listing the packages you have
> +installed::
>  
>    pip list --user
>  
>  And remove any package you want with::
>  
>    pip uninstall <package_name>
> +
> +If you've used ``make check-acceptance``, the Python virtual environment where
> +Avocado is installed will be cleaned up as part of ``make check-clean``.
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 68af79927d..00fdf9913e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -11,6 +11,7 @@ check-help:
>  	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>  	@echo " $(MAKE) check-block          Run block tests"
>  	@echo " $(MAKE) check-tcg            Run TCG tests"
> +	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>  	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>  	@echo " $(MAKE) check-clean          Clean the tests"
> @@ -1018,10 +1019,11 @@ check-decodetree:
>  
>  # Python venv for running tests
>  
> -.PHONY: check-venv
> +.PHONY: check-venv check-acceptance
>  
>  TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
>  TESTS_VENV_REQ=$(SRC_PATH)/tests/venv-requirements.txt
> +TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>  
>  $(TESTS_VENV_DIR):
>  	$(call quiet-command, \
> @@ -1031,8 +1033,19 @@ $(TESTS_VENV_DIR):
>              $(TESTS_VENV_DIR)/bin/pip -q install -r $(TESTS_VENV_REQ), \
>              PIP, $(TESTS_VENV_REQ))
>  
> +$(TESTS_RESULTS_DIR):
> +	$(call quiet-command, mkdir -p $@, \
> +            MKDIR, $@)
> +
>  check-venv: $(TESTS_VENV_DIR)
>  
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m avocado \
> +            --show=none run --job-results-dir=$(TESTS_RESULTS_DIR) --failfast=on \

Can we add an overwritable env var such AVOCADO_SHOW=none ?
I'd use it for Travis, to see which test failed on the console output.

> +            $(SRC_PATH)/tests/acceptance, \
> +            "AVOCADO", "tests/acceptance")
> +
>  # Consolidated targets
>  
>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> @@ -1046,7 +1059,7 @@ check-clean:
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>  	rm -f tests/test-qapi-gen-timestamp
> -	rm -rf $(TESTS_VENV_DIR)
> +	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
>  
>  clean: check-clean
>  
> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.txt
> index d39f9d1576..64c6e27a94 100644
> --- a/tests/venv-requirements.txt
> +++ b/tests/venv-requirements.txt
> @@ -1,3 +1,4 @@
>  # Add Python module requirements, one per line, to be installed
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> +avocado-framework==65.0
> 
