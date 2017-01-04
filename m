Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpy-0006ym-Cu
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpv-00008c-8s
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36031
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpv-00008C-1f
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:19 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J491050357
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:18 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rpyddqs7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:18 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:16 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:39 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-6-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 05/13] 9pfs: fix crash when fsdev is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

If the user passes -device virtio-9p without the corresponding -fsdev, QEMU
dereferences a NULL pointer and crashes.

This is a 2.8 regression introduced by commit 702dbcc274e2c.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
---
 hw/9pfs/9p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 97c2926aae50..fa58877570f6 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3525,7 +3525,7 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
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
