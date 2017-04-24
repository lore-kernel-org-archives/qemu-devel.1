Received: from eggs.gnu.org ([2001:4830:134:3::10]:53628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOs-0003zU-1L
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOq-0006xZ-9n
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOq-0006xC-2z
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17AB37F4A5
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:58 +0200
Message-Id: <1493018820-23445-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] migration: Make errp the last parameter
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
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-13-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.7.4
