Received: from eggs.gnu.org ([2001:4830:134:3::10]:34405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eCQdd-0001zE-8j
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eCQda-0005mt-4A
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:43:29 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:53671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eCQdZ-0005ku-Uo
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:43:26 -0500
Received: by mail-ua0-f171.google.com with SMTP id s41so1901417uab.10
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 05:43:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1b94bfaac633fc76c8633bbcec9ff4a9@ispras.ru>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
	<CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
	<CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
	<1b94bfaac633fc76c8633bbcec9ff4a9@ispras.ru>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 8 Nov 2017 14:43:23 +0100
Message-ID: <CABdb735OHqGVf_0D=zDy9D4HzG4s+w8OjUX5MG2pWrqOrQc=pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Wed, Nov 8, 2017 at 12:54 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-06 18:15:
>
>> On Mon, Oct 23, 2017 at 10:31 AM, Ladi Prosek <lprosek@redhat.com> wrote=
:
>>>
>>> On Tue, Oct 17, 2017 at 3:08 PM, Mihail Abakumov
>>> <mikhail.abakumov@ispras.ru> wrote:
>>>>
>>>> An update of:
>>>>
>>>>         v1:
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07092.html
>>>>
>>>> We made the debugger module WinDbg (like GDB) for QEMU. This is the
>>>> replacement of the remote stub in Windows kernel. Used for remote Wind=
ows
>>>> kernel debugging without debugging mode.
>>>>
>>>> WinDbg is a multipurpose debugger for the Microsoft Windows computer
>>>> operating system, distributed by Microsoft. Recent versions of WinDbg =
have
>>>> been and are being distributed as part of the free Debugging Tools for
>>>> Windows suite.
>>>>
>>>> How to start debugging QEMU using WinDbg:
>>>>   Run QEMU with next option:
>>>>     -windbg pipe:<name>
>>>>   QEMU will start and pause for waiting WinDbg connection.
>>>>   Run WinDbg with next options:
>>>>     -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\<name>,resets=3D0
>>>>   Wait for debugger connect to kernel.
>>>>
>>>> Note: You can add Symbol Search Path in WinDbg such as
>>>> srv*c:\tmp*http://msdl.microsoft.com/download/symbols.
>>>>
>>>> How it works:
>>>> The WinDbg debugger has the possibility of connecting to a remote debu=
g
>>>> service (Kdsrv.exe) in the Windows kernel. Therefore, it is possible t=
o
>>>> connect to the guest system running in the QEMU emulator. Kernel debug=
ging
>>>> is possible only with the enabled debugging mode, may change at the sa=
me
>>>> time. Our module of WinDbg debugger for QEMU is an alternative of the =
remote
>>>> debugging service in the kernel. Thus, the debugger connects to the
>>>> debugging module, not to the kernel of the operating system. The modul=
e
>>>> obtains all the necessary information answering debugger requests from=
 the
>>>> QEMU emulator. At the same time for debugging there is no need to enab=
le
>>>> debugging mode in the kernel. This leads to hidden debugging. Our modu=
le
>>>> supports all features of WinDbg regarding remote debugging, besides
>>>> interception of events and exceptions. Only i386 is supported now.
>>>>
>>>> Changed in v2:
>>>>
>>>>  - Move target specific code in the 'target/' directory. (Alistair
>>>> Francis)
>>>>  - Change 'kd_api_fill_memory'. Made a fill of memory by line segments=
.
>>>> Before that, a full array was immediately collected and written in RAM=
.
>>>> (Ladi Prosek)
>>>>  - Change 'kd_api_search_memory'. Made a search for memory by line
>>>> segments. (Ladi Prosek)
>>>>  - Change ld* to st* where it needs. (Ladi Prosek)
>>>>  - Add a additional check of input arguments in 'windbg_read_context'
>>>> and 'windbg_read_ks_regs'. (Ladi Prosek)
>>>>  - Fix typos. (Ladi Prosek)
>>>>  - Add a fliping back 'windbg_state->is_loaded' after reset VM.
>>>>  - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
>>>>  - Add a check to device in windbg option. Only pipe is supporting now=
.
>>>> (Alistair Francis)
>>>>  - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair
>>>> Francis)
>>>>  - Replace printf to qemu_log. (Alistair Francis)
>>>>  - Fix build on s390x host. (patchew)
>>>>  - Fix code style error. (patchew)
>>>
>>>
>>> Thank you, I am planning to take a closer look and test the changes in
>>> a week or two.
>>>
>>> Still wondering if it is limited to Windows hosts or if it can be used
>>> on Linux as well, preferably with KVM.
>>
>>
>> I haven't been able to make this work.
>>
>> I've built a 32-bit QEMU for Windows with these patches and used the
>> command line parameters given above:
>>
>>   qemu-system-i386.exe run with -windbg pipe:win7_dbg
>>   windbg -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\win7_dbg,resets=3D=
0
>>
>> The guest is a fresh install of Win7 32-bit.
>>
>> FS base passes all the checks in windbg_on_load() as the guest kernel
>> loads and it returns true. QEMU then sends some data over the pipe.
>> Windbg doesn't print anything, it's still showing:
>>
>>   Opened \\.\pipe\win7_dbg
>>   Waiting to reconnect...
>>
>> Is this expected? In regular remote kernel debugging, windbg produces
>> a bunch of output about the target state when it attaches.
>>
>> The only thing I can reasonably do at this point is Ctrl+Break. This
>> results in some data exchange between QEMU and windbg but nothing
>> really changes -- windbg still says "Waiting to reconnect...". Hitting
>> Ctrl+Break for the second time kills windbg. I tried running windbg
>> under windbg and was able to capture this output:
>>
>>   Debug target initialization failed, 0x8000FFFF
>>
>> Once I managed to make windbg actually attach (i.e. it generated the
>> target state output) but the QEMU process died shortly after that. I
>> don't know why because I haven't been able to reproduce it.
>>
>> So, what am I doing wrong? Can you post your detailed steps please?
>>
>> I'm pasting a dump of the pipe traffic as captured with IO Ninja. "<"
>> is windbg to QEMU, ">" is QEMU to windbg. QEMU initialized the stub at
>> 14:57:48, the first Ctrl+Break was issued at 15:00:32 and the second
>> one at 15:01:10.
>>
>
> This is very strange.
> After reading the desired addresses (windbg_on_load()), the interaction
> between the stub and windbg begins. A lot of packets are being sent.
> This happens about 10 seconds. All this time "Waiting to reconnect ..."
> Then the windbg connects.
> In your case windbg does not send packets, more specifically, does not
> continue to do it. What is your version of windbg. Also, windbg stub has
> been supported only for windbg x64, yet.

Ah, so that's a pretty important piece of information and not very
intuitive given the "Only i386 is supported now." sentence in the
cover email.

Microsoft (R) Windows Debugger Version 10.0.15063.468 X86
Microsoft (R) Windows Debugger Version 10.0.15063.468 AMD64
Microsoft (R) Windows Debugger Version 10.0.16299.15 X86
Microsoft (R) Windows Debugger Version 10.0.16299.15 AMD64

are the versions I have tried. I don't see any difference between x86
and amd64, all versions never connect and crash after the second
break.

What guest OS are you running? Can you maybe zip up your QEMU binaries
and share them with me?

Thanks,
Ladi
