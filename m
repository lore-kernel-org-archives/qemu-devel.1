Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED0F21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="cskjG/Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED0F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Nt-0002oh-9t
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79E-0007UV-8n
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79C-0006fc-RP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:12 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78x-0005ZJ-64; Mon, 29 Jul 2019 11:00:55 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 675B297030;
 Mon, 29 Jul 2019 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CuK0R1yEmIw3ue/ncT8aMu/7cio9gA+aFOL7xtl6KDw=;
 b=cskjG/WiG5xmo0EZ5ctOjAYEAz9/P3DtnpxcAWXvok8IT6V/FhQIzeru61jdcrryhbixyQ
 atYYSt3cwsd7JJ406AbQeeGVdpM5g1illutRlpexX3b0Wz0qrOyMGlNzFbl6TeRZpy6zhh
 qguG3ljV7Im2cpbDwK9UsFepxoaw2lM=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:49 +0200
Message-Id: <20190729145654.14644-29-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CuK0R1yEmIw3ue/ncT8aMu/7cio9gA+aFOL7xtl6KDw=;
 b=gcfzcXQO8gkMIyW+3VrA6ezPHFaNLe/3LfG7unKflwxesGP9AkN5FoEGj0Twiyzmb/7PuX
 4lAGRJ1jW35yYMHVWyI3Qff+Etf03JPiandTm8dH4dyyN3mdcPL3kyNMg70JdxxUzkptSS
 1WGpVTiCt1yXArDQVLnny2G7FO9XSCE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412369; a=rsa-sha256; cv=none;
 b=fbsfWrUIatX6lxuQoJRaFMOj+zbSPCsSlLQ4lGkibvRYbaBy/DTSjsVWEWaAErj7nap7x9
 PTE3R62B40fokyR9jFphjQNC0qt0ZdkVgyzJFh33Nw91lrNf3pkD58qwk/E7ksOWPDJTyC
 gg8/KOSxDPWYc4SzGjViy69UxnPeUgw=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 28/33] qdev: Remove unused deprecated reset
 functions
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

Remove the functions now they are unused:
+ device_legacy_reset
+ qdev_reset_all[_fn]
+ qbus_reset_all[_fn]

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev.c         | 30 ------------------------------
 include/hw/qdev-core.h | 29 -----------------------------
 2 files changed, 59 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 11a4de55ea..896b55f7ba 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -322,27 +322,6 @@ static void device_foreach_reset_child(Object *obj, =
void (*func)(Object *))
     }
 }
=20
-void qdev_reset_all(DeviceState *dev)
-{
-    device_reset(dev, false);
-}
-
-void qdev_reset_all_fn(void *opaque)
-{
-    qdev_reset_all(DEVICE(opaque));
-}
-
-void qbus_reset_all(BusState *bus)
-{
-    bus_reset(bus, false);
-}
-
-void qbus_reset_all_fn(void *opaque)
-{
-    BusState *bus =3D opaque;
-    qbus_reset_all(bus);
-}
-
 /* can be used as ->unplug() callback for the simple cases */
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
@@ -1223,15 +1202,6 @@ void device_class_set_parent_unrealize(DeviceClass=
 *dc,
     dc->unrealize =3D dev_unrealize;
 }
=20
-void device_legacy_reset(DeviceState *dev)
-{
-    DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
-
-    if (klass->reset) {
-        klass->reset(dev);
-    }
-}
-
 Object *qdev_get_machine(void)
 {
     static Object *dev;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f724ddc8f4..eb6370970e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -518,25 +518,6 @@ bool bus_is_resetting(BusState *bus);
  */
 bool bus_is_reset_cold(BusState *bus);
=20
-/**
- * qbus/qdev_reset_all:
- * @bus/dev: Bus/Device to be reset.
- *
- * Reset @bus/dev and perform a bus-level reset of all devices/buses con=
nected
- * to it, including recursive processing of all buses below @bus itself.=
  A
- * hard reset means that qbus_reset_all will reset all state of the devi=
ce.
- * For PCI devices, for example, this will include the base address regi=
sters
- * or configuration space.
- *
- * Theses functions are deprecated, please use device/bus_reset or
- * resettable_reset_* instead
- * TODO: remove them when all occurence are removed
- */
-void qdev_reset_all(DeviceState *dev);
-void qdev_reset_all_fn(void *opaque);
-void qbus_reset_all(BusState *bus);
-void qbus_reset_all_fn(void *opaque);
-
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
=20
@@ -551,16 +532,6 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState=
 *bus, DeviceState *dev);
  */
 void qdev_machine_init(void);
=20
-/**
- * device_legacy_reset:
- *
- * Reset a single device (by calling the reset method).
- *
- * This function is deprecated, please use device_reset() instead.
- * TODO: remove the function when all occurences are removed.
- */
-void device_legacy_reset(DeviceState *dev);
-
 /**
  * device_class_set_parent_reset:
  * TODO: remove the function when DeviceClass's reset method
--=20
2.22.0


