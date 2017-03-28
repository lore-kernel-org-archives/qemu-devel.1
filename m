Received: from eggs.gnu.org ([2001:4830:134:3::10]:41603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csrlH-0007jc-9C
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csrlG-00082f-82
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:06:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 28 Mar 2017 10:05:47 -0400
Message-Id: <20170328140555.3001-3-jcody@redhat.com>
In-Reply-To: <20170328140555.3001-1-jcody@redhat.com>
References: <20170328140555.3001-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 02/10] rbd: Fix to cleanly reject -drive
 without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

qemu_rbd_open() neglects to check pool and image are present.  Missing
image is caught by rbd_open(), but missing pool crashes.  Reproducer:

    $ qemu-system-x86_64 -nodefaults -drive driver=rbd,id=rbd,image=i,...
    terminate called after throwing an instance of 'std::logic_error'
      what():  basic_string::_M_construct null not valid
    Aborted (core dumped)

where ... is a working server.0.{host,port} configuration.

Doesn't affect -drive with file=..., because qemu_rbd_parse_filename()
always sets both pool and image.

Doesn't affect -blockdev, because pool and image are mandatory in the
QAPI schema.

Fix by adding the missing checks.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 1490691368-32099-3-git-send-email-armbru@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
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
2.9.3
