Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCPlr-0008Ny-WF
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCPlc-0005CA-Fc
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCPlW-0004yS-Ox
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:52:07 -0400
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-2-crosa@redhat.com>
	<94f7da55-eaa1-6e63-333c-894831b9d66e@redhat.com>
	<20181013033747.GC31060@habkost.net>
	<cac61fc7-e5f1-061b-fdab-23be1ef2f204@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <2f5931c6-0873-1bec-04ef-bd8d9e769ea4@redhat.com>
Date: Tue, 16 Oct 2018 09:51:54 -0400
MIME-Version: 1.0
In-Reply-To: <cac61fc7-e5f1-061b-fdab-23be1ef2f204@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ccarrara@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 10/15/18 2:41 PM, Caio Carrara wrote:
> On 13-10-2018 00:37, Eduardo Habkost wrote:
>> On Fri, Oct 12, 2018 at 11:30:39PM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> Hi Cleber,
>>>
>>> On 12/10/2018 18:53, Cleber Rosa wrote:
>>>> A number of QEMU tests are written in Python, and may benefit
>>>> from an untainted Python venv.
>>>>
>>>> By using make rules, tests that depend on specific Python libs
>>>> can set that rule as a requirement, along with rules that require
>>>> the presence or installation of specific libraries.
>>>>
>>>> The tests/venv-requirements.txt is supposed to contain the
>>>> Python requirements that should be added to the venv created
>>>> by check-venv.
>>>
>>> Maybe you (or Eduardo...) what you wrote in the cover:
>>>
>>>  There's one current caveat: it requires Python 3, as it's based on t=
he
>>>  venv module.
>>>
>>> To explain:
>>>
>>> $ make check-acceptance
>>> /usr/bin/python2: No module named venv
>>> make: *** [/home/phil/source/qemu/tests/Makefile.include:1033:] Error=
 1
>>
>> Oops, this doesn't look very friendly.
>>
>> But note that this would become a non-issue if we start requiring
>> Python 3 for building QEMU.
>>
>>
>>>
>>>>
>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>>  tests/Makefile.include      | 20 ++++++++++++++++++++
>>>>  tests/venv-requirements.txt |  3 +++
>>>>  2 files changed, 23 insertions(+)
>>>>  create mode 100644 tests/venv-requirements.txt
>>>>
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index 5eadfd52f9..b66180efa1 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -12,6 +12,7 @@ check-help:
>>>>  	@echo " $(MAKE) check-block          Run block tests"
>>>>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>>>>  	@echo " $(MAKE) check-report.html    Generates an HTML test report=
"
>>>> +	@echo " $(MAKE) check-venv           Creates a Python venv for tes=
ts"
>>>>  	@echo " $(MAKE) check-clean          Clean the tests"
>>>>  	@echo
>>>>  	@echo "Please note that HTML reports do not regenerate if the unit=
 tests"
>>>> @@ -1017,6 +1018,24 @@ check-decodetree:
>>>>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py=
", \
>>>>            TEST, decodetree.py)
>>>> =20
>>>> +# Python venv for running tests
>>>> +
>>>> +.PHONY: check-venv
>>>> +
>>>> +TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
>>>> +TESTS_VENV_REQ=3D$(SRC_PATH)/tests/venv-requirements.txt
>>>> +
>>>> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>>>> +	$(call quiet-command, \
>>>> +            $(PYTHON) -m venv --system-site-packages $@, \
>>>> +            VENV, $@)
>>>> +	$(call quiet-command, \
>>>> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TES=
TS_VENV_REQ), \
>>>> +            PIP, $(TESTS_VENV_REQ))
>>>> +	$(call quiet-command, touch $@)
>>>
>>> Hmm maybe we should print something like:
>>>
>>>   "You can now activate this virtual environment using:
>>>     source $(TESTS_VENV_DIR)/tests/venv/bin/activate"
>>
>> I'm not sure this would be necessary: I expect usage of the venv
>> to be completely transparent.
>>
>> If we require people to learn what venv is and manually activate
>> it, I'd say we have failed to provide usable tools for running
>> the tests.
>>
>=20
> Actually this is not necessary since the avocado is being called from
> the "venv python binary" as you can see in the check-acceptance target.
>=20

Exactly.

> This way all the requirements installed in the test venv can be used
> without activating the virtual environment.
>=20

Exactly.

- Cleber.

>>
>>>
>>>> +
>>>> +check-venv: $(TESTS_VENV_DIR)
>>>> +
>>>>  # Consolidated targets
>>>> =20
>>>>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
>>>> @@ -1030,6 +1049,7 @@ check-clean:
>>>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtes=
t-$(target)-y)) $(check-qtest-generic-y))
>>>>  	rm -f tests/test-qapi-gen-timestamp
>>>> +	rm -rf $(TESTS_VENV_DIR)
>>>> =20
>>>>  clean: check-clean
>>>> =20
>>>> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.t=
xt
>>>> new file mode 100644
>>>> index 0000000000..d39f9d1576
>>>> --- /dev/null
>>>> +++ b/tests/venv-requirements.txt
>>>> @@ -0,0 +1,3 @@
>>>> +# Add Python module requirements, one per line, to be installed
>>>> +# in the tests/venv Python virtual environment. For more info,
>>>> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>>>
>>>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>=20
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
