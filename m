Received: from eggs.gnu.org ([2001:4830:134:3::10]:52380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hd-0000bn-Co
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hZ-0002nD-HM
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  4 Jan 2018 11:40:41 -0300
Message-Id: <20180104144046.30793-2-f4bug@amsat.org>
In-Reply-To: <20180104144046.30793-1-f4bug@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/6] qom: introduce TypeInfo name aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qom/object.h |  3 +++
 qom/object.c         | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index dc73d59660..5d6e8795d4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -428,6 +428,8 @@ struct Object
  * TypeInfo:
  * @name: The name of the type.
  * @parent: The name of the parent type.
+ * @aliases: A list of alias names for the type. This should point to a static
+ *   array that's terminated with a zero filled element.
  * @instance_size: The size of the object (derivative of #Object).  If
  *   @instance_size is 0, then the size of the object will be the size of the
  *   parent object.
@@ -468,6 +470,7 @@ struct TypeInfo
 {
     const char *name;
     const char *parent;
+    const char **aliases;
 
     size_t instance_size;
     void (*instance_init)(Object *obj);
diff --git a/qom/object.c b/qom/object.c
index c58c52d518..c532a8aa65 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -83,10 +83,15 @@ static GHashTable *type_table_get(void)
 
 static bool enumerating_types;
 
-static void type_table_add(TypeImpl *ti)
+static void type_table_add_with_key(TypeImpl *ti, const char *key_name)
 {
     assert(!enumerating_types);
-    g_hash_table_insert(type_table_get(), (void *)ti->name, ti);
+    g_hash_table_insert(type_table_get(), (void *)key_name, ti);
+}
+
+static void type_table_add(TypeImpl *ti)
+{
+    type_table_add_with_key(ti, ti->name);
 }
 
 static TypeImpl *type_table_lookup(const char *name)
@@ -137,6 +142,15 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
     ti = type_new(info);
 
     type_table_add(ti);
+
+    if (info->aliases) {
+        int i;
+
+        for (i = 0; info->aliases[i]; i++) {
+            type_table_add_with_key(ti, info->aliases[i]);
+        }
+    }
+
     return ti;
 }
 
-- 
2.15.1
