Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652FEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BAB217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUv2rIqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BAB217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgou-0002R1-7L
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdl-0004Aq-G1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdj-0002HH-O8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdj-0002Fm-JG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZF6GaUuwtz7wDQ/xFrYBCdnfKKDq2GUMf0fGoafSX74=;
 b=dUv2rIqN1L2BcwKwzFLE1NsokfRGSQTajRDC1OyQ8gMaaxi32IrzM6qGCiSk1Qbpr77Iz2
 OO8GxohhCQp40EbjX13wx6gycfA0vbTPWPwymuaeh6cfT9x7avf9M/504N4EhbNd2/POr8
 ZKPBPc8OIgRD+uw5hvnDMPHgSjknjDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-z5edW4LnPMqNvrrdavGqCA-1; Thu, 06 Feb 2020 07:52:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C86010054E3;
 Thu,  6 Feb 2020 12:52:10 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3754D60BEC;
 Thu,  6 Feb 2020 12:52:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/17] iotests: add test for backup-top failure on permission
 activation
Date: Thu,  6 Feb 2020 13:51:32 +0100
Message-Id: <20200206125132.594625-18-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: z5edW4LnPMqNvrrdavGqCA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This test checks that bug is really fixed by previous commit.

Cc: qemu-stable@nongnu.org # v4.2.0
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20200121142802.21467-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/283     | 92 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/283.out |  8 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100644 tests/qemu-iotests/283
 create mode 100644 tests/qemu-iotests/283.out

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
new file mode 100644
index 0000000000..293e557bd9
--- /dev/null
+++ b/tests/qemu-iotests/283
@@ -0,0 +1,92 @@
+#!/usr/bin/env python
+#
+# Test for backup-top filter permission activation failure
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import iotests
+
+# The test is unrelated to formats, restrict it to qcow2 to avoid extra ru=
ns
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+
+size =3D 1024 * 1024
+
+""" Test description
+
+When performing a backup, all writes on the source subtree must go through=
 the
+backup-top filter so it can copy all data to the target before it is chang=
ed.
+backup-top filter is appended above source node, to achieve this thing, so=
 all
+parents of source node are handled. A configuration with side parents of s=
ource
+sub-tree with write permission is unsupported (we'd have append several
+backup-top filter like nodes to handle such parents). The test create an
+example of such configuration and checks that a backup is then not allowed
+(blockdev-backup command should fail).
+
+The configuration:
+
+    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90  target  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90
+    =E2=94=82 target =E2=94=82 =E2=97=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 backup_top  =E2=94=82
+    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98
+                            =E2=94=82
+                            =E2=94=82 backing
+                            =E2=96=BC
+                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
+                        =E2=94=82   source    =E2=94=82
+                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
+                            =E2=94=82
+                            =E2=94=82 file
+                            =E2=96=BC
+                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90  write perm   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
+                        =E2=94=82    base     =E2=94=82 =E2=97=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80 =E2=94=82 other =E2=94=82
+                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98               =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
+
+On activation (see .active field of backup-top state in block/backup-top.c=
),
+backup-top is going to unshare write permission on its source child. Write
+unsharing will be propagated to the "source->base" link and will conflict =
with
+other node write permission. So permission update will fail and backup job=
 will
+not be started.
+
+Note, that the only thing which prevents backup of running on such
+configuration is default permission propagation scheme. It may be altered =
by
+different block drivers, so backup will run in invalid configuration. But
+something is better than nothing. Also, before the previous commit (commit
+preceding this test creation), starting backup on such configuration led t=
o
+crash, so current "something" is a lot better, and this test actual goal i=
s
+to check that crash is fixed :)
+"""
+
+vm =3D iotests.VM()
+vm.launch()
+
+vm.qmp_log('blockdev-add', **{'node-name': 'target', 'driver': 'null-co'})
+
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'source',
+    'driver': 'blkdebug',
+    'image': {'node-name': 'base', 'driver': 'null-co', 'size': size}
+})
+
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'other',
+    'driver': 'blkdebug',
+    'image': 'base',
+    'take-child-perms': ['write']
+})
+
+vm.qmp_log('blockdev-backup', sync=3D'full', device=3D'source', target=3D'=
target')
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/283.out b/tests/qemu-iotests/283.out
new file mode 100644
index 0000000000..daaf5828c1
--- /dev/null
+++ b/tests/qemu-iotests/283.out
@@ -0,0 +1,8 @@
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name"=
: "target"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "blkdebug", "image": {=
"driver": "null-co", "node-name": "base", "size": 1048576}, "node-name": "s=
ource"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "blkdebug", "image": "=
base", "node-name": "other", "take-child-perms": ["write"]}}
+{"return": {}}
+{"execute": "blockdev-backup", "arguments": {"device": "source", "sync": "=
full", "target": "target"}}
+{"error": {"class": "GenericError", "desc": "Cannot set permissions for ba=
ckup-top filter: Conflicts with use by other as 'image', which uses 'write'=
 on base"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 9d30a4b6c4..1904223020 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -289,3 +289,4 @@
 279 rw backing quick
 280 rw migration quick
 281 rw quick
+283 auto quick
--=20
2.24.1


