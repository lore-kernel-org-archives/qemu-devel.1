Received: from eggs.gnu.org ([2001:4830:134:3::10]:52963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzfZl-0005IN-PT
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzfZg-0006Ah-Pz
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:02:45 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:55801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dzfZg-00069t-Ix
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:02:40 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C047312F795
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 11:02:36 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 04 Oct 2017 11:02:31 +0200
Message-ID: <150710775137.16096.2606042109300213433.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: sanity check size of the CAS buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

The CAS buffer is provided by SLOF. A broken SLOF could pass a silly
size: either smaller than the diff header, in which case the current
code will try to allocate 16 Exabytes of memory and g_malloc0() will
abort, or bigger than the maximum memory provisioned for SLOF (ie,
40 Megabytes), which doesn't make sense. Both cases indicate that
SLOF has a bug.

Let's print out an explicit error message and exit since rebooting as
we do with other errors would only result in a reset loop.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b284e0b9d43e..1a2ca8a22b6d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -819,6 +819,13 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
         return 1;
     }
 
+    if (size < sizeof(hdr) || size > FW_MAX_SIZE) {
+        error_report("SLOF provided an unexpected CAS buffer size "
+                     TARGET_FMT_lu " (min: %lu, max: %u)",
+                     size, sizeof(hdr), FW_MAX_SIZE);
+        exit(EXIT_FAILURE);
+    }
+
     size -= sizeof(hdr);
 
     /* Create skeleton */
