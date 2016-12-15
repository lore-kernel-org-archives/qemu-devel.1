Received: from eggs.gnu.org ([2001:4830:134:3::10]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHZmf-0000Xf-0S
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHZma-0005bn-2f
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:25:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45488
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHZmZ-0005bQ-Sc
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:25:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBFHNof6131198
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:27 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdmfxtp9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:26 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 15 Dec 2016 12:25:26 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
	[9.57.198.29])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9389DC90041
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:06 -0500 (EST)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
	[9.57.199.106])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	uBFHPNaR11731432
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 17:25:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89F592803F
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:23 -0500 (EST)
Received: from localhost (unknown [9.80.108.238])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 4CFD52803E
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:23 -0500 (EST)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 11:24:02 -0600
Message-Id: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hmp_object_del() followed by a subsequent hmp_object_add() can trigger a
duplicate ID error if the previous object shared the same ID and was added
via the command-line. Please see patch 2/2 for more details.

This patchset fixes the issue in question and adds some general unit tests
for object created via -object, which we later extend to verify the fix in
question.

Changes since v3:

  - Fixed up comment formating (Markus)
  - Instead of segfaulting, use &error_abort if assumptions about
    'object' property group existence change (Markus)
  - Use g_assert_null in place of g_assert(... == NULL) (Markus)

Changes since v2:

  - Moved the generic unit tests ahead of the fix patch, with a FIXME
    in place of the actual check for the failure addressed in patch
    2/2 (Daniel/Markus)
  - Dropped check for existence of objects' QemuOptsList (Markus)
  - Dropped unintended whitespace removal in PATCH 1/2
  - Slight rewording of commit messages to reflect the changes and fix
    minor grammar errors.

Changes since v1:

  - Moved QemuOpt cleanup out of {qmp,hmp}_object_del() and into common
    user_creatable_del() path (Daniel, David)
  - Added corresponding test case in check-qom-proplist
