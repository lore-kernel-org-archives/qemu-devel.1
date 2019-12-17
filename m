Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B19CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446A521835
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdURpsDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446A521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihG4g-0004vz-19
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihFyN-0005tp-Nt
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihFyJ-0008S7-8r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:45:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihFyI-0008Ov-Sa
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576601118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSKAIfhZrf4AzOzwxHf94n1FTTYtkdtk5h8oMtIkBhQ=;
 b=RdURpsDFoyI4zswFaaK8DtPBb0nzazYF2Ha8V5wpRa9yoFYcZq1JV8460/bhjC2CNe85iv
 W4HpwYtgVXXraby94QMXrOp4x3XQ0JQylbOPIvoJ8RnBxdmqGnnJFZQJdEOBxwHvMIvckG
 o/FXviZ0OVDgGvYEfMKCXkdifeCJygo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-1NDoE56uPtOn0SM-We1RLw-1; Tue, 17 Dec 2019 11:45:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C408800C80;
 Tue, 17 Dec 2019 16:45:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B888B68882;
 Tue, 17 Dec 2019 16:44:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 14/14] chardev: Use QEMUChrEvent enum in IOEventHandler typedef
Date: Tue, 17 Dec 2019 17:38:08 +0100
Message-Id: <20191217163808.20068-15-philmd@redhat.com>
In-Reply-To: <20191217163808.20068-1-philmd@redhat.com>
References: <20191217163808.20068-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 1NDoE56uPtOn0SM-We1RLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paul Burton <pburton@wavecomp.com>,
 Jason Wang <jasowang@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alberto Garcia <berto@igalia.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Joel Stanley <joel@jms.id.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Chardev events are listed in the QEMUChrEvent enum.

By using the enum in the IOEventHandler typedef we:

- make the IOEventHandler type more explicit (this handler
  process out-of-band information, while the IOReadHandler
  is in-band),
- help static code analyzers.

This patch was produced with the following spatch script:

  @match@
  expression backend, opaque, context, set_open;
  identifier fd_can_read, fd_read, fd_event, be_change;
  @@
  qemu_chr_fe_set_handlers(backend, fd_can_read, fd_read, fd_event,
                           be_change, opaque, context, set_open);

  @depends on match@
  identifier opaque, event;
  identifier match.fd_event;
  @@
   static
  -void fd_event(void *opaque, int event)
  +void fd_event(void *opaque, QEMUChrEvent event)
   {
   ...
   }

