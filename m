Received: from eggs.gnu.org ([2001:4830:134:3::10]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2GT-0001fU-NQ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2GS-00019R-UB
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:26:21 -0400
Received: from [107.173.13.209] (port=50372 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2GS-00019G-NM
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:26:20 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 30 Apr 2018 16:25:36 +1000
Message-Id: <20180430062536.49077-3-aik@ozlabs.ru>
In-Reply-To: <20180430062536.49077-1-aik@ozlabs.ru>
References: <20180430062536.49077-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 2/2] object: Handle objects with no
 parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

At the moment object_get_canonical_path_component() crashes on assert()
if the object does not have a parent. Usually it is not called for
orphan objects but various HMP/QMP commands can do that (info mtree,
qom-get).

This adds few more tests in object_get_canonical_path() to prevent QEMU
from crashing.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 4677951..e0e300b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1668,7 +1668,7 @@ gchar *object_get_canonical_path(Object *obj)
     Object *root = object_get_root();
     char *newpath, *path = NULL;
 
-    while (obj != root) {
+    while (obj && obj->parent && obj != root) {
         char *component = object_get_canonical_path_component(obj);
 
         if (path) {
-- 
2.11.0
