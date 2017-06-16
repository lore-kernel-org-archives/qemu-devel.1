Received: from eggs.gnu.org ([2001:4830:134:3::10]:49534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dLuxW-00072w-NZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dLuxT-0000Wg-J9
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:22:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35292
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dLuxT-0000W7-Cn
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:22:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5GHIoZU160142
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 13:22:54 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b4k36h8r3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 13:22:53 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 16 Jun 2017 14:22:51 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 14:22:30 -0300
Message-Id: <20170616172230.22755-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr.c: consecutive 'spapr->patb_entry
 = 0' statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

In ppc_spapr_reset(), if the guest is using HPT, the code was executing:

    } else {
        spapr->patb_entry = 0;
        spapr_setup_hpt_and_vrma(spapr);
    }

And, at the end of spapr_setup_hpt_and_vrma:

    /* We're setting up a hash table, so that means we're not radix */
    spapr->patb_entry = 0;

Resulting in spapr->patb_entry being assigned to 0 twice in a row.

Given that 'spapr_setup_hpt_and_vrma' is also called inside
'spapr_check_setup_free_hpt' of spapr_hcall.c, this trivial patch removes
the 'patb_entry = 0' assignment from the 'else' clause inside ppc_spapr_reset
to avoid this behavior.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e877d45..bd31972 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1326,7 +1326,6 @@ static void ppc_spapr_reset(void)
          * Set the GR bit in PATB so that we know there is no HPT. */
         spapr->patb_entry = PATBE1_GR;
     } else {
-        spapr->patb_entry = 0;
         spapr_setup_hpt_and_vrma(spapr);
     }
 
-- 
2.9.4
