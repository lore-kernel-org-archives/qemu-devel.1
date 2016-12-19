Received: from eggs.gnu.org ([2001:4830:134:3::10]:52943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cIyvL-0001PI-NA
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cIyvI-0004zt-Lm
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:28:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38420
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cIyvI-0004z2-EU
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:28:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJENWOi010078
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 09:28:14 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27egyu9dan-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 09:28:14 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 19 Dec 2016 07:28:13 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 19 Dec 2016 15:28:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148215768690.13973.9042496691140000163.stgit@bahia>
Subject: [Qemu-devel] [PATCH] 9pfs: fix crash when fsdev is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, liq3ea@gmail.com, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

If the user passes -device virtio-9p without the corresponding -fsdev, QEMU
dereferences a NULL pointer and crashes.

This is a 2.8 regression introduced by commit 702dbcc274e2c.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index faebd91f5fab..68725b7a1c97 100644
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
