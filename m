Received: from eggs.gnu.org ([209.51.188.92]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grWJ6-0007o4-RA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grW6m-00011m-47
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 17:55:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grW6k-0000xz-7S
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 17:55:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so4672288wmc.5
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 14:55:48 -0800 (PST)
References: <20181121214818.22874-1-crosa@redhat.com>
	<20181121214818.22874-2-crosa@redhat.com>
	<d67d31c9-06fe-1f06-66e0-bc6678212ccd@redhat.com>
	<9383c42d-b20f-9337-7d95-7fb57659513e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6925a91-24d9-c0b5-3942-e59bfda58e3a@redhat.com>
Date: Wed, 6 Feb 2019 23:55:45 +0100
MIME-Version: 1.0
In-Reply-To: <9383c42d-b20f-9337-7d95-7fb57659513e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Cleber Rosa <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Cleber,

On 2/6/19 8:30 PM, Cleber Rosa wrote:
> On 11/22/18 3:15 PM, Wainer dos Santos Moschetta wrote:
>>
>> On 11/21/2018 07:48 PM, Cleber Rosa wrote:
>>> So that when binaries such as qemu-img are searched for, those in the
>>> build tree will be favored.  As a clarification, SRC_ROOT_DIR is
>>> dependent on the location from where tests are executed, so they are
>>> equal to the build directory if one is being used.
>>
>> On avocado's job.log file I can see the full path of the qemu-img which
>> was called, but I wonder if it wouldn't be better to log that
>> information somewhere more explicitly. It wouldn't prevent this patch
>> from being merged though, it's just an improvement suggestion.
>>
>>>
>>> The original motivation is that Avocado libraries such as
>>> avocado.utils.vmimage.get() may use the matching binaries, but it may
>>> also apply to any other binary that test code may eventually attempt
>>> to execute.
>>>
>>> Other competing alternatives would be a more explicit path or binary
>>> registration mechanism, in which we tell the libraries such as
>>> avocado.utils.vmimage, the binaries to use in advance.  I think the
>>> model proposed here is simpler though, and is not inconsistent with
>>> the general approach of favoring the built binaries, and falling back
>>> to binaries available in the system.  I'd love to have comments on
>>> that, though.
>>
>> IMHO it makes sense to pick the built binaries, falling back to system's
>> otherwise. Keep it simple (and consistent) unless we eventually need
>> something robust, I would go for that approach here.
>>
> 
> Agreed.
> 
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py
>>> b/tests/acceptance/avocado_qemu/__init__.py
>>> index 1e54fd5932..3d5190cbab 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -49,6 +49,15 @@ class Test(avocado.Test):
>>>               self.cancel("No QEMU binary defined or found in the
>>> source tree")
>>>           self.vm = QEMUMachine(self.qemu_bin)
>>>   +        # RFC: avocado.utils.vmimage.get() uses qemu-img, from the
>>> +        # system's PATH, to create a snapshot.  This is a transparent,
>>> +        # but implicit way of making sure it finds the qemu-img that
>>> +        # matches the code being tested (as tests it indirectly too).
>>> +        # As for the cleanup, given that in the Avocado test execution
>>> +        # model every test is started in a different process, no
>>> +        # cleanup is needed.
>>> +        os.environ['PATH'] = '%s:%s' % (SRC_ROOT_DIR,
>>> os.environ['PATH'])
>>> +
>>>       def tearDown(self):
>>>           if self.vm is not None:
>>>               self.vm.shutdown()
>>
>> The boot Linux test (added on patch 02) exits with error when I ran
>> 'make check-acceptance'. I am using Fedora 29 x86_64 which don't have
>> qemu-img installed system-wide. See below:
>>
>> ------
>> # make check-acceptance
>>   AVOCADO tests/acceptance
>> make: *** [/root/qemu/tests/Makefile.include:940: check-acceptance] Error 9
>> # cat tests/results/latest/results.tap
>> 1..8
>> not ok 1 /root/qemu/tests/acceptance/boot_linux.py:BootLinux.test
>> # grep -e 'ERROR.*CmdNotFoundError' tests/results/latest/job.log
>> 2018-11-22 14:51:30,540 stacktrace       L0047 ERROR|     raise
>> CmdNotFoundError(cmd, path_paths)
>> 2018-11-22 14:51:30,540 stacktrace       L0047 ERROR|
>> avocado.utils.path.CmdNotFoundError: Command 'qemu-img' could not be
>> found in any of the PATH dirs: ['/usr/local/bin', '/bin', '/root/bin',
>> '/sbin', '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin',
>> '/usr/sbin']
>> 2018-11-22 14:51:30,572 test             L0984 ERROR|
>> avocado.utils.path.CmdNotFoundError: Command 'qemu-img' could not be
>> found in any of the PATH dirs: ['/usr/local/bin', '/bin', '/root/bin',
>> '/sbin', '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin',
>> '/usr/sbin']
>> 2018-11-22 14:51:30,572 test             L0999 ERROR| ERROR
>> 1-/root/qemu/tests/acceptance/boot_linux.py:BootLinux.test ->
>> CmdNotFoundError: Command 'qemu-img' could not be found in any of the
>> PATH dirs: ['/usr/local/bin', '/bin', '/root/bin', '/sbin',
>> '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin', '/usr/sbin']
>> ------
>>
>> The same test finished successfully when I ran with 'avocado run (...)'
>> though.
>>
>> - Wainer
>>
> 
> This is interesting, because:
> 
>  1) I can't reproduce it
>  2) I do see '/root/qemu' listed in the PATH, which I assume is the QEMU
> build directory
> 
> The only thing that comes to my mind is that you may have not built QEMU
> before running `make check-acceptance`, and perhaps, did so before
> running "avocado run ..." ?

I can reproduce Wainer's failure. I didn't test your v3 but I expect
this problem to persist.

If an avocado test requires some external tools, we could check they are
available and SKIP the test. But then this reduce the tests covered...

Similarly to:
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.html

This snippet helps:
-- >8 --
@@ -1117,3 +1117,3 @@ check-venv: $(TESTS_VENV_DIR)

-check-acceptance: check-venv $(TESTS_RESULTS_DIR)
+check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)
        $(call quiet-command, \
---

Build qemu-img once previous to run any test doesn't seem that bad.

What do you think? At least it is a cheap patch ;)

Regards,

Phil.

> Anyway, I'll be sending a v3 shortly, and I'll try further to reproduce
> it.  I'll, of course, appreciate if you try this again! :)
> 
> Thanks!
> - Cleber.
> 
