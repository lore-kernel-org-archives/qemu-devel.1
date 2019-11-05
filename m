Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FC9C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647B920656
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="exJqlPnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647B920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3Um-0002u4-FP
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iS3Ta-0001wX-Ft
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iS3TZ-0002r6-4e
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:22:46 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:44414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1iS3TR-0002V4-U2; Tue, 05 Nov 2019 13:22:38 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 21A802E14BC;
 Tue,  5 Nov 2019 21:22:32 +0300 (MSK)
Received: from sas2-2e05890d47f7.qloud-c.yandex.net
 (sas2-2e05890d47f7.qloud-c.yandex.net [2a02:6b8:c08:bd8e:0:640:2e05:890d])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 s5R0HVQzAF-MVR0TFdv; Tue, 05 Nov 2019 21:22:32 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1572978152; bh=rvAUbOVvHfz1igc0Fbs2ZHTfcuBR5wq6iJsI3ZLtmnE=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=exJqlPnjxMFLC/zhkzsEoaNITH3srbx3OvQ41EVwEhJjXACS2k6ELvQ4JtDq6BsKI
 4/QJAXNYBMFZ1lFGBvlqU4bq4P1J9wmN9gvVNfk799x3h1O6dLDWFxkYdRI3PP4ezN
 ejifGgJVBpu4IGd+FrnpJBRm5MtfItzU+pRXVC94=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by sas2-2e05890d47f7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 khPmPooGtK-MVSuq6uj; Tue, 05 Nov 2019 21:22:31 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
To: stefanha@redhat.com,
	mst@redhat.com
Subject: [PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE is
 advertised
Date: Tue,  5 Nov 2019 21:22:17 +0300
Message-Id: <1572978137-189218-1-git-send-email-wrfsh@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
default for all machine types <= 4.2 (but don't introduce 4.3
machine type itself yet).

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
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
index d4bedc2..bf4b1cb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2149,6 +2149,7 @@ type_init(machvirt_machine_init);
 
 static void virt_machine_4_2_options(MachineClass *mc)
 {
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4c357d2..d62e637 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -991,7 +991,9 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
     }
 
-    if (blk_enable_write_cache(s->blk)) {
+    if (blk_enable_write_cache(s->blk) ||
+        (s->conf.x_enable_wce_if_config_wce &&
+         virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {
         virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
     }
     if (blk_is_read_only(s->blk)) {
@@ -1270,6 +1272,8 @@ static Property virtio_blk_properties[] = {
                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
+    DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
+                     conf.x_enable_wce_if_config_wce, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3..023548b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,11 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
+GlobalProperty hw_compat_4_2[] = {
+    { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
+};
+const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
+
 GlobalProperty hw_compat_4_1[] = {
     { "virtio-pci", "x-pcie-flr-init", "off" },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c15929a..5e9a8de 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -423,6 +423,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass *m)
     m->alias = "pc";
     m->is_default = 1;
     pcmc->default_cpu_version = 1;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d51f524..6008d5a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -354,6 +354,7 @@ static void pc_q35_4_2_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias = "q35";
     pcmc->default_cpu_version = 1;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 94f9d27..c06a0cf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4491,7 +4491,7 @@ static const TypeInfo spapr_machine_info = {
  */
 static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d3edeef..cb5fe4c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -645,6 +645,7 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
 
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_CCW_MACHINE(4_2, "4.2", true);
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087..24cbeec 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -329,6 +329,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_4_2[];
+extern const size_t hw_compat_4_2_len;
+
 extern GlobalProperty hw_compat_4_1[];
 extern const size_t hw_compat_4_1_len;
 
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index cddcfbe..9c19f5b 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -40,6 +40,7 @@ struct VirtIOBlkConf
     uint16_t queue_size;
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
+    bool x_enable_wce_if_config_wce;
 };
 
 struct VirtIOBlockDataPlane;
-- 
2.7.4


