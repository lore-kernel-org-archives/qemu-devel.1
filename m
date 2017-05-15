Received: from eggs.gnu.org ([2001:4830:134:3::10]:41775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEM9-0004Ms-2k
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEM5-0002SJ-5U
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:40:05 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:46799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAEM4-0002S2-VB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:40:01 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9CC7D1FC04
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:39:59 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 15 May 2017 13:39:55 +0200
Message-ID: <149484839512.20089.2730407279712230463.stgit@bahia.lan>
In-Reply-To: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 5/6] spapr-cpu-core: release ICP object when
 realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

While here we introduce a single error path to avoid code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4389ef4c2aef..63d160f7e010 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -147,25 +147,25 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto error;
     }
 
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
-        object_unparent(obj);
-        error_propagate(errp, local_err);
-        return;
+        goto error;
     }
 
     spapr_cpu_init(spapr, cpu, &local_err);
     if (local_err) {
-        object_unparent(obj);
-        error_propagate(errp, local_err);
-        return;
+        goto error;
     }
 
     xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
+    return;
+
+error:
+    object_unparent(obj);
+    error_propagate(errp, local_err);
 }
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
