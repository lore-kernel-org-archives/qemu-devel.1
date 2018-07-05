Received: from eggs.gnu.org ([2001:4830:134:3::10]:58233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fazBu-0006YC-8h
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fazBp-0000G9-Ck
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:00:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53142
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fazBp-0000AR-6T
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:00:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w657tImt068233
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 04:00:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k1d3vd781-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 04:00:31 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Thu, 5 Jul 2018 09:00:29 +0100
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Thu,  5 Jul 2018 13:30:15 +0530
Message-Id: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel]  [PATCH 0/2] tests: multifd migration test scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, peterx@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>

This patchset adds test scenarios for precopy multifd migration
using fd and unix.

Also I am working on adding scenarios in tp-qemu using Avocado-VT
and observed `Segmentation fault` with recently added test scenario
using fd where as unix and tcp got PASS, 

https://github.com/autotest/tp-qemu/pull/1433

so thought to recreate using qtest but it works fine here, I will debug
more whether it is a test environment issue or real bug meanwhile.

QTest results:
# QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 \
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( \
${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=quick \
tests/migration-test
TEST: tests/migration-test... (pid=23465)
  /ppc64/migration/deprecated: OK
  /ppc64/migration/bad_dest: OK
  /ppc64/migration/postcopy/unix: OK
  /ppc64/migration/precopy/unix: OK
  /ppc64/migration/multifd/unix: OK
  /ppc64/migration/multifd/fd: OK
PASS: tests/migration-test

Please help review,

-- Bala

Balamuruhan S (2):
  tests: add precopy multifd migration test
  tests: add precopy multifd migration with fd protocol

 tests/migration-test.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

-- 
2.14.3
