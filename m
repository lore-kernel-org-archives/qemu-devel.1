Received: from eggs.gnu.org ([2001:4830:134:3::10]:36275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fIT0h-0008VR-2H
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fIT0g-0007bR-5m
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:00:31 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Tue, 15 May 2018 07:59:48 +0200
Message-Id: <20180515055949.6446-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] replace functions which are only available in
 glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Currently the minimal supported version of glib is 2.22.
Since testing is done with a glib that claims to be 2.22, but in fact
has APIs from newer version of glib, this bug was not caught during
submit of the patch referenced below.

Replace g_realloc_n, which is available only since 2.24, with g_renew.

Fixes commit 418026ca43 ("util: Introduce vfio helpers")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---

This must go into stable-2.12.


 util/vfio-helpers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 006674c916..5fd4f5f212 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
 
     assert(index >= 0);
     s->nr_mappings++;
-    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
-                              s->nr_mappings);
+    s->mappings = g_renew(IOVAMapping *, s->mappings, s->nr_mappings);
     insert = &s->mappings[index];
     shift = s->nr_mappings - index - 1;
     if (shift) {
@@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
     memmove(mapping, &s->mappings[index + 1],
             sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
     s->nr_mappings--;
-    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
-                              s->nr_mappings);
+    s->mappings = g_renew(IOVAMapping *, s->mappings, s->nr_mappings);
 }
 
 /* Check if the mapping list is (ascending) ordered. */
