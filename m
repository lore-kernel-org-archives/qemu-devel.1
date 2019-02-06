Received: from eggs.gnu.org ([209.51.188.92]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1grQQW-0007ra-Pw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1grQQN-0001EV-Pg
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:51:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55834
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1grQQK-0001CB-Re
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:51:47 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x16GpAds065716
	for <qemu-devel@nongnu.org>; Wed, 6 Feb 2019 11:51:42 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qg23pdkfb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 11:51:40 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 6 Feb 2019 16:51:39 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Wed,  6 Feb 2019 14:51:32 -0200
Message-Id: <20190206165133.12246-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/1] ppc/gdbstub: Expose SPRs to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, groug@kaod.org

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

Note about endianness:

GDB remote protocol defines that registers should be sent in target
(guest) byte order. It will store the value in memory without regard
to endianness and later use what it thinks is the target endianness to
choose a byte order for printing. This means that the `show endian`
option in GDB should match the guest's current endianness for the
values to display properly. Notice that GDB and QEMU could be running
in machines of opposite endianness.

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

v4 -> v5:
 - squash all 3 patches
 - use g_string_append() instead of g_string_append_printf() where
 possible
 - free the g_ascii_strdown() string
 - fix uninitialized variable
 - use POWERPC_CPU_GET_CLASS with CPUState

 Regarding the endianness discussion, continue providing the registers
 in the target endianness as GBD currently requires this.

 http://lists.nongnu.org/archive/html/qemu-ppc/2019-01/msg00498.html


Fabiano Rosas (1):
  target/ppc: Enable reporting of SPRs to GDB

 target/ppc/cpu-qom.h            |  4 +++
 target/ppc/cpu.h                |  5 +++
 target/ppc/gdbstub.c            | 61 ++++++++++++++++++++++++++++++++
 target/ppc/translate_init.inc.c | 62 +++++++++++++++++++++++++++++++--
 4 files changed, 130 insertions(+), 2 deletions(-)

--
2.17.1
