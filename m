Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D9C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A17B20657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTFJ-0000j5-S6
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSxP-00021Q-IX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSxL-00067L-FH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSxB-0005fg-3q; Mon, 24 Jun 2019 13:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E88596696C;
 Mon, 24 Jun 2019 17:40:15 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB37260BE2;
 Mon, 24 Jun 2019 17:40:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:34 +0200
Message-Id: <20190624173935.25747-15-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 24 Jun 2019 17:40:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 14/14] block: Make use of QAPI defaults
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes most of block-core.json to use QAPI defaults where
possible.

Notably omitted is everything around BlockdevOptions*, because that
would change json:{} filenames (which is technically not an incompatible
change, it would just break many iotests).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 144 +++++++++++++++++++++-------------
 block/file-posix.c   |   9 ---
 block/file-win32.c   |   8 +-
 block/parallels.c    |   6 +-
 block/qcow2.c        |  36 +++------
 block/qed.c          |   3 -
 block/sheepdog.c     |   3 -
 block/vdi.c          |   3 -
 block/vhdx.c         |  28 ++-----
 block/vpc.c          |   3 -
 blockdev.c           | 182 +++++++++----------------------------------
 monitor/hmp-cmds.c   |  27 ++++---
 monitor/qmp-cmds.c   |   3 +-
 13 files changed, 165 insertions(+), 290 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b30a19bf8e..5d5c0c4b81 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1300,7 +1300,8 @@
 { 'struct': 'BlockdevSnapshotSync',
   'data': { '*device': 'str', '*node-name': 'str',
             'snapshot-file': 'str', '*snapshot-node-name': 'str',
-            '*format': 'str', '*mode': 'NewImageMode' } }
+            '*format': { 'type': 'str', 'default': 'qcow2' },
+            '*mode': { 'type': 'NewImageMode', 'default': 'absolute-path=
s' } } }
=20
 ##
 # @BlockdevSnapshot:
@@ -1378,11 +1379,16 @@
 { 'struct': 'DriveBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', 'sync': 'MirrorSyncMode',
-            '*mode': 'NewImageMode', '*speed': 'int',
-            '*bitmap': 'str', '*compress': 'bool',
-            '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*mode': { 'type': 'NewImageMode', 'default': 'absolute-path=
s' },
+            '*speed': { 'type': 'int', 'default': 0 },
+            '*bitmap': 'str',
+            '*compress': { 'type': 'bool', 'default': false },
+            '*on-source-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*on-target-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*auto-finalize': { 'type': 'bool', 'default': true },
+            '*auto-dismiss': { 'type': 'bool', 'default': true } } }
=20
 ##
 # @BlockdevBackup:
@@ -1437,11 +1443,16 @@
 ##
 { 'struct': 'BlockdevBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            'sync': 'MirrorSyncMode', '*speed': 'int',
-            '*bitmap': 'str', '*compress': 'bool',
-            '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            'sync': 'MirrorSyncMode',
+            '*speed': { 'type': 'int', 'default': 0 },
+            '*bitmap': 'str',
+            '*compress': { 'type': 'bool', 'default': false },
+            '*on-source-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*on-target-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*auto-finalize': { 'type': 'bool', 'default': true },
+            '*auto-dismiss': { 'type': 'bool', 'default': true } } }
=20
 ##
 # @blockdev-snapshot-sync:
@@ -1631,9 +1642,11 @@
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
             '*base': 'str', '*top-node': 'str', '*top': 'str',
-            '*backing-file': 'str', '*speed': 'int',
+            '*backing-file': 'str',
+            '*speed': { 'type': 'int', 'default': 0 },
             '*filter-node-name': 'str',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*auto-finalize': { 'type': 'bool', 'default': true },
+            '*auto-dismiss': { 'type': 'bool', 'default': true } } }
=20
 ##
 # @drive-backup:
@@ -1958,12 +1971,19 @@
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
-            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*granularity': 'uint32',
-            '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError',
-            '*unmap': 'bool', '*copy-mode': 'MirrorCopyMode',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            'sync': 'MirrorSyncMode',
+            '*mode': { 'type': 'NewImageMode', 'default': 'absolute-path=
s' },
+            '*speed': { 'type': 'int', 'default': 0 },
+            '*granularity': 'uint32',
+            '*buf-size': 'int',
+            '*on-source-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*on-target-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*unmap': { 'type': 'bool', 'default': true },
+            '*copy-mode': { 'type': 'MirrorCopyMode', 'default': 'backgr=
ound' },
+            '*auto-finalize': { 'type': 'bool', 'default': true },
+            '*auto-dismiss': { 'type': 'bool', 'default': true } } }
=20
 ##
 # @BlockDirtyBitmap:
@@ -1984,8 +2004,8 @@
 #
 # @name: name of the dirty bitmap
 #
-# @granularity: the bitmap granularity, default is 64k for
-#               block-dirty-bitmap-add
+# @granularity: the bitmap granularity, default is the node's cluster si=
ze
+#               (clamped to [4k, 64k]), or 64k
 #
 # @persistent: the bitmap is persistent, i.e. it will be saved to the
 #              corresponding block device image file on its close. For n=
