Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZBve-0004J1-0w
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZBvZ-0002xO-T9
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:40:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55536)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZBvZ-0002vK-EX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:40:05 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<CABdb736PM6C4LTxg_-NdcWkcc6v1MxpMkp+2fmnxVBXf77picw@mail.gmail.com>
	<000801d37b27$bd7e7a40$387b6ec0$@ru>
	<9d5385b9-af8d-38ac-a4b6-376092badc17@redhat.com>
In-Reply-To: <9d5385b9-af8d-38ac-a4b6-376092badc17@redhat.com>
Date: Wed, 10 Jan 2018 11:40:03 +0300
Message-ID: <001501d389ee$9c4c1550$d4e43ff0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v4 00/46] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>
Cc: 'qemu-devel' <qemu-devel@nongnu.org>, sw@weilnetz.de, 'Roman Kagan' <rkagan@virtuozzo.com>, "'Denis V. Lunev'" <den@openvz.org>, 'Ladi Prosek' <lprosek@redhat.com>, 'Mihail Abakumov' <mikhail.abakumov@ispras.ru>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 22/12/2017 14:21, Pavel Dovgalyuk wrote:
> > Paolo, Ladi finished the review.
> > What about merging these into upstream?
> 
> Sure, in the new year though.

Now?

Pavel Dovgalyuk
> >
> >> -----Original Message-----
> >> From: Ladi Prosek [mailto:lprosek@redhat.com]
> >> Sent: Thursday, December 14, 2017 3:33 PM
> >> To: Mihail Abakumov
> >> Cc: qemu-devel; sw@weilnetz.de; Pavel Dovgalyuk; Roman Kagan; Paolo Bonzini; Denis V. Lunev
> >> Subject: Re: [PATCH v4 00/46] Windbg supporting
> >>
> >> On Mon, Dec 11, 2017 at 2:21 PM, Mihail Abakumov
> >> <mikhail.abakumov@ispras.ru> wrote:
> >>> An update of:
> >>>
> >>>         v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07092.html
> >>>
> >>> We made the debugger module WinDbg (like GDB) for QEMU. This is the replacement
> >>> of the remote stub in Windows kernel. Used for remote Windows kernel debugging
> >>> without debugging mode.
> >>>
> >>> WinDbg is a multipurpose debugger for the Microsoft Windows computer operating
> >>> system, distributed by Microsoft. Recent versions of WinDbg have been and are
> >>> being distributed as part of the free Debugging Tools for Windows suite.
> >>>
> >>> How to start debugging QEMU using WinDbg:
> >>>   Run QEMU with next option:
> >>>     -windbg pipe:<name>
> >>>   QEMU will start and pause for waiting WinDbg connection.
> >>>   Run WinDbg with next options:
> >>>     -b -k com:pipe,baud=115200,port=\\.\pipe\<name>,resets=0
> >>>   Wait for debugger connect to kernel.
> >>>
> >>> Note: You can add Symbol Search Path in WinDbg such as
> >>> srv*c:\tmp*http://msdl.microsoft.com/download/symbols.
> >>>
> >>> How it works:
> >>> The WinDbg debugger has the possibility of connecting to a remote debug service
> >>> (Kdsrv.exe) in the Windows kernel. Therefore, it is possible to connect to the
> >>> guest system running in the QEMU emulator. Kernel debugging is possible only
> >>> with the enabled debugging mode, may change at the same time. Our module of
> >>> WinDbg debugger for QEMU is an alternative of the remote debugging service in
> >>> the kernel. Thus, the debugger connects to the debugging module, not to the
> >>> kernel of the operating system. The module obtains all the necessary information
> >>> answering debugger requests from the QEMU emulator. At the same time for
> >>> debugging there is no need to enable debugging mode in the kernel. This leads to
> >>> hidden debugging. Our module supports all features of WinDbg regarding remote
> >>> debugging, besides interception of events and exceptions. Only i386 is supported
> >>> now.
> >>>
> >>> Changed in v4:
> >>>
> >>>  - Add WinDbg stub to the MAINTAINERS file.
> >>>  - Increase size of the search buffer in 'kd_api_search_memory'. (Ladi Prosek)
> >>>  - Add sub functions for helper_wrmsr and helper_rdmsr: cpu_x86_write_msr and
> >>>    cpu_x86_read_msr. Also they are used in packet handlers, i.e. duplication of
> >>>    code is removed. (Ladi Prosek)
> >>>  - Add a more user-friendly error when try to use -windbg and -gdb at the same
> >>>    time. (Ladi Prosek)
> >>>  - Remove macros for SizedBuf. (Ladi Prosek)
> >>>  - Add runtime assert to KD_API_NAME and KD_PKT_TYPE_NAME. (Ladi Prosek)
> >>>  - Remove 'ifneq ($(TARGET_NAME), x86_64)' from the 'Makefile.target' file.
> >>>    (Ladi Prosek)
> >>>  - Remove incorrect macro UINT32_P. Replace it by bit shifts. (Ladi Prosek)
> >>>
> >>> Changed in v3:
> >>>
> >>>  - Add a support of the new api functions from the WinDbg v10.
> >>>
> >>> Changed in v2:
> >>>
> >>>  - Move target specific code in the 'target/' directory. (Alistair Francis)
> >>>  - Change 'kd_api_fill_memory'. Made a fill of memory by line segments. Before
> >>>    that, a full array was immediately collected and written in RAM. (Ladi Prosek)
> >>>  - Change 'kd_api_search_memory'. Made a search for memory by line segments.
> >>>    (Ladi Prosek)
> >>>  - Change ld* to st* where it needs. (Ladi Prosek)
> >>>  - Add a additional check of input arguments in 'windbg_read_context' and
> >>>    'windbg_read_ks_regs'. (Ladi Prosek)
> >>>  - Fix typos. (Ladi Prosek)
> >>>  - Add a fliping back 'windbg_state->is_loaded' after reset VM.
> >>>  - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
> >>>  - Add a check to device in windbg option. Only pipe is supporting now.
> >>>    (Alistair Francis)
> >>>  - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair Francis)
> >>>  - Replace printf to qemu_log. (Alistair Francis)
> >>>  - Fix build on s390x host. (patchew)
> >>>  - Fix code style error. (patchew)
> >>>
> >>> ---
> >>>
> >>> Mihail Abakumov (46):
> >>>       windbg: added empty windbgstub files
> >>>       windbg: added windbg's KD header file
> >>>       windbg: modified windbgkd.h
> >>>       windbg: added '-windbg' option
> >>>       windbg: added helper features
> >>>       windbg: added WindbgState
> >>>       windbg: added chardev
> >>>       windbg: hook to wrmsr operation
> >>>       windbg: handler of fs/gs register
> >>>       windbg: structures for parsing data stream
> >>>       windbg: parsing data stream
> >>>       windbg: send data and control packets
> >>>       windbg: handler of parsing context
> >>>       windbg: init DBGKD_ANY_WAIT_STATE_CHANGE
> >>>       windbg: generate ExceptionStateChange
> >>>       windbg: generate LoadSymbolsStateChange
> >>>       windbg: windbg_vm_stop
> >>>       windbg: implemented windbg_process_control_packet
> >>>       windbg: implemented windbg_process_data_packet
> >>>       windbg: implemented windbg_process_manipulate_packet
> >>>       windbg: implemented kd_api_read_virtual_memory and kd_api_write_virtual_memory
> >>>       windbg: kernel's structures
> >>>       windbg: implemented kd_api_get_context and kd_api_set_context
> >>>       windbg: implemented kd_api_read_control_space and kd_api_write_control_space
> >>>       windbg: implemented windbg_read_context
> >>>       windbg: implemented windbg_write_context
> >>>       windbg: implemented windbg_read_ks_regs
> >>>       windbg: implemented windbg_write_ks_regs
> >>>       windbg: implemented windbg_set_sr
> >>>       windbg: implemented windbg_set_dr
> >>>       windbg: implemented windbg_set_dr7
> >>>       windbg: implemented windbg_hw_breakpoint_insert and windbg_hw_breakpoint_remove
> >>>       windbg: implemented kd_api_write_breakpoint and kd_api_restore_breakpoint
> >>>       windbg: debug exception subscribing
> >>>       windbg: implemented kd_api_continue
> >>>       windbg: implemented kd_api_read_io_space and kd_api_write_io_space
> >>>       windbg: implemented kd_api_read_physical_memory and kd_api_write_physical_memory
> >>>       windbg: implemented kd_api_get_version
> >>>       windbg: implemented kd_api_read_msr and kd_api_write_msr
> >>>       windbg: implemented kd_api_search_memory
> >>>       windbg: implemented kd_api_fill_memory
> >>>       windbg: implemented kd_api_query_memory
> >>>       windbg: added new api functions
> >>>       windbg: implemented kd_api_get_context_ex and kd_api_set_context_ex
> >>>       windbg: changed kd_api_read_msr and kd_api_write_msr
> >>>       windbg: maintainers
> >>>
> >>>
> >>>  MAINTAINERS                     |   12
> >>>  Makefile.target                 |    5
> >>>  cpus.c                          |   19 +
> >>>  gdbstub.c                       |    4
> >>>  include/exec/windbgkd.h         |  975 +++++++++++++++++++++++++++++++
> >>>  include/exec/windbgstub-utils.h |  105 +++
> >>>  include/exec/windbgstub.h       |   24 +
> >>>  include/sysemu/sysemu.h         |    2
> >>>  qemu-options.hx                 |    8
> >>>  stubs/Makefile.objs             |    1
> >>>  stubs/windbgstub.c              |   21 +
> >>>  target/i386/Makefile.objs       |    2
> >>>  target/i386/cpu.h               |    3
> >>>  target/i386/misc_helper.c       |   48 +-
> >>>  target/i386/windbgstub.c        | 1223 +++++++++++++++++++++++++++++++++++++++
> >>>  vl.c                            |    8
> >>>  windbgstub-utils.c              |  351 +++++++++++
> >>>  windbgstub.c                    |  498 ++++++++++++++++
> >>>  18 files changed, 3296 insertions(+), 13 deletions(-)
> >>>  create mode 100755 include/exec/windbgkd.h
> >>>  create mode 100755 include/exec/windbgstub-utils.h
> >>>  create mode 100755 include/exec/windbgstub.h
> >>>  create mode 100755 stubs/windbgstub.c
> >>>  create mode 100755 target/i386/windbgstub.c
> >>>  create mode 100755 windbgstub-utils.c
> >>>  create mode 100755 windbgstub.c
> >>
> >> Thank you. I have sent a small proposal as a reply to patch 5.
> >>
> >> Regardless:
> >>
> >> Acked-by: Ladi Prosek <lprosek@redhat.com>
> >>
> >> This is a great work with many interesting uses. For instance, Windows
> >> can't be kernel-debugged if secure boot is enabled. And "printf"
> >> debugging is painful, too, as modern Windows requires that all kernel
> >> code be signed by Microsoft.
> >>
> >> Now you'll probably have to find somebody who'll do a thorough review
> >> and merge the code.
> >>
> >> Thanks again,
> >> Ladi
> >
