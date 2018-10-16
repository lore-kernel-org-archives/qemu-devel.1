Received: from eggs.gnu.org ([2001:4830:134:3::10]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCQ1f-0008NE-5R
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCQ1c-0006pF-EI
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:08:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCQ1c-0006nO-3j
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:08:44 -0400
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-2-crosa@redhat.com>
	<94f7da55-eaa1-6e63-333c-894831b9d66e@redhat.com>
	<20181013033747.GC31060@habkost.net>
	<cac61fc7-e5f1-061b-fdab-23be1ef2f204@redhat.com>
	<92ecebc0-47dd-b80b-e59b-d0904fbafbb1@redhat.com>
	<20181015224036.GI31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <a88876a0-ef9e-ea0c-7301-e8d56acaf49f@redhat.com>
Date: Tue, 16 Oct 2018 10:08:25 -0400
MIME-Version: 1.0
In-Reply-To: <20181015224036.GI31060@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: ccarrara@redhat.com, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>



On 10/15/18 6:40 PM, Eduardo Habkost wrote:
> On Tue, Oct 16, 2018 at 12:28:07AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Caio,
>>
>> On 15/10/2018 20:41, Caio Carrara wrote:
>>> On 13-10-2018 00:37, Eduardo Habkost wrote:
>>>> On Fri, Oct 12, 2018 at 11:30:39PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>> Hi Cleber,
>>>>>
>>>>> On 12/10/2018 18:53, Cleber Rosa wrote:
>>>>>> A number of QEMU tests are written in Python, and may benefit
>>>>>> from an untainted Python venv.
>>>>>>
>>>>>> By using make rules, tests that depend on specific Python libs
>>>>>> can set that rule as a requirement, along with rules that require
>>>>>> the presence or installation of specific libraries.
>>>>>>
>>>>>> The tests/venv-requirements.txt is supposed to contain the
>>>>>> Python requirements that should be added to the venv created
>>>>>> by check-venv.
>>>>>
>>>>> Maybe you (or Eduardo...) what you wrote in the cover:
>>>>>
>>>>>  There's one current caveat: it requires Python 3, as it's based on=
 the
>>>>>  venv module.
>>>>>
>>>>> To explain:
>>>>>
>>>>> $ make check-acceptance
>>>>> /usr/bin/python2: No module named venv
>>>>> make: *** [/home/phil/source/qemu/tests/Makefile.include:1033:] Err=
or 1
>>>>
>>>> Oops, this doesn't look very friendly.
>>>>
>>>> But note that this would become a non-issue if we start requiring
>>>> Python 3 for building QEMU.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>>>> ---
>>>>>>  tests/Makefile.include      | 20 ++++++++++++++++++++
>>>>>>  tests/venv-requirements.txt |  3 +++
>>>>>>  2 files changed, 23 insertions(+)
>>>>>>  create mode 100644 tests/venv-requirements.txt
>>>>>>
>>>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>>>> index 5eadfd52f9..b66180efa1 100644
>>>>>> --- a/tests/Makefile.include
>>>>>> +++ b/tests/Makefile.include
>>>>>> @@ -12,6 +12,7 @@ check-help:
>>>>>>  	@echo " $(MAKE) check-block          Run block tests"
>>>>>>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>>>>>>  	@echo " $(MAKE) check-report.html    Generates an HTML test repo=
rt"
>>>>>> +	@echo " $(MAKE) check-venv           Creates a Python venv for t=
ests"
>>>>>>  	@echo " $(MAKE) check-clean          Clean the tests"
>>>>>>  	@echo
>>>>>>  	@echo "Please note that HTML reports do not regenerate if the un=
it tests"
>>>>>> @@ -1017,6 +1018,24 @@ check-decodetree:
>>>>>>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.=
py", \
>>>>>>            TEST, decodetree.py)
>>>>>> =20
>>>>>> +# Python venv for running tests
>>>>>> +
>>>>>> +.PHONY: check-venv
>>>>>> +
>>>>>> +TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
>>>>>> +TESTS_VENV_REQ=3D$(SRC_PATH)/tests/venv-requirements.txt
>>>>>> +
>>>>>> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>>>>>> +	$(call quiet-command, \
>>>>>> +            $(PYTHON) -m venv --system-site-packages $@, \
>>>>>> +            VENV, $@)
>>>>>> +	$(call quiet-command, \
>>>>>> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(T=
ESTS_VENV_REQ), \
>>>>>> +            PIP, $(TESTS_VENV_REQ))
>>>>>> +	$(call quiet-command, touch $@)
>>>>>
>>>>> Hmm maybe we should print something like:
>>>>>
>>>>>   "You can now activate this virtual environment using:
>>>>>     source $(TESTS_VENV_DIR)/tests/venv/bin/activate"
>>>>
>>>> I'm not sure this would be necessary: I expect usage of the venv
>>>> to be completely transparent.
>>>>
>>>> If we require people to learn what venv is and manually activate
>>>> it, I'd say we have failed to provide usable tools for running
>>>> the tests.
>>>>
>>>
>>> Actually this is not necessary since the avocado is being called from
>>> the "venv python binary" as you can see in the check-acceptance targe=
t.
>>>
>>> This way all the requirements installed in the test venv can be used
>>> without activating the virtual environment.
>>
>> Well this is only true if you call 'make check-acceptance', not if you
>> want to filter tests, or run the single file you are working on...
>> Or am I missing something? The only option user-configurable (without
>> activating the venv) is the output of all tests via the AVOCADO_SHOW e=
nv
>> var.
>>
>> This might be enough for a maintainer checking his subsystem, but I
>> don't find this practical for a acceptance test writer. And we want fo=
r
>> people to contribute adding tests, right?
>> Well, if we have maintainer running them, this is already a win :)
>>
>=20
> Good point: these are important use cases too.
>=20
> Now, we need to decide what's the best interface for performing
> those tasks.
>=20
> Existing unit tests and qtest-based tests use Makefile variables
> to select test cases to run.  But I'm not sure this is the most
> usable way to do it.
>=20

