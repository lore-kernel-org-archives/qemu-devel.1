Received: from eggs.gnu.org ([209.51.188.92]:54763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gsEtE-0001VV-0b
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gsEtC-00083D-Rt
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:44:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gsEtC-00082X-Lb
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:44:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so5893723wmt.0
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 14:44:54 -0800 (PST)
References: <20190205001835.25660-1-philmd@redhat.com>
	<20190205001835.25660-2-philmd@redhat.com>
	<99509706-b027-bf45-b17b-e9f66943f86c@redhat.com>
	<adf3d864-936d-d53d-ce26-1a5c75e88264@redhat.com>
	<cfeec01c-0397-f7e9-2abc-1339a6847945@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cfe8169-540f-59b1-d64b-7b753de0a3b6@redhat.com>
Date: Fri, 8 Feb 2019 23:44:51 +0100
MIME-Version: 1.0
In-Reply-To: <cfeec01c-0397-f7e9-2abc-1339a6847945@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] ahci-test: Add dependency to
 qemu-img tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On 2/8/19 11:34 PM, John Snow wrote:
> On 2/7/19 1:51 PM, Thomas Huth wrote:
>> On 2019-02-07 17:50, Philippe Mathieu-Daudé wrote:
>>> On 2/5/19 1:18 AM, Philippe Mathieu-Daudé wrote:
>>>> Since the ahci-test uses qemu-img, add a dependency to build it
>>>> before using it.
>>>> This fixes:
>>>>
>>>>   $ gmake check-qtest V=1
>>>>   QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/ahci-test
>>>>   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No such file or directory)
>>>>   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)
>>>>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> Slighly related is when vm-tests expect qemu-img available:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html
>>>>
>>>>   $ make vm-build-ubuntu.i386
>>>>   Traceback (most recent call last):
>>>>     File "source/qemu/tests/vm/basevm.py", line 236, in main
>>>>       return vm.build_image(args.image)
>>>>     File "tests/vm/ubuntu.i386", line 67, in build_image
>>>>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>>>>   OSError: [Errno 2] No such file or directory
>>>>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386.img' failed
>>>>   make: *** [tests/vm/ubuntu.i386.img] Error 2
>>>>
>>>> A better fix would be checking those tools via ./configure...
>>>> ---
>>>>  tests/Makefile.include | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index 75ad9c0dd3..679656b64a 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -708,7 +708,7 @@ tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
>>>>  tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
>>>>  tests/fdc-test$(EXESUF): tests/fdc-test.o
>>>>  tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
>>>> -tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
>>>> +tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
>>>
>>> In [*] Cleber noticed if we configure using --disable-tools, qemu-img is
>>> still built by when running "make check-block" due to this rule.
>>>
>>> I think this is OK because
>>> - at least a test requires it, so this test will run (which is what
>>>   we want)
>>> - while the tool is available in the build directory, it still won't
>>>   be installed by "make install"
>>
>> I guess you could also introduce a CONFIG_TOOLS switch and only run the
>> ahci test for CONFIG_TOOLS=y ? ... not that important, but in case you
>> respin the series, maybe worth a try.
>>
>>  Thomas
>>
> 
> Is this necessary?
> 
> You can run ahci-test by itself without building tools, but you need to
> export QTEST_QEMU_IMG yourself, which you can absolutely point to some
> other copy you have.
> 
> If you run "make check" though, it's going to use the built copy of
> qemu-img no matter what, isn't it? so what's so great about preserving a
> configuration where you ask it not to build tools and then intentionally
> try to execute tests that will necessarily fail because they can't find
> the qemu-img binary?
> 
> This seems fine the way it is, because you are asking the computer:
> 
> 1. Not to build tools, please
> 2. Actually, please make the tools so I can run the tests

I understand it the same way (although not being a computer).

I wanted to check if what Cleber noticed could bother someone else, but
I think the current behavior is the correct one.
Also I wouldn't worry much about this corner case, the combination of
having someone:
 - willing to run iotests
   AND
   (
      - doesn't have qemu-img distrib-installed
      OR
      - ran configure with --disable-tools
   )
is *very* unlikely, as only 2 person reported this and both encountered
this while working on QEMU testing.

> Convince me otherwise?
> --js
> 
