Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xEH-0000BU-43
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xED-00078s-VZ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:18:41 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44480)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xED-00077S-K3
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:18:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 24 Oct 2017 14:18:34 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CAKmqyKOm2NXzbs0CW_=oy2nNhJrx0iNfTyckbWN4FnsKZ9xF+A@mail.gmail.com>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<CAKmqyKOm2NXzbs0CW_=oy2nNhJrx0iNfTyckbWN4FnsKZ9xF+A@mail.gmail.com>
Message-ID: <82f7445bfb0e2470fa69a539f0e72c25@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/43] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, den@openvz.org

Alistair Francis =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-09-26 20:26:
> On Tue, Sep 26, 2017 at 4:04 AM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
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
>> ---
>=20
> This looks pretty cool! Thanks for sending the patches.
>=20
> I had a quick look through it. I think something worth keeping in mind
> is that ideally we want this to support every target. So generally
> it's best to have the target specific code in the target/ directory
> and then make the stubs all generic. At the moment it looks like there
> is a fair bit of x86 specific code in the debugger.
>=20
> I guess this is a weird case though as Windows only runs on x86, but
> in the future it sounds like ARM will be supported and it'd be great
> if this could be easily extended to support that.
>=20
> Thanks,
> Alistair
>=20

Once again, thank you for your feedback.

I done it. I moved the target specific code in the 'target/' directory=20
and made the stub for unsupported 'targets'.
Problems with targets received by Patchew I've already fixed.

Thanks,
Mihail Abakumov

>>=20
>> Mihail Abakumov (43):
>>       windbg: added empty windbgstub files
>>       windbg: added windbg's KD header file
>>       windbg: modified windbgkd.h
>>       windbg: added '-windbg' option
>>       windbg: added helper features
>>       windbg: added WindbgState
>>       windbg: added chardev
>>       windbg: hook to wrmsr operation
>>       windbg: handler of fs/gs register
>>       windbg: structures for parsing data stream
>>       windbg: parsing data stream
>>       windbg: send data and control packets
>>       windbg: handler of parsing context
>>       windbg: init DBGKD_ANY_WAIT_STATE_CHANGE
>>       windbg: sized data buffer
>>       windbg: generate ExceptionStateChange
>>       windbg: generate LoadSymbolsStateChange
>>       windbg: windbg_vm_stop
>>       windbg: implemented windbg_process_control_packet
>>       windbg: implemented windbg_process_data_packet
>>       windbg: implemented windbg_process_manipulate_packet
>>       windbg: implemented kd_api_read_virtual_memory and=20
>> kd_api_read_virtual_memory
>>       windbg: kernel's structures
>>       windbg: implemented kd_api_get_context and kd_api_set_context
>>       windbg: implemented kd_api_read_control_space and=20
>> kd_api_write_control_space
>>       windbg: implemented windbg_read_context
>>       windbg: implemented windbg_write_context
>>       windbg: implemented windbg_read_ks_regs
>>       windbg: implemented windbg_write_ks_regs
>>       windbg: implemented windbg_set_sr
>>       windbg: implemented windbg_set_dr
>>       windbg: implemented windbg_set_dr7
>>       windbg: implemented windbg_hw_breakpoint_insert and=20
>> windbg_hw_breakpoint_remove
>>       windbg: implemented kd_api_write_breakpoint and=20
>> kd_api_restore_breakpoint
>>       windbg: debug exception subscribing
>>       windbg: implemented kd_api_continue
>>       windbg: implemented kd_api_read_io_space and=20
>> kd_api_write_io_space
>>       windbg: implemented kd_api_read_physical_memory and=20
>> kd_api_write_physical_memory
>>       windbg: implemented kd_api_get_version
>>       windbg: implemented kd_api_read_msr and kd_api_write_msr
>>       windbg: implemented kd_api_search_memory
>>       windbg: implemented kd_api_fill_memory
>>       windbg: implemented kd_api_query_memory
>>=20
>>=20
>>  Makefile.target                 |    5
>>  cpus.c                          |   18
>>  gdbstub.c                       |    4
>>  include/exec/windbgkd.h         | 1030 ++++++++++++++++++++++
>>  include/exec/windbgstub-utils.h |  132 +++
>>  include/exec/windbgstub.h       |   21
>>  include/sysemu/sysemu.h         |    2
>>  qemu-options.hx                 |    8
>>  target/i386/misc_helper.c       |    3
>>  vl.c                            |    8
>>  windbgstub-utils.c              | 1788=20
>> +++++++++++++++++++++++++++++++++++++++
>>  windbgstub.c                    |  464 ++++++++++
>>  12 files changed, 3482 insertions(+), 1 deletion(-)
>>  create mode 100755 include/exec/windbgkd.h
>>  create mode 100755 include/exec/windbgstub-utils.h
>>  create mode 100755 include/exec/windbgstub.h
>>  create mode 100755 windbgstub-utils.c
>>  create mode 100755 windbgstub.c
>>=20
>> --
>> Thanks,
>> Mihail Abakumov
>>=20
