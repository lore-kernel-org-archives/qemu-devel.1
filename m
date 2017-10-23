Received: from eggs.gnu.org ([2001:4830:134:3::10]:54766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e6Y9I-0000HZ-M4
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e6Y9C-0003ct-BY
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:31:52 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:45820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1e6Y9C-0003cX-5u
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:31:46 -0400
Received: by mail-ua0-f180.google.com with SMTP id l40so12304624uah.2
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 01:31:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 23 Oct 2017 10:31:44 +0200
Message-ID: <CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
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

On Tue, Oct 17, 2017 at 3:08 PM, Mihail Abakumov
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

Thank you, I am planning to take a closer look and test the changes in
a week or two.

Still wondering if it is limited to Windows hosts or if it can be used
on Linux as well, preferably with KVM.

Thanks!
Ladi

> ---
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
>       windbg: implemented kd_api_read_virtual_memory and kd_api_write_vir=
tual_memory
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
>  include/exec/windbgkd.h         |  948 ++++++++++++++++++++++++++
>  include/exec/windbgstub-utils.h |  122 +++
>  include/exec/windbgstub.h       |   24 +
>  include/sysemu/sysemu.h         |    2
>  qemu-options.hx                 |    8
>  stubs/Makefile.objs             |    1
>  stubs/windbgstub.c              |   21 +
>  target/i386/Makefile.objs       |    2
>  target/i386/misc_helper.c       |    3
>  target/i386/windbgstub.c        | 1443 +++++++++++++++++++++++++++++++++=
++++++
>  vl.c                            |    8
>  windbgstub-utils.c              |  358 ++++++++++
>  windbgstub.c                    |  490 +++++++++++++
>  16 files changed, 3455 insertions(+), 2 deletions(-)
>  create mode 100755 include/exec/windbgkd.h
>  create mode 100755 include/exec/windbgstub-utils.h
>  create mode 100755 include/exec/windbgstub.h
>  create mode 100755 stubs/windbgstub.c
>  create mode 100755 target/i386/windbgstub.c
>  create mode 100755 windbgstub-utils.c
>  create mode 100755 windbgstub.c
>
> --
> Thanks,
> Mihail Abakumov
