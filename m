Received: from eggs.gnu.org ([209.51.188.92]:51009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm18q-0008Hz-TB
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm18h-00088t-Sf
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:51:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40406
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gm18h-00088I-IJ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:51:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MGx3xw119048
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:19 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q66p59jxw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:19 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 22 Jan 2019 17:01:18 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Tue, 22 Jan 2019 15:01:09 -0200
Message-Id: <20190122170112.8706-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/3] ppc/gdbstub: Expose SPRs to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org

This series implements the reading and writing of Special Purpose
Registers in PPC's gdbstub.

How it works generally [1]:

GDB asks for the target.xml file which contains the target description
along with the list of available feature XMLs. GDB then asks for each
of the XML files in sequence.

The XML files contain a list of registers descriptions:

  <reg name="msr" bitsize="64" type="uint64"/>

When the user tries to access a register, GDB reads the XML file in
sequence and sends QEMU the number of the register. This number is
sequential across all feature files.

The index provided by GDB must be converted by QEMU to match QEMU's
internal representation.

A set of callbacks are implemented to read/write the register.

In this series:

The first patch implements the dynamic generation of the power-spr.xml
file. Making it dynamically facilitates converting the GDB index to an
index useful for addressing the env->spr array.

The second patch implements the gdb_{get,set}_spr_reg callbacks along
with the convertion from GDB index to QEMU index.

The third patch enables the functionality.

https://sourceware.org/gdb/current/onlinedocs/gdb/Target-Descriptions.html

v1 -> v2:
 - patch 1: explicitly store the gdb_id and add comment explaining why
            we need it
 - patch 2: use gdb_id to find the correct env->spr array's index

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00648.html

v2 -> v3:
 - patch 2: move gdb_register_coprocessor call from patch 3 so that
            all patches build independently

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02939.html

v3 -> v4:
 - patch 1: move gdb_spr_xml into PowerPCCPUClass so that it is
            generated only once for all CPUs

 http://lists.nongnu.org/archive/html/qemu-ppc/2019-01/msg00357.html


Fabiano Rosas (3):
  target/ppc: Add SPRs XML generation code for gdbstub
  target/ppc: Add GDB callbacks for SPRs
  target/ppc: Enable reporting of SPRs to GDB

 target/ppc/cpu-qom.h            |  4 +++
 target/ppc/cpu.h                |  5 +++
 target/ppc/gdbstub.c            | 60 +++++++++++++++++++++++++++++++
 target/ppc/translate_init.inc.c | 62 +++++++++++++++++++++++++++++++--
 4 files changed, 129 insertions(+), 2 deletions(-)

--
2.17.1
