Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9261C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABED2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABED2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxzpn-0006Cs-FA
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznS-0004AS-Uc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznR-000468-7V
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxznJ-0003zU-W9; Wed, 14 Aug 2019 16:22:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1FF9970EB;
 Wed, 14 Aug 2019 20:22:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BAC910002BA;
 Wed, 14 Aug 2019 20:22:48 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:13 +0300
Message-Id: <20190814202219.1870-8-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 14 Aug 2019 20:22:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/13] block: add manage-encryption command
 (qmp and blockdev)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds:

* x-blockdev-update-encryption and x-blockdev-erase-encryption qmp commands
  Both commands take the QCryptoKeyManageOptions
  the x-blockdev-update-encryption is meant for non destructive addition
  of key slots / whatever the encryption driver supports in the future

  x-blockdev-erase-encryption is meant for destructive encryption key erase,
  in some cases even without way to recover the data.


* bdrv_setup_encryption callback in the block driver
  This callback does both the above functions with 'action' parameter

* QCryptoKeyManageOptions with set of options that drivers can use for encryption managment
  Currently it has all the options that LUKS needs, and later it can be extended
  (via union) to support more encryption drivers if needed

* blk_setup_encryption / bdrv_setup_encryption - the usual block layer wrappers.
  Note that bdrv_setup_encryption takes BlockDriverState and not BdrvChild,
  for the ease of use from the qmp code. It is not expected that this function
  will be used by anything but qmp and qemu-img code


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/block-backend.c          |  9 ++++++++
 block/io.c                     | 24 ++++++++++++++++++++
 blockdev.c                     | 40 ++++++++++++++++++++++++++++++++++
 include/block/block.h          | 12 ++++++++++
 include/block/block_int.h      | 11 ++++++++++
 include/sysemu/block-backend.h |  7 ++++++
 qapi/block-core.json           | 36 ++++++++++++++++++++++++++++++
 qapi/crypto.json               | 26 ++++++++++++++++++++++
 8 files changed, 165 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0056b526b8..1b75f28d0c 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2284,3 +2284,12 @@ const BdrvChild *blk_root(BlockBackend *blk)
 {
     return blk->root;
 }
+
+int blk_setup_encryption(BlockBackend *blk,
+                         enum BlkSetupEncryptionAction action,
+                         QCryptoEncryptionSetupOptions *options,
+                         bool force,
+                         Error **errp)
+{
+    return bdrv_setup_encryption(blk->root->bs, action, options, force, errp);
+}
diff --git a/block/io.c b/block/io.c
index 06305c6ea6..50090afe68 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3256,3 +3256,27 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
 
     return tco.ret;
 }
+
+
+int bdrv_setup_encryption(BlockDriverState *bs,
+                          enum BlkSetupEncryptionAction action,
+                          QCryptoEncryptionSetupOptions *options,
+                          bool force,
+                          Error **errp)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        error_setg(errp, "Can't do key management on read only block device");
+        return -ENOTSUP;
+    }
+
+    ret = bs->drv->bdrv_setup_encryption(bs, action, options, force,
+                                         &local_err);
+    if (ret) {
+        error_propagate(errp, local_err);
+        return ret;
+    }
+    return 0;
+}
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..27be251656 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4563,6 +4563,46 @@ void qmp_block_latency_histogram_set(
     }
 }
 
+void qmp_x_blockdev_update_encryption(const char *node_name,
+                                      bool has_force, bool force,
+                                      QCryptoEncryptionSetupOptions *options,
+                                      Error **errp)
+{
+    BlockDriverState *bs = bdrv_find_node(node_name);
+    Error *local_error = NULL;
+
+    if (!bs) {
+        error_setg(errp, "Cannot find node %s", node_name);
+        return;
+    }
+
+    if (bdrv_setup_encryption(bs, BLK_UPDATE_ENCRYPTION, options,
+                              has_force ? force : false, &local_error)) {
+        error_propagate(errp, local_error);
+    }
+}
+
+
+void qmp_x_blockdev_erase_encryption(const char *node_name,
+                                     bool has_force, bool force,
+                                     QCryptoEncryptionSetupOptions *options,
+                                     Error **errp)
+{
+    BlockDriverState *bs = bdrv_find_node(node_name);
+    Error *local_error = NULL;
+
+    if (!bs) {
+        error_setg(errp, "Cannot find node %s", node_name);
+        return;
+    }
+
+    if (bdrv_setup_encryption(bs, BLK_ERASE_ENCRYPTION, options,
+                              has_force ? force : false, &local_error)) {
+            error_propagate(errp, local_error);
+        }
+}
+
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..b55ef4c416 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -276,6 +276,12 @@ enum {
     DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
+enum BlkSetupEncryptionAction {
+    BLK_UPDATE_ENCRYPTION,
+    BLK_ERASE_ENCRYPTION,
+
+};
+
 char *bdrv_perm_names(uint64_t perm);
 
 /* disk I/O throttling */
@@ -348,6 +354,12 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
 int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
                   Error **errp);
 
