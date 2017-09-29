Received: from eggs.gnu.org ([2001:4830:134:3::10]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dxu1e-0004Ov-6a
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dxu1U-0001NP-RB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:04:14 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 29 Sep 2017 14:03:39 +0200
Message-Id: <20170929120339.14197-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv2] filter-mirror: segfault when specifying non
 existent device
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>, lizhijian@cn.fujitsu.com
List-ID: <qemu-devel.nongnu.org>

v2:
    Removed "err:" label from the end of the function and replaced by
    two separate error messages. One when outdev is not specified and
    one when outdev does not exist.

    Fixed the error message that was referencing nf->netdev_id and not
    s->outdev.

When using filter-mirror like the example below where the interface
'ndev0' does not exist on the host, QEMU crashes into segmentation
fault.

 $ qemu-system-x86_64 -S -machine pc -netdev user,id=ndev0 -object filter-mirror,id=test-object,netdev=ndev0

This happens because the function filter_mirror_setup() does not checks
if the device actually exists and still keep on processing calling
qemu_chr_find(). This patch fixes this issue.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 net/filter-mirror.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 90e2c92337..ce0dc23c2a 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -213,6 +213,12 @@ static void filter_mirror_setup(NetFilterState *nf, Error **errp)
     MirrorState *s = FILTER_MIRROR(nf);
     Chardev *chr;
 
+    if (s->outdev == NULL) {
+        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "filter-mirror parameter"\
+                  " 'outdev' cannot be empty");
+        return;
+    }
+
     chr = qemu_chr_find(s->outdev);
     if (chr == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
-- 
2.13.5
