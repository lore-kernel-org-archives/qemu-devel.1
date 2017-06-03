Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHIHr-0003fO-Tz
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 19:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHIHo-0002Dc-PX
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 19:16:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39928
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dHIHo-0002DL-Iy
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 19:16:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v53NDjB7022361
	for <qemu-devel@nongnu.org>; Sat, 3 Jun 2017 19:16:47 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2auuhs0q4d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Jun 2017 19:16:46 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sat, 3 Jun 2017 19:16:46 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Sat,  3 Jun 2017 18:13:30 -0500
Message-Id: <1496531612-22166-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

hmp_object_del() followed by a subsequent hmp_object_add() can trigger a
duplicate ID error if the previous object shared the same ID and was added
via the command-line. Please see patch 2/2 for more details.

This patchset fixes the issue in question and adds some general unit tests
for object created via -object, which we later extend to verify the fix in
question.

Changes since v4:

  - Rebased on master and re-tested

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
