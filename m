Received: from eggs.gnu.org ([209.51.188.92]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gphqS-0004BF-69
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gphqP-0005EM-QH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:03:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gphqP-0005C5-AC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:03:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so8852366wrp.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 15:03:33 -0800 (PST)
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
	<6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
	<f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
	<74cf6f64-254f-1a15-4071-0b73daef02a6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d65eda71-c173-5ca2-1e57-162acaaf223f@redhat.com>
Date: Sat, 2 Feb 2019 00:03:30 +0100
MIME-Version: 1.0
In-Reply-To: <74cf6f64-254f-1a15-4071-0b73daef02a6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2/1/19 11:35 PM, Laszlo Ersek wrote:
> On 01/31/19 19:55, Laszlo Ersek wrote:
>> On 01/31/19 18:07, Philippe Mathieu-Daudé wrote:
>>> On 1/24/19 9:39 PM, Laszlo Ersek wrote:
> 
>>>> +# "build.sh" invokes the "build" utility of edk2 BaseTools. In any given edk2
>>>> +# workspace, at most one "build" instance may be operating at a time. Therefore
>>>> +# we must serialize the rebuilding of targets in this Makefile.
>>>> +.NOTPARALLEL:
>>>
>>> Well this doesn't seem to improve my case :|
>>>
>>> You can test with:
>>>
>>> $ alias make='make -j8 -l7.5'
>>>
>>> So you get:
>>>
>>> $ make print-MAKEFLAGS
>>> MAKEFLAGS=rR -j8 -l7.5 --jobserver-auth=3,4
>>
>> I get something different (with make-3.82-23.el7.x86_64):
>>
>> MAKEFLAGS=Rrl 7.5 - --jobserver-fds=3,4 -j
>>
>> Notably, the argument 8 of "-j" is dropped.
>>
>> Anyway, I think this is a side topic.
>>
>>
>>> and this command fails:
>>>
>>> $ make -C tests/uefi-test-tools Build/bios-tables-test.x86_64.efi
>>
>> (1) How *exactly* does it fail for you?

In my mailbox the mail appears with Message-ID:
cf693646-58c8-8810-58a1-a6e503636d39@redhat.com in response to
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06393.html but
I can't see the mail on the public archives :/

>>
>> (2) What operating system and "make" are you using?
>>
>> Because, the command completes perfectly fine for me. (Just for this
>> test, I rebased the v2 branch on top of current master, i.e. commit
>> aefcd2836620, and re-tested there.)
>>
>> (3) Also, did you update all submodules first? (git submodule update
>> --init --force)
>>
>> (4) IMPORTANT: did you make sure you didn't have an earlier
>> *mis-built* BaseTools directory in the submodule? For that, run "make
>> clean" in the QEMU project root. Note that "git clean -ffdx" will
>> *not* clean submodules, when issued from the QEMU project root.
> 
> I've found the issue myself, through using an up to date Fedora 29 guest
> for the build.
> 
> (a) On RHEL7, I got "make-3.82-23.el7.x86_64". On Fedora 29, it's
> "make-4.2.1-10.fc29.x86_64". Note in particular "4.2", on Fedora.
> 
> (b) In the earlier discussion on help-make
> <http://lists.gnu.org/archive/html/help-make/2019-01/msg00004.html>,
> Paul Smith responded to me,
> 
> On 01/23/19 14:45, Paul Smith wrote:
>> On Wed, 2019-01-23 at 11:24 +0100, Laszlo Ersek wrote:
>>> In particular, "--jobserver-fds" is not documented in end-user
>>> documentation, apparently, so I get a feeling this option could
>>> change at any time, as an implementation detail of distributing jobs.
>>
>> In fact it DID change, in GNU make 4.2, to be --jobserver-auth.  At
>> the same time this new option was published in the documentation and
>> made an official part of the GNU make interface.
> 
> (c) That is, the version bump from RHEL7's make to Fedora29's make
> triggered, in our testing, this change. This explains why
> 
>   make print-MAKEFLAGS
> 
> printed
> 
>   MAKEFLAGS=rR -j8 -l7.5 --jobserver-auth=3,4
> 
> for you, and returned
> 
>   MAKEFLAGS=Rrl 7.5 - --jobserver-fds=3,4 -j
> 
> for me.
> 
> (d) The build *indeed* fails on Fedora29, with the following obscure
> error:
> 
>> make[1]: *** read jobs pipe: Bad file descriptor.  Stop.
>> make[1]: *** Waiting for unfinished jobs....

Yes, this is the problem.

> 
> (e) The documentation that Paul referenced, after I found it, provided
> the critical hint.
> 
> https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html
> 
>> If your tool determines that the --jobserver-auth option is available
>> in MAKEFLAGS but that the file descriptors specified are closed, this
>> means that the calling make process did not think that your tool was a
>> recursive make invocation (e.g., the command line was not prefixed
>> with a + character). [...]

o_O
Cc'ing Paolo and Eric who seems to like that kind of makefile black magic.

> This means that the inner (= edk2's) make process inherits the
> "--jobserver-auth=3,4" option from the outer (= qemu's) make process,
> through the MAKEFLAGS variable. However, it does not inherit the file
> descriptors themselves! And the reason is that the outer make does not
> believe that the recipe that invokes "build.sh" is in fact an (indirect)
> recursive make invocation. Therefore the outer make never bothers
> passing down the file descriptors for the jobserver pipe.

Yes!

> 
> The documentation writes,
> 
>> [...] only command lines that make understands to be recursive
>> invocations of make [...] will have access to the jobserver. When
>> writing makefiles you must be sure to mark the command as recursive
>> (most commonly by prefixing the command line with the + indicator
>> [...]
> 
> (Also:
> 
>> Using the MAKE variable has the same effect as using a '+' character
>> at the beginning of the recipe line.
> 
> This is why an explicit "+" is needed only infrequently; most recursive
> invocations are performed via $(MAKE), and the outer make recognizes
> that automatically).
> 
> (f) So, the solution is to prefix the "./build.sh" recipe with a "+"
> sign, to mark it as "recursive":
> 
>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
>> index 61d263861e..449b81d8ba 100644
>> --- a/tests/uefi-test-tools/Makefile
>> +++ b/tests/uefi-test-tools/Makefile
>> @@ -87,7 +87,7 @@ Build/%.fat: Build/%.efi
>>  .NOTPARALLEL:
>>
>>  Build/bios-tables-test.%.efi: build-edk2-tools
>> -	./build.sh $(edk2_dir) BiosTablesTest $* $@
>> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@

Yes :) This fixed it!

>>
>>  build-edk2-tools:
>>  	$(MAKE) -C $(edk2_dir)/BaseTools
> 
> This fixes the issue for me on Fedora 29, without breaking the behavior
> on RHEL7.

Excellent! I triggered Travis builds (Ubuntu/Debian).

> 
> I'll submit v3 later. Thank you for catching this error.

Now that we are happy, maybe Michael can do this change when applying,
but I guess you'd prefer first to write a line about this '+' in the
commit message or the Makefile.

With the +:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks a lot for figuring this out alone and fixing it!

Phil.