ow only
@@ -2004,7 +2024,9 @@
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bo=
ol' } }
+            '*persistent': { 'type': 'bool', 'default': false },
+            '*autoload': 'bool',
+            '*disabled': { 'type': 'bool', 'default': false } } }
=20
 ##
 # @BlockDirtyBitmapMergeSource:
@@ -2282,12 +2304,17 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
             'sync': 'MirrorSyncMode',
-            '*speed': 'int', '*granularity': 'uint32',
-            '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError',
+            '*speed': { 'type': 'int', 'default': 0 },
+            '*granularity': 'uint32',
+            '*buf-size': 'int',
+            '*on-source-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
+            '*on-target-error': { 'type': 'BlockdevOnError',
+                                  'default': 'report' },
             '*filter-node-name': 'str',
-            '*copy-mode': 'MirrorCopyMode',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*copy-mode': { 'type': 'MirrorCopyMode', 'default': 'backgr=
ound' },
+            '*auto-finalize': { 'type': 'bool', 'default': true },
+            '*auto-dismiss': { 'type': 'bool', 'default': true } } }
=20
 ##
 # @block_set_io_throttle:
@@ -2580,9 +2607,11 @@
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
-            '*base-node': 'str', '*backing-file': 'str', '*speed': 'int'=
,
-            '*on-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+            '*base-node': 'str', '*backing-file': 'str',
+            '*speed': { 'type': 'int', 'default': 0 },
+            '*on-error': { 'type': 'BlockdevOnError', 'default': 'report=
' },
+            '*auto-finalize': { 'type': 'bool', 'default': true },
+            '*auto-dismiss': { 'type': 'bool', 'default': true } } }
=20
 ##
 # @block-job-set-speed:
@@ -4204,8 +4233,8 @@
 { 'struct': 'BlockdevCreateOptionsFile',
   'data': { 'filename':         'str',
             'size':             'size',
-            '*preallocation':   'PreallocMode',
-            '*nocow':           'bool' } }
+            '*preallocation':   { 'type': 'PreallocMode', 'default': 'of=
f' },
+            '*nocow':           { 'type': 'bool', 'default': false } } }
=20
 ##
 # @BlockdevCreateOptionsGluster:
@@ -4224,7 +4253,7 @@
 { 'struct': 'BlockdevCreateOptionsGluster',
   'data': { 'location':         'BlockdevOptionsGluster',
             'size':             'size',
-            '*preallocation':   'PreallocMode' } }
+            '*preallocation':   { 'type': 'PreallocMode', 'default': 'of=
f' } } }
=20
 ##
 # @BlockdevCreateOptionsLUKS:
@@ -4269,7 +4298,7 @@
 { 'struct': 'BlockdevCreateOptionsParallels',
   'data': { 'file':             'BlockdevRef',
             'size':             'size',
-            '*cluster-size':    'size' } }
+            '*cluster-size':    { 'type': 'size', 'default': 1048576 } }=
 }
=20
 ##
 # @BlockdevCreateOptionsQcow:
@@ -4331,16 +4360,16 @@
 { 'struct': 'BlockdevCreateOptionsQcow2',
   'data': { 'file':             'BlockdevRef',
             '*data-file':       'BlockdevRef',
-            '*data-file-raw':   'bool',
+            '*data-file-raw':   { 'type': 'bool', 'default': false },
             'size':             'size',
-            '*version':         'BlockdevQcow2Version',
+            '*version':         { 'type': 'BlockdevQcow2Version', 'defau=
lt': 'v3' },
             '*backing-file':    'str',
             '*backing-fmt':     'BlockdevDriver',
             '*encrypt':         'QCryptoBlockCreateOptions',
-            '*cluster-size':    'size',
-            '*preallocation':   'PreallocMode',
-            '*lazy-refcounts':  'bool',
-            '*refcount-bits':   'int' } }
+            '*cluster-size':    { 'type': 'size', 'default': 65536 },
+            '*preallocation':   { 'type': 'PreallocMode', 'default': 'of=
f' },
+            '*lazy-refcounts':  { 'type': 'bool', 'default': false },
+            '*refcount-bits':   { 'type': 'int', 'default': 16 } } }
=20
 ##
 # @BlockdevCreateOptionsQed:
@@ -4362,7 +4391,7 @@
             'size':             'size',
             '*backing-file':    'str',
             '*backing-fmt':     'BlockdevDriver',
-            '*cluster-size':    'size',
+            '*cluster-size':    { 'type': 'size', 'default': 65536 },
             '*table-size':      'int' } }
=20
 ##
@@ -4445,11 +4474,13 @@
   'data': { 'file':             'BlockdevRef',
             'size':             'size',
             '*extents':          ['BlockdevRef'],
-            '*subformat':       'BlockdevVmdkSubformat',
+            '*subformat':       { 'type': 'BlockdevVmdkSubformat',
+                                  'default': 'monolithicSparse' },
             '*backing-file':    'str',
-            '*adapter-type':    'BlockdevVmdkAdapterType',
-            '*hwversion':       'str',
-            '*zeroed-grain':    'bool' } }
+            '*adapter-type':    { 'type': 'BlockdevVmdkAdapterType',
+                                  'default': 'ide' },
+            '*hwversion':       { 'type': 'str', 'default': '4' },
+            '*zeroed-grain':    { 'type': 'bool', 'default': false } } }
=20
=20
 ##
