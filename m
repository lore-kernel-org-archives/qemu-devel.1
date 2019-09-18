Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EDC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C67C218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C67C218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWk8-0008Af-5u
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAWd8-00016g-F4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAWd6-0005fA-QA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAWd0-0005Xl-RW; Wed, 18 Sep 2019 05:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A65031DBC;
 Wed, 18 Sep 2019 09:52:01 +0000 (UTC)
Received: from localhost (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D94E5C219;
 Wed, 18 Sep 2019 09:52:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 11:51:39 +0200
Message-Id: <20190918095144.955-4-mreitz@redhat.com>
In-Reply-To: <20190918095144.955-1-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 18 Sep 2019 09:52:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/8] block: Do not truncate file node when
 formatting
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
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no reason why the format drivers need to truncate the protocol
node when formatting it.  When using the old .bdrv_co_create_ops()
interface, the file will be created with no size option anyway, which
generally gives it a size of 0.  (Exceptions are block devices, which
cannot be truncated anyway.)

When using blockdev-create, the user must have given the file node some
size anyway, so there is no reason why we should override that.

qed is an exception, it needs the file to start completely empty (as
explained by c743849bee7333c7ef256b7e12e34ed6f907064f).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/parallels.c | 5 -----
 block/qcow.c      | 5 -----
 block/qcow2.c     | 6 ------
 3 files changed, 16 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7cd2714b69..905cac35c6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -563,11 +563,6 @@ static int coroutine_fn parallels_co_create(Blockdev=
CreateOptions* opts,
     blk_set_allow_write_beyond_eof(blk, true);
=20
     /* Create image format */
-    ret =3D blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
-    if (ret < 0) {
-        goto out;
-    }
-
     bat_entries =3D DIV_ROUND_UP(total_size, cl_size);
     bat_sectors =3D DIV_ROUND_UP(bat_entry_off(bat_entries), cl_size);
     bat_sectors =3D (bat_sectors *  cl_size) >> BDRV_SECTOR_BITS;
diff --git a/block/qcow.c b/block/qcow.c
index 5bdf72ba33..17705015ca 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -858,11 +858,6 @@ static int coroutine_fn qcow_co_create(BlockdevCreat=
eOptions *opts,
     blk_set_allow_write_beyond_eof(qcow_blk, true);
=20
     /* Create image format */
-    ret =3D blk_truncate(qcow_blk, 0, PREALLOC_MODE_OFF, errp);
-    if (ret < 0) {
-        goto exit;
-    }
-
     memset(&header, 0, sizeof(header));
     header.magic =3D cpu_to_be32(QCOW_MAGIC);
     header.version =3D cpu_to_be32(QCOW_VERSION);
diff --git a/block/qcow2.c b/block/qcow2.c
index 4d16393e61..4978ccc7be 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3186,12 +3186,6 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
     }
     blk_set_allow_write_beyond_eof(blk, true);
=20
-    /* Clear the protocol layer and preallocate it if necessary */
-    ret =3D blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
-    if (ret < 0) {
-        goto out;
-    }
-
     /* Write the header */
     QEMU_BUILD_BUG_ON((1 << MIN_CLUSTER_BITS) < sizeof(*header));
     header =3D g_malloc0(cluster_size);
--=20
2.21.0