Then the following files were manually modified:

  - include/chardev/char-fe.h
  - include/chardev/char.h
  - include/chardev/char-mux.h
  - chardev/char.c
  - chardev/char-mux.c

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Alberto Garcia <berto@igalia.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Thomas Huth <huth@tuxfamily.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Corey Minyard <minyard@acm.org>
Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-arm@nongnu.org
Cc: qemu-block@nongnu.org
Cc: qemu-s390x@nongnu.org
Cc: qemu-riscv@nongnu.org
---
 include/chardev/char-fe.h       | 2 +-
 include/chardev/char-mux.h      | 2 +-
 include/chardev/char.h          | 4 ++--
 backends/cryptodev-vhost-user.c | 2 +-
 chardev/char-mux.c              | 8 ++++----
 chardev/char.c                  | 4 ++--
 gdbstub.c                       | 2 +-
 hw/arm/pxa2xx.c                 | 2 +-
 hw/arm/strongarm.c              | 2 +-
 hw/block/vhost-user-blk.c       | 2 +-
 hw/char/cadence_uart.c          | 2 +-
 hw/char/digic-uart.c            | 2 +-
 hw/char/escc.c                  | 2 +-
 hw/char/etraxfs_ser.c           | 2 +-
 hw/char/exynos4210_uart.c       | 2 +-
 hw/char/grlib_apbuart.c         | 2 +-
 hw/char/imx_serial.c            | 2 +-
 hw/char/ipoctal232.c            | 2 +-
 hw/char/lm32_juart.c            | 2 +-
 hw/char/lm32_uart.c             | 2 +-
 hw/char/mcf_uart.c              | 2 +-
 hw/char/milkymist-uart.c        | 2 +-
 hw/char/nrf51_uart.c            | 2 +-
 hw/char/pl011.c                 | 2 +-
 hw/char/serial.c                | 2 +-
 hw/char/sh_serial.c             | 2 +-
 hw/char/terminal3270.c          | 2 +-
 hw/char/virtio-console.c        | 2 +-
 hw/char/xilinx_uartlite.c       | 2 +-
 hw/ipmi/ipmi_bmc_extern.c       | 2 +-
 hw/mips/boston.c                | 2 +-
 hw/mips/mips_malta.c            | 2 +-
 hw/riscv/riscv_htif.c           | 2 +-
 hw/riscv/sifive_uart.c          | 2 +-
 hw/usb/ccid-card-passthru.c     | 2 +-
 hw/usb/dev-serial.c             | 2 +-
 hw/usb/redirect.c               | 2 +-
 monitor/hmp.c                   | 2 +-
 monitor/qmp.c                   | 2 +-
 net/filter-mirror.c             | 2 +-
 net/vhost-user.c                | 4 ++--
 qtest.c                         | 2 +-
 tests/test-char.c               | 6 +++---
 tests/vhost-user-test.c         | 2 +-
 44 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 67601dc9a4..a553843364 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -4,7 +4,7 @@
 #include "chardev/char.h"
 #include "qemu/main-loop.h"
=20
-typedef void IOEventHandler(void *opaque, int event);
+typedef void IOEventHandler(void *opaque, QEMUChrEvent event);
 typedef int BackendChangeHandler(void *opaque);
=20
 /* This is the backend as seen by frontend, the actual backend is
diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
index 572cefd517..417fe32eed 100644
--- a/include/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -56,6 +56,6 @@ typedef struct MuxChardev {
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
=20
 void mux_set_focus(Chardev *chr, int focus);
-void mux_chr_send_all_event(Chardev *chr, int event);
+void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
=20
 #endif /* CHAR_MUX_H */
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 087b202b62..00589a6025 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -210,7 +210,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
  *
  * Send an event from the back end to the front end.
  */
-void qemu_chr_be_event(Chardev *s, int event);
+void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
=20
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
@@ -273,7 +273,7 @@ typedef struct ChardevClass {
     void (*chr_accept_input)(Chardev *chr);
     void (*chr_set_echo)(Chardev *chr, bool echo);
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
-    void (*chr_be_event)(Chardev *s, int event);
+    void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
     /* Return 0 if succeeded, 1 if failed */
     int (*chr_machine_done)(Chardev *chr);
 } ChardevClass;
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-use=
r.c
index d700934a0e..10e74c0b96 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -152,7 +152,7 @@ cryptodev_vhost_claim_chardev(CryptoDevBackendVhostUser=
 *s,
     return chr;
 }
=20
-static void cryptodev_vhost_user_event(void *opaque, int event)
+static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
 {
     CryptoDevBackendVhostUser *s =3D opaque;
     CryptoDevBackend *b =3D CRYPTODEV_BACKEND(s);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 200c62a0d0..46c44af67c 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -117,7 +117,7 @@ static void mux_print_help(Chardev *chr)
     }
 }
=20
-static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
+static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent eve=
nt)
 {
     CharBackend *be =3D d->backends[mux_nr];
=20
@@ -126,7 +126,7 @@ static void mux_chr_send_event(MuxChardev *d, int mux_n=
r, int event)
     }
 }
=20
-static void mux_chr_be_event(Chardev *chr, int event)
+static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d =3D MUX_CHARDEV(chr);
=20
@@ -232,7 +232,7 @@ static void mux_chr_read(void *opaque, const uint8_t *b=
uf, int size)
         }
 }
