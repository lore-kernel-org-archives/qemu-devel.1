Received: from eggs.gnu.org ([2001:4830:134:3::10]:34448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKh9Z-00036J-AN
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKh9V-0001HU-Bz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:26:21 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:34286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKh9V-0001HI-5g
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:26:17 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 51750105B15
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 10:26:15 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 13 Jun 2017 10:26:02 +0200
Message-ID: <149734236294.28467.16891018961029258858.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: exit gentfully when CPU doesn't support
 requested compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

QEMU currently aborts if the user asks something unrealistic like power9
compat mode with a POWER8 CPU for example. Since this isn't a bug in QEMU,
there's no point in aborting. The same goes with the other possible error
paths in ppc_set_compat_all(). Let's just terminate QEMU instead.

Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b2217f39eeea..d0cc124935c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1345,7 +1345,7 @@ static void ppc_spapr_reset(void)
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas = spapr_ovec_new();
 
-        ppc_set_compat_all(spapr->max_compat_pvr, &error_abort);
+        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
     }
 
     fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
