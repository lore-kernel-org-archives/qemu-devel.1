Received: from eggs.gnu.org ([2001:4830:134:3::10]:54262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xf0-0002R7-NP
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xez-0000qC-PT
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xez-0000ou-Jt
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FE1973056
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:36 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:08 +0800
Message-Id: <20170421122710.15373-13-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] migration: Make errp the last parameter
 of local functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 migration/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 674ccab..fe0a4b5 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -809,7 +809,7 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
  *
  * Patches are being reviewed on linux-rdma.
  */
-static int qemu_rdma_broken_ipv6_kernel(Error **errp, struct ibv_context *verbs)
+static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 {
     struct ibv_port_attr port_attr;
 
@@ -950,7 +950,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (!ret) {
             if (e->ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(errp, rdma->cm_id->verbs);
+                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs, errp);
                 if (ret) {
                     continue;
                 }
@@ -2277,7 +2277,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 }
 
 
-static int qemu_rdma_source_init(RDMAContext *rdma, Error **errp, bool pin_all)
+static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 {
     int ret, idx;
     Error *local_err = NULL, **temp = &local_err;
@@ -2469,7 +2469,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
             continue;
         }
         if (e->ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(errp, listen_id->verbs);
+            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs, errp);
             if (ret) {
                 continue;
             }
@@ -3676,8 +3676,8 @@ void rdma_start_outgoing_migration(void *opaque,
         goto err;
     }
 
-    ret = qemu_rdma_source_init(rdma, errp,
-        s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL]);
+    ret = qemu_rdma_source_init(rdma,
+        s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL], errp);
 
     if (ret) {
         goto err;
-- 
2.9.3