=20
-void mux_chr_send_all_event(Chardev *chr, int event)
+void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d =3D MUX_CHARDEV(chr);
     int i;
@@ -247,7 +247,7 @@ void mux_chr_send_all_event(Chardev *chr, int event)
     }
 }
=20
-static void mux_chr_event(void *opaque, int event)
+static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
     mux_chr_send_all_event(CHARDEV(opaque), event);
 }
diff --git a/chardev/char.c b/chardev/char.c
index c4b6bbc55a..3b60799813 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -48,7 +48,7 @@ static Object *get_chardevs_root(void)
     return container_get(object_get_root(), "/chardevs");
 }
=20
-static void chr_be_event(Chardev *s, int event)
+static void chr_be_event(Chardev *s, QEMUChrEvent event)
 {
     CharBackend *be =3D s->be;
=20
@@ -59,7 +59,7 @@ static void chr_be_event(Chardev *s, int event)
     be->chr_event(be->opaque, event);
 }
=20
-void qemu_chr_be_event(Chardev *s, int event)
+void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
 {
     /* Keep track if the char device is open */
     switch (event) {
diff --git a/gdbstub.c b/gdbstub.c
index 4cf8af365e..ce304ff482 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3171,7 +3171,7 @@ static void gdb_chr_receive(void *opaque, const uint8=
_t *buf, int size)
     }
 }
=20
-static void gdb_chr_event(void *opaque, int event)
+static void gdb_chr_event(void *opaque, QEMUChrEvent event)
 {
     int i;
     GDBState *s =3D (GDBState *) opaque;
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index cdafde2f76..950ff4239a 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1955,7 +1955,7 @@ static void pxa2xx_fir_rx(void *opaque, const uint8_t=
 *buf, int size)
     pxa2xx_fir_update(s);
 }
=20
-static void pxa2xx_fir_event(void *opaque, int event)
+static void pxa2xx_fir_event(void *opaque, QEMUChrEvent event)
 {
 }
=20
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 6bee034914..c6776e8479 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1093,7 +1093,7 @@ static void strongarm_uart_receive(void *opaque, cons=
t uint8_t *buf, int size)
     strongarm_uart_update_int_status(s);
 }
=20
-static void strongarm_uart_event(void *opaque, int event)
+static void strongarm_uart_event(void *opaque, QEMUChrEvent event)
 {
     StrongARMUARTState *s =3D opaque;
     if (event =3D=3D CHR_EVENT_BREAK) {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 4e2b2efdd3..f4e7a53688 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -361,7 +361,7 @@ static gboolean vhost_user_blk_watch(GIOChannel *chan, =
GIOCondition cond,
     return true;
 }
=20
-static void vhost_user_blk_event(void *opaque, int event)
+static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 {
     DeviceState *dev =3D opaque;
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 0e315b2376..51791bd217 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -348,7 +348,7 @@ static void uart_receive(void *opaque, const uint8_t *b=
uf, int size)
     }
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
     CadenceUARTState *s =3D opaque;
     uint8_t buf =3D '\0';
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 974a2619dd..033eba0a6a 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -131,7 +131,7 @@ static void uart_rx(void *opaque, const uint8_t *buf, i=
nt size)
     s->reg_rx =3D *buf;
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
=20
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 8f7bf322cb..c40c1d28f1 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -634,7 +634,7 @@ static void serial_receive1(void *opaque, const uint8_t=
 *buf, int size)
     serial_receive_byte(s, buf[0]);
 }
=20
-static void serial_event(void *opaque, int event)
+static void serial_event(void *opaque, QEMUChrEvent event)
 {
     ESCCChannelState *s =3D opaque;
     if (event =3D=3D CHR_EVENT_BREAK)
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 15ac12ef22..f34f767c60 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -202,7 +202,7 @@ static int serial_can_receive(void *opaque)
     return sizeof(s->rx_fifo) - s->rx_fifo_len;
 }
=20
-static void serial_event(void *opaque, int event)
+static void serial_event(void *opaque, QEMUChrEvent event)
 {
=20
 }
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index d6b6b62366..7e5c5ce789 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -528,7 +528,7 @@ static void exynos4210_uart_receive(void *opaque, const=
 uint8_t *buf, int size)
 }
