Received: from eggs.gnu.org ([2001:4830:134:3::10]:33332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cJ16g-00070N-Pt
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cJ16c-0003zp-IX
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cJ16c-0003zT-8o
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJGiOlr099847
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:48:05 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ecg38dwd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:48:04 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 19 Dec 2016 14:48:02 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 14:47:38 -0200
Message-Id: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/6] POWER9 TCG enablements - BCD functions
 - final part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

v4:
 - improves functions to behave exactly like the target

v3:
 - moves shift functions to host-utils.c and added config_int128 guard
 - changes Makefile to always compile host-utils.c
 - redesigns bcd[u]trunc to use bitwise operations
 - removes "target-ppc: Implement bcd_is_valid function" (merged)

v2:
 - bcd[s,sr,us] uses 1 byte for shifting instead of 4 bytes
 - left/right functions in host-utils are out of CONFIG_INT128
 - fixes overflowing issue in left shift and added a testcase

This serie contains 5 new instructions for POWER9 ISA3.0, left/right shifts for 
unsigned quadwords and a small improvement to check whether a bcd value is 
valid or not.

bcds.: Decimal signed shift
bcdus.: Decimal unsigned shift
bcdsr.: Decimal shift and round
bcdtrunc.: Decimal signed trucate
bcdutrunc.: Decimal unsigned truncate

Jose Ricardo Ziviani (6):
  target-ppc: Implement unsigned quadword left/right shift and unit
    tests
  target-ppc: Implement bcds. instruction
  target-ppc: Implement bcdus. instruction
  target-ppc: Implement bcdsr. instruction
  target-ppc: Implement bcdtrunc. instruction
  target-ppc: Implement bcdutrunc. instruction

 include/qemu/host-utils.h           |   3 +
 target-ppc/helper.h                 |   5 +
 target-ppc/int_helper.c             | 217 ++++++++++++++++++++++++++++++++++++
 target-ppc/translate/vmx-impl.inc.c |  16 +++
 target-ppc/translate/vmx-ops.inc.c  |  13 ++-
 tests/Makefile.include              |   5 +-
 tests/test-shift128.c               |  98 ++++++++++++++++
 util/Makefile.objs                  |   2 +-
 util/host-utils.c                   |  44 ++++++++
 9 files changed, 396 insertions(+), 7 deletions(-)
 create mode 100644 tests/test-shift128.c

-- 
2.7.4
