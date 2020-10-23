Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E26C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1672A208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj/y8OI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1672A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVu5y-00080G-NZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4M-0005i5-0n
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4G-0001e3-NU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603447983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AvzHwpDwNsQuKlUNployHUJ3nW3UB/Ldcv1ApkwmsI=;
 b=gj/y8OI9n7q/J5w6fnc0SZcE0E50qgl8Z2Un+M0oIG/0E7p1vUS47zV7pnK67prOFgRoXn
 iJTzb4In5VPlUZZoXDhcRFc5yuigXGFzJxpfSvktGvnMceaHyt8dZKsF4npNWKv3cGZkpN
 E9nI/ijqeBJK+BBOdNtlW2VDK6hCzUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-2FcdWPO0PIe7XBCyNyBXjQ-1; Fri, 23 Oct 2020 06:13:00 -0400
X-MC-Unique: 2FcdWPO0PIe7XBCyNyBXjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08787804B6A;
 Fri, 23 Oct 2020 10:12:59 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34D6B6EF41;
 Fri, 23 Oct 2020 10:12:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/6] qapi: Remove wrapper struct for simple unions
Date: Fri, 23 Oct 2020 12:12:19 +0200
Message-Id: <20201023101222.250147-4-kwolf@redhat.com>
In-Reply-To: <20201023101222.250147-1-kwolf@redhat.com>
References: <20201023101222.250147-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Variants of simple unions are always contained in a wrapper object
called 'data' that serves no real use. When mapping a QAPI object to the
command line, this becomes very visible to users because they have to
add one or more useless 'data.' to many option names.

As a first step towards avoiding this painful CLI experience, this gets
rid of the 'data' indirection internally: The QAPI parser doesn't use a
wrapper object as the variant type any more, so the indirection is
removed from the generated C types. As a result, the C type looks the
same for flat and simple unions now. A large part of this patch is
mechanical conversion of C code to remove the 'data' indirection.

Conceptually, the important change is that variants can now have flat
and wrapped representations. For a transitioning period, we'll allow
variants to support both representations in a later patch. Eventually,
the plan is to deprecate and remove wrapped representations entirely,
unifying simple and flat unions.

The externally visible interfaces stay unchanged: Visitors still expect
the 'data' wrappers, and introspection still shows it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/devel/qapi-code-gen.txt           | 32 ++++++++----
 backends/tpm/tpm_emulator.c            |  3 +-
 backends/tpm/tpm_passthrough.c         |  4 +-
 block/crypto.c                         |  3 +-
 block/qcow2.c                          |  9 ++--
 block/vmdk.c                           | 14 ++----
 blockdev.c                             | 36 ++++++-------
 chardev/char-file.c                    |  5 +-
 chardev/char-mux.c                     |  5 +-
 chardev/char-parallel.c                |  5 +-
 chardev/char-pipe.c                    |  7 ++-
 chardev/char-ringbuf.c                 |  5 +-
 chardev/char-serial.c                  |  5 +-
 chardev/char-socket.c                  | 13 ++---
 chardev/char-stdio.c                   |  5 +-
 chardev/char-udp.c                     | 11 ++--
 chardev/char.c                         | 10 ++--
 chardev/msmouse.c                      |  4 +-
 chardev/wctablet.c                     |  4 +-
 hw/core/numa.c                         |  6 +--
 hw/display/xenfb.c                     |  8 +--
 hw/input/hid.c                         |  8 +--
 hw/input/ps2.c                         |  6 +--
 hw/input/virtio-input-hid.c            |  8 +--
 hw/mem/pc-dimm.c                       | 18 +++----
 hw/virtio/virtio-mem-pci.c             |  3 +-
 hw/virtio/virtio-pmem-pci.c            |  3 +-
 monitor/hmp-cmds.c                     | 14 +++---
 qemu-keymap.c                          |  2 +-
 replay/replay-input.c                  | 46 +++++++----------
 tests/test-char.c                      | 12 ++---
 tests/test-clone-visitor.c             | 14 +++---
 tests/test-qmp-cmds.c                  |  2 +-
 tests/test-qobject-input-visitor.c     | 24 ++++-----
 tests/test-qobject-output-visitor.c    | 24 ++++-----
 ui/console.c                           |  5 +-
 ui/input-keymap.c                      | 12 ++---
 ui/input-legacy.c                      | 12 ++---
 ui/input.c                             | 43 ++++++++--------
 util/qemu-sockets.c                    |  8 +--
 scripts/qapi/introspect.py             |  7 ++-
 scripts/qapi/schema.py                 | 48 ++++++++++++++----
 scripts/qapi/visit.py                  | 28 +++++++++++
 tests/qapi-schema/doc-good.out         |  8 +--
 tests/qapi-schema/qapi-schema-test.out | 70 +++++++-------------------
 45 files changed, 308 insertions(+), 311 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c6438c6aa9..9722c1a204 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -310,7 +310,20 @@ The BRANCH's STRING name is the branch name.
 The BRANCH's value defines the branch's properties, in particular its
 type.  The form TYPE-REF is shorthand for { 'type': TYPE-REF }.
 
-A simple union type defines a mapping from automatic discriminator
+Each branch can have flat or wrapped representation in the Client JSON
+Protocol.
+
+Wrapped representation of a branch means that it is represented by a
+'data' member that is of the specified data type corresponding to the
+discriminator value.
+
+Flat representation means that the union forms a single object that
+contains both common members (from the base type) and the selected
+branch's members, without any additional nesting.  The two sets of
+member names must be disjoint.
+
+A simple union type automatically contains the 'type' member as a
+discriminator and defines a mapping from automatic discriminator
 values to data types like in this example:
 
  { 'struct': 'BlockdevOptionsFile', 'data': { 'filename': 'str' } }
@@ -321,10 +334,8 @@ values to data types like in this example:
    'data': { 'file': 'BlockdevOptionsFile',
              'qcow2': 'BlockdevOptionsQcow2' } }
 
-In the Client JSON Protocol, a simple union is represented by an
-object that contains the 'type' member as a discriminator, and a
-'data' member that is of the specified data type corresponding to the
-discriminator value, as in these examples:
+In the Client JSON Protocol, all simple union branches have wrapped
+representation, as in these examples:
 
  { "type": "file", "data": { "filename": "/some/place/my-image" } }
  { "type": "qcow2", "data": { "backing": "/some/place/my-image",
@@ -344,13 +355,12 @@ object, it defines common members just like a struct type's 'data'
 member defines struct type members.  If it is a STRING, it names a
 struct type whose members are the common members.
 
-All flat union branches must be of struct type.
+Member 'discriminator' must name a non-optional enum-typed member of
+the base struct and defines the option that should server as the
+discrimiator.
 
-In the Client JSON Protocol, a flat union is represented by an object
-with the common members (from the base type) and the selected branch's
-members.  The two sets of member names must be disjoint.  Member
-'discriminator' must name a non-optional enum-typed member of the base
-struct.
+All flat union branches must be of struct type.  They have always flat
+representation.
 
 The following example enhances the above simple union example by
 adding an optional common member 'read-only', renaming the
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 201cd38503..7d2dc2b19d 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -629,7 +629,8 @@ static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
     TpmTypeOptions *options = g_new0(TpmTypeOptions, 1);
 
     options->type = TPM_TYPE_OPTIONS_KIND_EMULATOR;
-    options->u.emulator.data = QAPI_CLONE(TPMEmulatorOptions, tpm_emu->options);
+    QAPI_CLONE_MEMBERS(TPMEmulatorOptions, &options->u.emulator,
+                       tpm_emu->options);
 
     return options;
 }
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 8f6f4998a5..7fa7c84f5a 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -322,8 +322,8 @@ static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
     TpmTypeOptions *options = g_new0(TpmTypeOptions, 1);
 
     options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
-    options->u.passthrough.data = QAPI_CLONE(TPMPassthroughOptions,
-                                             TPM_PASSTHROUGH(tb)->options);
+    QAPI_CLONE_MEMBERS(TPMPassthroughOptions, &options->u.passthrough,
+                       TPM_PASSTHROUGH(tb)->options);
 
     return options;
 }
diff --git a/block/crypto.c b/block/crypto.c
index 0807557763..0e7838d70a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -775,8 +775,7 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
 
     spec_info = g_new(ImageInfoSpecific, 1);
     spec_info->type = IMAGE_INFO_SPECIFIC_KIND_LUKS;
-    spec_info->u.luks.data = g_new(QCryptoBlockInfoLUKS, 1);
-    *spec_info->u.luks.data = info->u.luks;
+    spec_info->u.luks = info->u.luks;
 
     /* Blank out pointers we've just stolen to avoid double free */
     memset(&info->u.luks, 0, sizeof(info->u.luks));
diff --git a/block/qcow2.c b/block/qcow2.c
index b05512718c..104fd8ad06 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5052,10 +5052,9 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
     spec_info = g_new(ImageInfoSpecific, 1);
     *spec_info = (ImageInfoSpecific){
         .type  = IMAGE_INFO_SPECIFIC_KIND_QCOW2,
-        .u.qcow2.data = g_new0(ImageInfoSpecificQCow2, 1),
     };
     if (s->qcow_version == 2) {
-        *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
+        spec_info->u.qcow2 = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("0.10"),
             .refcount_bits      = s->refcount_bits,
         };
