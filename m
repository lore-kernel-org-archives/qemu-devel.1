Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF7CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC6220663
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj4JF2ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC6220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP50N-0001OU-2S
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xb-0003p1-5x
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xZ-0002Ot-82
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xZ-0002OX-3u
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aKuvnMVQFuDU56JNrd/dh0dSuS58g2T5cVoRy4wUis=;
 b=fj4JF2htImgh3yg94VK7OIt+SpNcjl5ma6VM+cSq7wdOL55b/jDkaZQ1U/ifxg1QDxJ9WT
 KwFz7LRwFX4y+tpABZR2tcMisUbEL94Duv/HNLS9e09u9A655yNlc5WM1q9Ye95P8mSW93
 g+B4YoaJWOmIcBbo/0SFlGxgCLuOaDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-3zlq06D3Or-0OHPcpcfeIw-1; Mon, 28 Oct 2019 08:17:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18C8E800FF1;
 Mon, 28 Oct 2019 12:17:16 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B49A75DA2C;
 Mon, 28 Oct 2019 12:17:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 63/69] block: Do not truncate file node when formatting
Date: Mon, 28 Oct 2019 13:14:55 +0100
Message-Id: <20191028121501.15279-64-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3zlq06D3Or-0OHPcpcfeIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Message-id: 20190918095144.955-4-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
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
@@ -563,11 +563,6 @@ static int coroutine_fn parallels_co_create(BlockdevCr=
eateOptions* opts,
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
@@ -858,11 +858,6 @@ static int coroutine_fn qcow_co_create(BlockdevCreateO=
ptions *opts,
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
index 8d4f38ae74..bf29d1c460 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3391,12 +3391,6 @@ qcow2_co_create(BlockdevCreateOptions *create_option=
s, Error **errp)
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


