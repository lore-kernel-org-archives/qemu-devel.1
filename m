Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094CBC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10AC21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="7a1I6G6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10AC21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7NZ-0002Xf-0V
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79B-0007N1-I2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs799-0006am-QU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78x-0005ZN-6n; Mon, 29 Jul 2019 11:00:55 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 0256197067;
 Mon, 29 Jul 2019 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aThNjuVE1UXty0oi0ItEPUL3pO9Pqai4sg44CRrS3k=;
 b=7a1I6G6whT1mF+2/EfRGbkcY9k7EMHus3Rgcr5vPaC30jIvzfiDS4QZWk75/JqJgTgfZr5
 G0o8Xv82b9hJziFrvdCWQ0bR+/Vuhsm2kM8pyjbXzznARos9ZPCMl+5BuVGpsD4eX3VZok
 pQ3luNhiAkMNRF9uXsVgdVDjK+6hisQ=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:52 +0200
Message-Id: <20190729145654.14644-32-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aThNjuVE1UXty0oi0ItEPUL3pO9Pqai4sg44CRrS3k=;
 b=ICBNHhSKdGk82y1XxC8KFIBj0ewRXUFpgW4t1LKIC1Z6L7DsxYNoqPNTucX2lc5dxnSD1u
 VWOr7ILxPpK6p4yG3SC64vC9E4G8FspmDl2mtr8mEi5ZwQXGBVLfg3hof3ctnovto8QU7r
 OxrC1prTKRFL/ni1w4gMYDZ0+NOtVL8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412374; a=rsa-sha256; cv=none;
 b=MGMsrLscgJR4Mg0EWT3LnAkICNh7DuOWC6gz1apLHMwcOeHxwjkHNFWn+WhJWgYjJNZid/
 f51UnZ/O8rHxUD8R7oui17iHVY8FQ4c0E04yXwsud2k8guRCE+BAn9r95RlJmr0fmSTsbJ
 /CGwjP8+fzbfG7/LMFPHqi+AFv0yG+E=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 31/33] Convert zynq's slcr to 3-phases reset
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change the legacy reset function into the init phase and test the
resetting flag in register accesses.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/misc/zynq_slcr.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index dd766a6779..6fcdbce4f0 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -172,6 +172,17 @@ REG32(DDRIOB, 0xb40)
=20
 #define TYPE_ZYNQ_SLCR "xilinx,zynq_slcr"
 #define ZYNQ_SLCR(obj) OBJECT_CHECK(ZynqSLCRState, (obj), TYPE_ZYNQ_SLCR=
)
+#define ZYNQ_SLCR_CLASS(class) \
+        OBJECT_CLASS_CHECK(ZynqSLCRClass, (class), TYPE_ZYNQ_SLCR)
+#define ZYNQ_SLCR_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(ZynqSLCRClass, (obj), TYPE_ZYNQ_SLCR)
+
+typedef struct ZynqSLCRClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+
+    struct ResettablePhases parent_reset_phases;
+} ZynqSLCRClass;
=20
 typedef struct ZynqSLCRState {
     SysBusDevice parent_obj;
@@ -181,13 +192,18 @@ typedef struct ZynqSLCRState {
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
 } ZynqSLCRState;
=20
-static void zynq_slcr_reset(DeviceState *d)
+static void zynq_slcr_reset_init(Object *obj)
 {
-    ZynqSLCRState *s =3D ZYNQ_SLCR(d);
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+    ZynqSLCRClass *zc =3D ZYNQ_SLCR_GET_CLASS(obj);
     int i;
=20
     DB_PRINT("RESET\n");
=20
+    if (zc->parent_reset_phases.init) {
+        zc->parent_reset_phases.init(obj);
+    }
+
     s->regs[R_LOCKSTA] =3D 1;
     /* 0x100 - 0x11C */
     s->regs[R_ARM_PLL_CTRL]   =3D 0x0001A008;
@@ -277,7 +293,6 @@ static void zynq_slcr_reset(DeviceState *d)
     s->regs[R_DDRIOB + 12] =3D 0x00000021;
 }
=20
-
 static bool zynq_slcr_check_offset(hwaddr offset, bool rnw)
 {
     switch (offset) {
@@ -347,6 +362,10 @@ static uint64_t zynq_slcr_read(void *opaque, hwaddr =
offset,
     offset /=3D 4;
     uint32_t ret =3D s->regs[offset];
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return 0;
+    }
+
     if (!zynq_slcr_check_offset(offset, true)) {
         qemu_log_mask(LOG_GUEST_ERROR, "zynq_slcr: Invalid read access t=
o "
                       " addr %" HWADDR_PRIx "\n", offset * 4);
@@ -362,6 +381,10 @@ static void zynq_slcr_write(void *opaque, hwaddr off=
set,
     ZynqSLCRState *s =3D (ZynqSLCRState *)opaque;
     offset /=3D 4;
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return;
+    }
+
     DB_PRINT("addr: %08" HWADDR_PRIx " data: %08" PRIx64 "\n", offset * =
4, val);
=20
     if (!zynq_slcr_check_offset(offset, false)) {
@@ -440,9 +463,16 @@ static const VMStateDescription vmstate_zynq_slcr =3D=
 {
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+    ZynqSLCRClass *zc =3D ZYNQ_SLCR_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_zynq_slcr;
-    dc->reset =3D zynq_slcr_reset;
+
+    resettable_class_set_parent_reset_phases(rc,
+                                             zynq_slcr_reset_init,
+                                             NULL,
+                                             NULL,
+                                             &zc->parent_reset_phases);
 }
=20
 static const TypeInfo zynq_slcr_info =3D {
@@ -451,6 +481,7 @@ static const TypeInfo zynq_slcr_info =3D {
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_size  =3D sizeof(ZynqSLCRState),
     .instance_init =3D zynq_slcr_init,
+    .class_size =3D sizeof(ZynqSLCRClass),
 };
=20
 static void zynq_slcr_register_types(void)
--=20
2.22.0


