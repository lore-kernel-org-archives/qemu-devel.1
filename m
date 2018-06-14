Received: from eggs.gnu.org ([2001:4830:134:3::10]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8T-0007IS-4T
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8O-00020U-9E
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:29 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:47829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTa8N-0001z6-Qu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:24 -0400
Received: from player157.ha.ovh.net (unknown [10.109.122.108])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 4DF6B185FB
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:50:22 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Jun 2018 23:50:11 +0200
Message-ID: <152901301117.252222.1572533397608306446.stgit@bahia.lan>
In-Reply-To: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/5] spapr_cpu_core: convert last snprintf() to
 g_strdup_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Because this is the preferred practice in QEMU.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 7e3a9e78d090..27602245fd55 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -190,7 +190,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        char id[32];
+        char *id;
         CPUState *cs;
         PowerPCCPU *cpu;
 
@@ -208,8 +208,9 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         /* Set NUMA node for the threads belonged to core  */
         cpu->node_id = sc->node_id;
 
-        snprintf(id, sizeof(id), "thread[%d]", i);
+        id = g_strdup_printf("thread[%d]", i);
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
+        g_free(id);
         if (local_err) {
             goto err;
         }
