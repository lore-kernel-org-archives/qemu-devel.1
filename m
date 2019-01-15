Received: from eggs.gnu.org ([209.51.188.92]:53137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gjTIx-0005E5-4H
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gjTIv-0005BY-C0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:19:15 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gjTIv-0005AF-0g
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:19:13 -0500
Received: by mail-wm1-x335.google.com with SMTP id t200so4295218wmt.0
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:19:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Jan 2019 19:19:04 +0100
Message-Id: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] qtest driver framework (core only)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com

As promised, this is the implementation of the core qtest driver
framework API.

The diff of patch 5 from the previous post is at the end of the
cover letter.

Emanuele Giuseppe Esposito (3):
  tests/libqos: introduce virtio_start_device
  tests/libqos: rename qpci_init_pc and qpci_init_spapr functions
  tests: qgraph API for the qtest driver framework

Paolo Bonzini (2):
  tests: remove rule for nonexisting qdev-monitor-test
  tests/libqos: embed allocators instead of malloc-ing them separately

 configure                      |   2 +-
 include/qemu/module.h          |   2 +
 tests/Makefile.include         |  14 +-
 tests/ahci-test.c              |   6 +-
 tests/e1000e-test.c            |  22 +-
 tests/i440fx-test.c            |   2 +-
 tests/ide-test.c               |  19 +-
 tests/libqos/ahci.c            |   2 +-
 tests/libqos/libqos-pc.c       |   5 +-
 tests/libqos/libqos-spapr.c    |   5 +-
 tests/libqos/libqos.c          |  13 +-
 tests/libqos/libqos.h          |  13 +-
 tests/libqos/malloc-generic.c  |  21 +-
 tests/libqos/malloc-generic.h  |   7 +-
 tests/libqos/malloc-pc.c       |  18 +-
 tests/libqos/malloc-pc.h       |   4 +-
 tests/libqos/malloc-spapr.c    |  19 +-
 tests/libqos/malloc-spapr.h    |   4 +-
 tests/libqos/malloc.c          |  41 +--
 tests/libqos/malloc.h          |  21 +-
 tests/libqos/pci-pc.c          |   2 +-
 tests/libqos/pci-pc.h          |   9 +-
 tests/libqos/pci-spapr.c       |   2 +-
 tests/libqos/pci-spapr.h       |   2 +-
 tests/libqos/qgraph.c          | 756 +++++++++++++++++++++++++++++++++++++++++
 tests/libqos/qgraph.h          | 575 +++++++++++++++++++++++++++++++
 tests/libqos/qgraph_internal.h | 257 ++++++++++++++
 tests/libqos/virtio.c          |   7 +
 tests/libqos/virtio.h          |   1 +
 tests/libqtest.h               |   3 +
 tests/q35-test.c               |   4 +-
 tests/qos-test.c               | 449 ++++++++++++++++++++++++
 tests/rtas-test.c              |   2 +-
 tests/rtl8139-test.c           |   2 +-
 tests/sdhci-test.c             |   2 +-
 tests/tco-test.c               |   2 +-
 tests/test-qgraph.c            | 434 +++++++++++++++++++++++
 tests/usb-hcd-ehci-test.c      |   2 +-
 tests/vhost-user-test.c        |  16 +-
 tests/virtio-9p-test.c         |  16 +-
 tests/virtio-blk-test.c        |  79 +++--
 tests/virtio-net-test.c        |  14 +-
 tests/virtio-scsi-test.c       |  18 +-
 43 files changed, 2650 insertions(+), 244 deletions(-)
 create mode 100644 tests/libqos/qgraph.c
 create mode 100644 tests/libqos/qgraph.h
 create mode 100644 tests/libqos/qgraph_internal.h
 create mode 100644 tests/qos-test.c
 create mode 100644 tests/test-qgraph.c

-- 
1.8.3.1

diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
index 6a750aa..cc42641 100644
--- a/tests/libqos/qgraph.c
+++ b/tests/libqos/qgraph.c
@@ -247,7 +247,7 @@ static void create_interface(const char *node)
     if (!interface) {
         create_node(node, QNODE_INTERFACE);
     } else if (interface->type != QNODE_INTERFACE) {
-        printf("Error: Node %s is not an interface\n", node);
+        fprintf(stderr, "Error: Node %s is not an interface\n", node);
         abort();
     }
 }
