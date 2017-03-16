Received: from eggs.gnu.org ([2001:4830:134:3::10]:54816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtV-00067u-7t
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00075j-GP
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtQ-000722-4Q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E3CA437F70
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC14B5DC1D
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:42 +0100
Message-Id: <1489645685-4750-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 26/49] qapi2texi: Implement boxed
 argument documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This replaces manual references like "For the arguments, see the
documentation of ..." by a generated reference "Arguments: the members
of ...".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-25-git-send-email-armbru@redhat.com>
---
 qapi-schema.json     |  2 +-
 qapi/block-core.json | 10 ----------
 scripts/qapi2texi.py |  8 +++++++-
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index d693033..1d7b1cd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1017,7 +1017,7 @@
 ##
 # @migrate-set-parameters:
 #
-# Set various migration parameters.  See MigrationParameters for details.
+# Set various migration parameters.
 #
 # Since: 2.4
 #
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1be1ec5..0f132fc 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1341,8 +1341,6 @@
 # The operation can be stopped before it has completed using the
 # block-job-cancel command.
 #
-# For the arguments, see the documentation of DriveBackup.
-#
 # Returns: nothing on success
 #          If @device is not a valid block device, GenericError
 #
@@ -1369,8 +1367,6 @@
 # The operation can be stopped before it has completed using the
 # block-job-cancel command.
 #
-# For the arguments, see the documentation of BlockdevBackup.
-#
 # Returns: nothing on success
 #          If @device is not a valid block device, DeviceNotFound
 #
@@ -1458,8 +1454,6 @@
 # format of the mirror image, default is to probe if mode='existing',
 # else the format of the source.
 #
-# See DriveMirror for parameter descriptions
-#
 # Returns: nothing on success
 #          If @device is not a valid block device, GenericError
 #
@@ -1731,8 +1725,6 @@
 # the device will be removed from its group and the rest of its
 # members will not be affected. The 'group' parameter is ignored.
 #
-# See BlockIOThrottle for parameter descriptions.
-#
 # Returns: Nothing on success
 #          If @device is not a valid block device, DeviceNotFound
 #
@@ -2915,8 +2907,6 @@
 # BlockBackend will be created; otherwise, @node-name is mandatory at the top
 # level and no BlockBackend will be created.
 #
-# For the arguments, see the documentation of BlockdevOptions.
-#
 # Note: This command is still a work in progress.  It doesn't support all
 # block drivers among other things.  Stay away from it unless you want
 # to help with its development.
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index df87441..3dd0146 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -220,9 +220,15 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
         doc = self.cur_doc
         if self.out:
             self.out += '\n'
+        if boxed:
+            body = texi_body(doc)
+            body += '\n@b{Arguments:} the members of @code{%s}' % arg_type.name
+            body += texi_sections(doc)
+        else:
+            body = texi_entity(doc, 'Arguments')
         self.out += MSG_FMT(type='Command',
                             name=doc.symbol,
-                            body=texi_entity(doc, 'Arguments'))
+                            body=body)
 
     def visit_event(self, name, info, arg_type, boxed):
         doc = self.cur_doc
-- 
2.7.4
