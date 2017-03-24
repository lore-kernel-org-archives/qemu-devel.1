Received: from eggs.gnu.org ([2001:4830:134:3::10]:36585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGa-0006sX-Vo
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGX-0001gw-Pz
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crTGX-0001gS-JC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57296A3277
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:44:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Mar 2017 18:44:35 +0100
Message-Id: <1490377482-13337-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-1-git-send-email-armbru@redhat.com>
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 2/9] rbd: Fix to cleanly reject -drive
 without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

qemu_rbd_open() neglects to check pool and image are present.
Reproducer:

    $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,pool=p
    Segmentation fault (core dumped)
    $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,image=i
    qemu-system-x86_64: -drive if=none,driver=rbd,image=i: error opening pool (null)

Doesn't affect -drive with file=..., because qemu_rbd_parse_filename()
always sets both pool and image.

Doesn't affect -blockdev, because pool and image are mandatory in the
QAPI schema.

Fix by adding the missing checks.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ee13f3d..5ba2a87 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -711,6 +711,12 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     name           = qemu_opt_get(opts, "image");
     keypairs       = qemu_opt_get(opts, "keyvalue-pairs");
 
+    if (!pool || !name) {
+        error_setg(errp, "Parameters 'pool' and 'image' are required");
+        r = -EINVAL;
+        goto failed_opts;
+    }
+
     r = rados_create(&s->cluster, clientname);
     if (r < 0) {
         error_setg_errno(errp, -r, "error initializing");
@@ -718,9 +724,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->snap = g_strdup(snap);
-    if (name) {
-        pstrcpy(s->name, RBD_MAX_IMAGE_NAME_SIZE, name);
-    }
+    pstrcpy(s->name, RBD_MAX_IMAGE_NAME_SIZE, name);
 
     /* try default location when conf=NULL, but ignore failure */
     r = rados_conf_read_file(s->cluster, conf);
-- 
2.7.4
