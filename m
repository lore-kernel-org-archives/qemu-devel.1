Received: from eggs.gnu.org ([2001:4830:134:3::10]:34297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eMVn1-0004If-D7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eMVmy-0006PA-5K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:14:51 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33992)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eMVmx-0006OY-OK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:14:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 06 Dec 2017 12:14:46 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb736ZwzjKDTZsKYqRtiqCVzKG8qEQKOubv6=oNDCwCDUe_A@mail.gmail.com>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151128141659.525.3916037556813470751@bafd83ae6430>
	<CABdb736ZwzjKDTZsKYqRtiqCVzKG8qEQKOubv6=oNDCwCDUe_A@mail.gmail.com>
Message-ID: <bcb83e92ef84c5fdeb929872033af3d3@ispras.ru>
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
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-29 11:23:
> On Tue, Nov 21, 2017 at 3:07 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
>> An update of:
>>=20
>>         v1:=20
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07092.html
>>=20
>> We made the debugger module WinDbg (like GDB) for QEMU. This is the=20
>> replacement of the remote stub in Windows kernel. Used for remote=20
>> Windows kernel debugging without debugging mode.
>>=20
>> WinDbg is a multipurpose debugger for the Microsoft Windows computer=20
>> operating system, distributed by Microsoft. Recent versions of WinDbg=20
>> have been and are being distributed as part of the free Debugging=20
>> Tools for Windows suite.
>>=20
>> How to start debugging QEMU using WinDbg:
>>   Run QEMU with next option:
>>     -windbg pipe:<name>
>>   QEMU will start and pause for waiting WinDbg connection.
>>   Run WinDbg with next options:
>>     -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\<name>,resets=3D0
>>   Wait for debugger connect to kernel.
>>=20
>> Note: You can add Symbol Search Path in WinDbg such as=20
>> srv*c:\tmp*http://msdl.microsoft.com/download/symbols.
>>=20
>> How it works:
>> The WinDbg debugger has the possibility of connecting to a remote=20
>> debug service (Kdsrv.exe) in the Windows kernel. Therefore, it is=20
>> possible to connect to the guest system running in the QEMU emulator.=20
>> Kernel debugging is possible only with the enabled debugging mode, may=
=20
>> change at the same time. Our module of WinDbg debugger for QEMU is an=20
>> alternative of the remote debugging service in the kernel. Thus, the=20
>> debugger connects to the debugging module, not to the kernel of the=20
>> operating system. The module obtains all the necessary information=20
>> answering debugger requests from the QEMU emulator. At the same time=20
>> for debugging there is no need to enable debugging mode in the kernel.=
=20
>> This leads to hidden debugging. Our module supports all features of=20
>> WinDbg regarding remote debugging, besides interception of events and=20
>> exceptions. Only i386 is supported now.
>>=20
>> Changed in v3:
>>=20
>>  - Add a support of the new api functions from the WinDbg v10.
>>=20
>> Changed in v2:
>>=20
>>  - Move target specific code in the 'target/' directory. (Alistair=20
>> Francis)
>>  - Change 'kd_api_fill_memory'. Made a fill of memory by line=20
>> segments. Before that, a full array was immediately collected and=20
>> written in RAM. (Ladi Prosek)
>>  - Change 'kd_api_search_memory'. Made a search for memory by line=20
>> segments. (Ladi Prosek)
>>  - Change ld* to st* where it needs. (Ladi Prosek)
>>  - Add a additional check of input arguments in 'windbg_read_context'=20
>> and 'windbg_read_ks_regs'. (Ladi Prosek)
>>  - Fix typos. (Ladi Prosek)
>>  - Add a fliping back 'windbg_state->is_loaded' after reset VM.
>>  - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
>>  - Add a check to device in windbg option. Only pipe is supporting=20
>> now. (Alistair Francis)
>>  - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair=20
>> Francis)
>>  - Replace printf to qemu_log. (Alistair Francis)
>>  - Fix build on s390x host. (patchew)
>>  - Fix code style error. (patchew)
>=20
>=20
> Thanks, v3 is working with a Win10 windbg for me!
>=20
> A few things I noticed during my testing (Win7 32-bit guest):
>=20
> * Windbg prints:
>=20
>   ReadVirtual: 827403d0 not properly sign extended
>=20
> after connecting. That's likely a bug hiding somewhere.
>=20

This is due to the fact that the cpu_memory_rw_debug function cannot
return the required memory region. No physical page mapped.

> * lm prints only nt and a bunch of unloaded crash dump modules. This
> doesn't look expected and blocks what I believe is the most common way
> of initiating debugging which is setting a breakpoint on a specific
> driver function. Additionally, after rebooting the guest, lm prints
> only nt, nothing else. Do you see the same thing?

Yes, the same.

>=20
>   kd> lm
>   start    end        module name
>   8260b000 82a1d000   nt         (pdb symbols)          C:\Program
> Files (x86)\Windows
> Kits\10\Debuggers\x64\sym\ntkrpamp.pdb\684DA42A30CC450F81C535B4D18944B1=
2\ntkrpamp.pdb
>=20
>   Unloaded modules:
>   869da000 869e7000   crashdmp.sys
>   869e7000 869f2000   dump_ataport.sys
>   869f2000 869fb000   dump_atapi.sys
>   86800000 86811000   dump_dumpfve.sys
>=20
> * It seems to work on a Linux host as well! Still ok to keep it
> limited to pipe: for now, especially if you don't test on Linux.
>=20
> * Wondering about the legal aspects of copying code from winnt.h. I'll
> let others confirm that it's ok.
>=20
> I have replied to some of the patches with comments.
>=20
> Thank you!
> Ladi

--=20
Thanks,
Mihail
