Received: from eggs.gnu.org ([2001:4830:134:3::10]:55624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9ue5-0008LJ-FP
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9ue2-00085d-7D
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:14:05 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9ue1-000852-Vm
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:14:02 -0400
Received: by mail-wr1-f52.google.com with SMTP id w5-v6so2480020wrt.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 09:14:01 -0700 (PDT)
References: <20181009041826.19462-1-crosa@redhat.com>
	<20181009041826.19462-2-crosa@redhat.com>
	<55a1c7a3-0381-f426-edca-d95c04180326@redhat.com>
	<5c424a39-02b3-2f5d-57fe-eb322b550675@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97c326c6-e096-427c-e38f-b31ba939bc3b@redhat.com>
Date: Tue, 9 Oct 2018 18:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <5c424a39-02b3-2f5d-57fe-eb322b550675@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 09/10/2018 18:00, Cleber Rosa wrote:
> 
> 
> On 10/9/18 9:25 AM, Philippe Mathieu-Daudé wrote:
>> Hi Cleber,
>>
>> On 09/10/2018 06:18, Cleber Rosa wrote:
>>> A number of QEMU tests are written in Python, and may benefit
>>> from an untainted Python venv.
>>>
>>> By using make rules, tests that depend on specific Python libs
>>> can set that rule as a requiment, along with rules that require
>>> the presence or installation of specific libraries.
>>>
>>> The tests/venv-requirements.txt is supposed to contain the
>>> Python requirements that should be added to the venv created
>>> by check-venv.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  tests/Makefile.include      | 19 +++++++++++++++++++
>>>  tests/venv-requirements.txt |  3 +++
>>>  2 files changed, 22 insertions(+)
>>>  create mode 100644 tests/venv-requirements.txt
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 7a3059bf6c..68af79927d 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -12,6 +12,7 @@ check-help:
>>>  	@echo " $(MAKE) check-block          Run block tests"
>>>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>>>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>>> +	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>>>  	@echo " $(MAKE) check-clean          Clean the tests"
>>>  	@echo
>>>  	@echo "Please note that HTML reports do not regenerate if the unit tests"
>>> @@ -1015,6 +1016,23 @@ check-decodetree:
>>>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>>>            TEST, decodetree.py)
>>>  
>>> +# Python venv for running tests
>>> +
>>> +.PHONY: check-venv
>>> +
>>> +TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
>>> +TESTS_VENV_REQ=$(SRC_PATH)/tests/venv-requirements.txt
>>> +
>>> +$(TESTS_VENV_DIR):
>>> +	$(call quiet-command, \
>>> +            $(PYTHON) -m venv --system-site-packages $@, \
>>
>> Why do we want the '--system-site-packages' flag?
>>
> 
> It allows the reuse of packages (with no additional downloads) in case
> there's a package installed system wide providing the same package and
> version.  If you have, say, an RPM or DEB (or even a pip) package
> installed system wide, it'll be copied over to the venv.  This was based
> on a suggestion by Eduardo.

Some system-site-packages are broken (or too old?).

> 
>>> +            VENV, $@)
>>> +	$(call quiet-command, \
>>> +            $(TESTS_VENV_DIR)/bin/pip -q install -r $(TESTS_VENV_REQ), \
>>
>> On Ubuntu I have to use (after installing python3-pip + python3.4-venv):
>>
>>                $(PYTHON) -m pip -q install -r $(TESTS_VENV_REQ), \
>>
> 
> I don't think running $(PYTHON) is the right thing to do here because it
> points to non-venv Python interpreter.  IMO it should be:
> 
>                 $(TESTS_VENV_DIR)/bin/python -m pip ...

Yes it worked: https://travis-ci.org/philmd/qemu/jobs/439216885

> 
>>> +            PIP, $(TESTS_VENV_REQ))
>>> +
>>> +check-venv: $(TESTS_VENV_DIR)
>>
>> Same problem from v1: if check-venv failed and the directory exists, the
>> rule succeeds.
>>
> 
> I really don't know how to make all the steps of this target "atomic",
> unless I do an ugly "venv ... && touch ... && pip ...".  The best I
> managed to think was to flag the requirement as fulfilled by touching
> the venv directory after pip finishes.
> 
> - Cleber.
> 
>>> +
>>>  # Consolidated targets
>>>  
>>>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
>>> @@ -1028,6 +1046,7 @@ check-clean:
>>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>>>  	rm -f tests/test-qapi-gen-timestamp
>>> +	rm -rf $(TESTS_VENV_DIR)
>>>  
>>>  clean: check-clean
>>>  
>>> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.txt
>>> new file mode 100644
>>> index 0000000000..d39f9d1576
>>> --- /dev/null
>>> +++ b/tests/venv-requirements.txt
>>> @@ -0,0 +1,3 @@
>>> +# Add Python module requirements, one per line, to be installed
>>> +# in the tests/venv Python virtual environment. For more info,
>>> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>>
