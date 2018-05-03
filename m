Received: from eggs.gnu.org ([2001:4830:134:3::10]:37493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELb0-0001aF-R1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELay-0000H3-3N
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:58 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:34657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fELax-0000FU-Qb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:56 -0400
Received: from player691.ha.ovh.net (unknown [10.109.122.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 62214F2FF6
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 23:16:54 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 03 May 2018 23:16:48 +0200
Message-ID: <152538220809.223014.13271851558592478609.stgit@bahia.lan>
In-Reply-To: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] spapr: don't migrate
 "spapr_option_vector_ov5_cas" to pre 2.8 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

a324d6f16697 "spapr: Support ibm,dynamic-memory-v2 property" added
a new feature in the set of CAS-negotiatable options. This causes
the CAS-negotiated options subsection to be migrated, even for old
machine types that don't know about it, and breaks backward migration
to QEMU 2.7 and older versions:

qemu-system-ppc64: error while loading state for instance 0x0 of device
 'spapr'
qemu-system-ppc64: load of migration failed: No such file or directory

Since this feature only affects boot time behaviour, it should be
filtered out when we decide to migrate CAS-negotiated options, like
we already do with OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b35aff5d811c..eb9d087d1a60 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1851,10 +1851,12 @@ static bool spapr_ov5_cas_needed(void *opaque)
      *
      * Thus, for any cases where the set of available CAS-negotiatable
      * options extends beyond OV5_FORM1_AFFINITY and OV5_DRCONF_MEMORY, we
-     * include the CAS-negotiated options in the migration stream.
+     * include the CAS-negotiated options in the migration stream, unless
+     * if they affect boot time behaviour only.
      */
     spapr_ovec_set(ov5_mask, OV5_FORM1_AFFINITY);
     spapr_ovec_set(ov5_mask, OV5_DRCONF_MEMORY);
+    spapr_ovec_set(ov5_mask, OV5_DRMEM_V2);
 
     /* spapr_ovec_diff returns true if bits were removed. we avoid using
      * the mask itself since in the future it's possible "legacy" bits may be
