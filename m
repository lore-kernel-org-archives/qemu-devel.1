Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905EC54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D893120753
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDseBlkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D893120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpfo-00056j-W3
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGpeS-0003lw-SX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGpeR-0003B0-At
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGpeR-0003Ad-80
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585079751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWjdcU0+UwWOy2uhLjizldByOPRYIeGKr/Jd6SGhlS4=;
 b=GDseBlknIl6MRpR/xEEYht7mqxEIaMLLl+lxvSyYcyFUq+KJFrsG4QzlYdyqb04qldGGae
 CHRuq/vUfueZc8gy3+aC6xq6xItctdynGy3dw+a1M3RF2YNMvyTQNZbDJXwsa2E0TlCRyo
 tEfR3TWSE9QzPQJM2X2H/pDFEWoKLzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-HnlTqlydMf-7Da3y1SU39Q-1; Tue, 24 Mar 2020 15:55:48 -0400
X-MC-Unique: HnlTqlydMf-7Da3y1SU39Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B84CD8024D6;
 Tue, 24 Mar 2020 19:55:44 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A366C5C883;
 Tue, 24 Mar 2020 19:55:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/2] fdc/i8257: implement verify transfer mode
Date: Tue, 24 Mar 2020 15:55:22 -0400
Message-Id: <20200324195523.19779-2-jsnow@redhat.com>
In-Reply-To: <20200324195523.19779-1-jsnow@redhat.com>
References: <20200324195523.19779-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sven Schnelle <svens@stackframe.org>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

While working on the Tulip driver i tried to write some Teledisk images to
a floppy image which didn't work. Turned out that Teledisk checks the writt=
en
data by issuing a READ command to the FDC but running the DMA controller
in VERIFY mode. As we ignored the DMA request in that case, the DMA transfe=
r
never finished, and Teledisk reported an error.

The i8257 spec says about verify transfers:

3) DMA verify, which does not actually involve the transfer of data. When a=
n
8257 channel is in the DMA verify mode, it will respond the same as describ=
ed
for transfer operations, except that no memory or I/O read/write control si=
gnals
will be generated.

Herv=C3=A9 proposed to remove all the dma_mode_ok stuff from fdc to have a =
more
clear boundary between DMA and FDC, so this patch also does that.

