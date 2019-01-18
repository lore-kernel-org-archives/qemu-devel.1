Received: from eggs.gnu.org ([209.51.188.92]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUog-00074u-Lh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUoe-0002R2-OZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43934
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUoc-0002Kq-EB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDx2eG070042
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:07 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q3fn21tjw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:06 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:06 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:51 -0200
Message-Id: <20190118140758.829-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 0/7] target/ppc: single step for KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com, aik@ozlabs.ru

Single stepping via GDB/gdbstub is currently not working with KVM
HV. When asking for a single step (stepi), KVM simply ignores the
request and execution continues.

This has the direct effect of breaking GDB's 'step', 'stepi', 'next',
'nexti' commands. The 'continue' command is also affected since
continuing right after a breakpoint requires that GDB first perform a
single step so that the breakpoint can be re-inserted before
continuing - in this case the breakpoint is not re-inserted and it
won't hit again.

The issue here is that single stepping in POWER makes use of an
interrupt (Trace Interrupt [1]) that does not reach the hypervisor, so
while the single step would happen if properly triggered, it would not
cause an exit to KVM so there would be no way of handing control back
to GDB. Aside from that, the guest kernel is not prepared to deal with
such an interrupt in kernel mode (when not using KGDB, or some other
debugging facility) and it causes an Oops.

This series implements a "software single step" approach that makes
use of: i) the Trace Interrupt to perform the step inside the guest
and ii) a breakpoint at the Trace Interrupt handler address to cause a
vm exit (Emulation Assist) so that we can return control to QEMU.

With (i), we basically get the single step for free, without having to
discover what are the possible targets of instructions that divert
execution.

With (ii), we hide the single step from the guest and keep all of the
step logic in QEMU.

Supported scenarios:

- Stepping of multiple vcpus;
- GDB scheduler locking on and off [2];
- single stepping of kernel code with QEMU while stepping with GDB
  inside the guest (user space, KGDB).

1- PowerISA Section 6.5.15 - Trace Interrupt
2- https://sourceware.org/gdb/onlinedocs/gdb/All_002dStop-Mode.html

v1 -> v2:
 - split in more patches to facilitate review
 - use extract32 for decoding instruction instead of open-coding
 - add more people to CC

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03738.html

v2 -> v3:
 - take Alternate Interrupt Location (AIL) into consideration when
   calculating the Trace Interrupt handler address (this allows single
   stepping in SLOF code);

 - check for a new KVM_GUEST_DEBUG_SSTEP capability (still to be
   submitted to kernel ml);

 - handle other vcpus (not currently stepping) hitting the single step
   breakpoint - by ignoring the breakpoint;

 - handle simultaneous single step by GDB inside guest - by first
   performing our step into the trace interrupt handler itself and
   returning to the guest afterwards;

 - handle single stepping when at the first trace interrupt handler
   instruction - by displacing the breakpoint to the next instruction;

 - restore MSR, SRR0, SRR1 after the step, taking into consideration
   possible mtspr, mtmsr instructions;

 - use stubs for arch-specific code that will not be implemented by
   other architectures at this point;

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03738.html


Fabiano Rosas (7):
  target/ppc: Move exception vector offset computation into a function
  target/ppc: Add ppc_get_trace_int_handler_addr
  kvm: support checking for single step capability
  kvm-all: Introduce kvm_set_singlestep
  target/ppc: Move handling of hardware breakpoints to a separate
    function
  target/ppc: Refactor kvm_handle_debug
  target/ppc: support single stepping with KVM HV

 accel/kvm/kvm-all.c             |  16 ++
 accel/stubs/kvm-stub.c          |   4 +
 exec.c                          |   2 +-
 include/sysemu/kvm.h            |   3 +
 stubs/Makefile.objs             |   1 +
 stubs/kvm-arch-set-singlestep.c |   8 +
 target/ppc/cpu.h                |   6 +
 target/ppc/excp_helper.c        |  43 +++--
 target/ppc/kvm.c                | 297 ++++++++++++++++++++++++++------
 9 files changed, 314 insertions(+), 66 deletions(-)
 create mode 100644 stubs/kvm-arch-set-singlestep.c

--
2.17.1
