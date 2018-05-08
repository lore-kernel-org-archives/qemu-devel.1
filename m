Received: from eggs.gnu.org ([2001:4830:134:3::10]:53311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fG77h-0002CA-5l
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fG77e-0005e8-03
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:14:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fG77d-0005d5-QQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:13:57 -0400
References: <20180426135755.GI29865@localhost.localdomain>
	<20180508095627.GB19710@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <a80c8743-0c99-ab24-7a16-71fd81bad792@redhat.com>
Date: Tue, 8 May 2018 14:13:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180508095627.GB19710@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Yash Mankad <ymankad@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 05/08/2018 05:56 AM, Stefan Hajnoczi wrote:
> On Thu, Apr 26, 2018 at 10:57:55AM -0300, Eduardo Habkost wrote:
>> (Starting a new thread, for more visibility)
>>
>> (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
>> devices with all machines, not only with "none")
>>
>> On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>> On 17.04.2018 14:12, Markus Armbruster wrote:
>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>
>>>>>> Many device introspection crashes only happen if you are using a
>>>>>> certain machine, e.g.:
>>>>>>
>>>>>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
>>>>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
>>>>>>  "package": "build-all"}, "capabilities": []}}
>>>>>> { 'execute': 'qmp_capabilities' }
>>>>>> {"return": {}}
>>>>>> { 'execute': 'device-list-properties',
>>>>>>   'arguments': {'typename': 'macio-newworld'}}
>>>>>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
>>>>>> Device 'serial0' is in use
>>>>>> Aborted (core dumped)
>>>>>>
>>>>>> To be able to catch these problems, let's extend the device-introspect
>>>>>> test to check the devices on all machine types. Since this is a rather
>>>>>> slow operation, the test is only run in "SPEED=slow" mode.
>>>>>
>>>>> If the device works with one machine type, it has a decent chance to
>>>>> work with others, too.  Thus, testing each device with every machine
>>>>> type is overkill.  I appreciate having overkill as an option :)
>>>>>
>>>>> What I'd like to see for a quick "make check" is testing each device
>>>>> once.  That should flush out most bugs.  
>>>>
>>>> That's already done with the "none" machine.
>>>
>>> I was too terse.  We test each device with -machine none for every
>>> target.  Fine if that's quick enough.  If not, we might want to reduce
>>> redundancy there.
>>>
>>> Actually, a worse offender in the "waste everybody's time via redunancy"
>>> department could be qom-test.
>>>
>>>> Anyway, do you think my patch here is useful and has a chance of getting
>>>> included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
>>>> rather wait for Eduardo's python-based tests to get included into the
>>>> repository?
>>>
>>> I don't mind having make check SPEED=slow run more extensive tests.
>>> Assuming we actually run them at least once in a while, which seems
>>> doubtful.
>>
>> We probably don't do that, but we really must be running a more
>> extensive (and slower) test set at least once before every
>> release.
>>
>> Maybe some people are running SPEED=slow tests, or even more
>> extensive test suites like avocado-vt once in a while, but we
>> need to know who is running them, and when.
>>
>> Today, the only test set I know people really run and would
>> surely block a release is "make check [SPEED=quick]".
>>
>> So, for anybody that runs automated QEMU tests once in a while,
>> can we know:
>>
>> * What test cases are you running?  Where can we get more
>>   information about the tests you run?
>> * When do you run them?  What triggers a new test run?
> 
> I manually run qemu-iotests on release candidates:
> 
>  $ (cd tests/qemu-iotests && ./check && ./check -qcow2)
> 
> The goal is to identify test failures that still need to be addressed
> before the release is made.
> 
> I think Kevin Wolf and John Snow have also been running qemu-iotests to
> eliminate regressions during the freeze.
> 
> Stefan
> 

Yeah, it's always manual though.

I generally do an x86-for-x86 build with clang, make check, and do an
iotests across raw and qcow2 before sending a patch series.

When RC0 hits, I usually do a full build of all targets and do an
iotests check across all the file formats, but I don't bother with
protocols.

I generally don't use gcc because there's probably enough coverage out
there.

--js
