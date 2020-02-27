Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B4C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A28320838
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jlks9anU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A28320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78Qv-0000LW-FW
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j78OA-0004c5-NT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j78O9-0002ZF-6v
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j78O9-0002Ww-2y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582768496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsUu0Tkg4IjYGzEi8JY5J1KyolilE13RDr+tqC7JBSE=;
 b=Jlks9anUsxJ1oIQIqlRtHdRuInKFEV5b1j6SnDgDro6fpmsN5kWugRPAMV2CmhypHElHLY
 +GFfmXby1Tcbca1Ep3WpALJBf1R/MZMKicG97LqAQniE7m/JGG/1d5Iq55a0qJJUZwUUwW
 ZfkkvMIxrK6IqJ56Y973VvnxKyJLHQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-MFB1uurqO6GzKwFcH6BciA-1; Wed, 26 Feb 2020 20:54:54 -0500
X-MC-Unique: MFB1uurqO6GzKwFcH6BciA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A7413E5;
 Thu, 27 Feb 2020 01:54:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2161A5C578;
 Thu, 27 Feb 2020 01:54:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] block/nbd: extract the common cleanup code
Date: Wed, 26 Feb 2020 19:54:47 -0600
Message-Id: <20200227015448.960538-4-eblake@redhat.com>
In-Reply-To: <20200227015448.960538-1-eblake@redhat.com>
References: <20200227015448.960538-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

The BDRVNBDState cleanup code is common in two places, add
nbd_clear_bdrvstate() function to do these cleanups.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: fix compilation error and commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index f69e61e68ad6..ed0f93ab27a9 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -95,6 +95,19 @@ typedef struct BDRVNBDState {

 static int nbd_client_connect(BlockDriverState *bs, Error **errp);

+static void nbd_clear_bdrvstate(BDRVNBDState *s)
+{
+    object_unref(OBJECT(s->tlscreds));
+    qapi_free_SocketAddress(s->saddr);
+    s->saddr =3D NULL;
+    g_free(s->export);
+    s->export =3D NULL;
+    g_free(s->tlscredsid);
+    s->tlscredsid =3D NULL;
+    g_free(s->x_dirty_bitmap);
+    s->x_dirty_bitmap =3D NULL;
+}
+
 static void nbd_channel_error(BDRVNBDState *s, int ret)
 {
     if (ret =3D=3D -EIO) {
@@ -1879,11 +1892,7 @@ static int nbd_process_options(BlockDriverState *bs,=
 QDict *options,

  error:
     if (ret < 0) {
-        object_unref(OBJECT(s->tlscreds));
-        qapi_free_SocketAddress(s->saddr);
-        g_free(s->export);
-        g_free(s->tlscredsid);
-        g_free(s->x_dirty_bitmap);
+        nbd_clear_bdrvstate(s);
     }
     qemu_opts_del(opts);
     return ret;
@@ -1962,12 +1971,7 @@ static void nbd_close(BlockDriverState *bs)
     BDRVNBDState *s =3D bs->opaque;

     nbd_client_close(bs);
-
-    object_unref(OBJECT(s->tlscreds));
-    qapi_free_SocketAddress(s->saddr);
-    g_free(s->export);
-    g_free(s->tlscredsid);
-    g_free(s->x_dirty_bitmap);
+    nbd_clear_bdrvstate(s);
 }

 static int64_t nbd_getlength(BlockDriverState *bs)
--=20
2.24.1


