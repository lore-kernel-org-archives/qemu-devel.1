Received: from eggs.gnu.org ([209.51.188.92]:40129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grmjZ-0004Ro-5I
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grmjX-000354-Pa
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:41:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1grmjX-00034h-HL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:41:03 -0500
References: <20181121214818.22874-1-crosa@redhat.com>
	<20181121214818.22874-2-crosa@redhat.com>
	<d67d31c9-06fe-1f06-66e0-bc6678212ccd@redhat.com>
	<9383c42d-b20f-9337-7d95-7fb57659513e@redhat.com>
	<c6925a91-24d9-c0b5-3942-e59bfda58e3a@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <07d0c006-f9c3-20b7-7de3-ebd0a2dfb8f1@redhat.com>
Date: Thu, 7 Feb 2019 11:40:53 -0500
MIME-Version: 1.0
In-Reply-To: <c6925a91-24d9-c0b5-3942-e59bfda58e3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] RFC: Acceptance tests: add the
 build directory to the system PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>



On 2/6/19 5:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 2/6/19 8:30 PM, Cleber Rosa wrote:
>> On 11/22/18 3:15 PM, Wainer dos Santos Moschetta wrote:
>>>
>>> On 11/21/2018 07:48 PM, Cleber Rosa wrote:
>>>> So that when binaries such as qemu-img are searched for, those in th=
e
>>>> build tree will be favored.=C2=A0 As a clarification, SRC_ROOT_DIR i=
s
>>>> dependent on the location from where tests are executed, so they are
>>>> equal to the build directory if one is being used.
>>>
>>> On avocado's job.log file I can see the full path of the qemu-img whi=
ch
>>> was called, but I wonder if it wouldn't be better to log that
>>> information somewhere more explicitly. It wouldn't prevent this patch
>>> from being merged though, it's just an improvement suggestion.
>>>
>>>>
>>>> The original motivation is that Avocado libraries such as
>>>> avocado.utils.vmimage.get() may use the matching binaries, but it ma=
y
>>>> also apply to any other binary that test code may eventually attempt
>>>> to execute.
>>>>
>>>> Other competing alternatives would be a more explicit path or binary
>>>> registration mechanism, in which we tell the libraries such as
>>>> avocado.utils.vmimage, the binaries to use in advance.=C2=A0 I think=
 the
>>>> model proposed here is simpler though, and is not inconsistent with
>>>> the general approach of favoring the built binaries, and falling bac=
k
>>>> to binaries available in the system.=C2=A0 I'd love to have comments=
 on
>>>> that, though.
>>>
>>> IMHO it makes sense to pick the built binaries, falling back to syste=
m's
>>> otherwise. Keep it simple (and consistent) unless we eventually need
>>> something robust, I would go for that approach here.
>>>
>>
>> Agreed.
>>
>>>>
>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
>>>> =C2=A0 1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py
>>>> b/tests/acceptance/avocado_qemu/__init__.py
>>>> index 1e54fd5932..3d5190cbab 100644
>>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>>> @@ -49,6 +49,15 @@ class Test(avocado.Test):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 self.cancel("No QEMU binary defined or found in the
>>>> source tree")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm =3D Q=
EMUMachine(self.qemu_bin)
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RFC: avocado.ut=
ils.vmimage.get() uses qemu-img, from the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # system's PATH, to crea=
te a snapshot.=C2=A0 This is a transparent,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # but implicit way of ma=
king sure it finds the qemu-img that
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # matches the code being=
 tested (as tests it indirectly too).
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # As for the cleanup, gi=
ven that in the Avocado test execution
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # model every test is st=
arted in a different process, no
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # cleanup is needed.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.environ['PATH'] =3D '=
%s:%s' % (SRC_ROOT_DIR,
>>>> os.environ['PATH'])
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def tearDown(self):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.vm is=
 not None:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 self.vm.shutdown()