=20
=20
-static void exynos4210_uart_event(void *opaque, int event)
+static void exynos4210_uart_event(void *opaque, QEMUChrEvent event)
 {
     Exynos4210UartState *s =3D (Exynos4210UartState *)opaque;
=20
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index fe3cbf41a3..8e59c3bc6e 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -155,7 +155,7 @@ static void grlib_apbuart_receive(void *opaque, const u=
int8_t *buf, int size)
     }
 }
=20
-static void grlib_apbuart_event(void *opaque, int event)
+static void grlib_apbuart_event(void *opaque, QEMUChrEvent event)
 {
     trace_grlib_apbuart_event(event);
 }
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index fddde9b43d..d09c210709 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -323,7 +323,7 @@ static void imx_receive(void *opaque, const uint8_t *bu=
f, int size)
     imx_put_data(opaque, *buf);
 }
=20
-static void imx_event(void *opaque, int event)
+static void imx_event(void *opaque, QEMUChrEvent event)
 {
     if (event =3D=3D CHR_EVENT_BREAK) {
         imx_put_data(opaque, URXD_BRK | URXD_FRMERR | URXD_ERR);
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 66c163ba26..80e9dff701 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -503,7 +503,7 @@ static void hostdev_receive(void *opaque, const uint8_t=
 *buf, int size)
     }
 }
=20
-static void hostdev_event(void *opaque, int event)
+static void hostdev_event(void *opaque, QEMUChrEvent event)
 {
     SCC2698Channel *ch =3D opaque;
     switch (event) {
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index e0b1bd6555..da9dd5668b 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -104,7 +104,7 @@ static int juart_can_rx(void *opaque)
     return !(s->jrx & JRX_FULL);
 }
=20
-static void juart_event(void *opaque, int event)
+static void juart_event(void *opaque, QEMUChrEvent event)
 {
 }
=20
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 32f29c44cf..8d7a475c91 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -235,7 +235,7 @@ static int uart_can_rx(void *opaque)
     return !(s->regs[R_LSR] & LSR_DR);
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
=20
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 58323baf43..2de3680b5d 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -256,7 +256,7 @@ static void mcf_uart_push_byte(mcf_uart_state *s, uint8=
_t data)
     mcf_uart_update(s);
 }
=20
-static void mcf_uart_event(void *opaque, int event)
+static void mcf_uart_event(void *opaque, QEMUChrEvent event)
 {
     mcf_uart_state *s =3D (mcf_uart_state *)opaque;
=20
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index c358ca07f3..1c7b61480e 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -180,7 +180,7 @@ static int uart_can_rx(void *opaque)
     return !(s->regs[R_STAT] & STAT_RX_EVT);
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
=20
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 2777afe366..b67fd21089 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -245,7 +245,7 @@ static int uart_can_receive(void *opaque)
     return s->rx_started ? (UART_FIFO_LENGTH - s->rx_fifo_len) : 0;
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
     NRF51UARTState *s =3D NRF51_UART(opaque);
=20
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 84ad8ff9fb..23cd544cc5 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -280,7 +280,7 @@ static void pl011_receive(void *opaque, const uint8_t *=
buf, int size)
     pl011_put_fifo(opaque, *buf);
 }
=20
-static void pl011_event(void *opaque, int event)
+static void pl011_event(void *opaque, QEMUChrEvent event)
 {
     if (event =3D=3D CHR_EVENT_BREAK)
         pl011_put_fifo(opaque, 0x400);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4aa250950..992b5ee944 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -634,7 +634,7 @@ static void serial_receive1(void *opaque, const uint8_t=
 *buf, int size)
     serial_update_irq(s);
 }
