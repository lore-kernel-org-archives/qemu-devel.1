Received: from eggs.gnu.org ([2001:4830:134:3::10]:48449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJxeb-0002W4-W1
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJxeX-00072Y-GD
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:23:37 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:45364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJxeX-00070w-B1
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:23:33 -0500
Received: by mail-ua0-f180.google.com with SMTP id h2so2820388uae.12
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 00:23:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151128141659.525.3916037556813470751@bafd83ae6430>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151128141659.525.3916037556813470751@bafd83ae6430>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 29 Nov 2017 09:23:31 +0100
Message-ID: <CABdb736ZwzjKDTZsKYqRtiqCVzKG8qEQKOubv6=oNDCwCDUe_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/45] Windbg supporting
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

On Tue, Nov 21, 2017 at 3:07 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> An update of:
>
>         v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg0=
7092.html
>
> We made the debugger module WinDbg (like GDB) for QEMU. This is the repla=
cement of the remote stub in Windows kernel. Used for remote Windows kernel=
 debugging without debugging mode.
>
> WinDbg is a multipurpose debugger for the Microsoft Windows computer oper=
ating system, distributed by Microsoft. Recent versions of WinDbg have been=
 and are being distributed as part of the free Debugging Tools for Windows =
suite.
>
> How to start debugging QEMU using WinDbg:
>   Run QEMU with next option:
>     -windbg pipe:<name>
>   QEMU will start and pause for waiting WinDbg connection.
>   Run WinDbg with next options:
>     -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\<name>,resets=3D0
>   Wait for debugger connect to kernel.
>
> Note: You can add Symbol Search Path in WinDbg such as srv*c:\tmp*http://=
msdl.microsoft.com/download/symbols.
>
> How it works:
> The WinDbg debugger has the possibility of connecting to a remote debug s=
ervice (Kdsrv.exe) in the Windows kernel. Therefore, it is possible to conn=
ect to the guest system running in the QEMU emulator. Kernel debugging is p=
ossible only with the enabled debugging mode, may change at the same time. =
Our module of WinDbg debugger for QEMU is an alternative of the remote debu=
gging service in the kernel. Thus, the debugger connects to the debugging m=
odule, not to the kernel of the operating system. The module obtains all th=
e necessary information answering debugger requests from the QEMU emulator.=
 At the same time for debugging there is no need to enable debugging mode i=
n the kernel. This leads to hidden debugging. Our module supports all featu=
res of WinDbg regarding remote debugging, besides interception of events an=
d exceptions. Only i386 is supported now.
>
> Changed in v3:
>
>  - Add a support of the new api functions from the WinDbg v10.
>
> Changed in v2:
>
>  - Move target specific code in the 'target/' directory. (Alistair Franci=
s)
>  - Change 'kd_api_fill_memory'. Made a fill of memory by line segments. B=
efore that, a full array was immediately collected and written in RAM. (Lad=
i Prosek)
>  - Change 'kd_api_search_memory'. Made a search for memory by line segmen=
ts. (Ladi Prosek)
>  - Change ld* to st* where it needs. (Ladi Prosek)
>  - Add a additional check of input arguments in 'windbg_read_context' and=
 'windbg_read_ks_regs'. (Ladi Prosek)
>  - Fix typos. (Ladi Prosek)
>  - Add a fliping back 'windbg_state->is_loaded' after reset VM.
>  - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
>  - Add a check to device in windbg option. Only pipe is supporting now. (=
Alistair Francis)
>  - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair Fra=
ncis)
>  - Replace printf to qemu_log. (Alistair Francis)
>  - Fix build on s390x host. (patchew)
>  - Fix code style error. (patchew)


Thanks, v3 is working with a Win10 windbg for me!

A few things I noticed during my testing (Win7 32-bit guest):

* Windbg prints:

  ReadVirtual: 827403d0 not properly sign extended

after connecting. That's likely a bug hiding somewhere.

* lm prints only nt and a bunch of unloaded crash dump modules. This
doesn't look expected and blocks what I believe is the most common way
of initiating debugging which is setting a breakpoint on a specific
driver function. Additionally, after rebooting the guest, lm prints
only nt, nothing else. Do you see the same thing?

  kd> lm
  start    end        module name
  8260b000 82a1d000   nt         (pdb symbols)          C:\Program
Files (x86)\Windows
Kits\10\Debuggers\x64\sym\ntkrpamp.pdb\684DA42A30CC450F81C535B4D18944B12\nt=
krpamp.pdb

  Unloaded modules:
  869da000 869e7000   crashdmp.sys
  869e7000 869f2000   dump_ataport.sys
  869f2000 869fb000   dump_atapi.sys
  86800000 86811000   dump_dumpfve.sys

* It seems to work on a Linux host as well! Still ok to keep it
limited to pipe: for now, especially if you don't test on Linux.

* Wondering about the legal aspects of copying code from winnt.h. I'll
let others confirm that it's ok.

I have replied to some of the patches with comments.

Thank you!
Ladi
