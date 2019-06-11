Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F7C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C463521734
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C463521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hakl9-0001Ug-1C
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 13:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hakcr-00045p-3J
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hakS5-0001g5-LX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:20:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hakS0-0001Yg-4w
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D5FB81F01;
 Tue, 11 Jun 2019 17:20:37 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-117-111.ams2.redhat.com
 [10.36.117.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C626D2B3DC;
 Tue, 11 Jun 2019 17:20:33 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 19:20:32 +0200
Message-Id: <20190611172032.19143-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 11 Jun 2019 17:20:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC] virtio-rng: add a watchdog
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-rng linux driver can be stuck in virtio_read() on a
wait_for_completion_killable() call if the virtio-rng device in QEMU
doesn't provide data.

It's a problem, because virtio_read() is called from rng_get_data() with
reading_mutex() held.  The same mutex is taken by add_early_randomness()
and hwrng_fillfn() and this brings to a hang during the boot sequence if
the virtio-rng driver is builtin.
Moreover, another lock is taken (rng_mutex) when the hwrng driver
wants to switch the RNG device or the user tries to unplug the virtio-rng
PCI card, and this can hang too because the virtio-rng driver is only abl=
e
to release the card if the virtio-rng device sends back the virtqueue ele=
ment.

  # echo -n virtio_rng.1 > /sys/class/misc/hw_random/rng_current
  [  240.165234] INFO: task kworker/u2:1:34 blocked for more than 120 sec=
onds.
  [  240.165961] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
  [  240.166708] kworker/u2:1    D ffffffffb86b85a8     0    34      2 0x=
00000000
  [  240.166714] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
  [  240.166716]  ffffa0e8f3c0b890 0000000000000046 ffffa0e8f3c00000 ffff=
a0e8f3c0bfd8
  [  240.166717]  ffffa0e8f3c0bfd8 ffffa0e8f3c0bfd8 ffffa0e8f3c00000 ffff=
ffffb86b85a0
  [  240.166719]  ffffffffb86b85a4 ffffa0e8f3c00000 00000000ffffffff ffff=
ffffb86b85a8
  [  240.166720] Call Trace:
  [  240.166725]  [<ffffffffb82a61c9>] schedule_preempt_disabled+0x29/0x7=
0
  [  240.166727]  [<ffffffffb82a40f7>] __mutex_lock_slowpath+0xc7/0x1d0
  [  240.166728]  [<ffffffffb82a350f>] mutex_lock+0x1f/0x2f
  [  240.166730]  [<ffffffffb8022b52>] hwrng_register+0x32/0x1d0
  [  240.166733]  [<ffffffffc07fa149>] virtrng_scan+0x19/0x30 [virtio_rng=
]
  [  240.166744]  [<ffffffffc03108db>] virtio_dev_probe+0x1eb/0x290 [virt=
io]
  [  240.166746]  [<ffffffffb803d6e5>] driver_probe_device+0x145/0x3c0
  ...

In some case, the QEMU RNG backend is not able to provide data, and
the virtio-rng device is not aware of that:
- with rng-random using /dev/random and no entropy is available,
- with rng-egd started with a socket in "server,nowait" mode and
  no daemon connected,
- with rng-egd and an egd daemon that is not providing enough data,
- ...

To release the locks regularly, this patch adds a watchdog in QEMU
virtio-rng device that sends back to the guest the virtqueue buffer
with a 0 byte payload. This case is expected and correctly managed by
the hwrng core.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-rng.c         | 23 +++++++++++++++++++++++
 include/hw/virtio/virtio-rng.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 30493a258622..173ecd370c0e 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -19,6 +19,8 @@
 #include "qom/object_interfaces.h"
 #include "trace.h"
=20
+#define VIRTIO_RNG_WATCHDOG_MS 500
+
 static bool is_guest_ready(VirtIORNG *vrng)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(vrng);
@@ -38,6 +40,21 @@ static size_t get_request_size(VirtQueue *vq, unsigned=
 quota)
     return in;
 }
=20
+static void watchdog(void *opaque)
+{
+    VirtIORNG *vrng =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(vrng);
+    VirtQueueElement *elem;
+
+    /* wake up driver */
+    elem =3D virtqueue_pop(vrng->vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+    virtqueue_push(vrng->vq, elem, 0);
+    virtio_notify(vdev, vrng->vq);
+}
+
 static void virtio_rng_process(VirtIORNG *vrng);
=20
 /* Send data from a char device over to the guest */
@@ -98,6 +115,9 @@ static void virtio_rng_process(VirtIORNG *vrng)
         return;
     }
=20
+    timer_mod(vrng->watchdog_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + VIRTIO_RNG_WATCHDO=
G_MS);
+
     if (vrng->activate_timer) {
         timer_mod(vrng->rate_limit_timer,
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + vrng->conf.per=
iod_ms);
@@ -222,6 +242,7 @@ static void virtio_rng_device_realize(DeviceState *de=
v, Error **errp)
=20
     vrng->vq =3D virtio_add_queue(vdev, 8, handle_input);
     vrng->quota_remaining =3D vrng->conf.max_bytes;
+    vrng->watchdog_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL, watchdog, =
vrng);
     vrng->rate_limit_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                check_rate_limit, vrng);
     vrng->activate_timer =3D true;
@@ -236,6 +257,8 @@ static void virtio_rng_device_unrealize(DeviceState *=
dev, Error **errp)
     VirtIORNG *vrng =3D VIRTIO_RNG(dev);
=20
     qemu_del_vm_change_state_handler(vrng->vmstate);
+    timer_del(vrng->watchdog_timer);
+    timer_free(vrng->watchdog_timer);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
     virtio_cleanup(vdev);
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index 922dce7caccf..05d6b0e7d881 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -42,6 +42,7 @@ typedef struct VirtIORNG {
     /* We purposefully don't migrate this state.  The quota will reset o=
n the
      * destination as a result.  Rate limiting is host state, not guest =
state.
      */
+    QEMUTimer *watchdog_timer;
     QEMUTimer *rate_limit_timer;
     int64_t quota_remaining;
     bool activate_timer;
--=20
2.21.0


