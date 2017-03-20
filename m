Received: from eggs.gnu.org ([2001:4830:134:3::10]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Ql-0001jL-Gz
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qg-0004yK-3Z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qf-0004wx-N0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8VSF130103
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ahw0awj1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:32 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:31 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:03 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-40-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 39/81] 9pfs: fix crash when fsdev is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

If the user passes -device virtio-9p without the corresponding -fsdev, QEMU
dereferences a NULL pointer and crashes.

This is a 2.8 regression introduced by commit 702dbcc274e2c.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
(cherry picked from commit f2b58c43758efc61e2a49b899f5e58848489d0dc)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index faebd91..68725b7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3521,7 +3521,7 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
     rc = 0;
 out:
     if (rc) {
-        if (s->ops->cleanup && s->ctx.private) {
+        if (s->ops && s->ops->cleanup && s->ctx.private) {
             s->ops->cleanup(&s->ctx);
         }
         g_free(s->tag);
-- 
2.7.4
