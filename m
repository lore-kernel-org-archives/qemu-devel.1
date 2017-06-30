Received: from eggs.gnu.org ([2001:4830:134:3::10]:34476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRn-0008Vp-0G
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRl-0007xv-UI
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:25 +1000
Message-Id: <20170630104632.27942-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/21] hw/ppc/spapr.c: consecutive
 'spapr->patb_entry = 0' statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ef944f7..3c12af0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1376,7 +1376,6 @@ static void ppc_spapr_reset(void)
          * Set the GR bit in PATB so that we know there is no HPT. */
         spapr->patb_entry = PATBE1_GR;
     } else {
-        spapr->patb_entry = 0;
         spapr_setup_hpt_and_vrma(spapr);
     }
 
-- 
2.9.4
