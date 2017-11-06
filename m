Received: from eggs.gnu.org ([2001:4830:134:3::10]:50656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eBj7z-0001lp-2P
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eBj7u-0002SX-GL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:15:55 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:57122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eBj7u-0002SH-AL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:15:50 -0500
Received: by mail-vk0-f52.google.com with SMTP id g11so5923480vkd.13
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 07:15:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
	<CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 6 Nov 2017 16:15:47 +0100
Message-ID: <CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
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

On Mon, Oct 23, 2017 at 10:31 AM, Ladi Prosek <lprosek@redhat.com> wrote:
> On Tue, Oct 17, 2017 at 3:08 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
>> An update of:
>>
>>         v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg=
07092.html
>>
>> We made the debugger module WinDbg (like GDB) for QEMU. This is the repl=
acement of the remote stub in Windows kernel. Used for remote Windows kerne=
l debugging without debugging mode.
>>
>> WinDbg is a multipurpose debugger for the Microsoft Windows computer ope=
rating system, distributed by Microsoft. Recent versions of WinDbg have bee=
n and are being distributed as part of the free Debugging Tools for Windows=
 suite.
>>
>> How to start debugging QEMU using WinDbg:
>>   Run QEMU with next option:
>>     -windbg pipe:<name>
>>   QEMU will start and pause for waiting WinDbg connection.
>>   Run WinDbg with next options:
>>     -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\<name>,resets=3D0
>>   Wait for debugger connect to kernel.
>>
>> Note: You can add Symbol Search Path in WinDbg such as srv*c:\tmp*http:/=
/msdl.microsoft.com/download/symbols.
>>
>> How it works:
>> The WinDbg debugger has the possibility of connecting to a remote debug =
service (Kdsrv.exe) in the Windows kernel. Therefore, it is possible to con=
nect to the guest system running in the QEMU emulator. Kernel debugging is =
possible only with the enabled debugging mode, may change at the same time.=
 Our module of WinDbg debugger for QEMU is an alternative of the remote deb=
ugging service in the kernel. Thus, the debugger connects to the debugging =
module, not to the kernel of the operating system. The module obtains all t=
he necessary information answering debugger requests from the QEMU emulator=
. At the same time for debugging there is no need to enable debugging mode =
in the kernel. This leads to hidden debugging. Our module supports all feat=
ures of WinDbg regarding remote debugging, besides interception of events a=
nd exceptions. Only i386 is supported now.
>>
>> Changed in v2:
>>
>>  - Move target specific code in the 'target/' directory. (Alistair Franc=
is)
>>  - Change 'kd_api_fill_memory'. Made a fill of memory by line segments. =
Before that, a full array was immediately collected and written in RAM. (La=
di Prosek)
>>  - Change 'kd_api_search_memory'. Made a search for memory by line segme=
nts. (Ladi Prosek)
>>  - Change ld* to st* where it needs. (Ladi Prosek)
>>  - Add a additional check of input arguments in 'windbg_read_context' an=
d 'windbg_read_ks_regs'. (Ladi Prosek)
>>  - Fix typos. (Ladi Prosek)
>>  - Add a fliping back 'windbg_state->is_loaded' after reset VM.
>>  - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
>>  - Add a check to device in windbg option. Only pipe is supporting now. =
(Alistair Francis)
>>  - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair Fr=
ancis)
>>  - Replace printf to qemu_log. (Alistair Francis)
>>  - Fix build on s390x host. (patchew)
>>  - Fix code style error. (patchew)
>
> Thank you, I am planning to take a closer look and test the changes in
> a week or two.
>
> Still wondering if it is limited to Windows hosts or if it can be used
> on Linux as well, preferably with KVM.

I haven't been able to make this work.

I've built a 32-bit QEMU for Windows with these patches and used the
command line parameters given above:

  qemu-system-i386.exe run with -windbg pipe:win7_dbg
  windbg -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\win7_dbg,resets=3D0

The guest is a fresh install of Win7 32-bit.

FS base passes all the checks in windbg_on_load() as the guest kernel
loads and it returns true. QEMU then sends some data over the pipe.
Windbg doesn't print anything, it's still showing:

  Opened \\.\pipe\win7_dbg
  Waiting to reconnect...

Is this expected? In regular remote kernel debugging, windbg produces
a bunch of output about the target state when it attaches.

The only thing I can reasonably do at this point is Ctrl+Break. This
results in some data exchange between QEMU and windbg but nothing
really changes -- windbg still says "Waiting to reconnect...". Hitting
Ctrl+Break for the second time kills windbg. I tried running windbg
under windbg and was able to capture this output:

  Debug target initialization failed, 0x8000FFFF

Once I managed to make windbg actually attach (i.e. it generated the
target state output) but the QEMU process died shortly after that. I
don't know why because I haven't been able to reproduce it.

So, what am I doing wrong? Can you post your detailed steps please?

I'm pasting a dump of the pipe traffic as captured with IO Ninja. "<"
is windbg to QEMU, ">" is QEMU to windbg. QEMU initialized the stub at
14:57:48, the first Ctrl+Break was issued at 15:00:32 and the second
one at 15:01:10.

14:56:44   File #1: Client file opened: \win7_dbg
14:56:49 < 0000  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:56:53 < 0010  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:56:56 < 0020  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:00 < 0030  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:03 < 0040  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:07 < 0050  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:11 < 0060  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:14 < 0070  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:18 < 0080  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:22 < 0090  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:26 < 00a0  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:29 < 00b0  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:33 < 00c0  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:37 < 00d0  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:40 < 00e0  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:44 < 00f0  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:48 < 0100  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00
14:57:48 < 0110  69 69 69 69 06 00 00 00 00 00 00 00 00 00 00 00

