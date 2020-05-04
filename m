Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B3DC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117F3206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhZ5GvvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117F3206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcA4-00036e-U9
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6N-0005YG-Uh
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6L-00067L-N9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3q2PV09NbvebXNW9HBjqH4Zi18jqVNRNbd0N7P7VPtU=;
 b=AhZ5GvvHexLEU9wy7pvbF16h1QvFOYs+HS2BjX9BMeMueTpuQtnkvw0WLV3UuuuXkdlq4M
 DlXPVYf2eR+21rmLQ7dTfvRwXJsKy38oiuheUqOL96VbFF1UTXyWZFzoyUq13hpNtywT/7
 HL2CVPZ7/G9laF8kRAQsnrZLSrl2iU8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-Vk68ID71MmSzWNlEYwWGmg-1; Mon, 04 May 2020 10:29:42 -0400
X-MC-Unique: Vk68ID71MmSzWNlEYwWGmg-1
Received: by mail-wr1-f69.google.com with SMTP id f2so10886032wrm.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rU763mQvG3h2UpJIPCYuJYZp3kdhMWRTa5wGYsAN1vY=;
 b=aivJPQrUrGwz6SwVVHlK5ZnYfhEKChjjm6ydO9S89gatbfaSn3AJ23W3Pv4zfOU0UW
 WeDkK/ohFlnYc8oe38/iwpFxLVAdy7Htg2X8zba4PXjjltwWRpqfQCUHNHKA2ExsJirw
 c8J8X/BGzx6WWzy/2ftYJKz6x/aF6Xn3SMomfN/hiuSOkry+jdd1YA1v5y0k7SA7ye4I
 VJFi4scFTH8gapEIKZR2acbyOwDFNjXMBvJDKJCZjt7L9K/vvJIqE0GXmG7zMGC2V+8z
 FgBHwjHQKIa0Yr0Y7XbyZb3+Hj1c2SIMa0iivVoq+vsuQLQrLMWnm8lJ+Y+CLx7ABAKT
 OsOQ==
X-Gm-Message-State: AGi0PubgCaMJRqS095TP8NJI5fdyPhZChRmmwZLehNBD+LMiVV/9/1hB
 zV6q1BGzkfjdPzBe3Kp5iiE4BxobPl9FN8KdkXoEFOYoGeZ9xF0vUgr48r99EaP+T2llABtRJsA
 uw4vIAtIosRERbFk=
X-Received: by 2002:adf:fccc:: with SMTP id f12mr1094069wrs.267.1588602581322; 
 Mon, 04 May 2020 07:29:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEX14lmYHjOf+7NYs/f3sK1v7cf+CYP3Zbu6NsY/7DI923/S8Kvv4QqZJ8B4BJ3BF+yHC5LQ==
X-Received: by 2002:adf:fccc:: with SMTP id f12mr1094044wrs.267.1588602581024; 
 Mon, 04 May 2020 07:29:41 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 t16sm19385536wrm.26.2020.05.04.07.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:40 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] vhost-user-blk: fix invalid memory access
Message-ID: <20200504142814.157589-12-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Li Feng <fengli@smartx.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Feng <fengli@smartx.com>

when s->inflight is freed, vhost_dev_free_inflight may try to access
s->inflight->addr, it will retrigger the following issue.

=3D=3D7309=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x6=
04001020d18 at pc 0x555555ce948a bp 0x7fffffffb170 sp 0x7fffffffb160
READ of size 8 at 0x604001020d18 thread T0
    #0 0x555555ce9489 in vhost_dev_free_inflight /root/smartx/qemu-el7/qemu=
-test/hw/virtio/vhost.c:1473
    #1 0x555555cd86eb in virtio_reset /root/smartx/qemu-el7/qemu-test/hw/vi=
rtio/virtio.c:1214
    #2 0x5555560d3eff in virtio_pci_reset hw/virtio/virtio-pci.c:1859
    #3 0x555555f2ac53 in device_set_realized hw/core/qdev.c:893
    #4 0x5555561d572c in property_set_bool qom/object.c:1925
    #5 0x5555561de8de in object_property_set_qobject qom/qom-qobject.c:27
    #6 0x5555561d99f4 in object_property_set_bool qom/object.c:1188
    #7 0x555555e50ae7 in qdev_device_add /root/smartx/qemu-el7/qemu-test/qd=
ev-monitor.c:626
    #8 0x555555e51213 in qmp_device_add /root/smartx/qemu-el7/qemu-test/qde=
v-monitor.c:806
    #9 0x555555e8ff40 in hmp_device_add /root/smartx/qemu-el7/qemu-test/hmp=