@@ -4516,7 +4547,7 @@
   'data': { 'location':         'BlockdevOptionsSheepdog',
             'size':             'size',
             '*backing-file':    'str',
-            '*preallocation':   'PreallocMode',
+            '*preallocation':   { 'type': 'PreallocMode', 'default': 'of=
f' },
             '*redundancy':      'SheepdogRedundancy',
             '*object-size':     'size' } }
=20
@@ -4549,7 +4580,7 @@
 { 'struct': 'BlockdevCreateOptionsVdi',
   'data': { 'file':             'BlockdevRef',
             'size':             'size',
-            '*preallocation':   'PreallocMode' } }
+            '*preallocation':   { 'type': 'PreallocMode', 'default': 'of=
f' } } }
=20
 ##
 # @BlockdevVhdxSubformat:
@@ -4584,10 +4615,11 @@
 { 'struct': 'BlockdevCreateOptionsVhdx',
   'data': { 'file':                 'BlockdevRef',
             'size':                 'size',
-            '*log-size':            'size',
+            '*log-size':            { 'type': 'size', 'default': 1048576=
 },
             '*block-size':          'size',
-            '*subformat':           'BlockdevVhdxSubformat',
-            '*block-state-zero':    'bool' } }
+            '*subformat':           { 'type': 'BlockdevVhdxSubformat',
+                                      'default': 'dynamic' },
+            '*block-state-zero':    { 'type': 'bool', 'default': true } =
} }
=20
 ##
 # @BlockdevVpcSubformat:
@@ -4607,7 +4639,7 @@
 #
 # @file             Node to create the image format on
 # @size             Size of the virtual disk in bytes
-# @subformat        vhdx subformat (default: dynamic)
+# @subformat        vpc subformat (default: dynamic)
 # @force-size       Force use of the exact byte size instead of rounding=
 to the
 #                   next size that can be represented in CHS geometry
 #                   (default: false)
@@ -4617,8 +4649,9 @@
 { 'struct': 'BlockdevCreateOptionsVpc',
   'data': { 'file':                 'BlockdevRef',
             'size':                 'size',
-            '*subformat':           'BlockdevVpcSubformat',
-            '*force-size':          'bool' } }
+            '*subformat':           { 'type': 'BlockdevVpcSubformat',
+                                      'default': 'dynamic' },
+            '*force-size':          { 'type': 'bool', 'default': false }=
 } }
=20
 ##
 # @BlockdevCreateOptions:
@@ -4714,7 +4747,7 @@
 { 'command': 'blockdev-open-tray',
   'data': { '*device': 'str',
             '*id': 'str',
-            '*force': 'bool' } }
+            '*force': { 'type': 'bool', 'default': false } } }
=20
 ##
 # @blockdev-close-tray:
@@ -4905,7 +4938,8 @@
             '*id': 'str',
             'filename': 'str',
             '*format': 'str',
-            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
+            '*read-only-mode': { 'type': 'BlockdevChangeReadOnlyMode',
+                                 'default': 'retain' } } }
=20
=20
 ##
diff --git a/block/file-posix.c b/block/file-posix.c
index ab05b51a66..88ac031e9f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2243,13 +2243,6 @@ raw_co_create(BlockdevCreateOptions *options, Erro=
r **errp)
     assert(options->driver =3D=3D BLOCKDEV_DRIVER_FILE);
     file_opts =3D &options->u.file;
=20
-    if (!file_opts->has_nocow) {
-        file_opts->nocow =3D false;
-    }
-    if (!file_opts->has_preallocation) {
-        file_opts->preallocation =3D PREALLOC_MODE_OFF;
-    }
-
     /* Create file */
     fd =3D qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0=
