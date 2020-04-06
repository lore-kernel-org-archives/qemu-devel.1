Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5DC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E22523133
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="BD9p98fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E22523133
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSEJ-0005ty-CW
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1jLSBj-0003yq-I9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1jLSBi-00027B-4V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:53:19 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1jLSBf-00022j-85; Mon, 06 Apr 2020 09:53:15 -0400
Received: from crumble.bar.greensocs.com (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPS id A99C496F52;
 Mon,  6 Apr 2020 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1586181194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd+c6ZlUhTW+CjsmjUZ8LHr1moi5jsi8mp25Jv1cp0E=;
 b=BD9p98fd1uLwshkrS+2ytKIb6U6JIgu8x2WRqIprN9ukg121Wyfzez4RDbcfK+rjPHI+5f
 LrG8PHLS9TJhQRNBBI74AsOje3dN0zYSRhoyWwiBDX34AVBmsa3V2C71OWWulaoOWbvvFn
 iOeW1/Mj8uvykKq7X1Vb+60HzkK0xwg=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 4/9] qdev-clock: introduce an init array to ease the device
 construction
Date: Mon,  6 Apr 2020 15:52:46 +0200
Message-Id: <20200406135251.157596-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406135251.157596-1-damien.hedde@greensocs.com>
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1586181194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd+c6ZlUhTW+CjsmjUZ8LHr1moi5jsi8mp25Jv1cp0E=;
 b=5zBwib28TL6fKOOXLYfKYYp4lupRnqmXjGMJh8zuqjy9+5A8KhO+X/0Ln+P15SUqU09a00
 B/NGM067GAHIvgCflk+ctBFSMbGTyHIpgS7dOwnyyNN+J8XdlEszFb3i++u2vhBuA5g+UN
 JOeuzTuOIlO4Z1AYqKfCgCtBEc0qTcc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1586181194; a=rsa-sha256; cv=none;
 b=EWLc22ikmNNFa+wYONptfxXkE4jxOVfgLTVYmr9R8iQUFkCXUoNguDRWnpdGFAFJKrdvDh
 XlDslJ3XTjZshvCTU+Cl9vOpbcG6AWJ+kzfRSaCH81JOjUZAd5s9uAjc5riYcLuFVuVeR3
 QqaqIP5NeFCVzkeIbO2uUgS7iTteSXs=
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
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com,
 edgar.iglesias@gmail.com, philmd@redhat.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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
2.26.0


