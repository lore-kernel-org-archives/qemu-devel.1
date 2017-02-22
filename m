Received: from eggs.gnu.org ([2001:4830:134:3::10]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGH-0000le-LP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGD-0006Vn-Mh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52424
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgTGD-0006VY-GO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:30:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M9SpxE070302
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:30:56 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s6qeb878-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:30:55 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 19:30:52 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 14:59:37 +0530
Message-Id: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 00/11] POWER9 TCG enablements - part15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

This series contains implentation of CA32 and OV32 bits added to the 
ISA 3.0. Various fixed-point arithmetic instructions are updated to take
care of the newer flags. 

Finally the last patch adds new instruction mcrxrx, that helps reading 
the carry (CA and CA32) and the overflow (OV and OV32) flags

Changelog:
v1: 
* Use these ISA 3.0 flag to enable CA32 and OV32
* Re-write ca32 compute routine
* Add setting of flags for "neg." and "nego."

Nikunj A Dadhania (11):
  target/ppc: move cpu_[read, write]_xer to cpu.c
  target/ppc: optimize gen_write_xer()
  target/ppc: support for 32-bit carry and overflow
  target/ppc: update ca32 in arithmetic add
  target/ppc: update ca32 in arithmetic substract
  target/ppc: update overflow flags for add/sub
  target/ppc: use tcg ops for neg instruction
  target/ppc: update ov/ov32 for nego
  target/ppc: add ov32 flag for multiply low insns
  target/ppc: add ov32 flag in divide operations
  target/ppc: add mcrxrx instruction

 target/ppc/Makefile.objs    |   1 +
 target/ppc/cpu.c            |  51 ++++++++++++++++
 target/ppc/cpu.h            |  21 +++----
 target/ppc/int_helper.c     |  49 +++++----------
 target/ppc/translate.c      | 143 ++++++++++++++++++++++++++++++++++++--------
 target/ppc/translate_init.c |   4 +-
 6 files changed, 196 insertions(+), 73 deletions(-)
 create mode 100644 target/ppc/cpu.c

-- 
2.7.4
