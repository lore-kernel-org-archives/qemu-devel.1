Received: from eggs.gnu.org ([2001:4830:134:3::10]:38830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Cu-0007wr-QO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Cq-0001oJ-NV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37600)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Cq-0001m5-9q
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:20 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:07:16 +0300
Message-ID: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 00/45] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

An update of:

	v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07092.html

We made the debugger module WinDbg (like GDB) for QEMU. This is the replacement of the remote stub in Windows kernel. Used for remote Windows kernel debugging without debugging mode.

WinDbg is a multipurpose debugger for the Microsoft Windows computer operating system, distributed by Microsoft. Recent versions of WinDbg have been and are being distributed as part of the free Debugging Tools for Windows suite.

How to start debugging QEMU using WinDbg:
  Run QEMU with next option:
    -windbg pipe:<name>
  QEMU will start and pause for waiting WinDbg connection.
  Run WinDbg with next options:
    -b -k com:pipe,baud=115200,port=\\.\pipe\<name>,resets=0
  Wait for debugger connect to kernel.

Note: You can add Symbol Search Path in WinDbg such as srv*c:\tmp*http://msdl.microsoft.com/download/symbols.

How it works:
The WinDbg debugger has the possibility of connecting to a remote debug service (Kdsrv.exe) in the Windows kernel. Therefore, it is possible to connect to the guest system running in the QEMU emulator. Kernel debugging is possible only with the enabled debugging mode, may change at the same time. Our module of WinDbg debugger for QEMU is an alternative of the remote debugging service in the kernel. Thus, the debugger connects to the debugging module, not to the kernel of the operating system. The module obtains all the necessary information answering debugger requests from the QEMU emulator. At the same time for debugging there is no need to enable debugging mode in the kernel. This leads to hidden debugging. Our module supports all features of WinDbg regarding remote debugging, besides interception of events and exceptions. Only i386 is supported now.

Changed in v3:

 - Add a support of the new api functions from the WinDbg v10.

Changed in v2:

 - Move target specific code in the 'target/' directory. (Alistair Francis)
 - Change 'kd_api_fill_memory'. Made a fill of memory by line segments. Before that, a full array was immediately collected and written in RAM. (Ladi Prosek)
 - Change 'kd_api_search_memory'. Made a search for memory by line segments. (Ladi Prosek)
 - Change ld* to st* where it needs. (Ladi Prosek)
 - Add a additional check of input arguments in 'windbg_read_context' and 'windbg_read_ks_regs'. (Ladi Prosek)
 - Fix typos. (Ladi Prosek)
 - Add a fliping back 'windbg_state->is_loaded' after reset VM.
 - Add a check to disabled kvm. It is supported yet. (Ladi Prosek)
 - Add a check to device in windbg option. Only pipe is supporting now. (Alistair Francis)
 - Add a check to 'ifdef' WINDBG_DEBUG_ON before define it. (Alistair Francis)
 - Replace printf to qemu_log. (Alistair Francis)
 - Fix build on s390x host. (patchew)
 - Fix code style error. (patchew)

---

Mihail Abakumov (45):
      windbg: added empty windbgstub files
      windbg: added windbg's KD header file
      windbg: modified windbgkd.h
      windbg: added '-windbg' option
      windbg: added helper features
      windbg: added WindbgState
      windbg: added chardev
      windbg: hook to wrmsr operation
      windbg: handler of fs/gs register
      windbg: structures for parsing data stream
      windbg: parsing data stream
      windbg: send data and control packets
      windbg: handler of parsing context
      windbg: init DBGKD_ANY_WAIT_STATE_CHANGE
      windbg: sized data buffer
      windbg: generate ExceptionStateChange
      windbg: generate LoadSymbolsStateChange
      windbg: windbg_vm_stop
      windbg: implemented windbg_process_control_packet
      windbg: implemented windbg_process_data_packet
      windbg: implemented windbg_process_manipulate_packet
      windbg: implemented kd_api_read_virtual_memory and kd_api_write_virtual_memory
      windbg: kernel's structures
      windbg: implemented kd_api_get_context and kd_api_set_context
      windbg: implemented kd_api_read_control_space and kd_api_write_control_space
      windbg: implemented windbg_read_context
      windbg: implemented windbg_write_context
      windbg: implemented windbg_read_ks_regs
      windbg: implemented windbg_write_ks_regs
      windbg: implemented windbg_set_sr
      windbg: implemented windbg_set_dr
      windbg: implemented windbg_set_dr7
      windbg: implemented windbg_hw_breakpoint_insert and windbg_hw_breakpoint_remove
      windbg: implemented kd_api_write_breakpoint and kd_api_restore_breakpoint
      windbg: debug exception subscribing
      windbg: implemented kd_api_continue
      windbg: implemented kd_api_read_io_space and kd_api_write_io_space
      windbg: implemented kd_api_read_physical_memory and kd_api_write_physical_memory
      windbg: implemented kd_api_get_version
      windbg: implemented kd_api_read_msr and kd_api_write_msr
      windbg: implemented kd_api_search_memory
      windbg: implemented kd_api_fill_memory
      windbg: implemented kd_api_query_memory
      windbg: added new api functions
      windbg: implemented kd_api_get_context_ex and kd_api_set_context_ex


 Makefile.target                 |    7 
 cpus.c                          |   18 
 gdbstub.c                       |    4 
 include/exec/windbgkd.h         |  967 +++++++++++++++++++++++++
 include/exec/windbgstub-utils.h |  117 +++
 include/exec/windbgstub.h       |   24 +
 include/sysemu/sysemu.h         |    2 
 qemu-options.hx                 |    8 
 stubs/Makefile.objs             |    1 
 stubs/windbgstub.c              |   21 +
 target/i386/Makefile.objs       |    2 
 target/i386/misc_helper.c       |    3 
 target/i386/windbgstub.c        | 1502 +++++++++++++++++++++++++++++++++++++++
 vl.c                            |    8 
 windbgstub-utils.c              |  354 +++++++++
 windbgstub.c                    |  498 +++++++++++++
 16 files changed, 3534 insertions(+), 2 deletions(-)
 create mode 100755 include/exec/windbgkd.h
 create mode 100755 include/exec/windbgstub-utils.h
 create mode 100755 include/exec/windbgstub.h
 create mode 100755 stubs/windbgstub.c
 create mode 100755 target/i386/windbgstub.c
 create mode 100755 windbgstub-utils.c
 create mode 100755 windbgstub.c

--
Thanks,
Mihail Abakumov