.c:1951
    #10 0x555555be889a in handle_hmp_command /root/smartx/qemu-el7/qemu-tes=
t/monitor.c:3404
    #11 0x555555beac8b in monitor_command_cb /root/smartx/qemu-el7/qemu-tes=
t/monitor.c:4296
    #12 0x555556433eb7 in readline_handle_byte util/readline.c:393
    #13 0x555555be89ec in monitor_read /root/smartx/qemu-el7/qemu-test/moni=
tor.c:4279
    #14 0x5555563285cc in tcp_chr_read chardev/char-socket.c:470
    #15 0x7ffff670b968 in g_main_context_dispatch (/lib64/libglib-2.0.so.0+=
0x4a968)
    #16 0x55555640727c in glib_pollfds_poll util/main-loop.c:215
    #17 0x55555640727c in os_host_main_loop_wait util/main-loop.c:238
    #18 0x55555640727c in main_loop_wait util/main-loop.c:497
    #19 0x555555b2d0bf in main_loop /root/smartx/qemu-el7/qemu-test/vl.c:20=
13
    #20 0x555555b2d0bf in main /root/smartx/qemu-el7/qemu-test/vl.c:4776
    #21 0x7fffdd2eb444 in __libc_start_main (/lib64/libc.so.6+0x22444)
    #22 0x555555b3767a  (/root/smartx/qemu-el7/qemu-test/x86_64-softmmu/qem=
u-system-x86_64+0x5e367a)

0x604001020d18 is located 8 bytes inside of 40-byte region [0x604001020d10,=
0x604001020d38)
freed by thread T0 here:
    #0 0x7ffff6f00508 in __interceptor_free (/lib64/libasan.so.4+0xde508)
    #1 0x7ffff671107d in g_free (/lib64/libglib-2.0.so.0+0x5007d)

previously allocated by thread T0 here:
    #0 0x7ffff6f00a88 in __interceptor_calloc (/lib64/libasan.so.4+0xdea88)
    #1 0x7ffff6710fc5 in g_malloc0 (/lib64/libglib-2.0.so.0+0x4ffc5)

SUMMARY: AddressSanitizer: heap-use-after-free /root/smartx/qemu-el7/qemu-t=
est/hw/virtio/vhost.c:1473 in vhost_dev_free_inflight
Shadow bytes around the buggy address:
  0x0c08801fc150: fa fa 00 00 00 00 04 fa fa fa fd fd fd fd fd fa
  0x0c08801fc160: fa fa fd fd fd fd fd fd fa fa 00 00 00 00 04 fa
  0x0c08801fc170: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 04 fa
  0x0c08801fc180: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 00 01
  0x0c08801fc190: fa fa 00 00 00 00 00 fa fa fa 00 00 00 00 04 fa
=3D>0x0c08801fc1a0: fa fa fd[fd]fd fd fd fa fa fa fd fd fd fd fd fa
  0x0c08801fc1b0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
  0x0c08801fc1c0: fa fa 00 00 00 00 00 fa fa fa fd fd fd fd fd fd
  0x0c08801fc1d0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
  0x0c08801fc1e0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
  0x0c08801fc1f0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D7309=3D=3DABORTING

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20200417101707.14467-1-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/block/vhost-user-blk.c | 4 ++++
 hw/virtio/vhost.c         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 17df5338e7..6c485d1c9e 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -441,7 +441,9 @@ reconnect:
=20
 virtio_err:
     g_free(s->vhost_vqs);
+    s->vhost_vqs =3D NULL;
     g_free(s->inflight);
+    s->inflight =3D NULL;
     for (i =3D 0; i < s->num_queues; i++) {
         virtio_delete_queue(s->virtqs[i]);
     }
@@ -462,7 +464,9 @@ static void vhost_user_blk_device_unrealize(DeviceState=
 *dev, Error **errp)
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
     g_free(s->vhost_vqs);
+    s->vhost_vqs =3D NULL;
     g_free(s->inflight);
+    s->inflight =3D NULL;
=20
     for (i =3D 0; i < s->num_queues; i++) {
         virtio_delete_queue(s->virtqs[i]);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 01ebe12f28..aff98a0ede 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1514,7 +1514,7 @@ void vhost_dev_set_config_notifier(struct vhost_dev *=
hdev,
=20
 void vhost_dev_free_inflight(struct vhost_inflight *inflight)
 {
-    if (inflight->addr) {
+    if (inflight && inflight->addr) {
         qemu_memfd_free(inflight->addr, inflight->size, inflight->fd);
         inflight->addr =3D NULL;
         inflight->fd =3D -1;
--=20
MST


