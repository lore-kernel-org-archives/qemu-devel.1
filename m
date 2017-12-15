Received: from eggs.gnu.org ([2001:4830:134:3::10]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePkzN-0007Dv-6P
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePkzJ-0001IN-EU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:05:01 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Dec 2017 16:04:45 +0800
Message-Id: <20171215080446.10671-2-famz@redhat.com>
In-Reply-To: <20171215080446.10671-1-famz@redhat.com>
References: <20171215080446.10671-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block: Open backing image in force share
 mode for size probe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Management tools create overlays of running guests with qemu-img:

  $ qemu-img create -b /image/in/use.qcow2 -f qcow2 /overlay/image.qcow2

but this doesn't work anymore due to image locking:

    qemu-img: /overlay/image.qcow2: Failed to get shared "write" lock
    Is another process using the image?
    Could not open backing image to determine size.
Use the force share option to allow this use case again.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 9a1a0d1e73..f236431da1 100644
--- a/block.c
+++ b/block.c
@@ -4593,10 +4593,11 @@ void bdrv_img_create(const char *filename, const char *fmt,
         back_flags = flags;
         back_flags &= ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING);
 
+        backing_options = qdict_new();
         if (backing_fmt) {
-            backing_options = qdict_new();
             qdict_put_str(backing_options, "driver", backing_fmt);
         }
+        qdict_put_bool(backing_options, BDRV_OPT_FORCE_SHARE, true);
 
         bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
                        &local_err);
-- 
2.14.3
