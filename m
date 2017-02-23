Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVi-0005ER-Ol
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVe-0001iF-Pt
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVe-0001i4-Kf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJtLBS043955
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:02 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t3cwqybt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:01 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:26:58 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:25 +0530
Message-Id: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 00/15] POWER9 TCG enablements - part15
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

Patches:
01-06  Cleans up the XER split out variables and now the 
       flag bits are stored in XER at their respective places 

07-14  Contains implentation of CA32 and OV32 bits added to the 
       ISA 3.0. Various fixed-point arithmetic instructions are 
       updated to take care of the newer flags.
 
15     Finally the last patch adds new instruction mcrxrx, that helps
       reading the carry (CA and CA32) and the overflow (OV and OV32) flags


Booted the POWER8 guest fine, needs more testing as changes are 
intrusive in nature.

Changelog:
v3:
* Get rid of cpu_ca, cpu_ov, cpu_so split out variables
* As most of the patches under went changes, dropped the 
  reviewed-bys(except neg[.] patch)

v2: 
* Add missing condition in narrow mode(add/subf), multiply and divide
* Drop nego patch, subf implementation is sufficient for setting OV and OV32
* Retaining neg[.], as the code is simplified.
* Fix OV resetting in compute_ov()

v1: 
* Use these ISA 3.0 flag to enable CA32 and OV32
* Re-write ca32 compute routine
* Add setting of flags for "neg." and "nego."

Nikunj A Dadhania (15):
  target/ppc: introduce helper_update_ov_legacy
  target/ppc: update ov flag from remaining paths
  target/ppc: introduce helper_update_ca_legacy
  target/ppc: add gen_op_update_ca_legacy() helper
  target/ppc: add gen_op_update_ov_legacy() helper
  target/ppc: remove xer split-out flags(so, ov, ca)
  target/ppc: support for 32-bit carry and overflow
  target/ppc: update ca32 in arithmetic add
  target/ppc: update ca32 in arithmetic substract
  target/ppc: add gen_op_update_ov_isa300()
  target/ppc: update OV/OV32 for mull[d,w] insns
  target/ppc: update OV/OV32 for divide operations
  target/ppc: update OV/OV32 flags for add/sub
  target/ppc: use tcg ops for neg instruction
  target/ppc: add mcrxrx instruction

 target/ppc/cpu.c        |   8 +-
 target/ppc/cpu.h        |  33 ++--
 target/ppc/int_helper.c |  90 ++++++-----
 target/ppc/translate.c  | 396 +++++++++++++++++++++++++++++++++++-------------
 4 files changed, 371 insertions(+), 156 deletions(-)

-- 
2.7.4
