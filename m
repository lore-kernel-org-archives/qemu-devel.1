Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A3C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC69020730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0ebGhjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC69020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzxR-0000f5-4p
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iyzwF-00084R-Bt
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iyzwD-0004fB-Iw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:16:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52911
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iyzwD-0004Xv-F5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580829388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=75L/t6x/uiiO6doR4YxxzePWkim/mtgWGGWNxXnKgic=;
 b=I0ebGhjRLKGmmYIk3YZ6NTomlxqDW7jZnQYrckEe4Ab4zlvTPhsmvxNoQY4DNhC4k3Zokl
 Mq42/eOKPsIfxJG593IXzDMsDpZdLjaTIe8bqQL/nb0Y/pEW5Vxtq1qFPKR5JWvtXeVJQl
 lhUvOtdEtbo7jaF53S65Ytpc+Ur2kLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-k1Ru0yVfOGaBGfXMl4Txow-1; Tue, 04 Feb 2020 10:16:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F0C91088388;
 Tue,  4 Feb 2020 15:16:25 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECFF5C1B5;
 Tue,  4 Feb 2020 15:16:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Date: Tue,  4 Feb 2020 15:16:18 +0000
Message-Id: <20200204151618.39296-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: k1Ru0yVfOGaBGfXMl4Txow-1
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/virtio.c checks vq->vring.desc !=3D NULL to see if the vring has been
set up successfully.

When virtio_queue_set_rings() fails due to an invalid vring memory
address it must clear vq->vring.desc (and related fields) so we don't
treat this virtqueue as successfully initialized later on.

This bug was found by device fuzzing and can be triggered as follows:

  $ qemu -M pc -device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0,addr=3D4.0 \
         -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,format=3Draw,auto-r=
ead-only=3Doff \
         -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=3D=
on,format=3Draw \
         -display none \
         -qtest stdio
  endianness
  outl 0xcf8 0x80002020
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80002004
  outw 0xcfc 0x7
  write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabffffffa=
bffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cffffffab=
ffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabfff=
fffabffffffabffffffabffffffabffffffab0000000001
  inb 0x4
  writew 0xe000001c 0x1
  write 0xe0000014 0x1 0x0d

The following error message is produced:

  qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vring_get=
_region_caches: Assertion `caches !=3D NULL' failed.

The backtrace looks like this:

  #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
  #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
  #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so.6
  #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so.6
  #4  0x00005555559073da in vring_get_region_caches (vq=3D<optimized out>) =
at qemu/hw/virtio/virtio.c:286
  #5  vring_get_region_caches (vq=3D<optimized out>) at qemu/hw/virtio/virt=
io.c:283
  #6  0x000055555590818d in vring_used_flags_set_bit (mask=3D1, vq=3D0x5555=
575ceea0) at qemu/hw/virtio/virtio.c:398
  #7  virtio_queue_split_set_notification (enable=3D0, vq=3D0x5555575ceea0)=
 at qemu/hw/virtio/virtio.c:398
  #8  virtio_queue_set_notification (vq=3Dvq@entry=3D0x5555575ceea0, enable=
=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:451
  #9  0x0000555555908512 in virtio_queue_set_notification (vq=3Dvq@entry=3D=
0x5555575ceea0, enable=3Denable@entry=3D0) at qemu/hw/virtio/virtio.c:444
  #10 0x00005555558c697a in virtio_blk_handle_vq (s=3D0x5555575c57e0, vq=3D=
0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
  #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=3D0x5555575ceea0=
) at qemu/hw/virtio/virtio.c:2244
  #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=3Dctx@entry=3D0x5555=
5671a420) at util/aio-posix.c:429
  #13 0x0000555555cb67a8 in aio_dispatch (ctx=3D0x55555671a420) at util/aio=
-posix.c:460
  #14 0x0000555555cb307e in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:260
  #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libglib-2.=
0.so.0
  #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:219
  #17 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-loop.=
c:242
  #18 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:51=
8
  #19 0x00005555559b20c9 in main_loop () at vl.c:1683
  #20 0x0000555555838115 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at vl.c:4441

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2c5410e981..5d7f619a1e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2163,6 +2163,11 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int =
n, hwaddr desc,
     vdev->vq[n].vring.avail =3D avail;
     vdev->vq[n].vring.used =3D used;
     virtio_init_region_cache(vdev, n);
+    if (vdev->broken) {
+        vdev->vq[n].vring.desc =3D 0;
+        vdev->vq[n].vring.avail =3D 0;
+        vdev->vq[n].vring.used =3D 0;
+    }
 }
=20
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
--=20
2.24.1