=20
-static void serial_event(void *opaque, int event)
+static void serial_event(void *opaque, QEMUChrEvent event)
 {
     SerialState *s =3D opaque;
     DPRINTF("event %x\n", event);
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 07dc16be13..167f4d8cb9 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -358,7 +358,7 @@ static void sh_serial_receive1(void *opaque, const uint=
8_t *buf, int size)
     }
 }
=20
-static void sh_serial_event(void *opaque, int event)
+static void sh_serial_event(void *opaque, QEMUChrEvent event)
 {
     sh_serial_state *s =3D opaque;
     if (event =3D=3D CHR_EVENT_BREAK)
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 9e59a2d92b..4ae9e1cff2 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -142,7 +142,7 @@ static void terminal_read(void *opaque, const uint8_t *=
buf, int size)
     }
 }
=20
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     Terminal3270 *t =3D opaque;
     CcwDevice *ccw_dev =3D CCW_DEVICE(t);
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index d3f7ba36fe..35e31a4515 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -145,7 +145,7 @@ static void chr_read(void *opaque, const uint8_t *buf, =
int size)
     virtio_serial_write(port, buf, size);
 }
=20
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     VirtConsole *vcon =3D opaque;
     VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(vcon);
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 2c47275068..aa6bf02e21 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -206,7 +206,7 @@ static int uart_can_rx(void *opaque)
     return s->rx_fifo_len < sizeof(s->rx_fifo);
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
=20
 }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 9d67e6a4a5..4dfb3ae8f5 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -379,7 +379,7 @@ static void receive(void *opaque, const uint8_t *buf, i=
nt size)
     handle_hw_op(ibe, hw_op);
 }
=20
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     IPMIBmcExtern *ibe =3D opaque;
     IPMIInterface *s =3D ibe->parent.intf;
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ca7d813a52..29b476b4bd 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -98,7 +98,7 @@ enum boston_plat_reg {
     PLAT_SYS_CTL        =3D 0x48,
 };
=20
-static void boston_lcd_event(void *opaque, int event)
+static void boston_lcd_event(void *opaque, QEMUChrEvent event)
 {
     BostonState *s =3D opaque;
     if (event =3D=3D CHR_EVENT_OPENED && !s->lcd_inited) {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 783cd99848..72c03baa8e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -545,7 +545,7 @@ static void malta_fpga_reset(void *opaque)
     snprintf(s->display_text, 9, "        ");
 }
=20
-static void malta_fgpa_display_event(void *opaque, int event)
+static void malta_fgpa_display_event(void *opaque, QEMUChrEvent event)
 {
     MaltaFPGAState *s =3D opaque;
=20
diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 4f7b11dc37..ca87a5cf9f 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -96,7 +96,7 @@ static void htif_recv(void *opaque, const uint8_t *buf, i=
nt size)
  * Called by the char dev to supply special events to the HTIF console.
  * Not used for HTIF.
  */
-static void htif_event(void *opaque, int event)
+static void htif_event(void *opaque, QEMUChrEvent event)
 {
=20
 }
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index a403ae90f5..9350482662 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -162,7 +162,7 @@ static int uart_can_rx(void *opaque)
     return s->rx_fifo_len < sizeof(s->rx_fifo);
 }
=20
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
=20
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 190f268da2..cfaddf7f45 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -307,7 +307,7 @@ static void ccid_card_vscard_read(void *opaque, const u=
int8_t *buf, int size)
     }
 }
=20
-static void ccid_card_vscard_event(void *opaque, int event)
+static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
 {
     PassthruState *card =3D opaque;
=20
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 497f932a5a..3504e6505a 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -461,7 +461,7 @@ static void usb_serial_read(void *opaque, const uint8_t=
 *buf, int size)
     s->recv_used +=3D size;
 }
