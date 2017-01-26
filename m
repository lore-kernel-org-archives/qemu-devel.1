Received: from eggs.gnu.org ([2001:4830:134:3::10]:38926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cWm9F-00078R-Mi
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cWm9A-0006DW-T2
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:39:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41164
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cWm9A-0006DB-NA
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:39:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0QFcveY103569
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 10:39:35 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287fagc3me-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 10:39:35 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 26 Jan 2017 15:39:34 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 16:39:29 +0100
Message-Id: <1485445171-16935-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 0/2] Qemu: gdbstub: fix vCont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com

This small patchset fixes the incorrect behaviour of the vCont command
in the gdb stub. 

The first patch, as suggested be Paolo, refactors some code. The most
visible change is that it moves vm_start to cpus.c 

The second one fixes the incorrect behaviour of the vCont command.
Previously, continuing or stepping a single thread (CPU) caused all
other CPUs to be started too, whereas the GDB specification clearly
states that without a default action all threads not explicitly
mentioned in the command should stay stopped.

So if the Qemu gdbstub receives a  vCont;c:1  packet, no other CPU
should be restarted except the first, and when a  vCont;s:1  is
received, the first CPU should be stepped without restarting the others.
With this patchset Qemu now behaves as expected.

See here for reference material about the packets: 
https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html
https://sourceware.org/gdb/onlinedocs/gdb/Packets.html

v4 -> v5
* rebased on master after target-s390x was moved
* put qemu_clock_enable back into resume_all_vcpus
* improved the parsing function of the vCont packet
* added qemu_clock_enable to gdb_continue_partial

v3 -> v4
* rebased on v2.8.0-rc2, no changes needed

v2 -> v3
* removed resume_some_vcpus
* cleared up the code and simplified the implementation in light of the 
  clarification in the specification of the vCont packet

Claudio Imbrenda (2):
  move vm_start to cpus.c
  gdbstub: Fix vCont behaviour

 cpus.c                  |  42 +++++++++++
 gdbstub.c               | 187 ++++++++++++++++++++++++++++++++++++------------
 include/sysemu/cpus.h   |   1 +
 include/sysemu/sysemu.h |   2 +
 vl.c                    |  30 +-------
 5 files changed, 186 insertions(+), 76 deletions(-)

-- 
1.9.1