644);
     if (fd < 0) {
@@ -2365,9 +2358,7 @@ static int coroutine_fn raw_co_create_opts(const ch=
ar *filename, QemuOpts *opts,
         .u.file     =3D {
             .filename           =3D (char *) filename,
             .size               =3D total_size,
-            .has_preallocation  =3D true,
             .preallocation      =3D prealloc,
-            .has_nocow          =3D true,
             .nocow              =3D nocow,
         },
     };
diff --git a/block/file-win32.c b/block/file-win32.c
index 6b2d67b239..9164b3d77c 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -565,11 +565,11 @@ static int raw_co_create(BlockdevCreateOptions *opt=
ions, Error **errp)
     assert(options->driver =3D=3D BLOCKDEV_DRIVER_FILE);
     file_opts =3D &options->u.file;
=20
-    if (file_opts->has_preallocation) {
+    if (file_opts->preallocation) {
         error_setg(errp, "Preallocation is not supported on Windows");
         return -EINVAL;
     }
-    if (file_opts->has_nocow) {
+    if (file_opts->nocow) {
         error_setg(errp, "nocow is not supported on Windows");
         return -EINVAL;
     }
@@ -604,8 +604,8 @@ static int coroutine_fn raw_co_create_opts(const char=
 *filename, QemuOpts *opts,
         .u.file     =3D {
             .filename           =3D (char *) filename,
             .size               =3D total_size,
-            .has_preallocation  =3D false,
-            .has_nocow          =3D false,
+            .preallocation      =3D false,
+            .nocow              =3D false,
         },
     };
     return raw_co_create(&options, errp);
diff --git a/block/parallels.c b/block/parallels.c
index 00fae125d1..67de90bd51 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -522,11 +522,7 @@ static int coroutine_fn parallels_co_create(Blockdev=
CreateOptions* opts,
     /* Sanity checks */
     total_size =3D parallels_opts->size;
=20
-    if (parallels_opts->has_cluster_size) {
-        cl_size =3D parallels_opts->cluster_size;
-    } else {
-        cl_size =3D DEFAULT_CLUSTER_SIZE;
-    }
+    cl_size =3D parallels_opts->cluster_size;
=20
     /* XXX What is the real limit here? This is an insanely large maximu=
m. */
     if (cl_size >=3D INT64_MAX / MAX_PARALLELS_IMAGE_FACTOR) {
diff --git a/block/qcow2.c b/block/qcow2.c
index 95de19d906..0136be1a14 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3076,35 +3076,23 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
         goto out;
     }
=20
-    if (qcow2_opts->has_version) {
-        switch (qcow2_opts->version) {
-        case BLOCKDEV_QCOW2_VERSION_V2:
-            version =3D 2;
-            break;
-        case BLOCKDEV_QCOW2_VERSION_V3:
-            version =3D 3;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    } else {
+    switch (qcow2_opts->version) {
+    case BLOCKDEV_QCOW2_VERSION_V2:
+        version =3D 2;
+        break;
+    case BLOCKDEV_QCOW2_VERSION_V3:
         version =3D 3;
+        break;
+    default:
+        g_assert_not_reached();
     }
=20
-    if (qcow2_opts->has_cluster_size) {
-        cluster_size =3D qcow2_opts->cluster_size;
-    } else {
-        cluster_size =3D DEFAULT_CLUSTER_SIZE;
-    }
-
+    cluster_size =3D qcow2_opts->cluster_size;
     if (!validate_cluster_size(cluster_size, errp)) {
         ret =3D -EINVAL;
         goto out;
     }
=20
-    if (!qcow2_opts->has_preallocation) {
-        qcow2_opts->preallocation =3D PREALLOC_MODE_OFF;
-    }
     if (qcow2_opts->has_backing_file &&
         qcow2_opts->preallocation !=3D PREALLOC_MODE_OFF)
     {
@@ -3119,9 +3107,6 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
         goto out;
     }
=20
-    if (!qcow2_opts->has_lazy_refcounts) {
-        qcow2_opts->lazy_refcounts =3D false;
-    }
     if (version < 3 && qcow2_opts->lazy_refcounts) {
         error_setg(errp, "Lazy refcounts only supported with compatibili=
ty "
                    "level 1.1 and above (use version=3Dv3 or greater)");
@@ -3129,9 +3114,6 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
         goto out;
     }
=20
-    if (!qcow2_opts->has_refcount_bits) {
-        qcow2_opts->refcount_bits =3D 16;
-    }
     if (qcow2_opts->refcount_bits > 64 ||
         !is_power_of_2(qcow2_opts->refcount_bits))
     {
diff --git a/block/qed.c b/block/qed.c
index 77c7cef175..7046eb63ae 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -615,9 +615,6 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCr=
eateOptions *opts,
     qed_opts =3D &opts->u.qed;
=20
     /* Validate options and set default values */
-    if (!qed_opts->has_cluster_size) {
-        qed_opts->cluster_size =3D QED_DEFAULT_CLUSTER_SIZE;
-    }
     if (!qed_opts->has_table_size) {
         qed_opts->table_size =3D QED_DEFAULT_TABLE_SIZE;
     }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 6f402e5d4d..7d74e76c34 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2034,9 +2034,6 @@ static int sd_co_create(BlockdevCreateOptions *opti=
ons, Error **errp)
     s->inode.vdi_size =3D opts->size;
     backing_file =3D opts->backing_file;
=20
-    if (!opts->has_preallocation) {
-        opts->preallocation =3D PREALLOC_MODE_OFF;
-    }
     switch (opts->preallocation) {
     case PREALLOC_MODE_OFF:
         prealloc =3D false;
diff --git a/block/vdi.c b/block/vdi.c
index b9845a4cbd..9dd22ee1d0 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -756,9 +756,6 @@ static int coroutine_fn vdi_co_do_create(BlockdevCrea=
teOptions *create_options,
     /* Validate options and set default values */
     bytes =3D vdi_opts->size;
=20
-    if (!vdi_opts->has_preallocation) {
-        vdi_opts->preallocation =3D PREALLOC_MODE_OFF;
-    }
     switch (vdi_opts->preallocation) {
     case PREALLOC_MODE_OFF:
         image_type =3D VDI_TYPE_DYNAMIC;
diff --git a/block/vhdx.c b/block/vhdx.c
index d6070b6fa8..b238438c1d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1829,29 +1829,19 @@ static int coroutine_fn vhdx_co_create(BlockdevCr=
eateOptions *opts,
         return -EINVAL;
     }
=20
-    if (!vhdx_opts->has_log_size) {
-        log_size =3D DEFAULT_LOG_SIZE;
-    } else {
-        if (vhdx_opts->log_size > UINT32_MAX) {
-            error_setg(errp, "Log size must be smaller than 4 GB");
-            return -EINVAL;
-        }
-        log_size =3D vhdx_opts->log_size;
+    if (vhdx_opts->log_size > UINT32_MAX) {
+        error_setg(errp, "Log size must be smaller than 4 GB");
+        return -EINVAL;
     }
+    log_size =3D vhdx_opts->log_size;
     if (log_size < MiB || (log_size % MiB) !=3D 0) {
         error_setg(errp, "Log size must be a multiple of 1 MB");
         return -EINVAL;
     }
=20
-    if (!vhdx_opts->has_block_state_zero) {
-        use_zero_blocks =3D true;
-    } else {
-        use_zero_blocks =3D vhdx_opts->block_state_zero;
-    }
+    use_zero_blocks =3D vhdx_opts->block_state_zero;
=20
-    if (!vhdx_opts->has_subformat) {
-        vhdx_opts->subformat =3D BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC;
-    }
+    vhdx_opts->subformat =3D BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC;
=20
     switch (vhdx_opts->subformat) {
     case BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC:
@@ -2030,10 +2020,8 @@ static int coroutine_fn vhdx_co_create_opts(const =
char *filename,
     create_options->u.vhdx.size =3D
         ROUND_UP(create_options->u.vhdx.size, BDRV_SECTOR_SIZE);
=20
-    if (create_options->u.vhdx.has_log_size) {
-        create_options->u.vhdx.log_size =3D
-            ROUND_UP(create_options->u.vhdx.log_size, MiB);
-    }
+    create_options->u.vhdx.log_size =3D
+        ROUND_UP(create_options->u.vhdx.log_size, MiB);
     if (create_options->u.vhdx.has_block_size) {
         create_options->u.vhdx.block_size =3D
             ROUND_UP(create_options->u.vhdx.block_size, MiB);
diff --git a/block/vpc.c b/block/vpc.c
index d4776ee8a5..82cd8d4081 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -991,9 +991,6 @@ static int coroutine_fn vpc_co_create(BlockdevCreateO=
ptions *opts,
     /* Validate options and set default values */
     total_size =3D vpc_opts->size;
=20
-    if (!vpc_opts->has_subformat) {
-        vpc_opts->subformat =3D BLOCKDEV_VPC_SUBFORMAT_DYNAMIC;
-    }
     switch (vpc_opts->subformat) {
     case BLOCKDEV_VPC_SUBFORMAT_DYNAMIC:
         disk_type =3D VHD_DYNAMIC;
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..f3828697a8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1122,8 +1122,8 @@ void qmp_blockdev_snapshot_sync(bool has_device, co=
nst char *device,
                                 const char *snapshot_file,
                                 bool has_snapshot_node_name,
                                 const char *snapshot_node_name,
-                                bool has_format, const char *format,
-                                bool has_mode, NewImageMode mode, Error =
**errp)
+                                const char *format, NewImageMode mode,
+                                Error **errp)
 {
     BlockdevSnapshotSync snapshot =3D {
         .has_device =3D has_device,
@@ -1133,9 +1133,7 @@ void qmp_blockdev_snapshot_sync(bool has_device, co=
nst char *device,
         .snapshot_file =3D (char *) snapshot_file,
         .has_snapshot_node_name =3D has_snapshot_node_name,
         .snapshot_node_name =3D (char *) snapshot_node_name,
-        .has_format =3D has_format,
         .format =3D (char *) format,
-        .has_mode =3D has_mode,
         .mode =3D mode,
     };
     TransactionAction action =3D {
@@ -1601,8 +1599,6 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
=20
     if (action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SY=
NC) {
         BlockdevSnapshotSync *s =3D action->u.blockdev_snapshot_sync.dat=
a;
-        const char *format =3D s->has_format ? s->format : "qcow2";
-        enum NewImageMode mode;
         const char *snapshot_node_name =3D
             s->has_snapshot_node_name ? s->snapshot_node_name : NULL;
=20
@@ -1622,15 +1618,14 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
         flags |=3D BDRV_O_NO_BACKING;
=20
         /* create new image w/backing file */
-        mode =3D s->has_mode ? s->mode : NEW_IMAGE_MODE_ABSOLUTE_PATHS;
-        if (mode !=3D NEW_IMAGE_MODE_EXISTING) {
+        if (s->mode !=3D NEW_IMAGE_MODE_EXISTING) {
             int64_t size =3D bdrv_getlength(state->old_bs);
             if (size < 0) {
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
                 goto out;
             }
             bdrv_refresh_filename(state->old_bs);
-            bdrv_img_create(new_image_file, format,
+            bdrv_img_create(new_image_file, s->format,
                             state->old_bs->filename,
                             state->old_bs->drv->format_name,
                             NULL, size, flags, false, &local_err);
@@ -1644,7 +1639,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
         if (snapshot_node_name) {
             qdict_put_str(options, "node-name", snapshot_node_name);
         }
-        qdict_put_str(options, "driver", format);
+        qdict_put_str(options, "driver", s->format);
     }
=20
     state->new_bs =3D bdrv_open(new_image_file, snapshot_ref, options, f=
lags,
@@ -1963,9 +1958,9 @@ static void block_dirty_bitmap_add_prepare(BlkActio=
nState *common,
     /* AIO context taken and released within qmp_block_dirty_bitmap_add =
*/
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granular=
ity,
-                               action->has_persistent, action->persisten=
t,
+                               action->persistent,
                                action->has_autoload, action->autoload,
-                               action->has_disabled, action->disabled,
+                               action->disabled,
                                &local_err);
=20
     if (!local_err) {
@@ -2410,15 +2405,11 @@ static int do_open_tray(const char *blk_name, con=
st char *qdev_id,
=20
 void qmp_blockdev_open_tray(bool has_device, const char *device,
                             bool has_id, const char *id,
-                            bool has_force, bool force,
-                            Error **errp)
+                            bool force, Error **errp)
 {
     Error *local_err =3D NULL;
     int rc;
=20
-    if (!has_force) {
-        force =3D false;
-    }
     rc =3D do_open_tray(has_device ? device : NULL,
                       has_id ? id : NULL,
                       force, &local_err);
@@ -2610,7 +2601,6 @@ void qmp_blockdev_change_medium(bool has_device, co=
nst char *device,
                                 bool has_id, const char *id,
                                 const char *filename,
                                 bool has_format, const char *format,
-                                bool has_read_only,
                                 BlockdevChangeReadOnlyMode read_only,
                                 Error **errp)
 {
@@ -2637,10 +2627,6 @@ void qmp_blockdev_change_medium(bool has_device, c=
onst char *device,
     bdrv_flags &=3D ~(BDRV_O_TEMPORARY | BDRV_O_SNAPSHOT | BDRV_O_NO_BAC=
KING |
         BDRV_O_PROTOCOL | BDRV_O_AUTO_RDONLY);
=20
-    if (!has_read_only) {
-        read_only =3D BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN;
-    }
-
     switch (read_only) {
     case BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN:
         break;
@@ -2804,10 +2790,8 @@ out:
=20
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granulari=
ty,
-                                bool has_persistent, bool persistent,
-                                bool has_autoload, bool autoload,
-                                bool has_disabled, bool disabled,
-                                Error **errp)
+                                bool persistent, bool has_autoload,
+                                bool autoload, bool disabled, Error **er=
rp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
@@ -2834,18 +2818,10 @@ void qmp_block_dirty_bitmap_add(const char *node,=
 const char *name,
         granularity =3D bdrv_get_default_bitmap_granularity(bs);
     }
=20
-    if (!has_persistent) {
-        persistent =3D false;
-    }
-
     if (has_autoload) {
         warn_report("Autoload option is deprecated and its value is igno=
red");
     }
=20
-    if (!has_disabled) {
-        disabled =3D false;
-    }
-
     if (persistent) {
         aio_context =3D bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
@@ -3172,10 +3148,8 @@ void qmp_block_stream(bool has_job_id, const char =
*job_id, const char *device,
                       bool has_base, const char *base,
                       bool has_base_node, const char *base_node,
                       bool has_backing_file, const char *backing_file,
-                      bool has_speed, int64_t speed,
-                      bool has_on_error, BlockdevOnError on_error,
-                      bool has_auto_finalize, bool auto_finalize,
-                      bool has_auto_dismiss, bool auto_dismiss,
+                      int64_t speed, BlockdevOnError on_error,
+                      bool auto_finalize, bool auto_dismiss,
                       Error **errp)
 {
     BlockDriverState *bs, *iter;
@@ -3185,10 +3159,6 @@ void qmp_block_stream(bool has_job_id, const char =
*job_id, const char *device,
     const char *base_name =3D NULL;
     int job_flags =3D JOB_DEFAULT;
=20
-    if (!has_on_error) {
-        on_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-
     bs =3D bdrv_lookup_bs(device, device, errp);
     if (!bs) {
         return;
@@ -3246,15 +3216,15 @@ void qmp_block_stream(bool has_job_id, const char=
 *job_id, const char *device,
     /* backing_file string overrides base bs filename */
     base_name =3D has_backing_file ? backing_file : base_name;
=20
-    if (has_auto_finalize && !auto_finalize) {
+    if (!auto_finalize) {
         job_flags |=3D JOB_MANUAL_FINALIZE;
     }
-    if (has_auto_dismiss && !auto_dismiss) {
+    if (!auto_dismiss) {
         job_flags |=3D JOB_MANUAL_DISMISS;
     }
=20
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 job_flags, has_speed ? speed : 0, on_error, &local_err)=
;
+                 job_flags, speed, on_error, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
@@ -3272,11 +3242,9 @@ void qmp_block_commit(bool has_job_id, const char =
*job_id, const char *device,
                       bool has_top_node, const char *top_node,
                       bool has_top, const char *top,
                       bool has_backing_file, const char *backing_file,
-                      bool has_speed, int64_t speed,
+                      int64_t speed,
                       bool has_filter_node_name, const char *filter_node=
_name,
-                      bool has_auto_finalize, bool auto_finalize,
-                      bool has_auto_dismiss, bool auto_dismiss,
-                      Error **errp)
+                      bool auto_finalize, bool auto_dismiss, Error **err=
p)
 {
     BlockDriverState *bs;
     BlockDriverState *iter;
@@ -3289,16 +3257,13 @@ void qmp_block_commit(bool has_job_id, const char=
 *job_id, const char *device,
     BlockdevOnError on_error =3D BLOCKDEV_ON_ERROR_REPORT;
     int job_flags =3D JOB_DEFAULT;
=20
-    if (!has_speed) {
-        speed =3D 0;
-    }
     if (!has_filter_node_name) {
         filter_node_name =3D NULL;
     }
-    if (has_auto_finalize && !auto_finalize) {
+    if (!auto_finalize) {
         job_flags |=3D JOB_MANUAL_FINALIZE;
     }
-    if (has_auto_dismiss && !auto_dismiss) {
+    if (!auto_dismiss) {
         job_flags |=3D JOB_MANUAL_DISMISS;
     }
=20
@@ -3441,30 +3406,9 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
     bool set_backing_hd =3D false;
     int ret;
=20
-    if (!backup->has_speed) {
-        backup->speed =3D 0;
-    }
-    if (!backup->has_on_source_error) {
-        backup->on_source_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-    if (!backup->has_on_target_error) {
-        backup->on_target_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-    if (!backup->has_mode) {
-        backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
-    }
     if (!backup->has_job_id) {
         backup->job_id =3D NULL;
     }
-    if (!backup->has_auto_finalize) {
-        backup->auto_finalize =3D true;
-    }
-    if (!backup->has_auto_dismiss) {
-        backup->auto_dismiss =3D true;
-    }
-    if (!backup->has_compress) {
-        backup->compress =3D false;
-    }
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
@@ -3619,27 +3563,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backu=
p, JobTxn *txn,
     int job_flags =3D JOB_DEFAULT;
     int ret;
=20
-    if (!backup->has_speed) {
-        backup->speed =3D 0;
-    }
-    if (!backup->has_on_source_error) {
-        backup->on_source_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-    if (!backup->has_on_target_error) {
-        backup->on_target_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
     if (!backup->has_job_id) {
         backup->job_id =3D NULL;
     }
-    if (!backup->has_auto_finalize) {
-        backup->auto_finalize =3D true;
-    }
-    if (!backup->has_auto_dismiss) {
-        backup->auto_dismiss =3D true;
-    }
-    if (!backup->has_compress) {
-        backup->compress =3D false;
-    }
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
@@ -3705,51 +3631,33 @@ static void blockdev_mirror_common(const char *jo=
b_id, BlockDriverState *bs,
                                    bool has_replaces, const char *replac=
es,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
-                                   bool has_speed, int64_t speed,
+                                   int64_t speed,
                                    bool has_granularity, uint32_t granul=
arity,
                                    bool has_buf_size, int64_t buf_size,
-                                   bool has_on_source_error,
                                    BlockdevOnError on_source_error,
-                                   bool has_on_target_error,
                                    BlockdevOnError on_target_error,
-                                   bool has_unmap, bool unmap,
+                                   bool unmap,
                                    bool has_filter_node_name,
                                    const char *filter_node_name,
-                                   bool has_copy_mode, MirrorCopyMode co=
py_mode,
-                                   bool has_auto_finalize, bool auto_fin=
alize,
-                                   bool has_auto_dismiss, bool auto_dism=
iss,
+                                   MirrorCopyMode copy_mode,
+                                   bool auto_finalize, bool auto_dismiss=
,
                                    Error **errp)
 {
     int job_flags =3D JOB_DEFAULT;
=20
-    if (!has_speed) {
-        speed =3D 0;
-    }
-    if (!has_on_source_error) {
-        on_source_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-    if (!has_on_target_error) {
-        on_target_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
     if (!has_granularity) {
         granularity =3D 0;
     }
     if (!has_buf_size) {
         buf_size =3D 0;
     }
-    if (!has_unmap) {
-        unmap =3D true;
-    }
     if (!has_filter_node_name) {
         filter_node_name =3D NULL;
     }
-    if (!has_copy_mode) {
-        copy_mode =3D MIRROR_COPY_MODE_BACKGROUND;
-    }
-    if (has_auto_finalize && !auto_finalize) {
+    if (!auto_finalize) {
         job_flags |=3D JOB_MANUAL_FINALIZE;
     }
-    if (has_auto_dismiss && !auto_dismiss) {
+    if (!auto_dismiss) {
         job_flags |=3D JOB_MANUAL_DISMISS;
     }
=20
@@ -3844,10 +3752,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
-    if (!arg->has_mode) {
-        arg->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
-    }
-
     if (!arg->has_format) {
         format =3D (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING
                   ? NULL : bs->drv->format_name);
@@ -3938,17 +3842,12 @@ void qmp_drive_mirror(DriveMirror *arg, Error **e=
rrp)
=20
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
-                           backing_mode, arg->has_speed, arg->speed,
+                           backing_mode, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
-                           arg->has_on_source_error, arg->on_source_erro=
r,
-                           arg->has_on_target_error, arg->on_target_erro=
r,
-                           arg->has_unmap, arg->unmap,
-                           false, NULL,
-                           arg->has_copy_mode, arg->copy_mode,
-                           arg->has_auto_finalize, arg->auto_finalize,
-                           arg->has_auto_dismiss, arg->auto_dismiss,
-                           &local_err);
+                           arg->on_source_error, arg->on_target_error,
+                           arg->unmap, false, NULL, arg->copy_mode,
+                           arg->auto_finalize, arg->auto_dismiss, &local=
_err);
     bdrv_unref(target_bs);
     error_propagate(errp, local_err);
 out:
@@ -3958,20 +3857,15 @@ out:
 void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          const char *device, const char *target,
                          bool has_replaces, const char *replaces,
-                         MirrorSyncMode sync,
-                         bool has_speed, int64_t speed,
+                         MirrorSyncMode sync, int64_t speed,
                          bool has_granularity, uint32_t granularity,
                          bool has_buf_size, int64_t buf_size,
-                         bool has_on_source_error,
                          BlockdevOnError on_source_error,
-                         bool has_on_target_error,
                          BlockdevOnError on_target_error,
                          bool has_filter_node_name,
                          const char *filter_node_name,
-                         bool has_copy_mode, MirrorCopyMode copy_mode,
-                         bool has_auto_finalize, bool auto_finalize,
-                         bool has_auto_dismiss, bool auto_dismiss,
-                         Error **errp)
+                         MirrorCopyMode copy_mode,
+                         bool auto_finalize, bool auto_dismiss, Error **=
errp)
 {
     BlockDriverState *bs;
     BlockDriverState *target_bs;
@@ -4000,17 +3894,11 @@ void qmp_blockdev_mirror(bool has_job_id, const c=
har *job_id,
=20
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
-                           has_speed, speed,
-                           has_granularity, granularity,
+                           speed, has_granularity, granularity,
                            has_buf_size, buf_size,
-                           has_on_source_error, on_source_error,
-                           has_on_target_error, on_target_error,
-                           true, true,
+                           on_source_error, on_target_error, true,
                            has_filter_node_name, filter_node_name,
-                           has_copy_mode, copy_mode,
-                           has_auto_finalize, auto_finalize,
-                           has_auto_dismiss, auto_dismiss,
-                           &local_err);
+                           copy_mode, auto_finalize, auto_dismiss, &loca=
l_err);
     error_propagate(errp, local_err);
 out:
     aio_context_release(aio_context);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c283dde0e9..486feccdc5 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1359,9 +1359,14 @@ void hmp_drive_mirror(Monitor *mon, const QDict *q=
dict)
         .has_format =3D !!format,
         .format =3D (char *)format,
         .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
-        .has_mode =3D true,
         .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOL=
UTE_PATHS,
+        .speed =3D 0,
+        .on_source_error =3D BLOCKDEV_ON_ERROR_REPORT,
+        .on_target_error =3D BLOCKDEV_ON_ERROR_REPORT,
         .unmap =3D true,
+        .copy_mode =3D MIRROR_COPY_MODE_BACKGROUND,
+        .auto_finalize =3D true,
+        .auto_dismiss =3D true,
     };
=20
     if (!filename) {
@@ -1388,10 +1393,13 @@ void hmp_drive_backup(Monitor *mon, const QDict *=
qdict)
         .has_format =3D !!format,
         .format =3D (char *)format,
         .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
-        .has_mode =3D true,
         .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOL=
UTE_PATHS,
-        .has_compress =3D !!compress,
+        .speed =3D 0,
         .compress =3D compress,
+        .on_source_error =3D BLOCKDEV_ON_ERROR_REPORT,
+        .on_target_error =3D BLOCKDEV_ON_ERROR_REPORT,
+        .auto_finalize =3D true,
+        .auto_dismiss =3D true,
     };
=20
     if (!filename) {
@@ -1408,7 +1416,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict =
*qdict)
 {
     const char *device =3D qdict_get_str(qdict, "device");
     const char *filename =3D qdict_get_try_str(qdict, "snapshot-file");
-    const char *format =3D qdict_get_try_str(qdict, "format");
+    const char *format =3D qdict_get_try_str(qdict, "format") ?: "qcow2"=
;
     bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
     enum NewImageMode mode;
     Error *err =3D NULL;
@@ -1424,8 +1432,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict =
*qdict)
     mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_P=
ATHS;
     qmp_blockdev_snapshot_sync(true, device, false, NULL,
                                filename, false, NULL,
-                               !!format, format,
-                               true, mode, &err);
+                               format, mode, &err);
     hmp_handle_error(mon, &err);
 }
=20
@@ -1978,11 +1985,12 @@ void hmp_change(Monitor *mon, const QDict *qdict)
                 hmp_handle_error(mon, &err);
                 return;
             }
+        } else {
+            read_only_mode =3D BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN;
         }
=20
         qmp_blockdev_change_medium(true, device, false, NULL, target,
-                                   !!arg, arg, !!read_only, read_only_mo=
de,
-                                   &err);
+                                   !!arg, arg, read_only_mode, &err);
     }
=20
     hmp_handle_error(mon, &err);
@@ -2024,8 +2032,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qd=
ict)
     int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
=20
     qmp_block_stream(true, device, device, base !=3D NULL, base, false, =
NULL,
-                     false, NULL, qdict_haskey(qdict, "speed"), speed, t=
rue,
-                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, fals=
e,
+                     false, NULL, speed, BLOCKDEV_ON_ERROR_REPORT, true,=
 true,
                      &error);
=20
     hmp_handle_error(mon, &error);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 01ce77e129..55eaf010b5 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -408,7 +408,8 @@ void qmp_change(const char *device, const char *targe=
t,
 #endif
     } else {
         qmp_blockdev_change_medium(true, device, false, NULL, target,
-                                   has_arg, arg, false, 0, errp);
+                                   has_arg, arg,
+                                   BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN=
, errp);
     }
 }
=20
--=20
2.21.0


