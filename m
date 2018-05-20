Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKIEY-0007pF-KF
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKIEV-0002KG-K0
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:54:22 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:15:04 +0300
Message-Id: <d29eb678bcfbb2fbf4b79423797253ee02f5c6cf.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 18/22] replace functions which are only
 available in glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org

From: Olaf Hering <olaf@aepfle.de>

Currently the minimal supported version of glib is 2.22.
Since testing is done with a glib that claims to be 2.22, but in fact
has APIs from newer version of glib, this bug was not caught during
submit of the patch referenced below.

Replace g_realloc_n, which is available only since 2.24, with g_renew.

Fixes commit 418026ca43 ("util: Introduce vfio helpers")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
CC: qemu-stable@nongnu.org
---
 util/vfio-helpers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 006674c916..1d9272efa4 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
 
     assert(index >= 0);
     s->nr_mappings++;
-    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
-                              s->nr_mappings);
+    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
     insert = &s->mappings[index];
     shift = s->nr_mappings - index - 1;
     if (shift) {
@@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
     memmove(mapping, &s->mappings[index + 1],
             sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
     s->nr_mappings--;
-    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
-                              s->nr_mappings);
+    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
 }
 
 /* Check if the mapping list is (ascending) ordered. */
-- 
2.11.0
