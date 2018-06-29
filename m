Received: from eggs.gnu.org ([2001:4830:134:3::10]:33720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumh-0007NW-Bp
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYume-0006IZ-Vq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYume-00063g-Kd
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumV-0004VM-MW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:52:56 +0100
Message-Id: <20180629145347.652-5-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/55] device_tree: Add qemu_fdt_node_unit_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

This helper allows to retrieve the paths of nodes whose name
match node-name or node-name@unit-address patterns.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1530044492-24921-2-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/device_tree.h | 16 +++++++++++
 device_tree.c                | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index e22e5bec9c3..c16fd69bc0b 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -43,6 +43,22 @@ void *load_device_tree_from_sysfs(void);
 char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
                           Error **errp);
 
+/**
+ * qemu_fdt_node_unit_path: return the paths of nodes matching a given
+ * node-name, ie. node-name and node-name@unit-address
+ * @fdt: pointer to the dt blob
+ * @name: node name
+ * @errp: handle to an error object
+ *
+ * returns a newly allocated NULL-terminated array of node paths.
+ * Use g_strfreev() to free it. If one or more nodes were found, the
+ * array contains the path of each node and the last element equals to
+ * NULL. If there is no error but no matching node was found, the
+ * returned array contains a single element equal to NULL. If an error
+ * was encountered when parsing the blob, the function returns NULL
+ */
+char **qemu_fdt_node_unit_path(void *fdt, const char *name, Error **errp);
+
 int qemu_fdt_setprop(void *fdt, const char *node_path,
                      const char *property, const void *val, int size);
 int qemu_fdt_setprop_cell(void *fdt, const char *node_path,
diff --git a/device_tree.c b/device_tree.c
index 3553819257b..6d9c9726f66 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -232,6 +232,61 @@ static int findnode_nofail(void *fdt, const char *node_path)
     return offset;
 }
 
+char **qemu_fdt_node_unit_path(void *fdt, const char *name, Error **errp)
+{
+    char *prefix =  g_strdup_printf("%s@", name);
+    unsigned int path_len = 16, n = 0;
+    GSList *path_list = NULL, *iter;
+    const char *iter_name;
+    int offset, len, ret;
+    char **path_array;
+
+    offset = fdt_next_node(fdt, -1, NULL);
+
+    while (offset >= 0) {
+        iter_name = fdt_get_name(fdt, offset, &len);
+        if (!iter_name) {
+            offset = len;
+            break;
+        }
+        if (!strcmp(iter_name, name) || g_str_has_prefix(iter_name, prefix)) {
+            char *path;
+
+            path = g_malloc(path_len);
+            while ((ret = fdt_get_path(fdt, offset, path, path_len))
+                  == -FDT_ERR_NOSPACE) {
+                path_len += 16;
+                path = g_realloc(path, path_len);
+            }
+            path_list = g_slist_prepend(path_list, path);
+            n++;
+        }
+        offset = fdt_next_node(fdt, offset, NULL);
+    }
+    g_free(prefix);
+
+    if (offset < 0 && offset != -FDT_ERR_NOTFOUND) {
+        error_setg(errp, "%s: abort parsing dt for %s node units: %s",
+                   __func__, name, fdt_strerror(offset));
+        for (iter = path_list; iter; iter = iter->next) {
+            g_free(iter->data);
+        }
+        g_slist_free(path_list);
+        return NULL;
+    }
+
+    path_array = g_new(char *, n + 1);
+    path_array[n--] = NULL;
+
+    for (iter = path_list; iter; iter = iter->next) {
+        path_array[n--] = iter->data;
+    }
+
+    g_slist_free(path_list);
+
+    return path_array;
+}
+
 char **qemu_fdt_node_path(void *fdt, const char *name, char *compat,
                           Error **errp)
 {
-- 
2.17.1
