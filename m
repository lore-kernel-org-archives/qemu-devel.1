Received: from eggs.gnu.org ([209.51.188.92]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hE0Az-0002SN-1v
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hE0Ay-0008ST-8K
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hE0Ay-0008S2-0U
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 909D43018ECF
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 23:20:09 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
Date: Tue,  9 Apr 2019 19:19:57 -0400
Message-Id: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: savevm: fix error code with
 migration blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Cole Robinson <crobinso@redhat.com>

The only caller that checks the error code is looking for !=3D 0,
so returning false is incorrect.

Fixes: 5aaac467938 "migration: savevm: consult migration blockers"

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 34bcad3807..a3dae4cf02 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2544,7 +2544,7 @@ int save_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
=20
     if (migration_is_blocked(errp)) {
-        return false;
+        return ret;
     }
=20
     if (!replay_can_snapshot()) {
--=20
2.21.0
