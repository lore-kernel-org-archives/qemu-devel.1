Received: from eggs.gnu.org ([2001:4830:134:3::10]:39778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eCOwH-0000TD-0h
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eCOwD-0005me-13
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:54:37 -0500
Received: from mail.ispras.ru ([83.149.199.45]:36334)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eCOwC-0005lp-JP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:54:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 08 Nov 2017 14:54:30 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
	<CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
	<CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
Message-ID: <1b94bfaac633fc76c8633bbcec9ff4a9@ispras.ru>
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
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-06 18:15:
> On Mon, Oct 23, 2017 at 10:31 AM, Ladi Prosek <lprosek@redhat.com>=20
> wrote:
>> On Tue, Oct 17, 2017 at 3:08 PM, Mihail Abakumov
>> <mikhail.abakumov@ispras.ru> wrote:
>>> An update of:
>>>=20
>>>         v1:=20
>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07092.htm=
l
>>>=20
>>> We made the debugger module WinDbg (like GDB) for QEMU. This is the=20
>>> replacement of the remote stub in Windows kernel. Used for remote=20
>>> Windows kernel debugging without debugging mode.
>>>=20
>>> WinDbg is a multipurpose debugger for the Microsoft Windows computer=20
>>> operating system, distributed by Microsoft. Recent versions of WinDbg=
=20
>>> have been and are being distributed as part of the free Debugging=20
>>> Tools for Windows suite.
>>>=20
>>> How to start debugging QEMU using WinDbg:
>>>   Run QEMU with next option:
>>>     -windbg pipe:<name>
>>>   QEMU will start and pause for waiting WinDbg connection.
>>>   Run WinDbg with next options:
>>>     -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\<name>,resets=3D0
>>>   Wait for debugger connect to kernel.
>>>=20
>>> Note: You can add Symbol Search Path in WinDbg such as=20
>>> srv*c:\tmp*http://msdl.microsoft.com/download/symbols.
>>>=20
>>> How it works:
>>> The WinDbg debugger has the possibility of connecting to a remote=20
>>> debug service (Kdsrv.exe) in the Windows kernel. Therefore, it is=20
>>> possible to connect to the guest system running in the QEMU emulator.=
=20
>>> Kernel debugging is possible only with the enabled debugging mode,=20
>>> may change at the same time. Our module of WinDbg debugger for QEMU=20
>>> is an alternative of the remote debugging service in the kernel.=20
>>> Thus, the debugger connects to the debugging module, not to the=20
>>> kernel of the operating system. The module obtains all the necessary=20
>>> information answering debugger requests from the QEMU emulator. At=20
>>> the same time for debugging there is no need to enable debugging mode=
=20
>>> in the kernel. This leads to hidden debugging. Our module supports=20
>>> all features of WinDbg regarding remote debugging, besides=20
>>> interception of events and exceptions. Only i386 is supported now.
>>>=20
>>> Changed in v2:
>>>=20
>>>  - Move target specific code in the 'target/' directory. (Alistair=20
>>> Francis)
>>>  - Change 'kd_api_fill_memory'. Made a fill of memory by line=20
>>> segments. Before that, a full array was immediately collected and=20
>>> written in RAM. (Ladi Prosek)
>>>  - Change 'kd_api_search_memory'. Made a search for memory by line=20
>>> segments. (Ladi Prosek)
>>>  - Change ld* to st* where it needs. (Ladi Prosek)
>>>  - Add a additional check of input arguments in 'windbg_read_context'=
=20
>>> and 'windbg_read_ks_regs'. (Ladi Prosek)
>>>  - Fix typos. (Ladi Prosek)
>>>  - Add a fliping back 'windbg_state->is_loaded' after reset VM.
>>>  - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
>>>  - Add a check to device in windbg option. Only pipe is supporting=20
>>> now. (Alistair Francis)
>>>  - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair=
=20
>>> Francis)
>>>  - Replace printf to qemu_log. (Alistair Francis)
>>>  - Fix build on s390x host. (patchew)
>>>  - Fix code style error. (patchew)
>>=20
>> Thank you, I am planning to take a closer look and test the changes in
>> a week or two.
>>=20
>> Still wondering if it is limited to Windows hosts or if it can be used
>> on Linux as well, preferably with KVM.
>=20
> I haven't been able to make this work.
>=20
> I've built a 32-bit QEMU for Windows with these patches and used the
> command line parameters given above:
>=20
>   qemu-system-i386.exe run with -windbg pipe:win7_dbg
>   windbg -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\win7_dbg,resets=3D=
0
>=20
> The guest is a fresh install of Win7 32-bit.
>=20
> FS base passes all the checks in windbg_on_load() as the guest kernel
> loads and it returns true. QEMU then sends some data over the pipe.
> Windbg doesn't print anything, it's still showing:
>=20
>   Opened \\.\pipe\win7_dbg
>   Waiting to reconnect...
>=20
> Is this expected? In regular remote kernel debugging, windbg produces
> a bunch of output about the target state when it attaches.
>=20
> The only thing I can reasonably do at this point is Ctrl+Break. This
> results in some data exchange between QEMU and windbg but nothing
> really changes -- windbg still says "Waiting to reconnect...". Hitting
> Ctrl+Break for the second time kills windbg. I tried running windbg
> under windbg and was able to capture this output:
>=20
>   Debug target initialization failed, 0x8000FFFF
>=20
> Once I managed to make windbg actually attach (i.e. it generated the
> target state output) but the QEMU process died shortly after that. I
> don't know why because I haven't been able to reproduce it.
>=20
> So, what am I doing wrong? Can you post your detailed steps please?
>=20
> I'm pasting a dump of the pipe traffic as captured with IO Ninja. "<"
> is windbg to QEMU, ">" is QEMU to windbg. QEMU initialized the stub at
> 14:57:48, the first Ctrl+Break was issued at 15:00:32 and the second
> one at 15:01:10.
>=20

This is very strange.
After reading the desired addresses (windbg_on_load()), the interaction
between the stub and windbg begins. A lot of packets are being sent.
This happens about 10 seconds. All this time "Waiting to reconnect ..."
Then the windbg connects.
In your case windbg does not send packets, more specifically, does not
continue to do it. What is your version of windbg. Also, windbg stub has
been supported only for windbg x64, yet.