>>>
>>> The boot Linux test (added on patch 02) exits with error when I ran
>>> 'make check-acceptance'. I am using Fedora 29 x86_64 which don't have
>>> qemu-img installed system-wide. See below:
>>>
>>> ------
>>> # make check-acceptance
>>> =C2=A0 AVOCADO tests/acceptance
>>> make: *** [/root/qemu/tests/Makefile.include:940: check-acceptance] E=
rror 9
>>> # cat tests/results/latest/results.tap
>>> 1..8
>>> not ok 1 /root/qemu/tests/acceptance/boot_linux.py:BootLinux.test
>>> # grep -e 'ERROR.*CmdNotFoundError' tests/results/latest/job.log
>>> 2018-11-22 14:51:30,540 stacktrace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 L0047 ERROR|=C2=A0=C2=A0=C2=A0=C2=A0 raise
>>> CmdNotFoundError(cmd, path_paths)
>>> 2018-11-22 14:51:30,540 stacktrace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 L0047 ERROR|
>>> avocado.utils.path.CmdNotFoundError: Command 'qemu-img' could not be
>>> found in any of the PATH dirs: ['/usr/local/bin', '/bin', '/root/bin'=
,
>>> '/sbin', '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin',
>>> '/usr/sbin']
>>> 2018-11-22 14:51:30,572 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0984 ERROR|
>>> avocado.utils.path.CmdNotFoundError: Command 'qemu-img' could not be
>>> found in any of the PATH dirs: ['/usr/local/bin', '/bin', '/root/bin'=
,
>>> '/sbin', '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin',
>>> '/usr/sbin']
>>> 2018-11-22 14:51:30,572 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0999 ERROR| ERROR
>>> 1-/root/qemu/tests/acceptance/boot_linux.py:BootLinux.test ->
>>> CmdNotFoundError: Command 'qemu-img' could not be found in any of the
>>> PATH dirs: ['/usr/local/bin', '/bin', '/root/bin', '/sbin',
>>> '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin', '/usr/sb=
in']
>>> ------
>>>
>>> The same test finished successfully when I ran with 'avocado run (...=
)'
>>> though.
>>>
>>> - Wainer
>>>
>>
>> This is interesting, because:
>>
>>  1) I can't reproduce it
>>  2) I do see '/root/qemu' listed in the PATH, which I assume is the QE=
MU
>> build directory
>>
>> The only thing that comes to my mind is that you may have not built QE=
MU
>> before running `make check-acceptance`, and perhaps, did so before
>> running "avocado run ..." ?
>=20
> I can reproduce Wainer's failure. I didn't test your v3 but I expect
> this problem to persist.
>=20
> If an avocado test requires some external tools, we could check they ar=
e
> available and SKIP the test. But then this reduce the tests covered...
>=20
> Similarly to:
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.html
>=20
> This snippet helps:
> -- >8 --
> @@ -1117,3 +1117,3 @@ check-venv: $(TESTS_VENV_DIR)
>=20
> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)
>         $(call quiet-command, \
> ---
>=20
> Build qemu-img once previous to run any test doesn't seem that bad.
>=20

Oh, now I see your point.  I had the understanding that one should
guarantee that a build had been completed before attempting to run `make
check-acceptance`.  So, I think your patch makes sense at this point.
My hope is that we'll soon be able to leverage the KConfig work and
automatically select tests based on the build environment (when in one).

Now, can you reproduce Wainer's experience when it comes to different
behavior when running "make check-acceptance" versus "avocado run ..."?
 This is what I was most puzzled about.

PS: I've tested your suggestion with `--disable-tools`, but the Makefile
doesn't care about it and builds qemu-img nonetheless.

> What do you think? At least it is a cheap patch ;)
>=20
> Regards,
>=20
> Phil.
>=20

Thanks a lot for the feedback and suggestions!
- Cleber.

>> Anyway, I'll be sending a v3 shortly, and I'll try further to reproduc=
e
>> it.  I'll, of course, appreciate if you try this again! :)
>>
>> Thanks!
>> - Cleber.
>>
