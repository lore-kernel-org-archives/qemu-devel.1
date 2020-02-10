Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8967C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06C820863
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Toti2cG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06C820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Grb-0001Uc-MV
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Gnx-0006IZ-4g
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Gnv-0001fk-HN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Gnv-0001dQ-4Q
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581370878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoXaWJQ9EJkF7ysR6MzOzTgFk+SloGOrcr166f0CBhM=;
 b=Toti2cG6vjViMlLTzhY1xY7egFRTuVNJwR4qRPNEQ0fc5kK+oatYLX0YdDa/a5aVwTNEn+
 n6bdgJeJJtUe/o9r45iniR9Ci2ZIFXnpm/iWVRinxJ2pIrgO0ckTW3sxd/IJ1rgZdd3ing
 BUjgtiEHuGbb8DHn6xATnscJyKpP3/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-UkTC_Q1ZPL6xLVWz4A1lmQ-1; Mon, 10 Feb 2020 16:41:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F21DB61;
 Mon, 10 Feb 2020 21:41:14 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A52BB5D9CA;
 Mon, 10 Feb 2020 21:41:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] nbd: Add .bdrv_known_zeroes() server support
Date: Mon, 10 Feb 2020 15:41:09 -0600
Message-Id: <20200210214109.751734-4-eblake@redhat.com>
In-Reply-To: <20200210214109.751734-1-eblake@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210214109.751734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UkTC_Q1ZPL6xLVWz4A1lmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the new NBD extension of NBD_INFO_INIT_STATE, we can advertise
at least the NBD_INIT_ZERO bit based on what the block layer already
knows.  Advertising NBD_INIT_SPARSE might also be possible by
inspecting blk_probe_blocksizes, but as the block layer does not
consume that information at present, the effort of advertising it for
a third party is less important.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/block-backend.c          |  9 +++++++++
 include/sysemu/block-backend.h |  1 +
 nbd/server.c                   | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 8b8f2a80a0d5..d7e01f2e67de 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2127,6 +2127,15 @@ int blk_load_vmstate(BlockBackend *blk, uint8_t *buf=
, int64_t pos, int size)
     return bdrv_load_vmstate(blk_bs(blk), buf, pos, size);
 }

+int blk_known_zeroes(BlockBackend *blk)
+{
+    if (!blk_is_available(blk)) {
+        return 0;
+    }
+
+    return bdrv_known_zeroes(blk_bs(blk));
+}
+
 int blk_probe_blocksizes(BlockBackend *blk, BlockSizes *bsz)
 {
     if (!blk_is_available(blk)) {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index b198deca0b24..2a9b750bb775 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -245,6 +245,7 @@ int blk_save_vmstate(BlockBackend *blk, const uint8_t *=
buf,
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int siz=
e);
 int blk_probe_blocksizes(BlockBackend *blk, BlockSizes *bsz);
 int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo);
+int blk_known_zeroes(BlockBackend *blk);
 BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
                                   BlockCompletionFunc *cb,
                                   void *opaque, int ret);
diff --git a/nbd/server.c b/nbd/server.c
index 11a31094ff83..f6bb7d944daa 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -661,6 +661,17 @@ static int nbd_negotiate_handle_info(NBDClient *client=
, Error **errp)
         return rc;
     }

+    /* Send NBD_INFO_INIT_STATE always */
+    trace_nbd_negotiate_new_style_size_flags(exp->size, myflags);
+    /* Is it worth using blk_probe_blocksizes for setting NBD_INIT_SPARSE?=
 */
+    stw_be_p(buf, ((blk_known_zeroes(exp->blk) & BDRV_ZERO_OPEN)
+                   ? NBD_INIT_ZERO : 0));
+    rc =3D nbd_negotiate_send_info(client, NBD_INFO_INIT_STATE,
+                                 sizeof(uint16_t), buf, errp);
+    if (rc < 0) {
+        return rc;
+    }
+
     /*
      * If the client is just asking for NBD_OPT_INFO, but forgot to
      * request block sizes in a situation that would impact
--=20
2.24.1


