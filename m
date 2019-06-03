Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8891C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B54273D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B54273D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXq0N-0003pF-WA
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:40:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hXpuu-0007UL-He
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hXpm6-00023D-CD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hXpm4-0001bL-Ug; Mon, 03 Jun 2019 12:25:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CC018F927;
	Mon,  3 Jun 2019 16:25:17 +0000 (UTC)
Received: from localhost (unknown [10.40.205.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F692E053;
	Mon,  3 Jun 2019 16:25:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 18:25:11 +0200
Message-Id: <20190603162512.30422-2-mreitz@redhat.com>
In-Reply-To: <20190603162512.30422-1-mreitz@redhat.com>
References: <20190603162512.30422-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 03 Jun 2019 16:25:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] qapi/block-core: Overlays are not snapshots
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A snapshot is something that reflects the state of something at a
certain point in time.  It does not change.

The file our snapshot commands create (or the node they install) is not
a snapshot, as it does change over time.  It is an overlay.  We cannot
do anything about the parameter names, but we can at least adjust the
descriptions to reflect that fact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1defcde048..df52a90736 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1279,17 +1279,17 @@
 #
 # Either @device or @node-name must be set but not both.
 #
-# @device: the name of the device to generate the snapshot from.
+# @device: the name of the device to take a snapshot of.
 #
 # @node-name: graph node name to generate the snapshot from (Since 2.0)
 #
-# @snapshot-file: the target of the new image. If the file exists, or
-# if it is a device, the snapshot will be created in the existing
-# file/device. Otherwise, a new file will be created.
+# @snapshot-file: the target of the new overlay image. If the file
+# exists, or if it is a device, the overlay will be created in the
+# existing file/device. Otherwise, a new file will be created.
 #
 # @snapshot-node-name: the graph node name of the new image (Since 2.0)
 #
-# @format: the format of the snapshot image, default is 'qcow2'.
+# @format: the format of the overlay image, default is 'qcow2'.
 #
 # @mode: whether and how QEMU should create a new image, default is
 #        'absolute-paths'.
@@ -1302,10 +1302,10 @@
 ##
 # @BlockdevSnapshot:
 #
-# @node: device or node name that will have a snapshot created.
+# @node: device or node name that will have a snapshot taken.
 #
 # @overlay: reference to the existing block device that will become
-#           the overlay of @node, as part of creating the snapshot.
+#           the overlay of @node, as part of taking the snapshot.
 #           It must not have a current backing file (this can be
 #           achieved by passing "backing": null to blockdev-add).
 #
@@ -1443,7 +1443,7 @@
 ##
 # @blockdev-snapshot-sync:
 #
-# Generates a synchronous snapshot of a block device.
+# Takes a synchronous snapshot of a block device.
 #
 # For the arguments, see the documentation of BlockdevSnapshotSync.
 #
@@ -1469,9 +1469,9 @@
 ##
 # @blockdev-snapshot:
 #
-# Generates a snapshot of a block device.
+# Takes a snapshot of a block device.
 #
-# Create a snapshot, by installing 'node' as the backing image of
+# Take a snapshot, by installing 'node' as the backing image of
 # 'overlay'. Additionally, if 'node' is associated with a block
 # device, the block device changes to using 'overlay' as its new active
 # image.
--=20
2.21.0