Suggested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/isa/isa.h |  1 -
 hw/block/fdc.c       | 61 +++++++++++++-------------------------------
 hw/dma/i8257.c       | 20 ++++++++++-----
 3 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index e9ac1f1205..59a4d4b50a 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -56,7 +56,6 @@ typedef int (*IsaDmaTransferHandler)(void *opaque, int nc=
han, int pos,
 typedef struct IsaDmaClass {
     InterfaceClass parent;
=20
-    IsaDmaTransferMode (*get_transfer_mode)(IsaDma *obj, int nchan);
     bool (*has_autoinitialization)(IsaDma *obj, int nchan);
     int (*read_memory)(IsaDma *obj, int nchan, void *buf, int pos, int len=
);
     int (*write_memory)(IsaDma *obj, int nchan, void *buf, int pos, int le=
n);
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 22e954e0dc..33bc9e2f92 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1714,53 +1714,28 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, i=
nt direction)
     }
     fdctrl->eot =3D fdctrl->fifo[6];
     if (fdctrl->dor & FD_DOR_DMAEN) {
-        IsaDmaTransferMode dma_mode;
+        /* DMA transfer is enabled. */
         IsaDmaClass *k =3D ISADMA_GET_CLASS(fdctrl->dma);
-        bool dma_mode_ok;
-        /* DMA transfer are enabled. Check if DMA channel is well programm=
ed */
-        dma_mode =3D k->get_transfer_mode(fdctrl->dma, fdctrl->dma_chann);
-        FLOPPY_DPRINTF("dma_mode=3D%d direction=3D%d (%d - %d)\n",
-                       dma_mode, direction,
-                       (128 << fdctrl->fifo[5]) *
+
+        FLOPPY_DPRINTF("direction=3D%d (%d - %d)\n",
+                       direction, (128 << fdctrl->fifo[5]) *
                        (cur_drv->last_sect - ks + 1), fdctrl->data_len);
-        switch (direction) {
-        case FD_DIR_SCANE:
-        case FD_DIR_SCANL:
-        case FD_DIR_SCANH:
-            dma_mode_ok =3D (dma_mode =3D=3D ISADMA_TRANSFER_VERIFY);
-            break;
-        case FD_DIR_WRITE:
-            dma_mode_ok =3D (dma_mode =3D=3D ISADMA_TRANSFER_WRITE);
-            break;
-        case FD_DIR_READ:
-            dma_mode_ok =3D (dma_mode =3D=3D ISADMA_TRANSFER_READ);
-            break;
-        case FD_DIR_VERIFY:
-            dma_mode_ok =3D true;
-            break;
-        default:
-            dma_mode_ok =3D false;
-            break;
-        }
-        if (dma_mode_ok) {
-            /* No access is allowed until DMA transfer has completed */
-            fdctrl->msr &=3D ~FD_MSR_RQM;
-            if (direction !=3D FD_DIR_VERIFY) {
-                /* Now, we just have to wait for the DMA controller to
-                 * recall us...
-                 */
-                k->hold_DREQ(fdctrl->dma, fdctrl->dma_chann);
-                k->schedule(fdctrl->dma);
-            } else {
-                /* Start transfer */
-                fdctrl_transfer_handler(fdctrl, fdctrl->dma_chann, 0,
-                                        fdctrl->data_len);
-            }
-            return;
+
+        /* No access is allowed until DMA transfer has completed */
+        fdctrl->msr &=3D ~FD_MSR_RQM;
+        if (direction !=3D FD_DIR_VERIFY) {
+            /*
+             * Now, we just have to wait for the DMA controller to
+             * recall us...
+             */
+            k->hold_DREQ(fdctrl->dma, fdctrl->dma_chann);
+            k->schedule(fdctrl->dma);
         } else {
-            FLOPPY_DPRINTF("bad dma_mode=3D%d direction=3D%d\n", dma_mode,
-                           direction);
+            /* Start transfer */
+            fdctrl_transfer_handler(fdctrl, fdctrl->dma_chann, 0,
+                    fdctrl->data_len);
         }
+        return;
     }
     FLOPPY_DPRINTF("start non-DMA transfer\n");
     fdctrl->msr |=3D FD_MSR_NONDMA | FD_MSR_RQM;
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index ef15c06d77..1b3435ab58 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -292,12 +292,6 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr n=
port, unsigned size)
     return val;
 }
=20
-static IsaDmaTransferMode i8257_dma_get_transfer_mode(IsaDma *obj, int nch=
an)
-{
-    I8257State *d =3D I8257(obj);
-    return (d->regs[nchan & 3].mode >> 2) & 3;
-}
-
 static bool i8257_dma_has_autoinitialization(IsaDma *obj, int nchan)
 {
     I8257State *d =3D I8257(obj);
@@ -400,6 +394,11 @@ static void i8257_dma_register_channel(IsaDma *obj, in=
t nchan,
     r->opaque =3D opaque;
 }
=20
+static bool i8257_is_verify_transfer(I8257Regs *r)
+{
+    return (r->mode & 0x0c) =3D=3D 0;
+}
+
 static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int po=
s,
                                  int len)
 {
@@ -407,6 +406,10 @@ static int i8257_dma_read_memory(IsaDma *obj, int ncha=
n, void *buf, int pos,
     I8257Regs *r =3D &d->regs[nchan & 3];
     hwaddr addr =3D ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[A=
DDR];
=20
+    if (i8257_is_verify_transfer(r)) {
+        return len;
+    }
+
     if (r->mode & 0x20) {
         int i;
         uint8_t *p =3D buf;
@@ -431,6 +434,10 @@ static int i8257_dma_write_memory(IsaDma *obj, int nch=
an, void *buf, int pos,
     I8257Regs *r =3D &s->regs[nchan & 3];
     hwaddr addr =3D ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[A=
DDR];
=20
+    if (i8257_is_verify_transfer(r)) {
+        return len;
+    }
+
     if (r->mode & 0x20) {
         int i;
         uint8_t *p =3D buf;
@@ -597,7 +604,6 @@ static void i8257_class_init(ObjectClass *klass, void *=
data)
     dc->vmsd =3D &vmstate_i8257;
     device_class_set_props(dc, i8257_properties);
=20
-    idc->get_transfer_mode =3D i8257_dma_get_transfer_mode;
     idc->has_autoinitialization =3D i8257_dma_has_autoinitialization;
     idc->read_memory =3D i8257_dma_read_memory;
     idc->write_memory =3D i8257_dma_write_memory;
--=20
2.21.1


