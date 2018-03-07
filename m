Received: from eggs.gnu.org ([2001:4830:134:3::10]:46110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1etVvj-0007Fx-AD
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1etVvg-0001zB-5O
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:04:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60596
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1etVvg-0001ys-01
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:04:12 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27A48xw040310
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 05:04:10 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjdpq0t7c-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 05:04:09 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 10:04:01 -0000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 07 Mar 2018 15:33:56 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871sgwmcc3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: [Qemu-devel] Using new TCG Vector infrastructure in PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Hi Richard,

I was working to get TCG vector support for PowerPC[1]. Started with
converting logical operations like vector AND/OR/XOR and compare
instructions. Found some inconsistency during my testing on x86 laptop
emulating PowerPC:

zero = 0000000000000000 0000000000000000 
max = ffffffffffffffff ffffffffffffffff 

1) tcg_gen_andc_vec - vandc in PPC

New API result:
andc(zero, max) -  (zero & ~max ) = 0000000000000000 0000000000000000
andc(max, zero) -  (max & ~zero ) = ffffffffffffffff ffffffffffffffff
andc(max, max)  -  (max & ~max ) = ffffffffffffffff ffffffffffffffff    -->WRONG
andc(zero, zero)-  (zero & ~zero ) = 0000000000000000 0000000000000000 

Expected result:
andc(zero, max)  (zero & ~max ) = 0000000000000000 0000000000000000 
andc(max, zero)  (max & ~zero ) = ffffffffffffffff ffffffffffffffff 
andc(max, max)   (max & ~max ) = 0000000000000000 0000000000000000 
andc(zero, zero) (zero & ~zero ) = 0000000000000000 0000000000000000 

2) tcg_gen_or_vec - vor in PPC

New API result:
(zero | max ) = 0000000000000000 0000000000000000   -----> WRONG
(max | max ) = ffffffffffffffff ffffffffffffffff 
(zero | zero ) = 0000000000000000 0000000000000000

Expected result:
(zero | max ) = ffffffffffffffff ffffffffffffffff 
(max | max ) = ffffffffffffffff ffffffffffffffff 
(zero | zero ) = 0000000000000000 0000000000000000 

3) tcg_gen_cmp_vec(TCG_COND_EQ) - vcmpequ* in PPC

New API result(all incorrect):

vcmpequb (zero == zero ) = 0000000000000000 0000000000000000 
vcmpequh (zero == zero ) = 0000000000000000 0000000000000000 
vcmpequw (zero == zero ) = 0000000000000000 0000000000000000 
vcmpequd (zero == zero ) = 0000000000000000 0000000000000000

Expected result:
vcmpequb (zero == zero ) = ffffffffffffffff ffffffffffffffff 
vcmpequh (zero == zero ) = ffffffffffffffff ffffffffffffffff 
vcmpequw (zero == zero ) = ffffffffffffffff ffffffffffffffff 
vcmpequd (zero == zero ) = ffffffffffffffff ffffffffffffffff

Do you see something that I am missing here ?

Regards,
Nikunj

1. PowerPC TCG vector infrastructure implementation
https://github.com/nikunjad/qemu/tree/ppc_vec_0
