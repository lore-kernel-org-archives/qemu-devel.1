Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSmfv-0003jN-UD
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSmfs-0007r6-Ri
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:01:44 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:49222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fSmfs-0007q2-LJ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:01:40 -0400
Received: from player760.ha.ovh.net (unknown [10.109.122.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6460AE4437
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 19:01:38 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Jun 2018 19:01:26 +0200
Message-ID: <152882288685.114328.8550617676763950480.stgit@bahia.lan>
In-Reply-To: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] spapr: fix leak in
 h_client_architecture_support()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

If the negotiated compat mode can't be set, but raw mode is supported,
we decide to ignore the error. An so, we should free it to prevent a
memory leak.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 022f6d810182..8b9a4b577fbf 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1547,6 +1547,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                 error_report_err(local_err);
                 return H_HARDWARE;
             }
+            error_free(local_err);
             local_err = NULL;
         }
     }