14:57:48 > 0000  30 30 30 30 07 00 f0 00 00 00 80 80 a9 0f 00 00
14:57:48 > 0010  31 30 00 00 00 00 00 00 01 00 00 00 00 00 00 00
14:57:48 > 0020  80 03 75 82 00 00 00 00 6c 2e 88 82 00 00 00 00
14:57:48 > 0030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 0040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 0060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 0070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 0080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 00a0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 00b0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 00c0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:57:48 > 00d0  f0 0f ff ff 00 04 00 00 10 00 03 00 c3 90 90 90
14:57:48 > 00e0  90 90 8b ff 53 56 8b f0 57 8d 46 08 08 00 23 00
14:57:48 > 00f0  23 00 30 00 02 02 20 00 00 00 00 00 00 00 00 00
14:57:48 > 0100  aa 69 69 69 69 06 00 00 00 9b 35 18 00 00 00 00
         > 0110  00

15:00:32 < 0000  62

15:00:34 > 0000  30 30 30 30 07 00 f4 00 01 00 80 80 6d 10 00 00
         > 0010  30 30 00 00 00 00 00 00 01 00 00 00 00 00 00 00
         > 0020  98 c7 69 85 00 00 00 00 56 68 11 8c 00 00 00 00
         > 0030  03 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
         > 0040  56 68 11 8c 00 00 00 00 00 00 00 00 00 00 00 00
         > 0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00a0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00b0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00c0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00d0  f0 0f ff ff 00 04 00 00 10 00 03 00 22 45 0c 3a
         > 00e0  45 10 74 38 ff d3 2b 7d f8 1b 75 fc 08 00 23 00
         > 00f0  23 00 30 00 46 02 00 00 00 00 00 00 00 00 00 00
15:00:34 > 0100  00 00 00 00 aa

15:01:10 < 0000  69 69 69 69 04 00 00 00 01 00 80 80 00 00 00 00
         < 0010  62

15:01:10 > 0000  30 30 30 30 07 00 f4 00 00 00 80 80 6d 10 00 00
         > 0010  30 30 00 00 00 00 00 00 01 00 00 00 00 00 00 00
         > 0020  98 c7 69 85 00 00 00 00 56 68 11 8c 00 00 00 00
         > 0030  03 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
         > 0040  56 68 11 8c 00 00 00 00 00 00 00 00 00 00 00 00
         > 0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00a0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00b0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00c0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         > 00d0  f0 0f ff ff 00 04 00 00 10 00 03 00 22 45 0c 3a
         > 00e0  45 10 74 38 ff d3 2b 7d f8 1b 75 fc 08 00 23 00
         > 00f0  23 00 30 00 46 02 00 00 00 00 00 00 00 00 00 00
15:01:10 > 0100  00 00 00 00 aa

15:01:10 < 0000  69 69 69 69 04 00 00 00 00 00 80 80 00 00 00 00
15:01:10 < 0010  30 30 30 30 02 00 38 00 00 00 80 80 62 10 00 00
         < 0020  46 31 00 00 b1 00 c7 6a 03 01 00 00 a8 fa d9 08
         < 0030  00 00 00 00 01 fb d9 08 7f 43 c9 6a 78 26 ba 6a
         < 0040  07 00 00 00 01 00 00 00 18 14 f0 04 68 cd b6 6a
15:01:10 < 0050  98 44 c9 6a 0c 1e 38 00 aa

15:01:10 > 0000  69 69 69 69 04 00 00 00 00 00 80 80 00 00 00 00
15:01:10 > 0010  30 30 30 30 02 00 38 00 01 00 80 80 39 18 00 00
         > 0020  46 31 00 00 b1 00 c7 6a 00 00 00 00 a8 fa d9 08
         > 0030  0f 00 b1 1d 06 00 03 00 4c 01 0c 03 2f 00 00 00
         > 0040  00 b0 61 82 ff ff ff ff 50 58 76 82 ff ff ff ff
15:01:10 > 0050  ec bf 98 82 ff ff ff ff aa

15:01:10 < 0000  69 69 69 69 04 00 00 00 01 00 80 80 00 00 00 00
15:01:10 < 0010  30 30 30 30 02 00 38 00 01 00 80 80 c2 10 00 00
         < 0020  30 31 00 00 20 00 00 00 d8 01 93 04 00 00 93 04
         < 0030  ec bf 98 82 ff ff ff ff 04 00 00 00 7a 3d d0 1c
         < 0040  08 fa d9 08 40 dd 10 77 38 00 00 00 00 00 00 00
15:01:10 < 0050  90 5c 7f 70 38 00 00 00 aa

15:01:10 > 0000  69 69 69 69 04 00 00 00 01 00 80 80 00 00 00 00
15:01:10 > 0010  30 30 30 30 02 00 38 00 00 00 80 80 70 0e 00 00
         > 0020  30 31 00 00 20 00 00 00 01 00 00 c0 00 00 93 04
         > 0030  ec bf 98 82 ff ff ff ff 04 00 00 00 00 00 00 00
         > 0040  08 fa d9 08 40 dd 10 77 38 00 00 00 00 00 00 00
15:01:10 > 0050  90 5c 7f 70 38 00 00 00 aa

15:01:10 < 0000  69 69 69 69 04 00 00 00 00 00 80 80 00 00 00 00
15:01:11   File closed
