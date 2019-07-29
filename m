Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0661EC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2222070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="xiA+Hxsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2222070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Fd-0002S4-3F
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77Q-0004HY-Rg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77L-0004j8-EZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:17 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs778-0004UA-K9; Mon, 29 Jul 2019 10:59:03 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 3E69896F63;
 Mon, 29 Jul 2019 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=409z6EcDD8PHCk72cCP2wzloU1EO5HsmW5lWXcYVGNs=;
 b=xiA+HxspsLSBtmQcw+UvJ/wzhyFTaaXQuhIXreXHNWUyJndVIdBS5VTsTzNdkxYvDKIc2N
 4c8tuqHWXo5Pg7KmqYndFmLGgi6sLEYUqPevLayStKO6KNvb5J76ilgmDQ3SmqvZ+OA0xi
 ig6QWdsZp3AbTtbeMWYY/K+OnIJvIgI=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:29 +0200
Message-Id: <20190729145654.14644-9-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=409z6EcDD8PHCk72cCP2wzloU1EO5HsmW5lWXcYVGNs=;
 b=yrwdTmD8nli09lh4tSL2S4rXSszfTatn7Y1PP+jI/c36hC5bnnX6cOxH3blgc2SqVeOSXK
 L4uvV5HjM6Ea2x9/gLXdfBhWC/4gxOmR7KXBc7+vBXfvg3KhcQRZ3cMo2q688hE4JKagXT
 D21NSh9YTv4mdnsrKB9UUw7yCCDQxW4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412341; a=rsa-sha256; cv=none;
 b=Iw5SF0aymzGYPVa6mybde/cU7+/kf+iKmI9X64k+3GPT2xQroQh2325IyGMVDrNXHzK+TZ
 ViVIj0y2juaNXZZoOAiDjsLJ/Ghz8vOrIDZ5zBSQ+IREWndsjGvRhLzwgYtZvGahqLS9nG
 Ve/Bzba2DvH4orgGjVoMvo4bOav83Lc=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 08/33] Add function to control reset with
 gpio inputs
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

It adds the possibility to add 2 gpios to control the warm and cold reset=
.
With theses ios, the reset can be maintained during some time.
Each io is associated with a state to detect level changes.

Vmstate subsections are also added to the existsing device_reset
subsection.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev-vmstate.c | 15 ++++++++++
 hw/core/qdev.c         | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h | 57 ++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
index 24f8465c61..72f84c6cee 100644
--- a/hw/core/qdev-vmstate.c
+++ b/hw/core/qdev-vmstate.c
@@ -24,10 +24,23 @@ static int device_vmstate_reset_post_load(void *opaqu=
e, int version_id)
 {
     DeviceState *dev =3D (DeviceState *) opaque;
     BusState *bus;
+    uint32_t io_count =3D 0;
+
     QLIST_FOREACH(bus, &dev->child_bus, sibling) {
         bus->resetting =3D dev->resetting;
         bus->reset_is_cold =3D dev->reset_is_cold;
     }
+
+    if (dev->cold_reset_input.state) {
+        io_count +=3D 1;
+    }
+    if (dev->warm_reset_input.state) {
+        io_count +=3D 1;
+    }
+    /* ensure resetting count is coherent with io states */
+    if (dev->resetting < io_count) {
+        return -1;
+    }
     return 0;
 }
