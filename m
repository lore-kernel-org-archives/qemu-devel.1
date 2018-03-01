Received: from eggs.gnu.org ([2001:4830:134:3::10]:58297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1erQZj-0001Lq-Pg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1erQZf-0002GM-TJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:56:55 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1erQZf-0002Ed-IF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:56:51 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Thu,  1 Mar 2018 16:56:15 +0100
Message-Id: <20180301155619.8640-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH v2 0/4] tricore: added small features + fixed
 wrong masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Hi Bastian,

thank you for your feedback and sorry for the late reply.

Changes from v1:
 * Removed OPC1_16_SB_JNE instruction.
 * Added CPU feature checks to new instructions.
 * Renamed ICR.IE and PCXI.PIE masks and added corresponding TC 1.6 masks.
 * Squashed patch 4/5 and 5/5.

>From the previous implementation I was unable to see that there are architecture differences between TriCore version 1.3 and version 1.6 (e.g. the masking of ICR.IE and PCXI.PIE).
I did not correct the situation technically but with this patch set one will be able to recognize the differences. 

My plan is to correct this issue in a future patch series. Inspecting the code I recognized that changing only the bit mask of ICR.IE and PCXI.PIE depending on the processor version would not solve the problem since also the shifting often used in that context depends on the architecure (e.g. in op_helper.c /* PCXI.PIE = ICR.IE */). 
Therefore I would create functions for the storing and restoring of ICR.IE. These functions would have different implementations for the given processor versions.

Best regards

David Brenken
 
 
David Brenken (4):
  tricore: added some missing cpu instructions
  tricore: added CORE_ID
  tricore: renamed masking of IE
  tricore: renamed masking of PIE

 target/tricore/cpu.h             |  7 +++++--
 target/tricore/csfr.def          |  1 +
 target/tricore/op_helper.c       | 29 +++++++++++++++--------------
 target/tricore/translate.c       | 31 +++++++++++++++++++++++++++++--
 target/tricore/tricore-opcodes.h |  3 +++
 5 files changed, 53 insertions(+), 18 deletions(-)

-- 
2.7.4
