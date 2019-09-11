Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9795CC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA31207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA31207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83vf-0004ZR-VA
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i83kA-0000tc-Me
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i83k8-0001Cn-FF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i83k3-00019g-7n; Wed, 11 Sep 2019 10:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 283A830A7BB5;
 Wed, 11 Sep 2019 14:37:06 +0000 (UTC)
Received: from localhost (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7676C60A9F;
 Wed, 11 Sep 2019 14:36:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 16:36:12 +0200
Message-Id: <20190911143612.17881-2-stefanha@redhat.com>
In-Reply-To: <20190911143612.17881-1-stefanha@redhat.com>
References: <20190911143612.17881-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 11 Sep 2019 14:37:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/1] virtio-blk: Cancel the pending BH when the
 dataplane is reset
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
 Yihuang Yu <yihyu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

When 'system_reset' is called, the main loop clear the memory
region cache before the BH has a chance to execute. Later when
the deferred function is called, some assumptions that were
made when scheduling them are no longer true when they actually
execute.

This is what happens using a virtio-blk device (fresh RHEL7.8 install):

 $ (sleep 12.3; echo system_reset; sleep 12.3; echo system_reset; sleep 1=
; echo q) \
   | qemu-system-x86_64 -m 4G -smp 8 -boot menu=3Don \
     -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1 \
     -drive file=3D/var/lib/libvirt/images/rhel78.qcow2,if=3Dnone,id=3Ddr=
ive_image1,format=3Dqcow2,cache=3Dnone \
     -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:e7:=
84 \
     -netdev tap,id=3Dnet0,script=3D/bin/true,downscript=3D/bin/true,vhos=
t=3Don \
     -monitor stdio -serial null -nographic
  (qemu) system_reset
  (qemu) system_reset
  (qemu) qemu-system-x86_64: hw/virtio/virtio.c:225: vring_get_region_cac=
hes: Assertion `caches !=3D NULL' failed.
  Aborted

  (gdb) bt
  Thread 1 (Thread 0x7f109c17b680 (LWP 10939)):
  #0  0x00005604083296d1 in vring_get_region_caches (vq=3D0x56040a24bdd0)=
 at hw/virtio/virtio.c:227
  #1  0x000056040832972b in vring_avail_flags (vq=3D0x56040a24bdd0) at hw=
/virtio/virtio.c:235
  #2  0x000056040832d13d in virtio_should_notify (vdev=3D0x56040a240630, =
vq=3D0x56040a24bdd0) at hw/virtio/virtio.c:1648
  #3  0x000056040832d1f8 in virtio_notify_irqfd (vdev=3D0x56040a240630, v=
q=3D0x56040a24bdd0) at hw/virtio/virtio.c:1662
  #4  0x00005604082d213d in notify_guest_bh (opaque=3D0x56040a243ec0) at =
hw/block/dataplane/virtio-blk.c:75
  #5  0x000056040883dc35 in aio_bh_call (bh=3D0x56040a243f10) at util/asy=
nc.c:90
  #6  0x000056040883dccd in aio_bh_poll (ctx=3D0x560409161980) at util/as=
ync.c:118
  #7  0x0000560408842af7 in aio_dispatch (ctx=3D0x560409161980) at util/a=
io-posix.c:460
  #8  0x000056040883e068 in aio_ctx_dispatch (source=3D0x560409161980, ca=
llback=3D0x0, user_data=3D0x0) at util/async.c:261
  #9  0x00007f10a8fca06d in g_main_context_dispatch () at /lib64/libglib-=
2.0.so.0
  #10 0x0000560408841445 in glib_pollfds_poll () at util/main-loop.c:215
  #11 0x00005604088414bf in os_host_main_loop_wait (timeout=3D0) at util/=
main-loop.c:238
  #12 0x00005604088415c4 in main_loop_wait (nonblocking=3D0) at util/main=
-loop.c:514
  #13 0x0000560408416b1e in main_loop () at vl.c:1923
  #14 0x000056040841e0e8 in main (argc=3D20, argv=3D0x7ffc2c3f9c58, envp=3D=
0x7ffc2c3f9d00) at vl.c:4578

Fix this by cancelling the BH when the virtio dataplane is stopped.

[This is version of the patch was modified as discussed with Philippe on
the mailing list thread.
--Stefan]

Reported-by: Yihuang Yu <yihyu@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: https://bugs.launchpad.net/qemu/+bug/1839428
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190816171503.24761-1-philmd@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
index 9299a1a7c2..119906a5fe 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -298,6 +298,9 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
         virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
     }
=20
+    qemu_bh_cancel(s->bh);
+    notify_guest_bh(s); /* final chance to notify guest */
+
     /* Clean up guest notifier (irq) */
     k->set_guest_notifiers(qbus->parent, nvqs, false);
=20
--=20
2.21.0


