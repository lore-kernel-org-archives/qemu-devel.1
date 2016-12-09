Received: from eggs.gnu.org ([2001:4830:134:3::10]:46139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFPY1-00082E-PK
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cFPXy-0005oF-1d
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:05:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60542
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cFPXx-0005ni-Qb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:05:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9I3OvM080916
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 13:05:24 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 277ymhp9dy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 13:05:24 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 13:05:24 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri,  9 Dec 2016 12:04:39 -0600
Message-Id: <1481306681-5760-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, bharata.rao@gmail.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

hmp_object_del() followed by a subsequent hmp_object_add() can trigger a
duplicate ID error if the previous object shared the same ID and was added
via the command-line. Please see patch 2/2 for more details.

This patchset fixes the issue in question and adds some general unit tests
for object created via -object, which we later extend to verify the fix in
question.

Changes since v3:
  - Moved the generic unit tests ahead of the fix patch, with a FIXME
    in place of the actual check for the failure addressed in patch
    2/2 (Daniel/Markus)
  - Dropped check for existence of objects' QemuOptsList (Markus)
  - Dropped unintended whitespace removal in PATCH 1/2
  - Slight rewording of commit messages to reflect the changes and fix
    minor grammar errors.

Changes since v2:

  - Moved QemuOpt cleanup out of {qmp,hmp}_object_del() and into common
    user_creatable_del() path (Daniel, David)
  - Added corresponding test case in check-qom-proplist