@@ -5068,7 +5067,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             qapi_free_QCryptoBlockInfo(encrypt_info);
             return NULL;
         }
-        *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
+        spec_info->u.qcow2 = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("1.1"),
             .lazy_refcounts     = s->compatible_features &
                                   QCOW2_COMPAT_LAZY_REFCOUNTS,
@@ -5112,8 +5111,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
         memset(&encrypt_info->u, 0, sizeof(encrypt_info->u));
         qapi_free_QCryptoBlockInfo(encrypt_info);
 
-        spec_info->u.qcow2.data->has_encrypt = true;
-        spec_info->u.qcow2.data->encrypt = qencrypt;
+        spec_info->u.qcow2.has_encrypt = true;
+        spec_info->u.qcow2.encrypt = qencrypt;
     }
 
     return spec_info;
diff --git a/block/vmdk.c b/block/vmdk.c
index a00dc00eb4..fc4ddcc351 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2932,18 +2932,14 @@ static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs,
 
     *spec_info = (ImageInfoSpecific){
         .type = IMAGE_INFO_SPECIFIC_KIND_VMDK,
-        .u = {
-            .vmdk.data = g_new0(ImageInfoSpecificVmdk, 1),
+        .u.vmdk = (ImageInfoSpecificVmdk) {
+            .create_type = g_strdup(s->create_type),
+            .cid = s->cid,
+            .parent_cid = s->parent_cid,
         },
     };
 
-    *spec_info->u.vmdk.data = (ImageInfoSpecificVmdk) {
-        .create_type = g_strdup(s->create_type),
-        .cid = s->cid,
-        .parent_cid = s->parent_cid,
-    };
-
-    next = &spec_info->u.vmdk.data->extents;
+    next = &spec_info->u.vmdk.extents;
     for (i = 0; i < s->num_extents; i++) {
         *next = g_new0(ImageInfoList, 1);
         (*next)->value = vmdk_get_extent_info(&s->extents[i]);
diff --git a/blockdev.c b/blockdev.c
index fe6fb5dc1d..2602298a26 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1090,7 +1090,7 @@ void qmp_blockdev_snapshot_sync(bool has_device, const char *device,
     };
     TransactionAction action = {
         .type = TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC,
-        .u.blockdev_snapshot_sync.data = &snapshot,
+        .u.blockdev_snapshot_sync = snapshot,
     };
     blockdev_do_action(&action, errp);
 }
@@ -1104,7 +1104,7 @@ void qmp_blockdev_snapshot(const char *node, const char *overlay,
     };
     TransactionAction action = {
         .type = TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT,
-        .u.blockdev_snapshot.data = &snapshot_data,
+        .u.blockdev_snapshot = snapshot_data,
     };
     blockdev_do_action(&action, errp);
 }
@@ -1119,7 +1119,7 @@ void qmp_blockdev_snapshot_internal_sync(const char *device,
     };
     TransactionAction action = {
         .type = TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC,
-        .u.blockdev_snapshot_internal_sync.data = &snapshot,
+        .u.blockdev_snapshot_internal_sync = snapshot,
     };
     blockdev_do_action(&action, errp);
 }