=20
-static void usb_serial_event(void *opaque, int event)
+static void usb_serial_event(void *opaque, QEMUChrEvent event)
 {
     USBSerialState *s =3D opaque;
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index acc376cc95..d5f85851b9 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1354,7 +1354,7 @@ static void usbredir_chardev_read(void *opaque, const=
 uint8_t *buf, int size)
     usbredirparser_do_write(dev->parser);
 }
=20
-static void usbredir_chardev_event(void *opaque, int event)
+static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
 {
     USBRedirDevice *dev =3D opaque;
=20
diff --git a/monitor/hmp.c b/monitor/hmp.c
index d84238c120..ad9a599a88 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1322,7 +1322,7 @@ static void monitor_read(void *opaque, const uint8_t =
*buf, int size)
     cur_mon =3D old_mon;
 }
=20
-static void monitor_event(void *opaque, int event)
+static void monitor_event(void *opaque, QEMUChrEvent event)
 {
     Monitor *mon =3D opaque;
     MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index d666b07e68..1c7cbbfff0 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -337,7 +337,7 @@ static QDict *qmp_greeting(MonitorQMP *mon)
         ver, cap_list);
 }
=20
-static void monitor_qmp_event(void *opaque, int event)
+static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 {
     QDict *data;
     MonitorQMP *mon =3D opaque;
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 8d36009c53..d83e815545 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -132,7 +132,7 @@ static void redirector_chr_read(void *opaque, const uin=
t8_t *buf, int size)
     }
 }
=20
-static void redirector_chr_event(void *opaque, int event)
+static void redirector_chr_event(void *opaque, QEMUChrEvent event)
 {
     NetFilterState *nf =3D opaque;
     MirrorState *s =3D FILTER_REDIRECTOR(nf);
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 383d68024e..051e1dbd6e 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -218,7 +218,7 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, =
GIOCondition cond,
     return TRUE;
 }
=20
-static void net_vhost_user_event(void *opaque, int event);
+static void net_vhost_user_event(void *opaque, QEMUChrEvent event);
=20
 static void chr_closed_bh(void *opaque)
 {
@@ -249,7 +249,7 @@ static void chr_closed_bh(void *opaque)
     }
 }
=20
-static void net_vhost_user_event(void *opaque, int event)
+static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
 {
     const char *name =3D opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
diff --git a/qtest.c b/qtest.c
index 8b50e2783e..12432f99cf 100644
--- a/qtest.c
+++ b/qtest.c
@@ -722,7 +722,7 @@ static int qtest_can_read(void *opaque)
     return 1024;
 }
=20
-static void qtest_event(void *opaque, int event)
+static void qtest_event(void *opaque, QEMUChrEvent event)
 {
     int i;
=20
diff --git a/tests/test-char.c b/tests/test-char.c
index 45e42af290..3afc9b1b8d 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -54,7 +54,7 @@ static void fe_read(void *opaque, const uint8_t *buf, int=
 size)
     quit =3D true;
 }
=20
-static void fe_event(void *opaque, int event)
+static void fe_event(void *opaque, QEMUChrEvent event)
 {
     FeHandler *h =3D opaque;
     bool new_open_state;
@@ -633,7 +633,7 @@ typedef struct {
=20
=20
 static void
-char_socket_event(void *opaque, int event)
+char_socket_event(void *opaque, QEMUChrEvent event)
 {
     CharSocketTestData *data =3D opaque;
     data->event =3D event;
@@ -1006,7 +1006,7 @@ static void char_socket_client_test(gconstpointer opa=
que)
 }
=20
 static void
-count_closed_event(void *opaque, int event)
+count_closed_event(void *opaque, QEMUChrEvent event)
 {
     int *count =3D opaque;
     if (event =3D=3D CHR_EVENT_CLOSED) {
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 91ea373ba5..2324b964ad 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -499,7 +499,7 @@ static TestServer *test_server_new(const gchar *name)
     return server;
 }
=20
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     TestServer *s =3D opaque;
=20
--=20
2.21.0