I also fear about getting too deep into the Makefiles, adding content
for every new test, etc.  It's certainly not the way to go here.

> Telling people to manually activate the venv and run avocado
> manually doesn't sound desirable to me: people would get a
> completely different behavior from `check-acceptance`: they'll
> get log files in a different location, and get confused if extra
> avocado arguments are required to make some tests work.
>=20

Agreed.  The whole point of this work, IMO, is to provide a seamless and
transparent way to execute the most common task.  At this point, we
should be telling people to run *all* tests we have, so selecting
specific tests is something that we have some time to deal with.

> Personally, I think most people would be more comfortable using a
> simple `./tests/acceptance/run` wrapper script, that would
> transparently invoke avocado inside the venv with the right
> arguments.
>=20

I have something in mind which seems to relate to your idea of `run`.
Basically, when we get to the point of having more complex test suites,
we can have "avocado job scripts", using the "Job API", to create and
run jobs with a specific selection of tests and custom options (such as
specific varianters for some tests, etc).

For instance, we may want to have a "job_storage_migration.py", an
Avocado job script (not a test), that includes a pre-tests plugin
execution that sets up some storage, a test suitewith a few acceptance
tests, another test suite with some iotests run with different variants,
and a post-tests plugin that cleans up the environment.

Until then, I don't know what I would put into `run`.  A command that
calls `make check-acceptance`?  I'm confused by that.

> Bonus points if we make it possible to execute single test cases
> directly using `python tests/acceptance/mytestcase.py` or
> `./tests/acceptance/mytestcase.py`.
>=20

This is possible with:

#!/usr/bin/env python

from avocado import main

[test]

if __name__ =3D=3D "__main__":
    main()

But is it really worth it?  IMO, it's not.

- Cleber.

>=20
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +check-venv: $(TESTS_VENV_DIR)
>>>>>> +
>>>>>>  # Consolidated targets
>>>>>> =20
>>>>>>  .PHONY: check-qapi-schema check-qtest check-unit check check-clea=
n
>>>>>> @@ -1030,6 +1049,7 @@ check-clean:
>>>>>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>>>>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qt=
est-$(target)-y)) $(check-qtest-generic-y))
>>>>>>  	rm -f tests/test-qapi-gen-timestamp
>>>>>> +	rm -rf $(TESTS_VENV_DIR)
>>>>>> =20
>>>>>>  clean: check-clean
>>>>>> =20
>>>>>> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements=
.txt
>>>>>> new file mode 100644
>>>>>> index 0000000000..d39f9d1576
>>>>>> --- /dev/null
>>>>>> +++ b/tests/venv-requirements.txt
>>>>>> @@ -0,0 +1,3 @@
>>>>>> +# Add Python module requirements, one per line, to be installed
>>>>>> +# in the tests/venv Python virtual environment. For more info,
>>>>>> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>>>>>
>>>>>
>>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>
>>>
>>>
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
