Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F14C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD1A2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1A2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU651-0004zH-GM
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:01:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hU630-0003f6-F7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hU60z-00007z-2a
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hU60x-000079-Le; Fri, 24 May 2019 04:57:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1368E3082132;
	Fri, 24 May 2019 08:57:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-157.ams2.redhat.com
	[10.36.117.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 014A15D9D3;
	Fri, 24 May 2019 08:57:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 24 May 2019 10:57:11 +0200
Message-Id: <20190524085711.17834-1-kwolf@redhat.com>
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 24 May 2019 08:57:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1.5/15] nbd-server: Call
 blk_set_allow_aio_context_change()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD server uses an AioContext notifier, so it can tolerate that its
BlockBackend is switched to a different AioContext. Before we start
actually calling bdrv_try_set_aio_context(), which checks for
consistency, outside of test cases, we need to make sure that the NBD
server actually allows this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c               |  1 +
 tests/qemu-iotests/240     | 21 +++++++++++++++++++++
 tests/qemu-iotests/240.out | 13 +++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index e21bd501dc..d1375350bc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1491,6 +1491,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
         goto fail;
     }
     blk_set_enable_write_cache(blk, !writethrough);
+    blk_set_allow_aio_context_change(blk, true);
=20
     exp->refcount =3D 1;
     QTAILQ_INIT(&exp->clients);
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index b4cf95096d..5be6b9c0f7 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -27,6 +27,12 @@ echo "QA output created by $seq"
=20
 status=3D1	# failure is the default!
=20
+_cleanup()
+{
+    rm -f "$TEST_DIR/nbd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -122,6 +128,21 @@ run_qemu <<EOF
 { "execute": "quit"}
 EOF
=20
+echo
+echo =3D=3D=3D Attach a SCSI disks using the same block device as a NBD =
server =3D=3D=3D
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0", "read-only": true}}
+{ "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","da=
ta":{"path":"$TEST_DIR/nbd"}}}}
+{ "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0", "bus": "scsi0.0"}}
+{ "execute": "quit"}
+EOF
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index d76392966c..84e0a43ce5 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -51,4 +51,17 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
+
+=3D=3D=3D Attach a SCSI disks using the same block device as a NBD serve=
r =3D=3D=3D
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
 *** done
--=20
2.20.1


