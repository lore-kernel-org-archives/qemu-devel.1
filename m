Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g9vKq-00056V-S2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g9vKh-00052I-8r
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:58:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g9vKf-00051T-7W
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:58:07 -0400
References: <20181009041826.19462-1-crosa@redhat.com>
	<20181009041826.19462-3-crosa@redhat.com>
	<2d9fea54-67ea-3cc5-6766-dd759710faab@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <c34a4d2f-feb9-3cca-a54f-f09aa256faa7@redhat.com>
Date: Tue, 9 Oct 2018 12:57:55 -0400
MIME-Version: 1.0
In-Reply-To: <2d9fea54-67ea-3cc5-6766-dd759710faab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 10/9/18 12:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/10/2018 06:18, Cleber Rosa wrote:
>> The acceptance (aka functional, aka Avocado-based) tests are
>> Python files located in "tests/acceptance" that need to be run
>> with the Avocado libs and test runner.
>>
>> Let's provide a convenient way for QEMU developers to run them,
>> by making use of the tests-venv with the required setup.
>>
>> Also, while the Avocado test runner will take care of creating a
>> location to save test results to, it was understood that it's better
>> if the results are kept within the build tree.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  docs/devel/testing.rst      | 35 ++++++++++++++++++++++++++++++-----
>>  tests/Makefile.include      | 17 +++++++++++++++--
>>  tests/venv-requirements.txt |  1 +
>>  3 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 727c4019b5..b992a2961d 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -545,10 +545,31 @@ Tests based on ``avocado_qemu.Test`` can easily:
>>     - http://avocado-framework.readthedocs.io/en/latest/api/test/avoca=
do.html#avocado.Test
>>     - http://avocado-framework.readthedocs.io/en/latest/api/utils/avoc=
ado.utils.html
>> =20
>> -Installation
>> -------------
>> +Running tests
>> +-------------
>> =20
>> -To install Avocado and its dependencies, run:
>> +You can run the acceptance tests simply by executing:
>> +
>> +.. code::
>> +
>> +  make check-acceptance
>> +
>> +This involves the automatic creation of Python virtual environment
>> +within the build tree (at ``tests/venv``) which will have all the
>> +right dependencies, and will save tests results also within the
>> +build tree (at ``tests/results``).
>> +
>> +Note: the build environment must be using a Python 3 stack, and have
>> +the ``venv`` and ``pip`` packages installed.  If necessary, make sure
>> +``configure`` is called with ``--python=3D`` and that those modules a=
re
>> +available.  On Debian and Ubuntu based systems, depending on the
>> +specific version, they may be on packages named ``python3-venv`` and
>> +``python3-pip``.
>> +
>> +Manual Installation
>> +-------------------
>> +
>> +To manually install Avocado and its dependencies, run:
>> =20
>>  .. code::
>> =20
>> @@ -689,11 +710,15 @@ The exact QEMU binary to be used on QEMUMachine.
>>  Uninstalling Avocado
>>  --------------------
>> =20
>> -If you've followed the installation instructions above, you can easil=
y
>> -uninstall Avocado.  Start by listing the packages you have installed:=
:
>> +If you've followed the manual installation instructions above, you ca=
n
>> +easily uninstall Avocado.  Start by listing the packages you have
>> +installed::
>> =20
>>    pip list --user
>> =20
>>  And remove any package you want with::
>> =20
>>    pip uninstall <package_name>
>> +
>> +If you've used ``make check-acceptance``, the Python virtual environm=
ent where
>> +Avocado is installed will be cleaned up as part of ``make check-clean=
``.
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 68af79927d..00fdf9913e 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -11,6 +11,7 @@ check-help:
>>  	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>>  	@echo " $(MAKE) check-block          Run block tests"
>>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>> +	@echo " $(MAKE) check-acceptance     Run all acceptance (functional)=
 tests"
>>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>>  	@echo " $(MAKE) check-venv           Creates a Python venv for tests=
"
>>  	@echo " $(MAKE) check-clean          Clean the tests"
>> @@ -1018,10 +1019,11 @@ check-decodetree:
>> =20
>>  # Python venv for running tests
>> =20
>> -.PHONY: check-venv
>> +.PHONY: check-venv check-acceptance
>> =20
>>  TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
>>  TESTS_VENV_REQ=3D$(SRC_PATH)/tests/venv-requirements.txt
>> +TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
>> =20
>>  $(TESTS_VENV_DIR):
>>  	$(call quiet-command, \
>> @@ -1031,8 +1033,19 @@ $(TESTS_VENV_DIR):
>>              $(TESTS_VENV_DIR)/bin/pip -q install -r $(TESTS_VENV_REQ)=
, \
>>              PIP, $(TESTS_VENV_REQ))
>> =20
>> +$(TESTS_RESULTS_DIR):
>> +	$(call quiet-command, mkdir -p $@, \
>> +            MKDIR, $@)
>> +
>>  check-venv: $(TESTS_VENV_DIR)
>> =20
>> +check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>> +	$(call quiet-command, \
>> +            $(TESTS_VENV_DIR)/bin/python -m avocado \
>> +            --show=3Dnone run --job-results-dir=3D$(TESTS_RESULTS_DIR=
) --failfast=3Don \
>=20
> Can we add an overwritable env var such AVOCADO_SHOW=3Dnone ?
> I'd use it for Travis, to see which test failed on the console output.
>=20

Yes, I was expecting a question/suggestion along those lines, because I
felt the need for that too.

Do you think we should use a non quiet version by default?  Even people
running `make check-acceptance` on their own systems might get
frustrated as the number of tests, and test run time, increases.

- Cleber.

>> +            $(SRC_PATH)/tests/acceptance, \
>> +            "AVOCADO", "tests/acceptance")
>> +
>>  # Consolidated targets
>> =20
>>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
>> @@ -1046,7 +1059,7 @@ check-clean:
>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-=
$(target)-y)) $(check-qtest-generic-y))
>>  	rm -f tests/test-qapi-gen-timestamp
>> -	rm -rf $(TESTS_VENV_DIR)
>> +	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
>> =20
>>  clean: check-clean
>> =20
>> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.txt
>> index d39f9d1576..64c6e27a94 100644
>> --- a/tests/venv-requirements.txt
>> +++ b/tests/venv-requirements.txt
>> @@ -1,3 +1,4 @@
>>  # Add Python module requirements, one per line, to be installed
>>  # in the tests/venv Python virtual environment. For more info,
>>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>> +avocado-framework=3D=3D65.0
>>
