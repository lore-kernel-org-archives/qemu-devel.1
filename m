Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsIr-0007RW-20
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsIo-0003LR-7f
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:58:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59608)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsIn-0003KH-Qv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:58:46 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:58:38 +0300
Message-ID: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/39] Windbg supporting
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

        v2: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg0074=
8.html

We made the debugger module WinDbg (like GDB) for QEMU. This is the repla=
cement
of the remote server in Windows kernel. Used for remote Windows kernel de=
bugging
without debugging mode.

WinDbg is a multipurpose debugger for the Microsoft Windows computer oper=
ating
system, distributed by Microsoft. Recent versions of WinDbg have been
and are being distributed as part of the free Debugging Tools for Windows=
 suite.

How to start debugging QEMU using WinDbg:
  Run QEMU with next option:
    -windbg pipe:<name>
  QEMU will start and pause for waiting WinDbg connection.
  Run WinDbg with next options:
    -b -k com:pipe,baud=3D115200,port=3D\\.\pipe\<name>,resets=3D0
  Wait for debugger connect to kernel.

Note: You can add Symbol Search Path in WinDbg
such as srv*c:\tmp*http://msdl.microsoft.com/download/symbols.

How it works:
The WinDbg debugger has the possibility of connecting to a remote debug s=
erver
(Kdsrv.exe) in the Windows kernel. Therefore, it is possible to connect
to the guest system running in the QEMU emulator. Kernel debugging is pos=
sible
only with the enabled debugging mode, may change at the same time.
Our module of WinDbg debugger for QEMU is an alternative of the remote de=
bugging
service in the kernel. Thus, the debugger connects to the debugging modul=
e,
not to the kernel of the operating system. The module obtains all the nec=
essary
information answering debugger requests from the QEMU emulator. At the sa=
me time
for debugging there is no need to enable debugging mode in the kernel.
This leads to hidden debugging. Our module supports all features of WinDb=
g
regarding remote debugging, besides interception of events and exceptions=
.
Supports i386 and x86_64 architectures.

Changed in v3:

 - Make gdb_set_stop_cpu static and remove the gdbstub.h reference
   from cpus.c (Alex Benn=C3=A9e).
 - Fix typo in code.

Changed in v2:

 - Fix errors in crash report (Changbin Du).

Tested-by: Ladi Prosek <lprosek@redhat.com>
---

Mikhail Abakumov (39):
      windbg: add empty windbgstub files
      windbg: add windbg's KD header file
      windbg: add -windbg option
      windbg: add helper features
      windbg: add WindbgState
      windbg: add chardev
      windbg: hook to wrmsr operation
      windbg: implement windbg_on_load
      windbg: implement find_KPCR
      windbg: implement find_kdVersion
      windbg: add windbg_search_vmaddr
      windbg: implement find_kdDebuggerDataBlock
      windbg: parsing data stream
      windbg: send data and control packets
      windbg: handler of parsing context
      windbg: init DBGKD_ANY_WAIT_STATE_CHANGE
      windbg: generate ExceptionStateChange and LoadSymbolsStateChange
      windbg: implement windbg_process_control_packet
      windbg: implement windbg_process_data_packet
      windbg: implement windbg_process_manipulate_packet
      windbg: implement kd_api_read_virtual_memory and kd_api_write_virtu=
al_memory
      windbg: some kernel structures
      windbg: add helper functions
      windbg: [de]serialization cpu context
      windbg: [de]serialization cpu spec registers
      windbg: implement kd_api_get_context and kd_api_set_context
      windbg: implement kd_api_get_context_ex and kd_api_set_context_ex
      windbg: implement kd_api_read_control_space and kd_api_write_contro=
l_space
      windbg: implement kd_api_write_breakpoint and kd_api_restore_breakp=
oint
      windbg: debug exception subscribing
      windbg: implement kd_api_continue
      windbg: implement kd_api_read_io_space and kd_api_write_io_space
      windbg: implement kd_api_read_physical_memory and kd_api_write_phys=
ical_memory
      windbg: implement kd_api_get_version
      windbg: implement kd_api_read_msr and kd_api_write_msr
      windbg: implement kd_api_search_memory
      windbg: implement kd_api_fill_memory
      windbg: implement kd_api_query_memory
      windbg: maintainers


 MAINTAINERS                      |   12=20
 Makefile.target                  |    3=20
 cpus.c                           |   20 +
 default-configs/i386-softmmu.mak |    1=20
 gdbstub.c                        |    6=20
 include/exec/gdbstub.h           |    1=20
 include/exec/windbgkd.h          |  928 ++++++++++++++++++++++++++
 include/exec/windbgstub-utils.h  |  104 +++
 include/exec/windbgstub.h        |   25 +
 include/sysemu/sysemu.h          |    2=20
 qemu-options.hx                  |    8=20
 stubs/Makefile.objs              |    1=20
 stubs/windbgstub.c               |   22 +
 target/i386/Makefile.objs        |    1=20
 target/i386/cpu.h                |    5=20
 target/i386/misc_helper.c        |   38 +
 target/i386/windbgstub.c         | 1368 ++++++++++++++++++++++++++++++++=
++++++
 vl.c                             |    8=20
 windbgstub-utils.c               |  511 ++++++++++++++
 windbgstub.c                     |  545 +++++++++++++++
 20 files changed, 3596 insertions(+), 13 deletions(-)
 create mode 100644 include/exec/windbgkd.h
 create mode 100644 include/exec/windbgstub-utils.h
 create mode 100644 include/exec/windbgstub.h
 create mode 100644 stubs/windbgstub.c
 create mode 100644 target/i386/windbgstub.c
 create mode 100644 windbgstub-utils.c
 create mode 100644 windbgstub.c

--
Mikhail Abakumov
