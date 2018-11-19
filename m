Received: from eggs.gnu.org ([2001:4830:134:3::10]:37323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gOrEw-00089F-Mp
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gOrEt-0004RT-Iw
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:37:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gOrEt-0004QW-Au
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:37:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAJLXYf1042651
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 16:37:49 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nv4e0hwu7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 16:37:49 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Mon, 19 Nov 2018 21:37:48 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Mon, 19 Nov 2018 19:37:38 -0200
Message-Id: <20181119213739.773-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/1] single step for KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au

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

This was so far tested with single and multiple vcpus and with GDB
scheduler locking on and off [2].

I have not fully explored yet the potential issues when using
debuggers simultaneously inside and outside the guest, however I was
able to single step the ptrace code while single stepping a userspace
program inside the guest with GDB.

I'm looking for feedback on the general approach before I develop this
further.

1- PowerISA Section 6.5.15 - Trace Interrupt
2- https://sourceware.org/gdb/onlinedocs/gdb/All_002dStop-Mode.html


Fabiano Rosas (1):
  target/ppc: support single stepping with KVM HV

 accel/kvm/kvm-all.c  | 10 +++++++
 exec.c               |  1 +
 include/sysemu/kvm.h |  4 +++
 target/arm/kvm.c     |  4 +++
 target/i386/kvm.c    |  4 +++
 target/ppc/kvm.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
 target/s390x/kvm.c   |  4 +++
 7 files changed, 91 insertions(+), 1 deletion(-)

--
2.17.1