=20
@@ -40,6 +53,8 @@ const struct VMStateDescription device_vmstate_reset =3D=
 {
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(resetting, DeviceState),
         VMSTATE_BOOL(reset_is_cold, DeviceState),
+        VMSTATE_BOOL(cold_reset_input.state, DeviceState),
+        VMSTATE_BOOL(warm_reset_input.state, DeviceState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 88387d3743..11a4de55ea 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -450,6 +450,67 @@ void qdev_init_gpio_in(DeviceState *dev, qemu_irq_ha=
ndler handler, int n)
     qdev_init_gpio_in_named(dev, handler, NULL, n);
 }
=20
+static DeviceResetInputState *device_get_reset_input_state(DeviceState *=
dev,
+                                                            bool cold)
+{
+    return cold ? &dev->cold_reset_input : &dev->warm_reset_input;
+}
+
+static void device_reset_handler(DeviceState *dev, bool cold, bool level=
)
+{
+    DeviceResetInputState *dris =3D device_get_reset_input_state(dev, co=
ld);
+
+    if (dris->type =3D=3D DEVICE_RESET_ACTIVE_LOW) {
+        level =3D !level;
+    }
+
+    if (dris->state =3D=3D level) {
+        /* io state has not changed */
+        return;
+    }
+
+    dris->state =3D level;
+
+    if (level) {
+        resettable_assert_reset(OBJECT(dev), cold);
+    } else {
+        resettable_deassert_reset(OBJECT(dev));
+    }
+}
+
+static void device_cold_reset_handler(void *opaque, int n, int level)
+{
+    device_reset_handler((DeviceState *) opaque, true, level);
+}
+
+static void device_warm_reset_handler(void *opaque, int n, int level)
+{
+    device_reset_handler((DeviceState *) opaque, false, level);
+}
+
+void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
+                                   bool cold, DeviceResetActiveType type=
)
+{
+    DeviceResetInputState *dris =3D device_get_reset_input_state(dev, co=
ld);
+    qemu_irq_handler handler;
+
+    switch (type) {
+    case DEVICE_RESET_ACTIVE_LOW:
+    case DEVICE_RESET_ACTIVE_HIGH:
+        break;
+    default:
+        assert(false);
+        break;
+    }
+
+    assert(!dris->exists);
+    dris->exists =3D true;
+    dris->type =3D type;
+
+    handler =3D cold ? device_cold_reset_handler : device_warm_reset_han=
dler;
+    qdev_init_gpio_in_named(dev, handler, name, 1);
+}
+
 void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
                               const char *name, int n)
 {
@@ -1007,6 +1068,10 @@ static void device_initfn(Object *obj)
     dev->instance_id_alias =3D -1;
     dev->realized =3D false;
     dev->resetting =3D 0;
+    dev->cold_reset_input.exists =3D false;
+    dev->cold_reset_input.state =3D false;
+    dev->warm_reset_input.exists =3D false;
+    dev->warm_reset_input.state =3D false;
=20
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, N=
ULL);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 926d4bbcb1..f724ddc8f4 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -136,6 +136,23 @@ struct NamedGPIOList {
     QLIST_ENTRY(NamedGPIOList) node;
 };
=20
+typedef enum DeviceResetActiveType {
+    DEVICE_RESET_ACTIVE_LOW,
+    DEVICE_RESET_ACTIVE_HIGH,
+} DeviceResetActiveType;
+
+/**
+ * DeviceResetInputState:
+ * @exists: tell if io exists
+ * @type: tell whether the io active low or high
+ * @state: true if reset is currently active
+ */
+typedef struct DeviceResetInputState {
+    bool exists;
+    DeviceResetActiveType type;
+    bool state;
+} DeviceResetInputState;
+
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
@@ -143,6 +160,8 @@ struct NamedGPIOList {
  * used to count how many times reset has been initiated on the device.
  * @reset_is_cold: If the device is under reset, indicates whether it is=
 cold
  * or warm.
+ * @cold_reset_input: state data for cold reset io
+ * @warm_reset_input: state data for warm reset io
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
@@ -167,6 +186,8 @@ struct DeviceState {
     uint32_t resetting;
     bool reset_is_cold;
     bool reset_hold_needed;
+    DeviceResetInputState cold_reset_input;
+    DeviceResetInputState warm_reset_input;
 };
=20
 struct DeviceListener {
@@ -372,6 +393,42 @@ static inline void qdev_init_gpio_in_named(DeviceSta=
te *dev,
 void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
                      const char *name);
=20
+/**
+ * qdev_init_reset_gpio_in_named:
+ * Create a gpio controlling the warm or cold reset of the device.
+ *
+ * @cold: specify whether it triggers cold or warm reset
+ * @type: what kind of reset io it is
+ *
+ * Note: the io is considered created in its inactive state. No reset
+ * is started by this function.
+ */
+void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
+                                   bool cold, DeviceResetActiveType type=
);
+
+/**
+ * qdev_init_warm_reset_gpio:
+ * Create the input to control the device warm reset.
+ */
+static inline void qdev_init_warm_reset_gpio(DeviceState *dev,
+                                             const char *name,
+                                             DeviceResetActiveType type)
+{
+    qdev_init_reset_gpio_in_named(dev, name, false, type);
+}
+
+/**
+ * qdev_init_cold_reset_gpio:
+ * Create the input to control the device cold reset.
+ * It can also be used as a power gate control.
+ */
+static inline void qdev_init_cold_reset_gpio(DeviceState *dev,
+                                             const char *name,
+                                             DeviceResetActiveType type)
+{
+    qdev_init_reset_gpio_in_named(dev, name, true, type);
+}
+
 BusState *qdev_get_parent_bus(DeviceState *dev);
=20
 /*** BUS API. ***/
--=20
2.22.0


