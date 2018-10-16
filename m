Received: from eggs.gnu.org ([2001:4830:134:3::10]:41240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCPqO-0002iW-2n
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCPqK-0001XV-30
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCPqJ-0001WW-Qg
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:57:04 -0400
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-2-crosa@redhat.com>
	<94f7da55-eaa1-6e63-333c-894831b9d66e@redhat.com>
	<20181013033747.GC31060@habkost.net>
	<cac61fc7-e5f1-061b-fdab-23be1ef2f204@redhat.com>
	<92ecebc0-47dd-b80b-e59b-d0904fbafbb1@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <a287a6a5-71c7-4ec8-945d-7c779cd070f4@redhat.com>
Date: Tue, 16 Oct 2018 09:56:53 -0400
MIME-Version: 1.0
In-Reply-To: <92ecebc0-47dd-b80b-e59b-d0904fbafbb1@redhat.com>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, ccarrara@redhat.com, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>



On 10/15/18 6:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Caio,
>=20
> On 15/10/2018 20:41, Caio Carrara wrote:
>> On 13-10-2018 00:37, Eduardo Habkost wrote:
>>> On Fri, Oct 12, 2018 at 11:30:39PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>> Hi Cleber,
>>>>
>>>> On 12/10/2018 18:53, Cleber Rosa wrote:
>>>>> A number of QEMU tests are written in Python, and may benefit
>>>>> from an untainted Python venv.
>>>>>
>>>>> By using make rules, tests that depend on specific Python libs
>>>>> can set that rule as a requirement, along with rules that require
>>>>> the presence or installation of specific libraries.
>>>>>
>>>>> The tests/venv-requirements.txt is supposed to contain the
>>>>> Python requirements that should be added to the venv created
>>>>> by check-venv.
>>>>
>>>> Maybe you (or Eduardo...) what you wrote in the cover:
>>>>
>>>>  There's one current caveat: it requires Python 3, as it's based on =
the
>>>>  venv module.
>>>>
>>>> To explain:
>>>>
>>>> $ make check-acceptance
>>>> /usr/bin/python2: No module named venv
>>>> make: *** [/home/phil/source/qemu/tests/Makefile.include:1033:] Erro=
r 1
>>>
>>> Oops, this doesn't look very friendly.
>>>
>>> But note that this would become a non-issue if we start requiring
>>> Python 3 for building QEMU.
>>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>>> ---
>>>>>  tests/Makefile.include      | 20 ++++++++++++++++++++
>>>>>  tests/venv-requirements.txt |  3 +++
>>>>>  2 files changed, 23 insertions(+)
>>>>>  create mode 100644 tests/venv-requirements.txt
>>>>>
>>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>>> index 5eadfd52f9..b66180efa1 100644
>>>>> --- a/tests/Makefile.include
>>>>> +++ b/tests/Makefile.include
>>>>> @@ -12,6 +12,7 @@ check-help:
>>>>>  	@echo " $(MAKE) check-block          Run block tests"
>>>>>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>>>>>  	@echo " $(MAKE) check-report.html    Generates an HTML test repor=
t"
>>>>> +	@echo " $(MAKE) check-venv           Creates a Python venv for te=
sts"
>>>>>  	@echo " $(MAKE) check-clean          Clean the tests"
>>>>>  	@echo
>>>>>  	@echo "Please note that HTML reports do not regenerate if the uni=
t tests"
>>>>> @@ -1017,6 +1018,24 @@ check-decodetree:
>>>>>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.p=
y", \
>>>>>            TEST, decodetree.py)
>>>>> =20
>>>>> +# Python venv for running tests
>>>>> +
>>>>> +.PHONY: check-venv
>>>>> +
>>>>> +TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
>>>>> +TESTS_VENV_REQ=3D$(SRC_PATH)/tests/venv-requirements.txt
>>>>> +
>>>>> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>>>>> +	$(call quiet-command, \
>>>>> +            $(PYTHON) -m venv --system-site-packages $@, \
>>>>> +            VENV, $@)
>>>>> +	$(call quiet-command, \
>>>>> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TE=
STS_VENV_REQ), \
>>>>> +            PIP, $(TESTS_VENV_REQ))
>>>>> +	$(call quiet-command, touch $@)
>>>>
>>>> Hmm maybe we should print something like:
>>>>
>>>>   "You can now activate this virtual environment using:
>>>>     source $(TESTS_VENV_DIR)/tests/venv/bin/activate"
>>>
>>> I'm not sure this would be necessary: I expect usage of the venv
>>> to be completely transparent.
>>>
>>> If we require people to learn what venv is and manually activate
>>> it, I'd say we have failed to provide usable tools for running
>>> the tests.
>>>
>>
>> Actually this is not necessary since the avocado is being called from
>> the "venv python binary" as you can see in the check-acceptance target=
.
>>
>> This way all the requirements installed in the test venv can be used
>> without activating the virtual environment.
>=20
> Well this is only true if you call 'make check-acceptance', not if you
> want to filter tests, or run the single file you are working on...
> Or am I missing something? The only option user-configurable (without
> activating the venv) is the output of all tests via the AVOCADO_SHOW en=
v
> var.

Allowing someone to just run `make check-acceptance` is the primary and
most important goal here IMO.  It's supposed to be simple, which means,
not having too many knobs.

>=20
> This might be enough for a maintainer checking his subsystem, but I
> don't find this practical for a acceptance test writer. And we want for
> people to contribute adding tests, right?
> Well, if we have maintainer running them, this is already a win :)
>=20

Today, with the code AS-IS, you can still do:

 $ tests/venv/bin/avocado run [all your options] tests/acceptance

I think the subsystem and maintainers question will come, but it's a
different discussion.  Contradicting myself now and getting into that
discussion, :P, it could be as simple as `make TAG=3Dfoo check-acceptance=
`
that gets passed to Avocado.  Or, in line with other check targets,
`make check-acceptance-foo`.

- Cleber.

>>
>>>
>>>>
>>>>> +
>>>>> +check-venv: $(TESTS_VENV_DIR)
>>>>> +
>>>>>  # Consolidated targets
>>>>> =20
>>>>>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
>>>>> @@ -1030,6 +1049,7 @@ check-clean:
>>>>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>>>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qte=
st-$(target)-y)) $(check-qtest-generic-y))
>>>>>  	rm -f tests/test-qapi-gen-timestamp
>>>>> +	rm -rf $(TESTS_VENV_DIR)
>>>>> =20
>>>>>  clean: check-clean
>>>>> =20
>>>>> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.=
txt
>>>>> new file mode 100644
>>>>> index 0000000000..d39f9d1576
>>>>> --- /dev/null
>>>>> +++ b/tests/venv-requirements.txt
>>>>> @@ -0,0 +1,3 @@
>>>>> +# Add Python module requirements, one per line, to be installed
>>>>> +# in the tests/venv Python virtual environment. For more info,
>>>>> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>>>>
>>>>
>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>
>>

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
