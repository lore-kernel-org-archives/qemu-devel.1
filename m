Received: from eggs.gnu.org ([2001:4830:134:3::10]:56095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafe-0007gJ-O7
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafc-0005Yl-Nr
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dBafc-0005Yd-Di
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4J5ehga117110
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:47 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahrwmm20k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:46 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 19 May 2017 15:41:42 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 11:10:35 +0530
Message-Id: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/4] ppc/spapr: Fix migration of radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

This patchset fixes the migration of sPAPR radix guests.

Changes in v1:
--------------
- Dropped the unrequired patch that fixed unregister_savevm().
- Reimplemented unregister_savevm_live() such that the existing
  unregister_savevm() signature isn't modified.
- Folded HTAB savevm unregistration into spapr_free_hpt().
- Obtaining GTSE bit from LPCR now and hence patb_flags needn't be part
  of the migration stream.

v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03923.html

Bharata B Rao (4):
  migration: Introduce unregister_savevm_live()
  spapr: Unregister HPT savevm handlers for radix guests
  spapr: Make h_register_process_table hcall flags global
  spapr: Fix migration of Radix guests

 hw/ppc/spapr.c              | 111 +++++++++++++++++++++++++-------------------
 hw/ppc/spapr_hcall.c        |  31 ++++++-------
 include/hw/ppc/spapr.h      |  12 +++++
 include/migration/vmstate.h |   1 +
 migration/savevm.c          |  17 ++++++-
 5 files changed, 104 insertions(+), 68 deletions(-)

-- 
2.7.4
