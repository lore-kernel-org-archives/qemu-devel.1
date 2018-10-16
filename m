Received: from eggs.gnu.org ([2001:4830:134:3::10]:48304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCQAm-0004FP-Nq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCQAg-0001Yf-Gt
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCQAg-0001Xm-7v
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:18:06 -0400
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-2-crosa@redhat.com>
	<15152430-8023-2fac-2bbe-0876ac632e9d@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <43405fa7-d7b6-6549-c82d-ffc5c534d3f6@redhat.com>
Date: Tue, 16 Oct 2018 10:17:59 -0400
MIME-Version: 1.0
In-Reply-To: <15152430-8023-2fac-2bbe-0876ac632e9d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ccarrara@redhat.com, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/15/18 3:04 PM, Caio Carrara wrote:
> On 12-10-2018 13:53, Cleber Rosa wrote:
>> A number of QEMU tests are written in Python, and may benefit
>> from an untainted Python venv.
>>
>> By using make rules, tests that depend on specific Python libs
>> can set that rule as a requirement, along with rules that require
>> the presence or installation of specific libraries.
>>
>> The tests/venv-requirements.txt is supposed to contain the
>> Python requirements that should be added to the venv created
>> by check-venv.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/Makefile.include      | 20 ++++++++++++++++++++
>>  tests/venv-requirements.txt |  3 +++
> 
> Any special reason to name `venv-requirements.txt` instead of only
> `requirements.txt`? I think the second way is better (if there's no
> cons) since it's the default from most of Python projects. Besides that
> seems more semantic to have a `tests/requirements.txt` file that
> registers the requirements for tests.
> 

It was a decision based on the fact that other components may have other
requirements, basically a namespace thing and a "explicit is better than
implicit" thing.

The env-requirements.txt file is not for "tests" in general, but for the
tests that we want to be run out of the venv.  This can quickly become a
different thing (look at the tests/docker, tests/vm, tests/migration, etc).

> Still in this topic. As far as I could see, the files in `tests/`
> directory are almost all C source code. The right place for the Python
> requirements seems the `tests/acceptance/` directory specially because
> the subject of all this patches. Keeping only one requirements file for
> all kinds of tests (that uses Python) can be problematic in my opinion.
> If it makes any sense, probably is also a good idea rename the target
> from `check-venv` to something like `check-acceptance-venv`.
> 

I agree with some of your points here.  The way I see this working is
either:

1) Have a single venv created for running Python based tests, and have
its requirements listed in tests/venv-requirements.txt

2) Have one venv created for every type of Python based tests, and have
requirements.txt in the specific directories (such as
tests/acceptance/requirements.txt, tests/vm/requirements.txt), and
multiple `check-[type]-venv` targets.

I obviously chose 1, simply because I find it overkill to have different
venvs at this point.  I don't see the additional value option #2 would
have at this point.

- Cleber.

>>  2 files changed, 23 insertions(+)
>>  create mode 100644 tests/venv-requirements.txt
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 5eadfd52f9..b66180efa1 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -12,6 +12,7 @@ check-help:
>>  	@echo " $(MAKE) check-block          Run block tests"
>>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>> +	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>>  	@echo " $(MAKE) check-clean          Clean the tests"
>>  	@echo
>>  	@echo "Please note that HTML reports do not regenerate if the unit tests"
>> @@ -1017,6 +1018,24 @@ check-decodetree:
>>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>>            TEST, decodetree.py)
>>  
>> +# Python venv for running tests
>> +
>> +.PHONY: check-venv
>> +
>> +TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
>> +TESTS_VENV_REQ=$(SRC_PATH)/tests/venv-requirements.txt
>> +
>> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>> +	$(call quiet-command, \
>> +            $(PYTHON) -m venv --system-site-packages $@, \
>> +            VENV, $@)
>> +	$(call quiet-command, \
>> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV_REQ), \
>> +            PIP, $(TESTS_VENV_REQ))
>> +	$(call quiet-command, touch $@)
>> +
>> +check-venv: $(TESTS_VENV_DIR)
>> +
>>  # Consolidated targets
>>  
>>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
>> @@ -1030,6 +1049,7 @@ check-clean:
>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>>  	rm -f tests/test-qapi-gen-timestamp
>> +	rm -rf $(TESTS_VENV_DIR)
>>  
>>  clean: check-clean
>>  
>> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.txt
>> new file mode 100644
>> index 0000000000..d39f9d1576
>> --- /dev/null
>> +++ b/tests/venv-requirements.txt
>> @@ -0,0 +1,3 @@
>> +# Add Python module requirements, one per line, to be installed
>> +# in the tests/venv Python virtual environment. For more info,
>> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>
> 
> 

-- 
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
