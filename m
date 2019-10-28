Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B688CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6403E20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHfJZgVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6403E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4Rj-000504-1e
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3x4-0002uO-HQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wy-00020D-1n
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wx-0001xa-Hc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KCmWSdKj/kmBW5vvX21H2fiPUW+Ik3EEjUw39XtQIM=;
 b=DHfJZgVOwGFHZt1fcDbBs0KA5kmKjIjEfoVAasyCni7gyBeWsnVLinNKNkzzwa2CqtZw4+
 9agRFzcWb05ljmvcLubyqbES60zWoxUtzAfoJNOiQ7+FfHyCZ5JjRVcIPJ7ITfn4wMErBY
 xRU/1Jfw3lyQd0ZN/vkCV+3FrJNKuoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-OoZQ5jusMN-3m-eNQdhqUQ-1; Mon, 28 Oct 2019 08:16:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D6C2107AD28;
 Mon, 28 Oct 2019 12:16:36 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2184E1001902;
 Mon, 28 Oct 2019 12:16:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 45/69] include: Move endof() up from hw/virtio/virtio.h
Date: Mon, 28 Oct 2019 13:14:37 +0100
Message-Id: <20191028121501.15279-46-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: OoZQ5jusMN-3m-eNQdhqUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

endof() is a useful macro, we can make use of it outside of virtio.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191011152814.14791-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/hw/virtio/virtio.h |  7 -------
 include/qemu/compiler.h    |  7 +++++++
 hw/block/virtio-blk.c      |  4 ++--
 hw/net/virtio-net.c        | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..ef083af550 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -37,13 +37,6 @@ static inline hwaddr vring_align(hwaddr addr,
     return QEMU_ALIGN_UP(addr, align);
 }
=20
-/*
- * Calculate the number of bytes up to and including the given 'field' of
- * 'container'.
- */
-#define virtio_endof(container, field) \
-    (offsetof(container, field) + sizeof_field(container, field))
-
 typedef struct VirtIOFeature {
     uint64_t flags;
     size_t end;
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 7b93c73340..85c02c16d3 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -60,6 +60,13 @@
=20
 #define sizeof_field(type, field) sizeof(((type *)0)->field)
=20
+/*
+ * Calculate the number of bytes up to and including the given 'field' of
+ * 'container'.
+ */
+#define endof(container, field) \
+    (offsetof(container, field) + sizeof_field(container, field))
+
 /* Convert from a base type to a parent type, with compile time checking. =
 */
 #ifdef __GNUC__
 #define DO_UPCAST(type, field, dev) ( __extension__ ( { \
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 14e9f85b8b..156416dfd5 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -42,9 +42,9 @@
  */
 static VirtIOFeature feature_sizes[] =3D {
     {.flags =3D 1ULL << VIRTIO_BLK_F_DISCARD,
-     .end =3D virtio_endof(struct virtio_blk_config, discard_sector_alignm=
ent)},
+     .end =3D endof(struct virtio_blk_config, discard_sector_alignment)},
     {.flags =3D 1ULL << VIRTIO_BLK_F_WRITE_ZEROES,
-     .end =3D virtio_endof(struct virtio_blk_config, write_zeroes_may_unma=
p)},
+     .end =3D endof(struct virtio_blk_config, write_zeroes_may_unmap)},
     {}
 };
=20
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f11422337..2c4909c5f9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -90,15 +90,15 @@ static inline __virtio16 *virtio_net_rsc_ext_num_dupack=
s(
=20
 static VirtIOFeature feature_sizes[] =3D {
     {.flags =3D 1ULL << VIRTIO_NET_F_MAC,
-     .end =3D virtio_endof(struct virtio_net_config, mac)},
+     .end =3D endof(struct virtio_net_config, mac)},
     {.flags =3D 1ULL << VIRTIO_NET_F_STATUS,
-     .end =3D virtio_endof(struct virtio_net_config, status)},
+     .end =3D endof(struct virtio_net_config, status)},
     {.flags =3D 1ULL << VIRTIO_NET_F_MQ,
-     .end =3D virtio_endof(struct virtio_net_config, max_virtqueue_pairs)}=
,
+     .end =3D endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags =3D 1ULL << VIRTIO_NET_F_MTU,
-     .end =3D virtio_endof(struct virtio_net_config, mtu)},
+     .end =3D endof(struct virtio_net_config, mtu)},
     {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
-     .end =3D virtio_endof(struct virtio_net_config, duplex)},
+     .end =3D endof(struct virtio_net_config, duplex)},
     {}
 };
=20
--=20
2.21.0


