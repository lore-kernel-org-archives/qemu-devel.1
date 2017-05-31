Received: from eggs.gnu.org ([2001:4830:134:3::10]:37726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dG1n9-0004Pk-Em
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dG1n6-0001I7-AJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:27:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dG1n6-0001Eu-0k
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:27:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VBPOZ0087305
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:27:49 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2asvxa821f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:27:49 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 31 May 2017 21:27:47 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 31 May 2017 16:56:43 +0530
Message-Id: <1496230005-12265-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/2] ppc/spapr: Fix migration of radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

This patchset fixes the migration of sPAPR radix guests.

Changes in v4
-------------
- The earlier approach of keeping the HTAB savevm handlers registered
  only for hash guests by explicitly deregistering does leave out a few
  corner cases which become ugly/difficult to fix. Hence based on
  David Gibson's suggestion, this new approach adds a new
  "no HPT" encoding into the migration stream when guest doesn't
  allocate HPT.
- There are a few assumptions in HTAB savevm handlers that spapr->htab
  will not be set only for KVM guests. This is no longer true with
  radix TCG guests. Fix this assumption. These changes enable TCG migration
  to work. However guest kernel failures are observed post migration which
  need to be fixed separately. This changes could acutally go into
  a separate patch.

v3: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05434.html

Bharata B Rao (2):
  spapr: Add a "no HPT" encoding to HTAB migration stream
  spapr: Fix migration of Radix guests

 hw/ppc/spapr.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

-- 
2.7.4
