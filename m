Received: from eggs.gnu.org ([2001:4830:134:3::10]:33437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2zd-0003CG-Fb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2zZ-00016f-G0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV2zZ-0000zr-4u
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CA5930014C4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:36 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-16.ams2.redhat.com
	[10.36.112.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D2D8762675
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  7 Dec 2018 00:23:28 +0100
Message-Id: <20181206232333.22408-2-pbonzini@redhat.com>
In-Reply-To: <20181206232333.22408-1-pbonzini@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] qemu/queue.h: do not access tqe_prev
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use the QTAILQ_IN_USE macro instead, it does the same thing but the next
patch will change it to a different definition.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 81f95d920b..7604b2183b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4259,7 +4259,7 @@ void qmp_blockdev_del(const char *node_name, Error =
**errp)
         goto out;
     }
=20
-    if (!bs->monitor_list.tqe_prev) {
+    if (!QTAILQ_IN_USE(bs, monitor_list)) {
         error_setg(errp, "Node %s is not owned by the monitor",
                    bs->node_name);
         goto out;
--=20
2.19.2
