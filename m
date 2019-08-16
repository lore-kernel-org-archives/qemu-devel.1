Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66246C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E934B206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E934B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylVI-0004Bl-Ao
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPY-0006BZ-RM
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPX-0005hJ-47
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPR-0005bN-Gj; Fri, 16 Aug 2019 19:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C0AE3082A6C;
 Fri, 16 Aug 2019 23:13:23 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4F6C19C6A;
 Fri, 16 Aug 2019 23:13:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:43 -0400
Message-Id: <20190816231318.8650-2-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 23:13:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/36] qapi/block-core: Introduce BackupCommon
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

drive-backup and blockdev-backup have an awful lot of things in common
that are the same. Let's fix that.

I don't deduplicate 'target', because the semantics actually did change
between each structure. Leave that one alone so it can be documented
separately.

Where documentation was not identical, use the most up-to-date version.
For "speed", use Blockdev-Backup's version. For "sync", use
Drive-Backup's version.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
[Maintainer edit: modified commit message. --js]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20190709232550.10724-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 103 ++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 70 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f1e7701fbea..8ca12004ae9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1315,32 +1315,23 @@
   'data': { 'node': 'str', 'overlay': 'str' } }
=20
 ##
-# @DriveBackup:
+# @BackupCommon:
 #
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device: the device name or node-name of a root node which should be c=
opied.
 #
-# @target: the target of the new image. If the file exists, or if it
-#          is a device, the existing file/device will be used as the new
-#          destination.  If it does not exist, a new file will be create=
d.
-#
-# @format: the format of the new destination, default is to
-#          probe if @mode is 'existing', else the format of the source
-#
 # @sync: what parts of the disk image should be copied to the destinatio=
n
 #        (all the disk, only the sectors allocated in the topmost image,=
 from a
 #        dirty bitmap, or only new I/O).
 #
-# @mode: whether and how QEMU should create a new image, default is
-#        'absolute-paths'.
-#
-# @speed: the maximum speed, in bytes per second
+# @speed: the maximum speed, in bytes per second. The default is 0,
+#         for unlimited.
 #
 # @bitmap: the name of dirty bitmap if sync is "incremental".
 #          Must be present if sync is "incremental", must NOT be present
-#          otherwise. (Since 2.4)
+#          otherwise. (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
 #
 # @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
@@ -1370,75 +1361,47 @@
 # I/O.  If an error occurs during a guest write request, the device's
 # rerror/werror actions will be used.
 #
+# Since: 4.2
+##
+{ 'struct': 'BackupCommon',
+  'data': { '*job-id': 'str', 'device': 'str',
+            'sync': 'MirrorSyncMode', '*speed': 'int',
+            '*bitmap': 'str', '*compress': 'bool',
+            '*on-source-error': 'BlockdevOnError',
+            '*on-target-error': 'BlockdevOnError',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+
+##
+# @DriveBackup:
+#
+# @target: the target of the new image. If the file exists, or if it
+#          is a device, the existing file/device will be used as the new
+#          destination.  If it does not exist, a new file will be create=
d.
+#
+# @format: the format of the new destination, default is to
+#          probe if @mode is 'existing', else the format of the source
+#
+# @mode: whether and how QEMU should create a new image, default is
+#        'absolute-paths'.
+#
 # Since: 1.6
 ##
 { 'struct': 'DriveBackup',
-  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            '*format': 'str', 'sync': 'MirrorSyncMode',
-            '*mode': 'NewImageMode', '*speed': 'int',
-            '*bitmap': 'str', '*compress': 'bool',
-            '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+  'base': 'BackupCommon',
+  'data': { 'target': 'str',
+            '*format': 'str',
+            '*mode': 'NewImageMode' } }
=20
 ##
 # @BlockdevBackup:
 #
-# @job-id: identifier for the newly-created block job. If
-#          omitted, the device name will be used. (Since 2.7)
-#
-# @device: the device name or node-name of a root node which should be c=
opied.
-#
 # @target: the device name or node-name of the backup target node.
 #
-# @sync: what parts of the disk image should be copied to the destinatio=
n
-#        (all the disk, only the sectors allocated in the topmost image,=
 or
-#        only new I/O).
-#
-# @speed: the maximum speed, in bytes per second. The default is 0,
-#         for unlimited.
-#
-# @bitmap: the name of dirty bitmap if sync is "incremental".
-#          Must be present if sync is "incremental", must NOT be present
-#          otherwise. (Since 3.1)
-#
-# @compress: true to compress data, if the target format supports it.
-#            (default: false) (since 2.8)
-#
-# @on-source-error: the action to take on an error on the source,
-#                   default 'report'.  'stop' and 'enospc' can only be u=
sed
-#                   if the block device supports io-status (see BlockInf=
o).
-#
-# @on-target-error: the action to take on an error on the target,
-#                   default 'report' (no limitations, since this applies=
 to
-#                   a different block device than @device).
-#
-# @auto-finalize: When false, this job will wait in a PENDING state afte=
r it has
-#                 finished its work, waiting for @block-job-finalize bef=
ore
-#                 making any block graph changes.
-#                 When true, this job will automatically
-#                 perform its abort or commit actions.
-#                 Defaults to true. (Since 2.12)
-#
-# @auto-dismiss: When false, this job will wait in a CONCLUDED state aft=
er it
-#                has completely ceased all work, and awaits @block-job-d=
ismiss.
-#                When true, this job will automatically disappear from t=
he query
-#                list without user intervention.
-#                Defaults to true. (Since 2.12)
-#
-# Note: @on-source-error and @on-target-error only affect background
-# I/O.  If an error occurs during a guest write request, the device's
-# rerror/werror actions will be used.
-#
 # Since: 2.3
 ##
 { 'struct': 'BlockdevBackup',
-  'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            'sync': 'MirrorSyncMode', '*speed': 'int',
-            '*bitmap': 'str', '*compress': 'bool',
-            '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
+  'base': 'BackupCommon',
+  'data': { 'target': 'str' } }
=20
 ##
 # @blockdev-snapshot-sync:
--=20
2.21.0


