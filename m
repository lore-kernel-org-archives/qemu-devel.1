Received: from eggs.gnu.org ([2001:4830:134:3::10]:55273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltV-0001mr-4A
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltR-0008OV-LB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35478
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cQltR-0008OK-Am
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A29FdB077534
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 21:10:32 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vkwrn71v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 21:10:32 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 00:10:30 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 00:10:07 -0200
Message-Id: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/7] POWER9 TCG enablements - BCD functions
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, eblake@redhat.com

v5:
 - removes 'unlikely' gcc branch pred. hints from not unlikely places
 - adds comments in host-utils functions
 - adds more test cases for shift functions
 - handles "shift backwards" with signed shifts
 - rebases branch

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

Jose Ricardo Ziviani (7):
  host-utils: Move 128-bit guard macro to .c file
  host-utils: Implement unsigned quadword left/right shift and unit
    tests
  ppc: Implement bcds. instruction
  ppc: Implement bcdus. instruction
  ppc: Implement bcdsr. instruction
  ppc: Implement bcdtrunc. instruction
  ppc: Implement bcdutrunc. instruction

 include/qemu/host-utils.h           |  27 +++++
 target/ppc/helper.h                 |   5 +
 target/ppc/int_helper.c             | 217 ++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  16 +++
 target/ppc/translate/vmx-ops.inc.c  |  13 ++-
 tests/Makefile.include              |   5 +-
 tests/test-shift128.c               | 139 +++++++++++++++++++++++
 util/Makefile.objs                  |   2 +-
 util/host-utils.c                   |  66 +++++++++++
 9 files changed, 483 insertions(+), 7 deletions(-)
 create mode 100644 tests/test-shift128.c

-- 
2.7.4