@@ -265,8 +265,7 @@ static void create_interface(const char *node)
  */
 static void build_machine_cmd_line(QOSGraphNode *node, const char *args)
 {
-    char *arch, *machine;
-    qos_separate_arch_machine(node->name, &arch, &machine);
+    char *machine = qos_get_machine_type(node->name);
     if (args) {
         node->command_line = g_strconcat("-M ", machine, ",", args, NULL);
     } else {
@@ -343,7 +342,7 @@ static void qos_push(QOSGraphNode *el, QOSStackElement *parent,
 /* qos_tos(): returns the top of stack, without popping */
 static QOSStackElement *qos_tos(void)
 {
-    return &qos_node_stack[(qos_node_tos - 1)];
+    return &qos_node_stack[qos_node_tos - 1];
 }
 
 /* qos_pop(): pops an element from the tos, setting it unvisited*/
@@ -419,7 +418,7 @@ static void qos_traverse_graph(QOSGraphNode *root, QOSTestCallback callback)
                 dest_node = search_node(e->dest);
 
                 if (!dest_node) {
-                    printf("node %s in %s -> %s does not exist\n",
+                    fprintf(stderr, "node %s in %s -> %s does not exist\n",
                             e->dest, v->name, e->dest);
                     abort();
                 }
@@ -733,25 +732,24 @@ void qos_object_start_hw(QOSGraphObject *obj)
     }
 }
 
-void qos_separate_arch_machine(char *name, char **arch, char **machine)
+char *qos_get_machine_type(char *name)
 {
-    *arch = name;
     while (*name != '\0' && *name != '/') {
         name++;
     }
 
-    if (*name == '/' && (*name + 1) != '\0') {
-        *machine = name + 1;
-    } else {
-        printf("Machine name has to be of the form <arch>/<machine>\n");
+    if (!*name || !name[1]) {
+        fprintf(stderr, "Machine name has to be of the form <arch>/<machine>\n");
         abort();
     }
+
+    return name + 1;
 }
 
-void qos_delete_abstract_cmd_line(const char *name, bool abstract)
+void qos_delete_cmd_line(const char *name)
 {
     QOSGraphNode *node = search_node(name);
-    if (node && abstract) {
+    if (node) {
         g_free(node->command_line);
         node->command_line = NULL;
     }
diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index 8d68314..ccc30ee 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -243,7 +243,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
  * There are three types of command line arguments:
  * - in node      : created from the node name. For example, machines will
  *                  have "-M <machine>" to its command line, while devices
- *                  "- device <device>". It is automatically done by the
+ *                  "-device <device>". It is automatically done by the
  *                   framework.
  * - after node   : added as additional argument to the node name.
  *                  This argument is added optionally when creating edges,
@@ -466,7 +466,7 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function);
  * It also has the possibility to add optional NULL-terminated
  * @opts parameters (see %QOSGraphEdgeOptions)
  *
- * This function can be useful whrn there are multiple devices
+ * This function can be useful when there are multiple devices
  * with the same node name contained in a machine/other node
  *
  * For example, if "arm/raspi2" contains 2 "generic-sdhci"
diff --git a/tests/libqos/qgraph_internal.h b/tests/libqos/qgraph_internal.h
index 3728a25..2ef748b 100644
--- a/tests/libqos/qgraph_internal.h
+++ b/tests/libqos/qgraph_internal.h
@@ -227,32 +227,26 @@ void qos_print_graph(void);
 void qos_graph_foreach_test_path(QOSTestCallback fn);
 
 /**
- * qos_separate_arch_machine(): separate arch from machine.
+ * qos_get_machine_type(): return QEMU machine type for a machine node.
  * This function requires every machine @name to be in the form
  * <arch>/<machine_name>, like "arm/raspi2" or "x86_64/pc".
  *
- * The function will split then the string in two parts,
- * assigning @arch to point to <arch>/<machine_name>, and
- * @machine to <machine_name>.
+ * The function will validate the format and return a pointer to
+ * @machine to <machine_name>.  For example, when passed "x86_64/pc"
+ * it will return "pc".
  *
- * For example, "x86_64/pc" will be split in this way:
- * *arch = "x86_64/pc"
- * *machine = "pc"
- *
- * Note that this function *does not* allocate any new string,
- * but just sets the pointer *arch and *machine to the respective
- * part of the string.
+ * Note that this function *does not* allocate any new string.
  */
-void qos_separate_arch_machine(char *name, char **arch, char **machine);
+char *qos_get_machine_type(char *name);
 
 /**
- * qos_delete_abstract_cmd_line(): if @abstract is #TRUE, delete the
+ * qos_delete_cmd_line(): delete the
  * command line present in node mapped with key @name.
  *
  * This function is called when the QMP query returns a node with
- * { "abstract" : <boolean> } attribute.
+ * { "abstract" : true } attribute.
  */
-void qos_delete_abstract_cmd_line(const char *name, bool abstract);
+void qos_delete_cmd_line(const char *name);
 
 /**
  * qos_graph_node_set_availability(): sets the node identified
diff --git a/tests/qos-test.c b/tests/qos-test.c
index d85ed71..386c399 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -29,30 +29,19 @@
 
 static char *old_path;
 
-/**
- * create_machine_name(): appends the architecture to @name if
- * @is_machine is valid.
- */
-static void create_machine_name(const char **name, bool is_machine)
+static void apply_to_node(const char *name, bool is_machine, bool is_abstract)
 {
-    const char *arch;
-    if (!is_machine) {
-        return;
+    char *machine_name = NULL;
+    if (is_machine) {
+        const char *arch = qtest_get_arch();
+        machine_name = g_strconcat(arch, "/", name, NULL);
+        name = machine_name;
     }
-    arch = qtest_get_arch();
-    *name = g_strconcat(arch, "/", *name, NULL);
-}
-
-/**
- * destroy_machine_name(): frees the given @name if
- * @is_machine is valid.
- */
-static void destroy_machine_name(const char *name, bool is_machine)
-{
-    if (!is_machine) {
-        return;
+    qos_graph_node_set_availability(name, TRUE);
+    if (is_abstract) {
+        qos_delete_cmd_line(name);
     }
-    g_free((char *)name);
+    g_free(machine_name);
 }
 
 /**
@@ -71,7 +60,7 @@ static void apply_to_qlist(QList *list, bool is_machine)
     QDict *minfo;
     QObject *qobj;
     QString *qstr;
-    QBool *qbol;
+    QBool *qbool;
 
     for (p = qlist_first(list); p; p = qlist_next(p)) {
         minfo = qobject_to(QDict, qlist_entry_obj(p));
@@ -79,28 +68,21 @@ static void apply_to_qlist(QList *list, bool is_machine)
         qstr = qobject_to(QString, qobj);
         name = qstring_get_str(qstr);
 
-        create_machine_name(&name, is_machine);
-        qos_graph_node_set_availability(name, TRUE);
+        qobj = qdict_get(minfo, "abstract");
+        if (qobj) {
+            qbool = qobject_to(QBool, qobj);
+            abstract = qbool_get_bool(qbool);
+        } else {
+            abstract = false;
+        }
 
+        apply_to_node(name, is_machine, abstract);
         qobj = qdict_get(minfo, "alias");
         if (qobj) {
             qstr = qobject_to(QString, qobj);
-
-            destroy_machine_name(name, is_machine);
             name = qstring_get_str(qstr);
-
-            create_machine_name(&name, is_machine);
-            qos_graph_node_set_availability(name, TRUE);
-        }
-
-        qobj = qdict_get(minfo, "abstract");
-        if (qobj) {
-            qbol = qobject_to(QBool, qobj);
-            abstract = qbool_get_bool(qbol);
-            qos_delete_abstract_cmd_line(name, abstract);
+            apply_to_node(name, is_machine, abstract);
         }
-
-        destroy_machine_name(name, is_machine);
     }
 }
 
@@ -363,7 +345,6 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     char **path_vec = g_new0(char *, (QOS_PATH_MAX_ELEMENT_SIZE * 2));
     int path_vec_size = 0;
 
-    char *machine = NULL, *arch = NULL;
     char *after_cmd = NULL, *before_cmd = NULL, *after_device = NULL;
     char *node_name = orig_path->name, *path_str;
 
@@ -373,9 +354,8 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     path = qos_graph_get_node(node_name); /* root */
     node_name = qos_graph_edge_get_dest(path->path_edge); /* machine name */
 
-    qos_separate_arch_machine(node_name, &arch, &machine);
-    path_vec[path_vec_size++] = arch;
-    path_vec[path_vec_size++] = machine;
+    path_vec[path_vec_size++] = node_name;
+    path_vec[path_vec_size++] = qos_get_machine_type(node_name);
 
     for (;;) {
         path = qos_graph_get_node(node_name);
@@ -417,19 +397,19 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     g_string_free(cmd_line2, TRUE);
 
     /* here position 0 has <arch>/<machine>, position 1 has <machine>.
-     * The path must not have the <arch>
+     * The path must not have the <arch>, qtest_add_data_func adds it.
      */
     path_str = g_strjoinv("/", path_vec + 1);
 
     /* put arch/machine in position 1 so run_one_test can do its work
      * and add the command line at position 0.
      */
+    path_vec[1] = path_vec[0];
     path_vec[0] = g_string_free(cmd_line, FALSE);
-    path_vec[1] = arch;
 
     if (path->u.test.subprocess) {
         gchar *subprocess_path = g_strdup_printf("/%s/%s/subprocess",
-                                                 qtest_get_arch(), path_str);
+						 qtest_get_arch(), path_str);
         qtest_add_data_func(path_str, subprocess_path, subprocess_run_one_test);
         g_test_add_data_func(subprocess_path, path_vec, run_one_test);
     } else {
