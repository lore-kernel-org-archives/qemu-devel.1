Received: from eggs.gnu.org ([2001:4830:134:3::10]:59778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6K-00083j-0g
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6J-0002fW-6J
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:56 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Apr 2017 15:44:35 +0200
Message-Id: <20170411134435.27271-4-mreitz@redhat.com>
In-Reply-To: <20170411134435.27271-1-mreitz@redhat.com>
References: <20170411134435.27271-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] iscsi: Fix iscsi_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Fam Zheng <famz@redhat.com>

Since d5895fcb (iscsi: Split URL into individual options), creating
qcow2 image on an iscsi LUN fails:

    qemu-img create -f qcow2 iscsi://$SERVER/$IQN/0 1G
    qemu-img: iscsi://$SERVER/$IQN/0: Could not create image: Invalid
        argument

The problem is iscsi_open now expects that transport_name, portal and
target are already parsed into structured options by
iscsi_parse_filename, but it is not called in iscsi_create.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170410075451.21329-1-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
[mreitz: Dropped now superfluous
         qdict_put(bs_options, "filename", ...)]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/iscsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 716e74abba..42fb0b019c 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2092,6 +2092,7 @@ static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
     BlockDriverState *bs;
     IscsiLun *iscsilun = NULL;
     QDict *bs_options;
+    Error *local_err = NULL;
 
     bs = bdrv_new();
 
@@ -2102,8 +2103,13 @@ static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
     iscsilun = bs->opaque;
 
     bs_options = qdict_new();
-    qdict_put(bs_options, "filename", qstring_from_str(filename));
-    ret = iscsi_open(bs, bs_options, 0, NULL);
+    iscsi_parse_filename(filename, bs_options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+    } else {
+        ret = iscsi_open(bs, bs_options, 0, NULL);
+    }
     QDECREF(bs_options);
 
     if (ret != 0) {
-- 
2.12.2
