Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99107C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EF223CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="GmrGNpaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EF223CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCMA-00063z-Ls
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:32:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCG1-0000dB-Qh
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFz-0003iU-W7
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:53 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFw-0003bS-Qu; Tue, 04 Jun 2019 12:25:49 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 37ADC96F68;
	Tue,  4 Jun 2019 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=MCCvN1xRL6lomue9uOOMJhghQO1bTT/gZNsAko9dsf4=;
	b=GmrGNpaGYaj/GCcw6VZxwbrpC4Q1wL85KYRt6NJ4UAJbWHQydp2Zrx7mRA3ZzlRYm5p89i
	Q4dqcSMo8YvBd98hPHo4RrEiBK5VGkGGcibIuHwfGvN7sO5UKDSk6tgOgi+HAZWT3vWtLx
	j3NPIw4jAzr4/FZGD47tT12utKWnaxQ=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:24 +0200
Message-Id: <20190604162526.10655-11-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=MCCvN1xRL6lomue9uOOMJhghQO1bTT/gZNsAko9dsf4=;
	b=y9PTVYdS5gJqOF9WIW+pVyiZtMINwiuL6Q7lcHJI5Xv8T4W+UMQlA1uhs55HPoo3t9b9ar
	3DyIXe8DNRO7R+HKqsdNjmCjGYYyotUk7zipnbXYzthIchoEmgKZmWb8SxACJgAnbzv/SP
	Nk1q82iry1uNTzvUalwqYmrDiyVINvU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665547; a=rsa-sha256; cv=none;
	b=s/EMiGQIdfx0FfifSOGkN2n82/hoQJIL8RsbE+vg/h5T0iLTCH2txS20BzodAhXSRzTmxX
	SlUElqwydkNzG5n4TVJd929DMatb664Fi8mv+Ce4UsS351tc+gXOl7A9cQoYLjwe6CDAov
	rEv8yE27Pi6o7zy7Hji+izO6/DfkHwU=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 10/12] Convert zynq's slcr to 3-phases
 reset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
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
index baa13d1316..c6d2bba966 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -171,6 +171,17 @@ REG32(DDRIOB, 0xb40)
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
@@ -180,13 +191,18 @@ typedef struct ZynqSLCRState {
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
 } ZynqSLCRState;
=20
-static void zynq_slcr_reset(DeviceState *d)
+static void zynq_slcr_reset_init(Object *obj, bool cold)
 {
-    ZynqSLCRState *s =3D ZYNQ_SLCR(d);
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+    ZynqSLCRClass *zc =3D ZYNQ_SLCR_GET_CLASS(obj);
     int i;
=20
     DB_PRINT("RESET\n");
=20
+    if (zc->parent_reset_phases.init) {
+        zc->parent_reset_phases.init(obj, cold);
+    }
+
     s->regs[R_LOCKSTA] =3D 1;
     /* 0x100 - 0x11C */
     s->regs[R_ARM_PLL_CTRL]   =3D 0x0001A008;
@@ -276,7 +292,6 @@ static void zynq_slcr_reset(DeviceState *d)
     s->regs[R_DDRIOB + 12] =3D 0x00000021;
 }
=20
-
 static bool zynq_slcr_check_offset(hwaddr offset, bool rnw)
 {
     switch (offset) {
@@ -346,6 +361,10 @@ static uint64_t zynq_slcr_read(void *opaque, hwaddr =
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
@@ -361,6 +380,10 @@ static void zynq_slcr_write(void *opaque, hwaddr off=
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
@@ -439,9 +462,16 @@ static const VMStateDescription vmstate_zynq_slcr =3D=
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
@@ -450,6 +480,7 @@ static const TypeInfo zynq_slcr_info =3D {
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_size  =3D sizeof(ZynqSLCRState),
     .instance_init =3D zynq_slcr_init,
+    .class_size =3D sizeof(ZynqSLCRClass),
 };
=20
 static void zynq_slcr_register_types(void)
--=20
2.21.0