+int bdrv_setup_encryption(BlockDriverState *bs,
+                          enum BlkSetupEncryptionAction action,
+                          QCryptoEncryptionSetupOptions *options,
+                          bool force,
+                          Error **errp);
+
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..64c71fe269 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -556,6 +556,16 @@ struct BlockDriver {
     void (*bdrv_unregister_buf)(BlockDriverState *bs, void *host);
     QLIST_ENTRY(BlockDriver) list;
 
+
+    /* Manage encryption keys on the block device */
+    int (*bdrv_setup_encryption)(BlockDriverState *bs,
+                                  enum BlkSetupEncryptionAction action,
+                                  QCryptoEncryptionSetupOptions *options,
+                                  bool force,
+                                  Error **errp);
+
+
+
     /* Pointer to a NULL-terminated array of names of strong options
      * that can be specified for bdrv_open(). A strong option is one
      * that changes the data of a BDS.
@@ -1271,4 +1281,5 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
 
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
+
 #endif /* BLOCK_INT_H */
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 733c4957eb..18e98499fd 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -262,4 +262,11 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
 
 const BdrvChild *blk_root(BlockBackend *blk);
 
+
+int blk_setup_encryption(BlockBackend *blk,
+                         enum BlkSetupEncryptionAction action,
+                         QCryptoEncryptionSetupOptions *options,
+                         bool force,
+                         Error **errp);
+
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..53ed411eed 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5327,3 +5327,39 @@
   'data' : { 'node-name': 'str',
              'iothread': 'StrOrNull',
              '*force': 'bool' } }
+
+
+##
+# @x-blockdev-update-encryption:
+#
+# Update the encryption keys for an encrypted block device
+#
+# @node-name: 	  Name of the blockdev to operate on
+# @force:         Disable safety checks (use with care)
+# @options:       Driver specific options
+#
+
+# Since: 4.2
+##
+{ 'command': 'x-blockdev-update-encryption',
+  'data': { 'node-name' : 'str',
+            '*force' : 'bool',
+            'options': 'QCryptoEncryptionSetupOptions' } }
+
+##
+# @x-blockdev-erase-encryption:
+#
+# Erase the encryption keys for an encrypted block device
+#
+# @node-name: 	  Name of the blockdev to operate on
+# @force:         Disable safety checks (use with care)
+# @options:       Driver specific options
+#
+# Returns: @QCryptoKeyManageResult
+#
+# Since: 4.2
+##
+{ 'command': 'x-blockdev-erase-encryption',
+  'data': { 'node-name' : 'str',
+            '*force' : 'bool',
+            'options': 'QCryptoEncryptionSetupOptions' } }
diff --git a/qapi/crypto.json b/qapi/crypto.json
index b2a4cff683..69e8b086db 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -309,3 +309,29 @@
   'base': 'QCryptoBlockInfoBase',
   'discriminator': 'format',
   'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
+
+
+##
+# @QCryptoEncryptionSetupOptions:
+#
+# Driver specific options for encryption key management.
+#
+# @key-secret: the ID of a QCryptoSecret object providing the password
+#              to add or to erase (optional for erase)
+#
+# @old-key-secret: the ID of a QCryptoSecret object providing the password
+#                  that can currently unlock the image
+#
+# @slot: Key slot to update/erase
+#        (optional, for update will select a free slot,
+#        for erase will erase all slots that match the password)
+#
+# @iter-time: number of milliseconds to spend in
+#             PBKDF passphrase processing. Currently defaults to 2000
+# Since: 4.2
+##
+{ 'struct': 'QCryptoEncryptionSetupOptions',
+  'data': { '*key-secret': 'str',
+            '*old-key-secret': 'str',
+            '*slot': 'int',
+            '*iter-time': 'int' } }
-- 
2.17.2


