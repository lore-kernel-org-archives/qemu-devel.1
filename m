Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFDC35E02
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02978222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2VVIrUeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02978222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aja-0002KS-Uq
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6a2p-000819-M5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6a2o-00026t-3v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:39 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:57210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1j6a2g-00021r-Re; Tue, 25 Feb 2020 08:14:31 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id B1AF596F52;
 Tue, 25 Feb 2020 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582636468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqSRTY6rjrAFDgu21fuqsHvriNk00Q2D0c+ln5Zh6Po=;
 b=2VVIrUeO8nyx3gWEQmtCZNQeYw+iEcpHfWqnna9YXXKs9UWAAx2+PLtRx6ycSAVsjSpfa0
 51TjtE3QCoicyJMJ3dsaYsRO7pBzokEDlgwZyhMWcFVkDeEHVaikWO0TXXRpi4n6dv5s0z
 IMNYnUZ2nc+5CH/+mWOXT41k5IjkIyQ=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 4/9] qdev-clock: introduce an init array to ease the device
 construction
Date: Tue, 25 Feb 2020 14:14:17 +0100
Message-Id: <20200225131422.53368-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225131422.53368-1-damien.hedde@greensocs.com>
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582636468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqSRTY6rjrAFDgu21fuqsHvriNk00Q2D0c+ln5Zh6Po=;
 b=qmWK40eWN2Ho1/DWR6bLcChnwu9HFVzHpR83nb7Tf3FxBh9BHDxeMUimKOzEq9GtJit7X6
 eGFw0+3FBXyp4Z31z54eBl0jyyoSbw+vO9BpQpHV4125waayucoWLybadk54kLxkOPWQvP
 dDFNcPE8Vtcxhu13H/fgZwsW8jTlxvE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582636468; a=rsa-sha256; cv=none;
 b=aev5dM6dYHHHTEFh1y2DMLUzr/8Z1Ts04Kx+VA4zeuF2fs/xgh+hCI4GUR9UDPT9kIblU4
 LXeXlah/ptyTOEZdTTVqxD/mDGdUXnxt/IRWosPNOfwoCQIgVBJ+MHwbadsfTnV5Eeh93/
 ajDhV25gf6ANJGwlaRRpjwuore8AfRc=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a function and macro helpers to setup several clocks
in a device from a static array description.

An element of the array describes the clock (name and direction) as
well as the related callback and an optional offset to store the
created object pointer in the device state structure.

The array must be terminated by a special element QDEV_CLOCK_END.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
--

v7:
 + update ClockIn/Out types
 + remove the QDEV_CLOCK_IN_NOFIELD macro
 + remove leading underscores in macro arguments (Peter)
 + updated some comments (Peter)
 + removed trivial asserts (Peter)
---
 include/hw/qdev-clock.h | 55 +++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev-clock.c    | 17 +++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index b3b3a3e021..a340f65ff9 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -101,4 +101,59 @@ Clock *qdev_alias_clock(DeviceState *dev, const char=
 *name,
  */
 void qdev_finalize_clocklist(DeviceState *dev);
=20
+/**
+ * ClockPortInitElem:
+ * @name: name of the clock (can't be NULL)
+ * @output: indicates whether the clock is input or output
+ * @callback: for inputs, optional callback to be called on clock's upda=
te
+ * with device as opaque
+ * @offset: optional offset to store the ClockIn or ClockOut pointer in =
device
+ * state structure (0 means unused)
+ */
+struct ClockPortInitElem {
+    const char *name;
+    bool is_output;
+    ClockCallback *callback;
+    size_t offset;
+};
+
+#define clock_offset_value(devstate, field) \
+    (offsetof(devstate, field) + \
+     type_check(Clock *, typeof_field(devstate, field)))
+
+#define QDEV_CLOCK(out_not_in, devstate, field, cb) { \
+    .name =3D (stringify(field)), \
+    .is_output =3D out_not_in, \
+    .callback =3D cb, \
+    .offset =3D clock_offset_value(devstate, field), \
+}
+
+/**
+ * QDEV_CLOCK_(IN|OUT):
+ * @devstate: structure type. @dev argument of qdev_init_clocks below mu=
st be
+ * a pointer to that same type.
+ * @field: a field in @_devstate (must be Clock*)
+ * @callback: (for input only) callback (or NULL) to be called with the =
device
+ * state as argument
+ *
+ * The name of the clock will be derived from @field
+ */
+#define QDEV_CLOCK_IN(devstate, field, callback) \
+    QDEV_CLOCK(false, devstate, field, callback)
+
+#define QDEV_CLOCK_OUT(devstate, field) \
+    QDEV_CLOCK(true, devstate, field, NULL)
+
+#define QDEV_CLOCK_END { .name =3D NULL }
+
+typedef struct ClockPortInitElem ClockPortInitArray[];
+
+/**
+ * qdev_init_clocks:
+ * @dev: the device to add clocks to
+ * @clocks: a QDEV_CLOCK_END-terminated array which contains the
+ * clocks information.
+ */
+void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)=
;
+
 #endif /* QDEV_CLOCK_H */
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 62035aef83..a94cc44437 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -116,6 +116,23 @@ Clock *qdev_init_clock_in(DeviceState *dev, const ch=
ar *name,
     return ncl->clock;
 }
=20
+void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
+{
+    const struct ClockPortInitElem *elem;
+
+    for (elem =3D &clocks[0]; elem->name !=3D NULL; elem++) {
+        Clock **clkp;
+        /* offset cannot be inside the DeviceState part */
+        assert(elem->offset > sizeof(DeviceState));
+        clkp =3D (Clock **)(((void *) dev) + elem->offset);
+        if (elem->is_output) {
+            *clkp =3D qdev_init_clock_out(dev, elem->name);
+        } else {
+            *clkp =3D qdev_init_clock_in(dev, elem->name, elem->callback=
, dev);
+        }
+    }
+}
+
 static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *=
name)
 {
     NamedClockList *ncl;
--=20
2.25.1


