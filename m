Received: from eggs.gnu.org ([2001:4830:134:3::10]:41447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxUAB-0001xx-5S
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxUAA-0002VJ-Df
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:55:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 15:54:51 +0800
Message-Id: <20170410075451.21329-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] iscsi: Fix iscsi_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Since d5895fcb (iscsi: Split URL into individual options), creating
qcow2 image on an iscsi LUN fails:

    qemu-img create -f qcow2 iscsi://$SERVER/$IQN/0 1G
    qemu-img: iscsi://$SERVER/$IQN/0: Could not create image: Invalid
        argument

The problem is iscsi_open now expects that transport_name, portal and
target are already parsed into structured options by
iscsi_parse_filename, but it is not called in iscsi_create.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/iscsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 716e74a..07596b5 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2092,6 +2092,7 @@ static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
     BlockDriverState *bs;
     IscsiLun *iscsilun = NULL;
     QDict *bs_options;
+    Error *local_err = NULL;
 
     bs = bdrv_new();
 
@@ -2103,7 +2104,13 @@ static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
 
     bs_options = qdict_new();
     qdict_put(bs_options, "filename", qstring_from_str(filename));
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
2.9.3
