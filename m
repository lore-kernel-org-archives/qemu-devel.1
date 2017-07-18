Received: from eggs.gnu.org ([2001:4830:134:3::10]:58140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7W-00056w-A0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7U-00018G-R9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXZ7U-00017h-IP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9250D61BBB
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3420E5F912
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 22:29:15 +0200
Message-Id: <1500409760-20730-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1500409760-20730-1-git-send-email-armbru@redhat.com>
References: <1500409760-20730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] block: Use JSON null instead of "" to
 disable backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

BlockdevRef is an alternate of BlockdevOptions (inline definition) and
str (reference to an existing block device by name).  BlockdevRef
value "" is special: "no block device should be referenced."  It's
actually interpreted that way in just one place: optional member
@backing of COW formats.  Semantics:

* Present means "use this block device" as backing storage

* Absent means "default to the one stored in the image"

* Except "" means "don't use backing storage at all"

The first two are perfectly normal: when the parameter is absent, it
defaults to an implied value, but the value's meaning is the same.

The third one overloads the parameter with a second meaning.  The
overloading is *implicit*, i.e. it's not visible in the types.  Works
here, because "" is not a value block device ID.

Pressing argument values the schema accepts, but are semantically
invalid, into service to mean "do something else entirely" is not
general, as suitable invalid values need not exist.  I also find it
ugly.

To clean this up, we could add a separate flag argument to suppress
@backing, or add a distinct value to @backing.  This commit implements
the latter: add JSON null to the values of @backing, deprecate "".

Because we're so close to the 2.10 freeze, implement it in the
stupidest way possible: have qmp_blockdev_add() rewrite null to ""
before anything else can see the null.  Works, because BlockdevRef
occurs only within arguments of blockdev-add.  The proper way to do it
would be rewriting "" to null, preferably in a cleaner way, but that
requires fixing up code to work with null.  Add a TODO comment for
that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c             | 14 ++++++++++++++
 qapi/block-core.json   | 29 ++++++++++++++++++++++-------
 tests/qemu-iotests/085 |  2 +-
 tests/qemu-iotests/139 |  2 +-
 4 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 9c6dd27..1c42699 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3886,6 +3886,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
     QObject *obj;
     Visitor *v = qobject_output_visitor_new(&obj);
     QDict *qdict;
+    const QDictEntry *ent;
     Error *local_err = NULL;
 
     visit_type_BlockdevOptions(v, NULL, &options, &local_err);
@@ -3899,6 +3900,19 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
 
     qdict_flatten(qdict);
 
+    /*
+     * Rewrite "backing": null to "backing": ""
+     * TODO Rewrite "" to null instead, and perhaps not even here
+     */
+    for (ent = qdict_first(qdict); ent; ent = qdict_next(qdict, ent)) {
+        char *dot = strrchr(ent->key, '.');
+
+        if (!strcmp(dot ? dot + 1 : ent->key, "backing")
+            && qobject_type(ent->value) == QTYPE_QNULL) {
+            qdict_put(qdict, ent->key, qstring_new());
+        }
+    }
+
     if (!qdict_get_try_str(qdict, "node-name")) {
         error_setg(errp, "'node-name' must be specified for the root node");
         goto fail;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c437aa5..4088041 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2266,15 +2266,14 @@
 # besides their data source and an optional backing file.
 #
 # @backing:     reference to or definition of the backing file block
-#               device (if missing, taken from the image file content). It is
-#               allowed to pass an empty string here in order to disable the
-#               default backing file.
+#               device, null disables the backing file entirely.
+#               Defaults to the backing file stored the image file.
 #
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsGenericCOWFormat',
   'base': 'BlockdevOptionsGenericFormat',
-  'data': { '*backing': 'BlockdevRef' } }
+  'data': { '*backing': 'BlockdevRefOrNull' } }
 
 ##
 # @Qcow2OverlapCheckMode:
@@ -3113,9 +3112,7 @@
 # Reference to a block device.
 #
 # @definition:      defines a new block device inline
-# @reference:       references the ID of an existing block device. An
-#                   empty string means that no block device should be
-#                   referenced.
+# @reference:       references the ID of an existing block device
 #
 # Since: 2.9
 ##
@@ -3124,6 +3121,24 @@
             'reference': 'str' } }
 
 ##
+# @BlockdevRefOrNull:
+#
+# Reference to a block device.
+#
+# @definition:      defines a new block device inline
+# @reference:       references the ID of an existing block device.
+#                   An empty string means that no block device should
+#                   be referenced.  Deprecated; use null instead.
+# @null:            No block device should be referenced (since 2.10)
+#
+# Since: 2.9
+##
+{ 'alternate': 'BlockdevRefOrNull',
+  'data': { 'definition': 'BlockdevOptions',
+            'reference': 'str',
+            'null': 'null' } }
+
+##
 # @blockdev-add:
 #
 # Creates a new block device. If the @id option is given at the top level, a
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index b97adcd..76e10aa 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -106,7 +106,7 @@ function add_snapshot_image()
     snapshot_file="${TEST_DIR}/${1}-${snapshot_virt0}"
     _make_test_img -b "${base_image}" "$size"
     mv "${TEST_IMG}" "${snapshot_file}"
-    do_blockdev_add "$1" "'backing': '', " "${snapshot_file}"
+    do_blockdev_add "$1" "'backing': null, " "${snapshot_file}"
 }
 
 # ${1}: unique identifier for the snapshot filename
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 175d8f0..b2f14db 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -69,7 +69,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                          '-b', base_img, new_img, '1M')
         opts = {'driver': iotests.imgfmt,
                 'node-name': node,
-                'backing': '',
+                'backing': None,
                 'file': {'driver': 'file',
                          'filename': new_img}}
         result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-- 
2.7.5