@@ -1289,7 +1289,7 @@ static void internal_snapshot_prepare(BlkActionState *common,
 
     g_assert(common->action->type ==
              TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC);
-    internal = common->action->u.blockdev_snapshot_internal_sync.data;
+    internal = &common->action->u.blockdev_snapshot_internal_sync;
     state = DO_UPCAST(InternalSnapshotState, common, common);
 
     /* 1. parse input */
@@ -1453,7 +1453,7 @@ static void external_snapshot_prepare(BlkActionState *common,
     switch (action->type) {
     case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT:
         {
-            BlockdevSnapshot *s = action->u.blockdev_snapshot.data;
+            BlockdevSnapshot *s = &action->u.blockdev_snapshot;
             device = s->node;
             node_name = s->node;
             new_image_file = NULL;
@@ -1462,7 +1462,7 @@ static void external_snapshot_prepare(BlkActionState *common,
         break;
     case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC:
         {
-            BlockdevSnapshotSync *s = action->u.blockdev_snapshot_sync.data;
+            BlockdevSnapshotSync *s = &action->u.blockdev_snapshot_sync;
             device = s->has_device ? s->device : NULL;
             node_name = s->has_node_name ? s->node_name : NULL;
             new_image_file = s->snapshot_file;
@@ -1507,7 +1507,7 @@ static void external_snapshot_prepare(BlkActionState *common,
     }
 
     if (action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC) {
-        BlockdevSnapshotSync *s = action->u.blockdev_snapshot_sync.data;
+        BlockdevSnapshotSync *s = &action->u.blockdev_snapshot_sync;
         const char *format = s->has_format ? s->format : "qcow2";
         enum NewImageMode mode;
         const char *snapshot_node_name =
@@ -1712,7 +1712,7 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     int ret;
 
     assert(common->action->type == TRANSACTION_ACTION_KIND_DRIVE_BACKUP);
-    backup = common->action->u.drive_backup.data;
+    backup = &common->action->u.drive_backup;
 
     if (!backup->has_mode) {
         backup->mode = NEW_IMAGE_MODE_ABSOLUTE_PATHS;
@@ -1907,7 +1907,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
     int ret;
 
     assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
-    backup = common->action->u.blockdev_backup.data;
+    backup = &common->action->u.blockdev_backup;
 
     bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
@@ -2012,7 +2012,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.block_dirty_bitmap_add.data;
+    action = &common->action->u.block_dirty_bitmap_add;
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
@@ -2033,7 +2033,7 @@ static void block_dirty_bitmap_add_abort(BlkActionState *common)
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
-    action = common->action->u.block_dirty_bitmap_add.data;
+    action = &common->action->u.block_dirty_bitmap_add;
     /* Should not be able to fail: IF the bitmap was added via .prepare(),
      * then the node reference and bitmap name must have been valid.
      */
@@ -2053,7 +2053,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.block_dirty_bitmap_clear.data;
+    action = &common->action->u.block_dirty_bitmap_clear;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               &state->bs,
@@ -2098,7 +2098,7 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.block_dirty_bitmap_enable.data;
+    action = &common->action->u.block_dirty_bitmap_enable;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2136,7 +2136,7 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.block_dirty_bitmap_disable.data;
+    action = &common->action->u.block_dirty_bitmap_disable;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2174,7 +2174,7 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.block_dirty_bitmap_merge.data;
+    action = &common->action->u.block_dirty_bitmap_merge;
 
     state->bitmap = block_dirty_bitmap_merge(action->node, action->target,
                                              action->bitmaps, &state->backup,
@@ -2192,7 +2192,7 @@ static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.block_dirty_bitmap_remove.data;
+    action = &common->action->u.block_dirty_bitmap_remove;
 
     state->bitmap = block_dirty_bitmap_remove(action->node, action->name,
                                               false, &state->bs, errp);
@@ -2895,7 +2895,7 @@ void qmp_drive_backup(DriveBackup *backup, Error **errp)
 {
     TransactionAction action = {
         .type = TRANSACTION_ACTION_KIND_DRIVE_BACKUP,
-        .u.drive_backup.data = backup,
+        .u.drive_backup = *backup,
     };
     blockdev_do_action(&action, errp);
 }
@@ -2918,7 +2918,7 @@ void qmp_blockdev_backup(BlockdevBackup *backup, Error **errp)
 {
     TransactionAction action = {
         .type = TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP,
-        .u.blockdev_backup.data = backup,
+        .u.blockdev_backup = *backup,
     };
     blockdev_do_action(&action, errp);
 }
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 2fd80707e5..3f0f0b6045 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -39,7 +39,7 @@ static void qmp_chardev_open_file(Chardev *chr,
                                   bool *be_opened,
                                   Error **errp)
 {
-    ChardevFile *file = backend->u.file.data;
+    ChardevFile *file = &backend->u.file;
 #ifdef _WIN32
     HANDLE out;
     DWORD accessmode;
@@ -100,14 +100,13 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
                                     Error **errp)
 {
     const char *path = qemu_opt_get(opts, "path");
-    ChardevFile *file;
+    ChardevFile *file = &backend->u.file;
 
     backend->type = CHARDEV_BACKEND_KIND_FILE;
     if (path == NULL) {
         error_setg(errp, "chardev: file: no filename given");
         return;
     }
-    file = backend->u.file.data = g_new0(ChardevFile, 1);
     qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
     file->out = g_strdup(path);
 
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6f980bb836..bfb4bc6b8b 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -314,7 +314,7 @@ static void qemu_chr_open_mux(Chardev *chr,
                               bool *be_opened,
                               Error **errp)
 {
-    ChardevMux *mux = backend->u.mux.data;
+    ChardevMux *mux = &backend->u.mux;
     Chardev *drv;
     MuxChardev *d = MUX_CHARDEV(chr);
 
@@ -336,14 +336,13 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
                                Error **errp)
 {
     const char *chardev = qemu_opt_get(opts, "chardev");
-    ChardevMux *mux;
+    ChardevMux *mux = &backend->u.mux;
 
     if (chardev == NULL) {
         error_setg(errp, "chardev: mux: no chardev given");
         return;
     }
     backend->type = CHARDEV_BACKEND_KIND_MUX;
-    mux = backend->u.mux.data = g_new0(ChardevMux, 1);
     qemu_chr_parse_common(opts, qapi_ChardevMux_base(mux));
     mux->chardev = g_strdup(chardev);
 }
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 05e7efbd6c..a17157a3be 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -244,7 +244,7 @@ static void qmp_chardev_open_parallel(Chardev *chr,
                                       bool *be_opened,
                                       Error **errp)
 {
-    ChardevHostdev *parallel = backend->u.parallel.data;
+    ChardevHostdev *parallel = &backend->u.parallel;
     int fd;
 
     fd = qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
@@ -258,14 +258,13 @@ static void qemu_chr_parse_parallel(QemuOpts *opts, ChardevBackend *backend,
                                     Error **errp)
 {
     const char *device = qemu_opt_get(opts, "path");
-    ChardevHostdev *parallel;
+    ChardevHostdev *parallel = &backend->u.parallel;
 
     if (device == NULL) {
         error_setg(errp, "chardev: parallel: no device path given");
         return;
     }
     backend->type = CHARDEV_BACKEND_KIND_PARALLEL;
-    parallel = backend->u.parallel.data = g_new0(ChardevHostdev, 1);
     qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(parallel));
     parallel->device = g_strdup(device);
 }
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 7eca5d9a56..eb19d9a526 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -109,7 +109,7 @@ static void qemu_chr_open_pipe(Chardev *chr,
                                bool *be_opened,
                                Error **errp)
 {
-    ChardevHostdev *opts = backend->u.pipe.data;
+    ChardevHostdev *opts = &backend->u.pipe;
     const char *filename = opts->device;
 
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
@@ -124,7 +124,7 @@ static void qemu_chr_open_pipe(Chardev *chr,
                                bool *be_opened,
                                Error **errp)
 {
-    ChardevHostdev *opts = backend->u.pipe.data;
+    ChardevHostdev *opts = &backend->u.pipe;
     int fd_in, fd_out;
     char *filename_in;
     char *filename_out;
@@ -158,14 +158,13 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
                                 Error **errp)
 {
     const char *device = qemu_opt_get(opts, "path");
-    ChardevHostdev *dev;
+    ChardevHostdev *dev = &backend->u.pipe;
 
     if (device == NULL) {
         error_setg(errp, "chardev: pipe: no device path given");
         return;
     }
     backend->type = CHARDEV_BACKEND_KIND_PIPE;
-    dev = backend->u.pipe.data = g_new0(ChardevHostdev, 1);
     qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
     dev->device = g_strdup(device);
 }
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index d40d21d3cf..0ef2a17f90 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -97,7 +97,7 @@ static void qemu_chr_open_ringbuf(Chardev *chr,
                                   bool *be_opened,
                                   Error **errp)
 {
-    ChardevRingbuf *opts = backend->u.ringbuf.data;
+    ChardevRingbuf *opts = &backend->u.ringbuf;
     RingBufChardev *d = RINGBUF_CHARDEV(chr);
 
     d->size = opts->has_size ? opts->size : 65536;
@@ -210,10 +210,9 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
                                    Error **errp)
 {
     int val;
-    ChardevRingbuf *ringbuf;
+    ChardevRingbuf *ringbuf = &backend->u.ringbuf;
 
     backend->type = CHARDEV_BACKEND_KIND_RINGBUF;
-    ringbuf = backend->u.ringbuf.data = g_new0(ChardevRingbuf, 1);
     qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ringbuf));
 
     val = qemu_opt_get_size(opts, "size", 0);
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 7c3d84ae24..baec955ecf 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -263,7 +263,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
                                     bool *be_opened,
                                     Error **errp)
 {
-    ChardevHostdev *serial = backend->u.serial.data;
+    ChardevHostdev *serial = &backend->u.serial;
     int fd;
 
     fd = qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBLOCK,
@@ -283,14 +283,13 @@ static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backend,
                                   Error **errp)
 {
     const char *device = qemu_opt_get(opts, "path");
-    ChardevHostdev *serial;
+    ChardevHostdev *serial = &backend->u.serial;
 
     if (device == NULL) {
         error_setg(errp, "chardev: serial/tty: no device path given");
         return;
     }
     backend->type = CHARDEV_BACKEND_KIND_SERIAL;
-    serial = backend->u.serial.data = g_new0(ChardevHostdev, 1);
     qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(serial));
     serial->device = g_strdup(device);
 }
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 95e45812d5..5332439d34 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1301,7 +1301,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                                     Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
-    ChardevSocket *sock = backend->u.socket.data;
+    ChardevSocket *sock = &backend->u.socket;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
@@ -1403,7 +1403,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     }
 
     backend->type = CHARDEV_BACKEND_KIND_SOCKET;
-    sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
+    sock = &backend->u.socket;
     qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
 
     sock->has_nodelay = qemu_opt_get(opts, "delay");
@@ -1435,16 +1435,14 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
 
     addr = g_new0(SocketAddressLegacy, 1);
     if (path) {
-        UnixSocketAddress *q_unix;
+        UnixSocketAddress *q_unix = &addr->u.q_unix;
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-        q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
         q_unix->tight = tight;
         q_unix->abstract = abstract;
     } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        addr->u.inet.data = g_new(InetSocketAddress, 1);
-        *addr->u.inet.data = (InetSocketAddress) {
+        addr->u.inet = (InetSocketAddress) {
             .host = g_strdup(host),
             .port = g_strdup(port),
             .has_to = qemu_opt_get(opts, "to"),
@@ -1456,8 +1454,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         };
     } else if (fd) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
-        addr->u.fd.data = g_new(String, 1);
-        addr->u.fd.data->str = g_strdup(fd);
+        addr->u.fd.str = g_strdup(fd);
     } else {
         g_assert_not_reached();
     }
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 403da308c9..81ee655a21 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -87,7 +87,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
                                 bool *be_opened,
                                 Error **errp)
 {
-    ChardevStdio *opts = backend->u.stdio.data;
+    ChardevStdio *opts = &backend->u.stdio;
     struct sigaction act;
 
     if (is_daemonized()) {
@@ -120,10 +120,9 @@ static void qemu_chr_open_stdio(Chardev *chr,
 static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend,
                                  Error **errp)
 {
-    ChardevStdio *stdio;
+    ChardevStdio *stdio = &backend->u.stdio;
 
     backend->type = CHARDEV_BACKEND_KIND_STDIO;
-    stdio = backend->u.stdio.data = g_new0(ChardevStdio, 1);
     qemu_chr_parse_common(opts, qapi_ChardevStdio_base(stdio));
     stdio->has_signal = true;
     stdio->signal = qemu_opt_get_bool(opts, "signal", true);
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 16b5dbce58..3b1bdddbbd 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -140,7 +140,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
     const char *localport = qemu_opt_get(opts, "localport");
     bool has_local = false;
     SocketAddressLegacy *addr;
-    ChardevUdp *udp;
+    ChardevUdp *udp = &backend->u.udp;
 
     backend->type = CHARDEV_BACKEND_KIND_UDP;
     if (host == NULL || strlen(host) == 0) {
@@ -161,13 +161,11 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
         has_local = true;
     }
 
-    udp = backend->u.udp.data = g_new0(ChardevUdp, 1);
     qemu_chr_parse_common(opts, qapi_ChardevUdp_base(udp));
 
     addr = g_new0(SocketAddressLegacy, 1);
     addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    addr->u.inet.data = g_new(InetSocketAddress, 1);
-    *addr->u.inet.data = (InetSocketAddress) {
+    addr->u.inet = (InetSocketAddress) {
         .host = g_strdup(host),
         .port = g_strdup(port),
         .has_ipv4 = qemu_opt_get(opts, "ipv4"),
@@ -181,8 +179,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
         udp->has_local = true;
         addr = g_new0(SocketAddressLegacy, 1);
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        addr->u.inet.data = g_new(InetSocketAddress, 1);
-        *addr->u.inet.data = (InetSocketAddress) {
+        addr->u.inet = (InetSocketAddress) {
             .host = g_strdup(localaddr),
             .port = g_strdup(localport),
         };
@@ -195,7 +192,7 @@ static void qmp_chardev_open_udp(Chardev *chr,
                                  bool *be_opened,
                                  Error **errp)
 {
-    ChardevUdp *udp = backend->u.udp.data;
+    ChardevUdp *udp = &backend->u.udp;
     SocketAddress *local_addr = socket_address_flatten(udp->local);
     SocketAddress *remote_addr = socket_address_flatten(udp->remote);
     QIOChannelSocket *sioc = qio_channel_socket_new();
diff --git a/chardev/char.c b/chardev/char.c
index 028612c333..5192964694 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -238,7 +238,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
     /* Any ChardevCommon member would work */
-    ChardevCommon *common = backend ? backend->u.null.data : NULL;
+    ChardevCommon *common = backend ? &backend->u.null : NULL;
 
     if (common && common->has_logfile) {
         int flags = O_WRONLY | O_CREAT;
@@ -625,9 +625,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
             return NULL;
         }
     } else {
-        ChardevCommon *ccom = g_new0(ChardevCommon, 1);
-        qemu_chr_parse_common(opts, ccom);
-        backend->u.null.data = ccom; /* Any ChardevCommon member would work */
+        /* Any ChardevCommon member would work */
+        qemu_chr_parse_common(opts, &backend->u.null);
     }
 
     return backend;
@@ -690,8 +689,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
         qapi_free_ChardevBackend(backend);
         backend = g_new0(ChardevBackend, 1);
         backend->type = CHARDEV_BACKEND_KIND_MUX;
-        backend->u.mux.data = g_new0(ChardevMux, 1);
-        backend->u.mux.data->chardev = g_strdup(bid);
+        backend->u.mux.chardev = g_strdup(bid);
         mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index eb9231dcdb..98b0ef8cd7 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -111,12 +111,12 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         mouse->axis[move->axis] += move->value;
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         mouse->btns[btn->button] = btn->down;
         mouse->btnc[btn->button] = true;
         break;
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 95e005f5a5..8479f59183 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -154,12 +154,12 @@ static void wctablet_input_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         tablet->axis[move->axis] = move->value;
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         tablet->btns[btn->button] = btn->down;
         break;
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 7c4dd4e68e..24fe0e11d8 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -765,19 +765,19 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
             case MEMORY_DEVICE_INFO_KIND_DIMM:
             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
                 pcdimm_info = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
-                              value->u.dimm.data : value->u.nvdimm.data;
+                              &value->u.dimm : &value->u.nvdimm;
                 node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
                 node_mem[pcdimm_info->node].node_plugged_mem +=
                     pcdimm_info->size;
                 break;
             case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
-                vpi = value->u.virtio_pmem.data;
+                vpi = &value->u.virtio_pmem;
                 /* TODO: once we support numa, assign to right node */
                 node_mem[0].node_mem += vpi->size;
                 node_mem[0].node_plugged_mem += vpi->size;
                 break;
             case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
-                vmi = value->u.virtio_mem.data;
+                vmi = &value->u.virtio_mem;
                 node_mem[vmi->node].node_mem += vmi->size;
                 node_mem[vmi->node].node_plugged_mem += vmi->size;
                 break;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 838260b6ad..6aa6010774 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -201,7 +201,7 @@ static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
                             InputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    InputKeyEvent *key = evt->u.key.data;
+    InputKeyEvent *key = &evt->u.key;
     int qcode = qemu_input_key_value_to_qcode(key->key);
     int lnx;
 
@@ -236,7 +236,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         switch (btn->button) {
         case INPUT_BUTTON_LEFT:
             xenfb_send_key(xenfb, btn->down, BTN_LEFT);
@@ -263,7 +263,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         if (xenfb->raw_pointer_wanted) {
             xenfb->axis[move->axis] = move->value;
         } else {
@@ -289,7 +289,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         xenfb->axis[move->axis] += move->value;
         break;
 
diff --git a/hw/input/hid.c b/hw/input/hid.c
index 89239b5634..2472c5a902 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -126,7 +126,7 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         if (move->axis == INPUT_AXIS_X) {
             e->xdx += move->value;
         } else if (move->axis == INPUT_AXIS_Y) {
@@ -135,7 +135,7 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         if (move->axis == INPUT_AXIS_X) {
             e->xdx = move->value;
         } else if (move->axis == INPUT_AXIS_Y) {
@@ -144,7 +144,7 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         if (btn->down) {
             e->buttons_state |= bmap[btn->button];
             if (btn->button == INPUT_BUTTON_WHEEL_UP) {
@@ -230,7 +230,7 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
     HIDState *hs = (HIDState *)dev;
     int scancodes[3], i, count;
     int slot;
-    InputKeyEvent *key = evt->u.key.data;
+    InputKeyEvent *key = &evt->u.key;
 
     count = qemu_input_key_value_to_scancode(key->key,
                                              key->down,
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f8746d2f52..1176ccc88c 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -284,7 +284,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                                InputEvent *evt)
 {
     PS2KbdState *s = (PS2KbdState *)dev;
-    InputKeyEvent *key = evt->u.key.data;
+    InputKeyEvent *key = &evt->u.key;
     int qcode;
     uint16_t keycode = 0;
     int mod;
@@ -727,7 +727,7 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         if (move->axis == INPUT_AXIS_X) {
             s->mouse_dx += move->value;
         } else if (move->axis == INPUT_AXIS_Y) {
@@ -736,7 +736,7 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         if (btn->down) {
             s->mouse_buttons |= bmap[btn->button];
             if (btn->button == INPUT_BUTTON_WHEEL_UP) {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index a7a244a95d..1c7b07cf42 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -83,7 +83,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        key = evt->u.key.data;
+        key = &evt->u.key;
         qcode = qemu_input_key_value_to_qcode(key->key);
         if (qcode < qemu_input_map_qcode_to_linux_len &&
             qemu_input_map_qcode_to_linux[qcode]) {
@@ -99,7 +99,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         if (vhid->wheel_axis &&
             (btn->button == INPUT_BUTTON_WHEEL_UP ||
              btn->button == INPUT_BUTTON_WHEEL_DOWN) &&
@@ -123,14 +123,14 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
         }
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         event.type  = cpu_to_le16(EV_REL);
         event.code  = cpu_to_le16(axismap_rel[move->axis]);
         event.value = cpu_to_le32(move->value);
         virtio_input_send(vinput, &event);
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         event.type  = cpu_to_le16(EV_ABS);
         event.code  = cpu_to_le16(axismap_abs[move->axis]);
         event.value = cpu_to_le32(move->value);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c30351070b..3d6f836621 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,11 +236,19 @@ static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
 static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
                                         MemoryDeviceInfo *info)
 {
-    PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+    PCDIMMDeviceInfo *di;
     const DeviceClass *dc = DEVICE_GET_CLASS(md);
     const PCDIMMDevice *dimm = PC_DIMM(md);
     const DeviceState *dev = DEVICE(md);
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+        di = &info->u.nvdimm;
+        info->type = MEMORY_DEVICE_INFO_KIND_NVDIMM;
+    } else {
+        di = &info->u.dimm;
+        info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
+    }
+
     if (dev->id) {
         di->has_id = true;
         di->id = g_strdup(dev->id);
@@ -253,14 +261,6 @@ static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
     di->size = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
                                         NULL);
     di->memdev = object_get_canonical_path(OBJECT(dimm->hostmem));
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
-        info->u.nvdimm.data = di;
-        info->type = MEMORY_DEVICE_INFO_KIND_NVDIMM;
-    } else {
-        info->u.dimm.data = di;
-        info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
-    }
 }
 
 static void pc_dimm_class_init(ObjectClass *oc, void *data)
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 913f4a3326..f93572fc27 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -58,7 +58,7 @@ static uint64_t virtio_mem_pci_get_plugged_size(const MemoryDeviceState *md,
 static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
                                             MemoryDeviceInfo *info)
 {
-    VirtioMEMDeviceInfo *vi = g_new0(VirtioMEMDeviceInfo, 1);
+    VirtioMEMDeviceInfo *vi = &info->u.virtio_mem;
     VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
     VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
     VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
@@ -72,7 +72,6 @@ static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
     /* let the real device handle everything else */
     vpc->fill_device_info(vmem, vi);
 
-    info->u.virtio_mem.data = vi;
     info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
 }
 
diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
index 2b2a0b1eae..adf17f873b 100644
--- a/hw/virtio/virtio-pmem-pci.c
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -63,7 +63,7 @@ static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState *md,
 static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
                                              MemoryDeviceInfo *info)
 {
-    VirtioPMEMDeviceInfo *vi = g_new0(VirtioPMEMDeviceInfo, 1);
+    VirtioPMEMDeviceInfo *vi = &info->u.virtio_pmem;
     VirtIOPMEMPCI *pci_pmem = VIRTIO_PMEM_PCI(md);
     VirtIOPMEM *pmem = VIRTIO_PMEM(&pci_pmem->vdev);
     VirtIOPMEMClass *vpc = VIRTIO_PMEM_GET_CLASS(pmem);
@@ -77,7 +77,6 @@ static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
     /* let the real device handle everything else */
     vpc->fill_device_info(pmem, vi);
 
-    info->u.virtio_pmem.data = vi;
     info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
 }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9789f4277f..0324caa114 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -918,7 +918,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
 
         switch (ti->options->type) {
         case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
-            tpo = ti->options->u.passthrough.data;
+            tpo = &ti->options->u.passthrough;
             monitor_printf(mon, "%s%s%s%s",
                            tpo->has_path ? ",path=" : "",
                            tpo->has_path ? tpo->path : "",
@@ -926,7 +926,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                            tpo->has_cancel_path ? tpo->cancel_path : "");
             break;
         case TPM_TYPE_OPTIONS_KIND_EMULATOR:
-            teo = ti->options->u.emulator.data;
+            teo = &ti->options->u.emulator;
             monitor_printf(mon, ",chardev=%s", teo->chardev);
             break;
         case TPM_TYPE_OPTIONS_KIND__MAX:
@@ -1728,14 +1728,14 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
                 goto err_out;
             }
             keylist->value->type = KEY_VALUE_KIND_NUMBER;
-            keylist->value->u.number.data = value;
+            keylist->value->u.number = value;
         } else {
             int idx = index_from_key(keys, keyname_len);
             if (idx == Q_KEY_CODE__MAX) {
                 goto err_out;
             }
             keylist->value->type = KEY_VALUE_KIND_QCODE;
-            keylist->value->u.qcode.data = idx;
+            keylist->value->u.qcode = idx;
         }
 
         if (!*separator) {
@@ -1860,7 +1860,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
             case MEMORY_DEVICE_INFO_KIND_DIMM:
             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
                 di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
-                     value->u.dimm.data : value->u.nvdimm.data;
+                     &value->u.dimm : &value->u.nvdimm;
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
                                MemoryDeviceInfoKind_str(value->type),
                                di->id ? di->id : "");
@@ -1875,7 +1875,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                                di->hotpluggable ? "true" : "false");
                 break;
             case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
-                vpi = value->u.virtio_pmem.data;
+                vpi = &value->u.virtio_pmem;
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
                                MemoryDeviceInfoKind_str(value->type),
                                vpi->id ? vpi->id : "");
@@ -1884,7 +1884,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                 monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
                 break;
             case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
-                vmi = value->u.virtio_mem.data;
+                vmi = &value->u.virtio_mem;
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
                                MemoryDeviceInfoKind_str(value->type),
                                vmi->id ? vmi->id : "");
diff --git a/qemu-keymap.c b/qemu-keymap.c
index 536e8f2385..52637c449c 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -38,7 +38,7 @@ static uint32_t qcode_to_number(uint32_t qcode)
     uint32_t number;
 
     keyvalue.type = KEY_VALUE_KIND_QCODE;
-    keyvalue.u.qcode.data = qcode;
+    keyvalue.u.qcode = qcode;
     number = qemu_input_key_value_to_number(&keyvalue);
     assert(number != 0);
     return number;
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 1147e3d34e..c1eb1b79e1 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -26,16 +26,16 @@ void replay_save_input_event(InputEvent *evt)
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        key = evt->u.key.data;
+        key = &evt->u.key;
         replay_put_dword(key->key->type);
 
         switch (key->key->type) {
         case KEY_VALUE_KIND_NUMBER:
-            replay_put_qword(key->key->u.number.data);
+            replay_put_qword(key->key->u.number);
             replay_put_byte(key->down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            replay_put_dword(key->key->u.qcode.data);
+            replay_put_dword(key->key->u.qcode);
             replay_put_byte(key->down);
             break;
         case KEY_VALUE_KIND__MAX:
@@ -44,17 +44,17 @@ void replay_save_input_event(InputEvent *evt)
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         replay_put_dword(btn->button);
         replay_put_byte(btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         replay_put_dword(move->axis);
         replay_put_qword(move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         replay_put_dword(move->axis);
         replay_put_qword(move->value);
         break;
@@ -68,26 +68,21 @@ InputEvent *replay_read_input_event(void)
 {
     InputEvent evt;
     KeyValue keyValue;
-    InputKeyEvent key;
-    key.key = &keyValue;
-    InputBtnEvent btn;
-    InputMoveEvent rel;
-    InputMoveEvent abs;
+    evt.u.key.key = &keyValue;
 
     evt.type = replay_get_dword();
     switch (evt.type) {
     case INPUT_EVENT_KIND_KEY:
-        evt.u.key.data = &key;
-        evt.u.key.data->key->type = replay_get_dword();
+        evt.u.key.key->type = replay_get_dword();
 
-        switch (evt.u.key.data->key->type) {
+        switch (evt.u.key.key->type) {
         case KEY_VALUE_KIND_NUMBER:
-            evt.u.key.data->key->u.number.data = replay_get_qword();
-            evt.u.key.data->down = replay_get_byte();
+            evt.u.key.key->u.number = replay_get_qword();
+            evt.u.key.down = replay_get_byte();
             break;
         case KEY_VALUE_KIND_QCODE:
-            evt.u.key.data->key->u.qcode.data = (QKeyCode)replay_get_dword();
-            evt.u.key.data->down = replay_get_byte();
+            evt.u.key.key->u.qcode = (QKeyCode)replay_get_dword();
+            evt.u.key.down = replay_get_byte();
             break;
         case KEY_VALUE_KIND__MAX:
             /* keep gcc happy */
@@ -95,19 +90,16 @@ InputEvent *replay_read_input_event(void)
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        evt.u.btn.data = &btn;
-        evt.u.btn.data->button = (InputButton)replay_get_dword();
-        evt.u.btn.data->down = replay_get_byte();
+        evt.u.btn.button = (InputButton)replay_get_dword();
+        evt.u.btn.down = replay_get_byte();
         break;
     case INPUT_EVENT_KIND_REL:
-        evt.u.rel.data = &rel;
-        evt.u.rel.data->axis = (InputAxis)replay_get_dword();
-        evt.u.rel.data->value = replay_get_qword();
+        evt.u.rel.axis = (InputAxis)replay_get_dword();
+        evt.u.rel.value = replay_get_qword();
         break;
     case INPUT_EVENT_KIND_ABS:
-        evt.u.abs.data = &abs;
-        evt.u.abs.data->axis = (InputAxis)replay_get_dword();
-        evt.u.abs.data->value = replay_get_qword();
+        evt.u.abs.axis = (InputAxis)replay_get_dword();
+        evt.u.abs.value = replay_get_qword();
         break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
diff --git a/tests/test-char.c b/tests/test-char.c
index 9196e566e9..0e7a033a90 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1220,7 +1220,7 @@ static void char_file_fifo_test(void)
                          .has_in = true,
                          .out = out };
     ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
-                               .u.file.data = &file };
+                               .u.file = file };
     FeHandler fe = { 0, };
     int fd, ret;
 
@@ -1273,19 +1273,17 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
     char *out;
     Chardev *chr;
     char *contents = NULL;
-    ChardevFile file = {};
-    ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
-                               .u.file.data = &file };
+    ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE };
     gsize length;
     int ret;
 
     if (ext_chr) {
         chr = ext_chr;
         out = g_strdup(filepath);
-        file.out = out;
+        backend.u.file.out = out;
     } else {
         out = g_build_filename(tmp_path, "out", NULL);
-        file.out = out;
+        backend.u.file.out = out;
         chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
                                NULL, &error_abort);
     }
@@ -1384,7 +1382,7 @@ static void char_hotswap_test(void)
     char *filename = g_build_filename(tmp_path, "file", NULL);
     ChardevFile file = { .out = filename };
     ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
-                               .u.file.data = &file };
+                               .u.file = file };
     ChardevReturn *ret;
 
     int port;
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index 5e1e8b2f5e..0a62704bed 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -110,7 +110,7 @@ static void test_clone_complex1(void)
     dst = QAPI_CLONE(UserDefListUnion, src);
     g_assert(dst);
     g_assert_cmpint(dst->type, ==, src->type);
-    g_assert(!dst->u.string.data);
+    g_assert(!dst->u.string);
 
     qapi_free_UserDefListUnion(src);
     qapi_free_UserDefListUnion(dst);
@@ -155,30 +155,30 @@ static void test_clone_complex3(void)
     tmp = src->array = g_new0(__org_qemu_x_Union1List, 1);
     tmp->value = g_new0(__org_qemu_x_Union1, 1);
     tmp->value->type = ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
-    tmp->value->u.__org_qemu_x_branch.data = g_strdup("one");
+    tmp->value->u.__org_qemu_x_branch = g_strdup("one");
     tmp = tmp->next = g_new0(__org_qemu_x_Union1List, 1);
     tmp->value = g_new0(__org_qemu_x_Union1, 1);
     tmp->value->type = ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
-    tmp->value->u.__org_qemu_x_branch.data = g_strdup("two");
+    tmp->value->u.__org_qemu_x_branch = g_strdup("two");
     tmp = tmp->next = g_new0(__org_qemu_x_Union1List, 1);
     tmp->value = g_new0(__org_qemu_x_Union1, 1);
     tmp->value->type = ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
-    tmp->value->u.__org_qemu_x_branch.data = g_strdup("three");
+    tmp->value->u.__org_qemu_x_branch = g_strdup("three");
 
     dst = QAPI_CLONE(__org_qemu_x_Struct2, src);
     g_assert(dst);
     tmp = dst->array;
     g_assert(tmp);
     g_assert(tmp->value);
-    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch.data, ==, "one");
+    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch, ==, "one");
     tmp = tmp->next;
     g_assert(tmp);
     g_assert(tmp->value);
-    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch.data, ==, "two");
+    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch, ==, "two");
     tmp = tmp->next;
     g_assert(tmp);
     g_assert(tmp->value);
-    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch.data, ==, "three");
+    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch, ==, "three");
     tmp = tmp->next;
     g_assert(!tmp);
 
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index d3413bfef0..3d699fbb66 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -136,7 +136,7 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_qemu_x_EnumList *a,
     __org_qemu_x_Union1 *ret = g_new0(__org_qemu_x_Union1, 1);
 
     ret->type = ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
-    ret->u.__org_qemu_x_branch.data = strdup("blah1");
+    ret->u.__org_qemu_x_branch = strdup("blah1");
 
     /* Also test that 'wchar-t' was munged to 'q_wchar_t' */
     if (b && b->value && !b->value->has_q_wchar_t) {
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index e41b91a2a6..b976ab9763 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -710,7 +710,7 @@ static void test_list_union_integer_helper(TestInputVisitorData *data,
     switch (kind) {
     case USER_DEF_LIST_UNION_KIND_INTEGER: {
         intList *elem = NULL;
-        for (i = 0, elem = cvalue->u.integer.data;
+        for (i = 0, elem = cvalue->u.integer;
              elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
@@ -718,56 +718,56 @@ static void test_list_union_integer_helper(TestInputVisitorData *data,
     }
     case USER_DEF_LIST_UNION_KIND_S8: {
         int8List *elem = NULL;
-        for (i = 0, elem = cvalue->u.s8.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.s8; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S16: {
         int16List *elem = NULL;
-        for (i = 0, elem = cvalue->u.s16.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.s16; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S32: {
         int32List *elem = NULL;
-        for (i = 0, elem = cvalue->u.s32.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.s32; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S64: {
         int64List *elem = NULL;
-        for (i = 0, elem = cvalue->u.s64.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.s64; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U8: {
         uint8List *elem = NULL;
-        for (i = 0, elem = cvalue->u.u8.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.u8; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U16: {
         uint16List *elem = NULL;
-        for (i = 0, elem = cvalue->u.u16.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.u16; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U32: {
         uint32List *elem = NULL;
-        for (i = 0, elem = cvalue->u.u32.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.u32; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U64: {
         uint64List *elem = NULL;
-        for (i = 0, elem = cvalue->u.u64.data; elem; elem = elem->next, i++) {
+        for (i = 0, elem = cvalue->u.u64; elem; elem = elem->next, i++) {
             g_assert_cmpint(elem->value, ==, i);
         }
         break;
@@ -868,7 +868,7 @@ static void test_visitor_in_list_union_bool(TestInputVisitorData *data,
     g_assert(cvalue != NULL);
     g_assert_cmpint(cvalue->type, ==, USER_DEF_LIST_UNION_KIND_BOOLEAN);
 
-    for (i = 0, elem = cvalue->u.boolean.data; elem; elem = elem->next, i++) {
+    for (i = 0, elem = cvalue->u.boolean; elem; elem = elem->next, i++) {
         g_assert_cmpint(elem->value, ==, (i % 3 == 0) ? 1 : 0);
     }
 
@@ -900,7 +900,7 @@ static void test_visitor_in_list_union_string(TestInputVisitorData *data,
     g_assert(cvalue != NULL);
     g_assert_cmpint(cvalue->type, ==, USER_DEF_LIST_UNION_KIND_STRING);
 
-    for (i = 0, elem = cvalue->u.string.data; elem; elem = elem->next, i++) {
+    for (i = 0, elem = cvalue->u.string; elem; elem = elem->next, i++) {
         gchar str[8];
         sprintf(str, "%d", i);
         g_assert_cmpstr(elem->value, ==, str);
@@ -936,7 +936,7 @@ static void test_visitor_in_list_union_number(TestInputVisitorData *data,
     g_assert(cvalue != NULL);
     g_assert_cmpint(cvalue->type, ==, USER_DEF_LIST_UNION_KIND_NUMBER);
 
-    for (i = 0, elem = cvalue->u.number.data; elem; elem = elem->next, i++) {
+    for (i = 0, elem = cvalue->u.number; elem; elem = elem->next, i++) {
         GString *double_expected = g_string_new("");
         GString *double_actual = g_string_new("");
 
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 1c856d9bd2..202f848062 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -444,7 +444,7 @@ static void init_list_union(UserDefListUnion *cvalue)
     int i;
     switch (cvalue->type) {
     case USER_DEF_LIST_UNION_KIND_INTEGER: {
-        intList **list = &cvalue->u.integer.data;
+        intList **list = &cvalue->u.integer;
         for (i = 0; i < 32; i++) {
             *list = g_new0(intList, 1);
             (*list)->value = i;
@@ -454,7 +454,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S8: {
-        int8List **list = &cvalue->u.s8.data;
+        int8List **list = &cvalue->u.s8;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int8List, 1);
             (*list)->value = i;
@@ -464,7 +464,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S16: {
-        int16List **list = &cvalue->u.s16.data;
+        int16List **list = &cvalue->u.s16;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int16List, 1);
             (*list)->value = i;
@@ -474,7 +474,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S32: {
-        int32List **list = &cvalue->u.s32.data;
+        int32List **list = &cvalue->u.s32;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int32List, 1);
             (*list)->value = i;
@@ -484,7 +484,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_S64: {
-        int64List **list = &cvalue->u.s64.data;
+        int64List **list = &cvalue->u.s64;
         for (i = 0; i < 32; i++) {
             *list = g_new0(int64List, 1);
             (*list)->value = i;
@@ -494,7 +494,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U8: {
-        uint8List **list = &cvalue->u.u8.data;
+        uint8List **list = &cvalue->u.u8;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint8List, 1);
             (*list)->value = i;
@@ -504,7 +504,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U16: {
-        uint16List **list = &cvalue->u.u16.data;
+        uint16List **list = &cvalue->u.u16;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint16List, 1);
             (*list)->value = i;
@@ -514,7 +514,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U32: {
-        uint32List **list = &cvalue->u.u32.data;
+        uint32List **list = &cvalue->u.u32;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint32List, 1);
             (*list)->value = i;
@@ -524,7 +524,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_U64: {
-        uint64List **list = &cvalue->u.u64.data;
+        uint64List **list = &cvalue->u.u64;
         for (i = 0; i < 32; i++) {
             *list = g_new0(uint64List, 1);
             (*list)->value = i;
@@ -534,7 +534,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_BOOLEAN: {
-        boolList **list = &cvalue->u.boolean.data;
+        boolList **list = &cvalue->u.boolean;
         for (i = 0; i < 32; i++) {
             *list = g_new0(boolList, 1);
             (*list)->value = QEMU_IS_ALIGNED(i, 3);
@@ -544,7 +544,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_STRING: {
-        strList **list = &cvalue->u.string.data;
+        strList **list = &cvalue->u.string;
         for (i = 0; i < 32; i++) {
             *list = g_new0(strList, 1);
             (*list)->value = g_strdup_printf("%d", i);
@@ -554,7 +554,7 @@ static void init_list_union(UserDefListUnion *cvalue)
         break;
     }
     case USER_DEF_LIST_UNION_KIND_NUMBER: {
-        numberList **list = &cvalue->u.number.data;
+        numberList **list = &cvalue->u.number;
         for (i = 0; i < 32; i++) {
             *list = g_new0(numberList, 1);
             (*list)->value = (double)i / 3;
diff --git a/ui/console.c b/ui/console.c
index 820e408170..2f93723ed6 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2212,7 +2212,7 @@ static void vc_chr_open(Chardev *chr,
                         bool *be_opened,
                         Error **errp)
 {
-    ChardevVC *vc = backend->u.vc.data;
+    ChardevVC *vc = &backend->u.vc;
     VCChardev *drv = VC_CHARDEV(chr);
     QemuConsole *s;
     unsigned width = 0;
@@ -2362,10 +2362,9 @@ void qemu_display_help(void)
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     int val;
-    ChardevVC *vc;
+    ChardevVC *vc = &backend->u.vc;
 
     backend->type = CHARDEV_BACKEND_KIND_VC;
-    vc = backend->u.vc.data = g_new0(ChardevVC, 1);
     qemu_chr_parse_common(opts, qapi_ChardevVC_base(vc));
 
     val = qemu_opt_get_number(opts, "width", 0);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 1b756a6970..0232e25124 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -33,13 +33,13 @@ int qemu_input_linux_to_qcode(unsigned int lnx)
 int qemu_input_key_value_to_number(const KeyValue *value)
 {
     if (value->type == KEY_VALUE_KIND_QCODE) {
-        if (value->u.qcode.data >= qemu_input_map_qcode_to_qnum_len) {
+        if (value->u.qcode >= qemu_input_map_qcode_to_qnum_len) {
             return 0;
         }
-        return qemu_input_map_qcode_to_qnum[value->u.qcode.data];
+        return qemu_input_map_qcode_to_qnum[value->u.qcode];
     } else {
         assert(value->type == KEY_VALUE_KIND_NUMBER);
-        return value->u.number.data;
+        return value->u.number;
     }
 }
 
@@ -54,10 +54,10 @@ int qemu_input_key_number_to_qcode(unsigned int nr)
 int qemu_input_key_value_to_qcode(const KeyValue *value)
 {
     if (value->type == KEY_VALUE_KIND_QCODE) {
-        return value->u.qcode.data;
+        return value->u.qcode;
     } else {
         assert(value->type == KEY_VALUE_KIND_NUMBER);
-        return qemu_input_key_number_to_qcode(value->u.number.data);
+        return qemu_input_key_number_to_qcode(value->u.number);
     }
 }
 
@@ -68,7 +68,7 @@ int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
     int count = 0;
 
     if (value->type == KEY_VALUE_KIND_QCODE &&
-        value->u.qcode.data == Q_KEY_CODE_PAUSE) {
+        value->u.qcode == Q_KEY_CODE_PAUSE) {
         /* specific case */
         int v = down ? 0 : 0x80;
         codes[count++] = 0xe1;
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 9fc78a639b..5a32b010d4 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -75,9 +75,9 @@ static KeyValue *copy_key_value(KeyValue *src)
     KeyValue *dst = g_new(KeyValue, 1);
     memcpy(dst, src, sizeof(*src));
     if (dst->type == KEY_VALUE_KIND_NUMBER) {
-        QKeyCode code = qemu_input_key_number_to_qcode(dst->u.number.data);
+        QKeyCode code = qemu_input_key_number_to_qcode(dst->u.number);
         dst->type = KEY_VALUE_KIND_QCODE;
-        dst->u.qcode.data = code;
+        dst->u.qcode = code;
     }
     return dst;
 }
@@ -113,7 +113,7 @@ static void legacy_kbd_event(DeviceState *dev, QemuConsole *src,
 {
     QEMUPutKbdEntry *entry = (QEMUPutKbdEntry *)dev;
     int scancodes[3], i, count;
-    InputKeyEvent *key = evt->u.key.data;
+    InputKeyEvent *key = &evt->u.key;
 
     if (!entry || !entry->put_kbd) {
         return;
@@ -159,7 +159,7 @@ static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         if (btn->down) {
             s->buttons |= bmap[btn->button];
         } else {
@@ -181,11 +181,11 @@ static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
         }
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         s->axis[move->axis] = move->value;
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         s->axis[move->axis] += move->value;
         break;
     default:
diff --git a/ui/input.c b/ui/input.c
index 4791b089c7..a4078780ee 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -164,10 +164,10 @@ void qmp_input_send_event(bool has_device, const char *device,
         InputEvent *evt = e->value;
 
         if (evt->type == INPUT_EVENT_KIND_KEY &&
-            evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER) {
-            KeyValue *key = evt->u.key.data->key;
-            QKeyCode code = qemu_input_key_number_to_qcode(key->u.number.data);
-            qemu_input_event_send_key_qcode(con, code, evt->u.key.data->down);
+            evt->u.key.key->type == KEY_VALUE_KIND_NUMBER) {
+            KeyValue *key = evt->u.key.key;
+            QKeyCode code = qemu_input_key_number_to_qcode(key->u.number);
+            qemu_input_event_send_key_qcode(con, code, evt->u.key.down);
         } else {
             qemu_input_event_send(con, evt);
         }
@@ -183,7 +183,7 @@ static int qemu_input_transform_invert_abs_value(int value)
 
 static void qemu_input_transform_abs_rotate(InputEvent *evt)
 {
-    InputMoveEvent *move = evt->u.abs.data;
+    InputMoveEvent *move = &evt->u.abs;
     switch (graphic_rotate) {
     case 90:
         if (move->axis == INPUT_AXIS_X) {
@@ -220,16 +220,16 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
     }
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        key = evt->u.key.data;
+        key = &evt->u.key;
         switch (key->key->type) {
         case KEY_VALUE_KIND_NUMBER:
-            qcode = qemu_input_key_number_to_qcode(key->key->u.number.data);
+            qcode = qemu_input_key_number_to_qcode(key->key->u.number);
             name = QKeyCode_str(qcode);
-            trace_input_event_key_number(idx, key->key->u.number.data,
+            trace_input_event_key_number(idx, key->key->u.number,
                                          name, key->down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            name = QKeyCode_str(key->key->u.qcode.data);
+            name = QKeyCode_str(key->key->u.qcode);
             trace_input_event_key_qcode(idx, name, key->down);
             break;
         case KEY_VALUE_KIND__MAX:
@@ -238,17 +238,17 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->u.btn;
         name = InputButton_str(btn->button);
         trace_input_event_btn(idx, name, btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->u.rel;
         name = InputAxis_str(move->axis);
         trace_input_event_rel(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->u.abs;
         name = InputAxis_str(move->axis);
         trace_input_event_abs(idx, name, move->value);
         break;
@@ -355,7 +355,7 @@ void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
     /* Expect all parts of QEMU to send events with QCodes exclusively.
      * Key numbers are only supported as end-user input via QMP */
     assert(!(evt->type == INPUT_EVENT_KIND_KEY &&
-             evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER));
+             evt->u.key.key->type == KEY_VALUE_KIND_NUMBER));
 
 
     /*
@@ -367,8 +367,8 @@ void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
      * neeed to deal with this mistake
      */
     if (evt->type == INPUT_EVENT_KIND_KEY &&
-        evt->u.key.data->key->u.qcode.data == Q_KEY_CODE_SYSRQ) {
-        evt->u.key.data->key->u.qcode.data = Q_KEY_CODE_PRINT;
+        evt->u.key.key->u.qcode == Q_KEY_CODE_SYSRQ) {
+        evt->u.key.key->u.qcode = Q_KEY_CODE_PRINT;
     }
 
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
@@ -407,10 +407,9 @@ void qemu_input_event_sync(void)
 static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
 {
     InputEvent *evt = g_new0(InputEvent, 1);
-    evt->u.key.data = g_new0(InputKeyEvent, 1);
     evt->type = INPUT_EVENT_KIND_KEY;
-    evt->u.key.data->key = key;
-    evt->u.key.data->down = down;
+    evt->u.key.key = key;
+    evt->u.key.down = down;
     return evt;
 }
 
@@ -440,7 +439,7 @@ void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
 {
     KeyValue *key = g_new0(KeyValue, 1);
     key->type = KEY_VALUE_KIND_QCODE;
-    key->u.qcode.data = q;
+    key->u.qcode = q;
     qemu_input_event_send_key(src, key, down);
 }
 
@@ -469,7 +468,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
     };
     InputEvent evt = {
         .type = INPUT_EVENT_KIND_BTN,
-        .u.btn.data = &bevt,
+        .u.btn = bevt,
     };
 
     qemu_input_event_send(src, &evt);
@@ -520,7 +519,7 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
     };
     InputEvent evt = {
         .type = INPUT_EVENT_KIND_REL,
-        .u.rel.data = &move,
+        .u.rel = move,
     };
 
     qemu_input_event_send(src, &evt);
@@ -537,7 +536,7 @@ void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
     };
     InputEvent evt = {
         .type = INPUT_EVENT_KIND_ABS,
-        .u.abs.data = &move,
+        .u.abs = move,
     };
 
     qemu_input_event_send(src, &evt);
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 05e5c73f9d..59e317cbb8 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1365,21 +1365,21 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
     case SOCKET_ADDRESS_LEGACY_KIND_INET:
         addr->type = SOCKET_ADDRESS_TYPE_INET;
         QAPI_CLONE_MEMBERS(InetSocketAddress, &addr->u.inet,
-                           addr_legacy->u.inet.data);
+                           &addr_legacy->u.inet);
         break;
     case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
         addr->type = SOCKET_ADDRESS_TYPE_UNIX;
         QAPI_CLONE_MEMBERS(UnixSocketAddress, &addr->u.q_unix,
-                           addr_legacy->u.q_unix.data);
+                           &addr_legacy->u.q_unix);
         break;
     case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
         addr->type = SOCKET_ADDRESS_TYPE_VSOCK;
         QAPI_CLONE_MEMBERS(VsockSocketAddress, &addr->u.vsock,
-                           addr_legacy->u.vsock.data);
+                           &addr_legacy->u.vsock);
         break;
     case SOCKET_ADDRESS_LEGACY_KIND_FD:
         addr->type = SOCKET_ADDRESS_TYPE_FD;
-        QAPI_CLONE_MEMBERS(String, &addr->u.fd, addr_legacy->u.fd.data);
+        QAPI_CLONE_MEMBERS(String, &addr->u.fd, &addr_legacy->u.fd);
         break;
     default:
         abort();
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index fafec94e02..1c4e3407a3 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -188,7 +188,12 @@ const QLitObject %(c_name)s = %(c_string)s;
                 'variants': [self._gen_variant(v) for v in variants]}
 
     def _gen_variant(self, variant):
-        obj = {'case': variant.name, 'type': self._use_type(variant.type)}
+        if variant.wrapped:
+            obj = {'case': variant.name,
+                   'type': self._use_type(variant.wrapper_type)}
+        else:
+            obj = {'case': variant.name,
+                   'type': self._use_type(variant.type)}
         return _make_tree(obj, variant.ifcond, None)
 
     def visit_builtin_type(self, name, info, json_type):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 720449feee..17525b4216 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -216,6 +216,11 @@ class QAPISchemaBuiltinType(QAPISchemaType):
         self._json_type_name = json_type
         self._c_type_name = c_type
 
+    def check(self, schema):
+        # Don't check twice, it would fail an assertion
+        if not self._checked:
+            super().check(schema)
+
     def c_name(self):
         return self.name
 
@@ -593,18 +598,21 @@ class QAPISchemaVariants:
                         "branch '%s' is not a value of %s"
                         % (v.name, self.tag_member.type.describe()))
                 if (not isinstance(v.type, QAPISchemaObjectType)
-                        or v.type.variants):
+                        or v.type.variants) and v.flat:
                     raise QAPISemError(
                         self.info,
                         "%s cannot use %s"
                         % (v.describe(self.info), v.type.describe()))
-                v.type.check(schema)
+                if isinstance(v.type, QAPISchemaObjectType):
+                    v.type.check(schema)
 
     def check_clash(self, info, seen):
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
-            # branch do not affect another branch
-            v.type.check_clash(info, dict(seen))
+            # branch do not affect another branch.  Variants that are
+            # never flat don't even conflict with the base.
+            if isinstance(v.type, QAPISchemaObjectType):
+                v.type.check_clash(info, dict(seen) if v.flat else {})
 
 
 class QAPISchemaMember:
@@ -705,9 +713,22 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
 class QAPISchemaVariant(QAPISchemaObjectTypeMember):
     role = 'branch'
 
-    def __init__(self, name, info, typ, ifcond=None):
+    def __init__(self, name, info, typ, ifcond=None, flat=True,
+                 wrapper_type=None):
         super().__init__(name, info, typ, False, ifcond)
 
+        self.flat = flat
+        self.wrapped = bool(wrapper_type)
+        self.wrapper_type = wrapper_type
+
+        # For now, unions are either flat or wrapped, never both
+        assert self.flat or self.wrapped
+        assert not (self.flat and self.wrapped)
+
+    def check(self, schema):
+        super().check(schema)
+        if self.wrapped:
+            self.wrapper_type.check(schema)
 
 class QAPISchemaCommand(QAPISchemaEntity):
     meta = 'command'
@@ -1017,14 +1038,19 @@ class QAPISchema:
     def _make_variant(self, case, typ, ifcond, info):
         return QAPISchemaVariant(case, info, typ, ifcond)
 
-    def _make_simple_variant(self, case, typ, ifcond, info):
+    def _make_simple_variant(self, union_name, case, typ, ifcond, info):
         if isinstance(typ, list):
             assert len(typ) == 1
             typ = self._make_array_type(typ[0], info)
-        typ = self._make_implicit_object_type(
-            typ, info, self.lookup_type(typ),
-            'wrapper', [self._make_member('data', typ, None, None, info)])
-        return QAPISchemaVariant(case, info, typ, ifcond)
+
+        # The wrapper type is only used for introspection compatibility.
+        # Don't add it to the entity list of the schema.
+        wrapper_name = 'q_obj_%s-%s-wrapper' % (union_name, case)
+        wrapper_member = self._make_member('data', typ, None, None, info)
+        wrapper_type = QAPISchemaObjectType(wrapper_name, info, None, ifcond,
+                                            None, None, [wrapper_member], None)
+        return QAPISchemaVariant(case, info, typ, ifcond, flat=False,
+                                 wrapper_type=wrapper_type)
 
     def _def_union_type(self, expr, info, doc):
         name = expr['union']
@@ -1044,7 +1070,7 @@ class QAPISchema:
                         for (key, value) in data.items()]
             members = []
         else:
-            variants = [self._make_simple_variant(key, value['type'],
+            variants = [self._make_simple_variant(name, key, value['type'],
                                                   value.get('if'), info)
                         for (key, value) in data.items()]
             enum = [{'name': v.name, 'if': v.ifcond} for v in variants]
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 339f152152..f72567cbcc 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -118,6 +118,34 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
         break;
 ''',
                              case=case_str)
+            elif not isinstance(var.type, QAPISchemaObjectType):
+                assert not var.flat
+                ret += mcgen('''
+    case %(case)s:
+        return visit_type_%(c_type)s(v, "data", &obj->u.%(c_name)s, errp);
+''',
+                             case=case_str,
+                             c_type=var.type.c_name(), c_name=c_name(var.name))
+            elif var.wrapped:
+                ret += mcgen('''
+    case %(case)s:
+    {
+        bool ok;
+
+        if (!visit_start_struct(v, "data", NULL, 0, errp)) {
+            return false;
+        }
+        ok = visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, errp);
+        if (ok) {
+            ok = visit_check_struct(v, errp);
+        }
+        visit_end_struct(v, NULL);
+        return ok;
+    }
+''',
+                             case=case_str,
+                             c_type=var.type.c_name(), c_name=c_name(var.name))
+
             else:
                 ret += mcgen('''
     case %(case)s:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 419284dae2..bcbcbd2fce 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -31,10 +31,6 @@ object Object
     case two: Variant2
         if ['IFTWO']
     feature union-feat1
-object q_obj_Variant1-wrapper
-    member data: Variant1 optional=False
-object q_obj_Variant2-wrapper
-    member data: Variant2 optional=False
 enum SugaredUnionKind
     member one
     member two
@@ -42,8 +38,8 @@ enum SugaredUnionKind
 object SugaredUnion
     member type: SugaredUnionKind optional=False
     tag type
-    case one: q_obj_Variant1-wrapper
-    case two: q_obj_Variant2-wrapper
+    case one: Variant1
+    case two: Variant2
         if ['IFTWO']
     feature union-feat2
 alternate Alternate
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 8868ca0dca..a4e4051c61 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -125,36 +125,6 @@ alternate AltStrObj
     tag type
     case s: str
     case o: TestStruct
-object q_obj_intList-wrapper
-    member data: intList optional=False
-object q_obj_int8List-wrapper
-    member data: int8List optional=False
-object q_obj_int16List-wrapper
-    member data: int16List optional=False
-object q_obj_int32List-wrapper
-    member data: int32List optional=False
-object q_obj_int64List-wrapper
-    member data: int64List optional=False
-object q_obj_uint8List-wrapper
-    member data: uint8List optional=False
-object q_obj_uint16List-wrapper
-    member data: uint16List optional=False
-object q_obj_uint32List-wrapper
-    member data: uint32List optional=False
-object q_obj_uint64List-wrapper
-    member data: uint64List optional=False
-object q_obj_numberList-wrapper
-    member data: numberList optional=False
-object q_obj_boolList-wrapper
-    member data: boolList optional=False
-object q_obj_strList-wrapper
-    member data: strList optional=False
-object q_obj_sizeList-wrapper
-    member data: sizeList optional=False
-object q_obj_anyList-wrapper
-    member data: anyList optional=False
-object q_obj_StatusList-wrapper
-    member data: StatusList optional=False
 enum UserDefListUnionKind
     member integer
     member s8
@@ -174,21 +144,21 @@ enum UserDefListUnionKind
 object UserDefListUnion
     member type: UserDefListUnionKind optional=False
     tag type
-    case integer: q_obj_intList-wrapper
-    case s8: q_obj_int8List-wrapper
-    case s16: q_obj_int16List-wrapper
-    case s32: q_obj_int32List-wrapper
-    case s64: q_obj_int64List-wrapper
-    case u8: q_obj_uint8List-wrapper
-    case u16: q_obj_uint16List-wrapper
-    case u32: q_obj_uint32List-wrapper
-    case u64: q_obj_uint64List-wrapper
-    case number: q_obj_numberList-wrapper
-    case boolean: q_obj_boolList-wrapper
-    case string: q_obj_strList-wrapper
-    case sizes: q_obj_sizeList-wrapper
-    case any: q_obj_anyList-wrapper
-    case user: q_obj_StatusList-wrapper
+    case integer: intList
+    case s8: int8List
+    case s16: int16List
+    case s32: int32List
+    case s64: int64List
+    case u8: uint8List
+    case u16: uint16List
+    case u32: uint32List
+    case u64: uint64List
+    case number: numberList
+    case boolean: boolList
+    case string: strList
+    case sizes: sizeList
+    case any: anyList
+    case user: StatusList
 include include/sub-module.json
 command user_def_cmd None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
@@ -263,14 +233,12 @@ object __org.qemu_x-Struct
     base __org.qemu_x-Base
     member __org.qemu_x-member2: str optional=False
     member wchar-t: int optional=True
-object q_obj_str-wrapper
-    member data: str optional=False
 enum __org.qemu_x-Union1Kind
     member __org.qemu_x-branch
 object __org.qemu_x-Union1
     member type: __org.qemu_x-Union1Kind optional=False
     tag type
-    case __org.qemu_x-branch: q_obj_str-wrapper
+    case __org.qemu_x-branch: str
 alternate __org.qemu_x-Alt1
     tag type
     case __org.qemu_x-branch: str
@@ -305,8 +273,6 @@ enum TestIfEnum
     member bar
         if ['defined(TEST_IF_ENUM_BAR)']
     if ['defined(TEST_IF_ENUM)']
-object q_obj_TestStruct-wrapper
-    member data: TestStruct optional=False
 enum TestIfUnionKind
     member foo
     member union_bar
@@ -315,8 +281,8 @@ enum TestIfUnionKind
 object TestIfUnion
     member type: TestIfUnionKind optional=False
     tag type
-    case foo: q_obj_TestStruct-wrapper
-    case union_bar: q_obj_str-wrapper
+    case foo: TestStruct
+    case union_bar: str
         if ['defined(TEST_IF_UNION_BAR)']
     if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object q_obj_TestIfUnionCmd-arg
-- 
2.28.0


