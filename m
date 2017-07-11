Received: from eggs.gnu.org ([2001:4830:134:3::10]:45044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUwPO-0003tK-DW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUwPN-0000xU-0q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:45:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170710193047.z2t6eww7nhckgg3z@postretch>
	<87d197mm0f.fsf@dusky.pond.sub.org>
Date: Tue, 11 Jul 2017 16:44:46 +0200
In-Reply-To: <87d197mm0f.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 11 Jul 2017 10:10:56 +0200")
Message-ID: <87wp7fghi9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v14 15/21] qom: support non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, afaerber@suse.de, berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Manos Pitsidianakis <el13635@mail.ntua.gr> writes:
>
>> Is there a specific reason this patch wasn't finished? If I'm not
>> wrong using non-scalar properties with -object is still not possible,
>> yet would be a very useful feature for drivers with UserCreatable
>> objects.
>>
>> Archive link since this is an old patch:
>> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08252.html
>
> Yes, we want non-scalar properties with -object.
>
> This series attempts to provide them by extending QemuOpts.  The trouble
> is that we've already pushed QemuOpts beyond its design limits, and this
> series pushes it some more.  We need to stop working around the design
> limits of QemuOpts and start replacing them by something that serves our
> current needs, as I explained in:
>
>     Subject: Re: [PATCH v14 00/19] QAPI/QOM work for non-scalar object properties
>     Message-ID: <87vawnnjpi.fsf@dusky.pond.sub.org>
>     https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04895.html
>
> I started the replacement work (merge commit 8746709).  It provides
> non-scalar properties for -blockdev.  I stole Dan's PATCH 07 for it,
> which became commit cbd8acf.  See also the design thread
>
>     Subject: Non-flat command line option argument syntax
>     Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
>     https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> PATCH 02-06 have been merged separately (merge commit ede0cbe).
>
> More work is needed to apply the solution for -blockdev to -object, and
> I intend to work on it.  A main difficulty is backwards compatibility to
> all the ill-designed / accidental QemuOpts warts.  We may have to accept
> some incompatibility to make progress.

Waiting for that work to be completed may be less than ideal for you.
Perhaps we can crack the simple part of the problem quickly, so you can
play with it while I still work on the harder parts.

Simple part: -object argument in JSON syntax, exactly as in QMP.
Example:

    -object '{ "qom-type": "memory-backend-ram", "id": "mem1", "props": { "size": 4096 } }'

Non-scalar members of "props" should just work there.

Hard part: non-scalar properties in the traditional KEY=VALUE syntax,
using dotted key convention.

Sketch appended.  If this would be useful for you, I can prepare proper
patches.


diff --git a/qapi-schema.json b/qapi-schema.json
index 37c4b95..82cb48d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3538,15 +3538,23 @@
 { 'command': 'netdev_del', 'data': {'id': 'str'} }
 
 ##
-# @object-add:
+# @ObjectOptions:
 #
-# Create a QOM object.
+# Options for creating an object.
 #
 # @qom-type: the class name for the object to be created
 #
 # @id: the name of the new object
 #
 # @props: a dictionary of properties to be passed to the backend
+##
+{ 'struct': 'ObjectOptions',
+  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
+
+##
+# @object-add:
+#
+# Create a QOM object.
 #
 # Returns: Nothing on success
 #          Error if @qom-type is not a valid class name
@@ -3562,7 +3570,7 @@
 #
 ##
 { 'command': 'object-add',
-  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
+  'data': 'ObjectOptions' }
 
 ##
 # @object-del:
diff --git a/vl.c b/vl.c
index d17c863..1a8a11d 100644
--- a/vl.c
+++ b/vl.c
@@ -2841,7 +2841,6 @@ static bool object_create_initial(const char *type)
     return true;
 }
 
-
 /*
  * The remainder of object creation happens after the
  * creation of chardev, fsdev, net clients and device data types.
@@ -2851,6 +2850,37 @@ static bool object_create_delayed(const char *type)
     return !object_create_initial(type);
 }
 
+typedef struct ObjectOptionsQueueEntry {
+    ObjectOptions *oo;
+    Location loc;
+    QSIMPLEQ_ENTRY(ObjectOptionsQueueEntry) entry;
+} ObjectOptionsQueueEntry;
+
+typedef QSIMPLEQ_HEAD(ObjectOptionsQueue, ObjectOptionsQueueEntry) ObjectOptionsQueue;
+
+ObjectOptionsQueue oo_queue = QSIMPLEQ_HEAD_INITIALIZER(oo_queue);
+
+
+static void object_create(bool (*type_predicate)(const char *))
+{
+    ObjectOptionsQueueEntry *e;
+
+    QSIMPLEQ_FOREACH(e, &oo_queue, entry) {
+        if (!type_predicate(e->oo->qom_type)) {
+            continue;
+        }
+        loc_push_restore(&e->loc);
+        qmp_object_add(e->oo->qom_type, e->oo->id,
+                       e->oo->has_props, e->oo->props, &error_fatal);
+        loc_pop(&e->loc);
+    }
+
+    if (qemu_opts_foreach(qemu_find_opts("object"),
+                          user_creatable_add_opts_foreach,
+                          type_predicate, NULL)) {
+        exit(1);
+    }
+}
 
 static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
                                MachineClass *mc)
@@ -4067,6 +4097,29 @@ int main(int argc, char **argv, char **envp)
 #endif
                 break;
             case QEMU_OPTION_object:
+                /*
+                 * TODO Use qobject_input_visitor_new_str() instead of
+                 * QemuOpts, not in addition to.  Not done now because
+                 * keyval_parse() isn't wart-compatible with QemuOpts.
+                 */
+                if (optarg[0] == '{') {
+                    Visitor *v;
+                    ObjectOptionsQueueEntry *e;
+
+                    v = qobject_input_visitor_new_str(optarg, "qom-type",
+                                                      &err);
+                    if (!v) {
+                        error_report_err(err);
+                        exit(1);
+                    }
+
+                    e = g_new(ObjectOptionsQueueEntry, 1);
+                    visit_type_ObjectOptions(v, NULL, &e->oo, &error_fatal);
+                    visit_free(v);
+                    loc_save(&e->loc);
+                    QSIMPLEQ_INSERT_TAIL(&oo_queue, e, entry);
+                    break;
+                }
                 opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
                                                optarg, true);
                 if (!opts) {
@@ -4386,11 +4439,7 @@ int main(int argc, char **argv, char **envp)
     page_size_init();
     socket_init();
 
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_initial, NULL)) {
-        exit(1);
-    }
+    object_create(object_create_initial);
 
     if (qemu_opts_foreach(qemu_find_opts("chardev"),
                           chardev_init_func, NULL, NULL)) {
@@ -4503,10 +4552,14 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_delayed, NULL)) {
-        exit(1);
+    object_create(object_create_delayed);
+
+    while (!QSIMPLEQ_EMPTY(&oo_queue)) {
+        ObjectOptionsQueueEntry *e = QSIMPLEQ_FIRST(&oo_queue);
+
+        QSIMPLEQ_REMOVE_HEAD(&oo_queue, entry);
+        qapi_free_ObjectOptions(e->oo);
+        g_free(e);
     }
 
 #ifdef CONFIG_TPM
