Received: from eggs.gnu.org ([2001:4830:134:3::10]:59864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfe-0005cx-Gd
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfd-00034E-DW
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:34 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Dec 2016 14:23:11 +0100
Message-Id: <1481203391-9523-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 6/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, berrange@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This adds blockdev-add support for iscsi devices.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c        | 14 ++++++----
 qapi/block-core.json | 74 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 29191f2..6a11cdd 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1281,13 +1281,13 @@ static void apply_header_digest(struct iscsi_context *iscsi, QemuOpts *opts,
     digest = qemu_opt_get(opts, "header-digest");
     if (!digest) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
-    } else if (!strcmp(digest, "CRC32C")) {
+    } else if (!strcmp(digest, "crc32c")) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_CRC32C);
-    } else if (!strcmp(digest, "NONE")) {
+    } else if (!strcmp(digest, "none")) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE);
-    } else if (!strcmp(digest, "CRC32C-NONE")) {
+    } else if (!strcmp(digest, "crc32c-none")) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_CRC32C_NONE);
-    } else if (!strcmp(digest, "NONE-CRC32C")) {
+    } else if (!strcmp(digest, "none-crc32c")) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
     } else {
         error_setg(errp, "Invalid header-digest setting : %s", digest);
@@ -1555,7 +1555,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 
     header_digest = qemu_opt_get(opts, "header-digest");
     if (header_digest) {
-        qdict_set_default_str(options, "header-digest", header_digest);
+        /* -iscsi takes upper case values, but QAPI only supports lower case
+         * enum constant names, so we have to convert here. */
+        char *qapi_value = g_ascii_strdown(header_digest, -1);
+        qdict_set_default_str(options, "header-digest", qapi_value);
+        g_free(qapi_value);
     }
 
     timeout = qemu_opt_get(opts, "timeout");
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c29bef7..95a8d23 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1721,10 +1721,10 @@
 { 'enum': 'BlockdevDriver',
   'data': [ 'archipelago', 'blkdebug', 'blkverify', 'bochs', 'cloop',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
-            'host_device', 'http', 'https', 'luks', 'nbd', 'nfs', 'null-aio',
-            'null-co', 'parallels', 'qcow', 'qcow2', 'qed', 'quorum', 'raw',
-            'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
-            'vvfat' ] }
+            'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
+            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
+            'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
+            'vpc', 'vvfat' ] }
 
 ##
 # @BlockdevOptionsFile
@@ -2209,6 +2209,70 @@
             '*logfile': 'str' } }
 
 ##
+# @IscsiTransport
+#
+# An enumeration of libiscsi transport types
+#
+# Since: 2.9
+##
+{ 'enum': 'IscsiTransport',
+  'data': [ 'tcp', 'iser' ] }
+
+##
+# @IscsiHeaderDigest
+#
+# An enumeration of header digests supported by libiscsi
+#
+# Since: 2.9
+##
+{ 'enum': 'IscsiHeaderDigest',
+  'prefix': 'QAPI_ISCSI_HEADER_DIGEST',
+  'data': [ 'crc32c', 'none', 'crc32c-none', 'none-crc32c' ] }
+
+##
+# @BlockdevOptionsIscsi
+#
+# @transport        The iscsi transport type
+#
+# @portal           The address of the iscsi portal
+#
+# @target           The target iqn name
+#
+# @lun              #optional LUN to connect to. Defaults to 0.
+#
+# @user             #optional User name to log in with. If omitted, no CHAP
+#                   authentication is performed.
+#
+# @password-secret  #optional The ID of a QCryptoSecret object providing
+#                   the password for the login. This option is required if 
+#                   @user is specified.
+#
+# @initiator-name   #optional The iqn name we want to identify to the target
+#                   as. If this option is not specified, an initiator name is
+#                   generated automatically.
+#
+# @header-digest    #optional The desired header digest. Defaults to
+#                   none-crc32c.
+#
+# @timeout          #optional Timeout in seconds after which a request will
+#                   timeout. 0 means no timeout and is the default.
+#
+# Driver specific block device options for iscsi
+#
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsIscsi',
+  'data': { 'transport': 'IscsiTransport',
+            'portal': 'str',
+            'target': 'str',
+            '*lun': 'int',
+            '*user': 'str',
+            '*password-secret': 'str',
+            '*initiator-name': 'str',
+            '*header-digest': 'IscsiHeaderDigest',
+            '*timeout': 'int' } }
+
+##
 # @ReplicationMode
 #
 # An enumeration of replication modes.
@@ -2394,7 +2458,7 @@
       'host_device':'BlockdevOptionsFile',
       'http':       'BlockdevOptionsCurl',
       'https':      'BlockdevOptionsCurl',
-# TODO iscsi: Wait for structured options
+      'iscsi':      'BlockdevOptionsIscsi',
       'luks':       'BlockdevOptionsLUKS',
       'nbd':        'BlockdevOptionsNbd',
       'nfs':        'BlockdevOptionsNfs',
-- 
1.8.3.1
