Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F09C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A532465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNpfPpJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A532465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifm3n-0007ci-A8
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifm0Y-0004PK-0N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifm0W-00087n-D8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25504
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifm0W-00086e-8Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576247607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OER0OXw3W5d6ZJtKEAz8bgG9o7LexLM47lHjVxV/+c=;
 b=TNpfPpJHKaHG377mEJDOupWqYgS7RElQbG6X+rI9m1x2LvgkIFewoOS80mT/jwlit/Y+Aj
 WKdHV70pV0DjmkKUqfIWQQxuKlM0+jim1GTIXidWY9byk+Pd53I5hfWFhLxTCwKnYkIAFY
 Kfub/VDAnbDrP7ErkNUDm20BeuKSEvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-dvT_RBOkNTe8ujn4aS2GsQ-1; Fri, 13 Dec 2019 09:33:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF431005510;
 Fri, 13 Dec 2019 14:33:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6219419C4F;
 Fri, 13 Dec 2019 14:33:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE is
 advertised
Date: Fri, 13 Dec 2019 14:33:13 +0000
Message-Id: <20191213143314.1198821-2-stefanha@redhat.com>
In-Reply-To: <20191213143314.1198821-1-stefanha@redhat.com>
References: <20191213143314.1198821-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dvT_RBOkNTe8ujn4aS2GsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Evgeny Yakovlev <wrfsh@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Evgeny Yakovlev <wrfsh@yandex-team.ru>

Virtio spec 1.1 (and earlier), 5.2.5.2 Driver Requirements: Device
Initialization:

"Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
they offer VIRTIO_BLK_F_CONFIG_WCE"

Currently F_CONFIG_WCE and F_WCE are not connected to each other.
Qemu will advertise F_CONFIG_WCE if config-wce argument is
set for virtio-blk device. And F_WCE is advertised only if
underlying block backend actually has it's caching enabled.

Fix this by advertising F_WCE if F_CONFIG_WCE is also advertised.

To preserve backwards compatibility with newer machine types make this
behaviour governed by "x-enable-wce-if-config-wce" virtio-blk-device
property and introduce hw_compat_4_2 with new property being off by
default for all machine types <=3D 4.2 (but don't introduce 4.3
machine type itself yet).

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-Id: <1572978137-189218-1-git-send-email-wrfsh@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/virt.c                  | 1 +
 hw/block/virtio-blk.c          | 6 +++++-
 hw/core/machine.c              | 5 +++++
 hw/i386/pc_piix.c              | 1 +
 hw/i386/pc_q35.c               | 1 +
 hw/ppc/spapr.c                 | 2 +-
 hw/s390x/s390-virtio-ccw.c     | 1 +
 include/hw/boards.h            | 3 +++
 include/hw/virtio/virtio-blk.h | 1 +
 9 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc2607..bf4b1cbfb8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2149,6 +2149,7 @@ type_init(machvirt_machine_init);
=20
 static void virt_machine_4_2_options(MachineClass *mc)
 {
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
=20
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4c357d2928..d62e6377c2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -991,7 +991,9 @@ static uint64_t virtio_blk_get_features(VirtIODevice *v=
dev, uint64_t features,
         virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
     }
=20
-    if (blk_enable_write_cache(s->blk)) {
+    if (blk_enable_write_cache(s->blk) ||
+        (s->conf.x_enable_wce_if_config_wce &&
+         virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {
         virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
     }
     if (blk_is_read_only(s->blk)) {
@@ -1270,6 +1272,8 @@ static Property virtio_blk_properties[] =3D {
                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS)=
,
     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SEC=
TORS),
+    DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
+                     conf.x_enable_wce_if_config_wce, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..023548b4f3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,11 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
=20
+GlobalProperty hw_compat_4_2[] =3D {
+    { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
+};
+const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
+
 GlobalProperty hw_compat_4_1[] =3D {
     { "virtio-pci", "x-pcie-flr-init", "off" },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1bd70d1abb..87aced0742 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -431,6 +431,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass =
*m)
     m->alias =3D "pc";
     m->is_default =3D 1;
     pcmc->default_cpu_version =3D 1;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 385e5cffb1..2608cd0062 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -354,6 +354,7 @@ static void pc_q35_4_2_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias =3D "q35";
     pcmc->default_cpu_version =3D 1;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e076f6023c..2ca92f2148 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4496,7 +4496,7 @@ static const TypeInfo spapr_machine_info =3D {
  */
 static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
 DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d3edeef0ad..cb5fe4c84d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -645,6 +645,7 @@ static void ccw_machine_4_2_instance_options(MachineSta=
te *machine)
=20
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", true);
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087f34..24cbeecbae 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -329,6 +329,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
+extern GlobalProperty hw_compat_4_2[];
+extern const size_t hw_compat_4_2_len;
+
 extern GlobalProperty hw_compat_4_1[];
 extern const size_t hw_compat_4_1_len;
=20
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.=
h
index cddcfbebe9..9c19f5b634 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -40,6 +40,7 @@ struct VirtIOBlkConf
     uint16_t queue_size;
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
+    bool x_enable_wce_if_config_wce;
 };
=20
 struct VirtIOBlockDataPlane;
--=20
2.23.0


