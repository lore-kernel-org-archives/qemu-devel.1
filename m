Received: from eggs.gnu.org ([2001:4830:134:3::10]:41138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAst-0002rB-BX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAss-0001JZ-B5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:59 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAss-0001JC-42
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:58 -0400
Received: by mail-wm0-x241.google.com with SMTP id j5-v6so24175698wme.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:14:58 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-189-60.clienti.tiscali.it.
	[78.12.189.60]) by smtp.gmail.com with ESMTPSA id
	c15-v6sm14020129edr.78.2018.05.08.15.14.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 08 May 2018 15:14:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:22 +0200
Message-Id: <1525817687-34620-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/30] qom: allow
 object_get_canonical_path_component without parent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just return NULL; any callers that cause a change in behavior
would have caused an assertion failure before, so this is safe.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 1 +
 qom/object.c         | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 96ce81b..a0c78c7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1302,6 +1302,7 @@ Object *object_get_internal_root(void);
  *
  * Returns: The final component in the object's canonical path.  The canonical
  * path is the path within the composition tree starting from the root.
+ * %NULL if the object doesn't have a parent (and thus a canonical path).
  */
 gchar *object_get_canonical_path_component(Object *obj);
 
diff --git a/qom/object.c b/qom/object.c
index 76a89af..0fc9720 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1644,8 +1644,9 @@ gchar *object_get_canonical_path_component(Object *obj)
     ObjectProperty *prop = NULL;
     GHashTableIter iter;
 
-    g_assert(obj);
-    g_assert(obj->parent != NULL);
+    if (obj->parent == NULL) {
+        return NULL;
+    }
 
     g_hash_table_iter_init(&iter, obj->parent->properties);
     while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
-- 
1.8.3.1
