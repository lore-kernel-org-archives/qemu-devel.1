Received: from eggs.gnu.org ([208.118.235.92]:56726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gfVak-0000jm-2V
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gfVaf-0000cQ-Tg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gfVad-0000Y7-O5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x04JshKa115300
	for <qemu-devel@nongnu.org>; Fri, 4 Jan 2019 14:57:04 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ptds40n8p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:57:04 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 4 Jan 2019 19:57:03 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri,  4 Jan 2019 17:56:51 -0200
Message-Id: <20190104195654.19976-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/3] ppc/gdbstub: Expose SPRs to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

This series implements the reading and writing of Special Purpose
Registers in PPC's gdbstub.

* How it works generally [1]:

GDB asks for the target.xml file which contains the target description
along with the list of available feature XMLs. GDB then asks for each
of the XML files in sequence.

The XML files contain a list of registers descriptions:

  <reg name="msr" bitsize="64" type="uint64"/>

When the user tries to access a register, GDB looks for the register
name in the XML file and sends QEMU the index of the register. This
index is sequential across all feature files.

The index provided by GDB must be converted by QEMU to match QEMU's
internal representation.

A set of callbacks are implemented to read/write the register.

* In this series:

The first patch implements the dynamic generation of the power-spr.xml
file. Making it dynamically facilitates converting the GDB index to an
index useful for addressing the env->spr array.

The second patch implements the gdb_{get,set}_spr_reg callbacks along
with the convertion from GDB index to QEMU index.

The third patch enables the functionality.

1- https://sourceware.org/gdb/current/onlinedocs/gdb/Target-Descriptions.html


Fabiano Rosas (3):
  target/ppc: Add SPRs XML generation code for gdbstub
  target/ppc: Add GDB callbacks for SPRs
  target/ppc: Enable reporting of SPRs to GDB

 target/ppc/cpu.h                |  7 ++++
 target/ppc/gdbstub.c            | 45 +++++++++++++++++++++++++
 target/ppc/translate_init.inc.c | 59 +++++++++++++++++++++++++++++++--
 3 files changed, 109 insertions(+), 2 deletions(-)

--
2.17.1
