Received: from eggs.gnu.org ([2001:4830:134:3::10]:57908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPX3B-0008W2-2W
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPX0o-0006bt-KT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56780
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gPX0l-0006XT-7b
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wALI4KAY131747
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:13:59 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwae2ddqp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:13:58 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 21 Nov 2018 18:13:58 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Wed, 21 Nov 2018 16:13:44 -0200
Message-Id: <20181121181347.24035-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/3] target/ppc: single step for KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

Single stepping via GDB/gdbstub in POWER is currently not working with
KVM HV. When asking for a single step (stepi), KVM simply ignores the
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

v1 -> v2:
 - split in more patches to facilitate review
 - use extract32 for decoding instruction instead of open-coding
 - add more people to CC

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03738.html


Fabiano Rosas (3):
  target/ppc: Add macro definitions for relocated interrupt vectors
    offsets
  kvm-all: Introduce kvm_set_singlestep
  target/ppc: support single stepping with KVM HV

 accel/kvm/kvm-all.c      | 10 +++++++
 exec.c                   |  1 +
 include/sysemu/kvm.h     |  4 +++
 target/arm/kvm.c         |  4 +++
 target/i386/kvm.c        |  4 +++
 target/mips/kvm.c        |  4 +++
 target/ppc/cpu.h         |  3 ++
 target/ppc/excp_helper.c |  4 +--
 target/ppc/kvm.c         | 65 +++++++++++++++++++++++++++++++++++++++-
 target/s390x/kvm.c       |  4 +++
 10 files changed, 100 insertions(+), 3 deletions(-)

--
2.17.1
