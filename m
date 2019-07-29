Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D0AC41514
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87F32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="CroHY+Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87F32070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Gw-0005B2-2q
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77J-0004C2-VH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77H-0004fM-Dl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:13 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs777-0004TL-1w; Mon, 29 Jul 2019 10:59:01 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id D39C596F5E;
 Mon, 29 Jul 2019 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnkkIoHVwWj6c273Ch/WUhHvEUJl8xs34edh8vQqVyY=;
 b=CroHY+IlItvjMM4Iw8/7AYkxH5q8EiTBp1PKOIK+M0rdPIHctZYv9o1GokUeUF5uTySRNj
 fO8u47ZuIG+TSBno3xcVOgBS4os+0iLJ/5bfKNCLRprHTocNKBxKxID9LM2xqptAiIHor/
 V3gQvO/Jxh+CZ27PTXuYGxw613ku4OU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:28 +0200
Message-Id: <20190729145654.14644-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnkkIoHVwWj6c273Ch/WUhHvEUJl8xs34edh8vQqVyY=;
 b=NFJL4PD3UgBLR7FmwdToZdyfJh+nCcCVNXArVa4OtIbRuz0PoSUGZ+bl5HZSd1I7C5Stvy
 351xcD331HNpGgIFDA/gRnLDcGopGY2Bc3QmEoacdjQpD5TpifOfi01xTDzTIaZI3mRWMg
 zE701oZWUEyMYk/qp/oqfdW8u+TgCI0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412340; a=rsa-sha256; cv=none;
 b=XwPuZipvWSknFivXe90DlrcOw0OtcyvyzoGCBs9TYAJuwybn3igXaReNWrg991UMTMRDs4
 AiT3xcKfHAdH2kOJ8xNEQxxsXTQuxzX1h/t+ckopXNAAzKR0fkPOUfAk1iGO1/erfhMoJT
 7b7TOiaXU/Z/cN7GGLWb61OvUTXGgQ4=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for reset
 support in devices
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

This add the reset related sections for every QOM
device.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev-vmstate.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 12 +++++++++++-
 include/hw/qdev-core.h |  3 +++
 stubs/Makefile.objs    |  1 +
 stubs/device.c         |  7 +++++++
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 stubs/device.c

diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
index 07b010811f..24f8465c61 100644
--- a/hw/core/qdev-vmstate.c
+++ b/hw/core/qdev-vmstate.c
@@ -43,3 +43,44 @@ const struct VMStateDescription device_vmstate_reset =3D=
 {
         VMSTATE_END_OF_LIST()
     },
 };
+
+static VMStateDescription *vmsd_duplicate_and_append(
+        const VMStateDescription *old_vmsd,
+        const VMStateDescription *new_subsection)
+{
+    VMStateDescription *vmsd;
+    int n =3D 0;
+
+    assert(old_vmsd && new_subsection);
+
+    vmsd =3D (VMStateDescription *) g_memdup(old_vmsd, sizeof(*vmsd));
+
+    if (old_vmsd->subsections) {
+        while (old_vmsd->subsections[n]) {
+            n +=3D 1;
+        }
+    }
+    vmsd->subsections =3D g_new(const VMStateDescription *, n + 2);
+
+    if (old_vmsd->subsections) {
+        memcpy(vmsd->subsections, old_vmsd->subsections,
+               sizeof(VMStateDescription *) * n);
+    }
+    vmsd->subsections[n] =3D new_subsection;
+    vmsd->subsections[n + 1] =3D NULL;
+
+    return vmsd;
+}
+
+void device_class_build_extended_vmsd(DeviceClass *dc)
+{
+    assert(dc->vmsd);
+    assert(!dc->vmsd_ext);
+
+    /* forge a subsection with proper name */
+    VMStateDescription *reset;
+    reset =3D g_memdup(&device_vmstate_reset, sizeof(*reset));
+    reset->name =3D g_strdup_printf("%s/device_reset", dc->vmsd->name);
+
+    dc->vmsd_ext =3D vmsd_duplicate_and_append(dc->vmsd, reset);
+}
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e9e5f2d5f9..88387d3743 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -45,7 +45,17 @@ bool qdev_hot_removed =3D false;
 const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
 {
     DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
-    return dc->vmsd;
+
+    if (!dc->vmsd) {
+        return NULL;
+    }
+
+    if (!dc->vmsd_ext) {
+        /* build it first time we need it */
+        device_class_build_extended_vmsd(dc);
+    }
+
+    return dc->vmsd_ext;
 }
=20
 static void bus_remove_child(BusState *bus, DeviceState *child)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1670ae41bb..926d4bbcb1 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -120,6 +120,7 @@ typedef struct DeviceClass {
=20
     /* device state */
     const struct VMStateDescription *vmsd;
+    const struct VMStateDescription *vmsd_ext;
=20
     /* Private to qdev / bus.  */
     const char *bus_type;
@@ -520,6 +521,8 @@ void device_class_set_parent_unrealize(DeviceClass *d=
c,
=20
 const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
=20
+void device_class_build_extended_vmsd(DeviceClass *dc);
+
 const char *qdev_fw_name(DeviceState *dev);
=20
 Object *qdev_get_machine(void);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9c7393b08c..432b56f290 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,4 +40,5 @@ stub-obj-y +=3D pci-host-piix.o
 stub-obj-y +=3D ram-block.o
 stub-obj-y +=3D ramfb.o
 stub-obj-y +=3D fw_cfg.o
+stub-obj-y +=3D device.o
 stub-obj-$(CONFIG_SOFTMMU) +=3D semihost.o
diff --git a/stubs/device.c b/stubs/device.c
new file mode 100644
index 0000000000..e9b4f57e5f
--- /dev/null
+++ b/stubs/device.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+
+void device_class_build_extended_vmsd(DeviceClass *dc)
+{
+    return;
+}
--=20
2.22.0


