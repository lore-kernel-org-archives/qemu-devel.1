Received: from eggs.gnu.org ([2001:4830:134:3::10]:56323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtdl-0006lV-Ui
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtdk-0004JA-Fg
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:25 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:46132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwtdk-0004Im-9M
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:24 -0400
Received: by mail-io0-x22a.google.com with SMTP id d16so13456113ioj.3
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:27:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2017 10:26:52 -0700
Message-ID: <CAKmqyKOm2NXzbs0CW_=oy2nNhJrx0iNfTyckbWN4FnsKZ9xF+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, den@openvz.org

On Tue, Sep 26, 2017 at 4:04 AM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
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
> ---

This looks pretty cool! Thanks for sending the patches.

I had a quick look through it. I think something worth keeping in mind
is that ideally we want this to support every target. So generally
it's best to have the target specific code in the target/ directory
and then make the stubs all generic. At the moment it looks like there
is a fair bit of x86 specific code in the debugger.

I guess this is a weird case though as Windows only runs on x86, but
in the future it sounds like ARM will be supported and it'd be great
if this could be easily extended to support that.

Thanks,
Alistair

>
> Mihail Abakumov (43):
>       windbg: added empty windbgstub files
>       windbg: added windbg's KD header file
>       windbg: modified windbgkd.h
>       windbg: added '-windbg' option
>       windbg: added helper features
>       windbg: added WindbgState
>       windbg: added chardev
>       windbg: hook to wrmsr operation
>       windbg: handler of fs/gs register
>       windbg: structures for parsing data stream
>       windbg: parsing data stream
>       windbg: send data and control packets
>       windbg: handler of parsing context
>       windbg: init DBGKD_ANY_WAIT_STATE_CHANGE
>       windbg: sized data buffer
>       windbg: generate ExceptionStateChange
>       windbg: generate LoadSymbolsStateChange
>       windbg: windbg_vm_stop
>       windbg: implemented windbg_process_control_packet
>       windbg: implemented windbg_process_data_packet
>       windbg: implemented windbg_process_manipulate_packet
>       windbg: implemented kd_api_read_virtual_memory and kd_api_read_virt=
ual_memory
>       windbg: kernel's structures
>       windbg: implemented kd_api_get_context and kd_api_set_context
>       windbg: implemented kd_api_read_control_space and kd_api_write_cont=
rol_space
>       windbg: implemented windbg_read_context
>       windbg: implemented windbg_write_context
>       windbg: implemented windbg_read_ks_regs
>       windbg: implemented windbg_write_ks_regs
>       windbg: implemented windbg_set_sr
>       windbg: implemented windbg_set_dr
>       windbg: implemented windbg_set_dr7
>       windbg: implemented windbg_hw_breakpoint_insert and windbg_hw_break=
point_remove
>       windbg: implemented kd_api_write_breakpoint and kd_api_restore_brea=
kpoint
>       windbg: debug exception subscribing
>       windbg: implemented kd_api_continue
>       windbg: implemented kd_api_read_io_space and kd_api_write_io_space
>       windbg: implemented kd_api_read_physical_memory and kd_api_write_ph=
ysical_memory
>       windbg: implemented kd_api_get_version
>       windbg: implemented kd_api_read_msr and kd_api_write_msr
>       windbg: implemented kd_api_search_memory
>       windbg: implemented kd_api_fill_memory
>       windbg: implemented kd_api_query_memory
>
>
>  Makefile.target                 |    5
>  cpus.c                          |   18
>  gdbstub.c                       |    4
>  include/exec/windbgkd.h         | 1030 ++++++++++++++++++++++
>  include/exec/windbgstub-utils.h |  132 +++
>  include/exec/windbgstub.h       |   21
>  include/sysemu/sysemu.h         |    2
>  qemu-options.hx                 |    8
>  target/i386/misc_helper.c       |    3
>  vl.c                            |    8
>  windbgstub-utils.c              | 1788 +++++++++++++++++++++++++++++++++=
++++++
>  windbgstub.c                    |  464 ++++++++++
>  12 files changed, 3482 insertions(+), 1 deletion(-)
>  create mode 100755 include/exec/windbgkd.h
>  create mode 100755 include/exec/windbgstub-utils.h
>  create mode 100755 include/exec/windbgstub.h
>  create mode 100755 windbgstub-utils.c
>  create mode 100755 windbgstub.c
>
> --
> Thanks,
> Mihail Abakumov
>
