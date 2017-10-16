Received: from eggs.gnu.org ([2001:4830:134:3::10]:51923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDw-0006fC-7i
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDt-0006Q2-3u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:40 +0300
Message-Id: <aa1530dec499f7525d2ccaa0e3a876dc8089ed1e.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 13/14] filter-mirror: segfault when specifying
 non existent device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eduardo Otubo <otubo@redhat.com>

When using filter-mirror like the example below where the interface
'ndev0' does not exist on the host, QEMU crashes into segmentation
fault.

 $ qemu-system-x86_64 -S -machine pc -netdev user,id=ndev0 -object filter-mirror,id=test-object,netdev=ndev0

This happens because the function filter_mirror_setup() does not check
if the device actually exists and still keep on processing calling
qemu_chr_find(). This patch fixes this issue.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
