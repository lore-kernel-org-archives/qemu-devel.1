Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB7C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5DF20578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5DF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIkE-0002sf-2v
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIig-0001Iw-ET
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIic-000262-5z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIib-00025q-Ue
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0779A300163C;
 Thu, 15 Aug 2019 16:35:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA3160F8C;
 Thu, 15 Aug 2019 16:35:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:33 +0100
Message-Id: <20190815163504.18937-3-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 15 Aug 2019 16:35:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/33] hw/net: fix vmxnet3 live migration
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

At some point vmxnet3 live migration stopped working and git-bisect
didn't help finding a working version.
The issue is the PCI configuration space is not being migrated
successfully and MSIX remains masked at destination.

Remove the migration differentiation between PCI and PCIe since
the logic resides now inside VMSTATE_PCI_DEVICE.
Remove also the VMXNET3_COMPAT_FLAG_DISABLE_PCIE based differentiation
since at 'realize' time is decided if the device is PCI or PCIe,
then the above macro is enough.

Use the opportunity to move to the standard VMSTATE_MSIX
instead of the deprecated SaveVMHandlers.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
Tested-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/vmxnet3.c | 52 ++----------------------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 10d01d0058..8b17548b02 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2141,21 +2141,6 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
     msi_uninit(d);
 }
=20
-static void
-vmxnet3_msix_save(QEMUFile *f, void *opaque)
-{
-    PCIDevice *d =3D PCI_DEVICE(opaque);
-    msix_save(d, f);
-}
-
-static int
-vmxnet3_msix_load(QEMUFile *f, void *opaque, int version_id)
-{
-    PCIDevice *d =3D PCI_DEVICE(opaque);
-    msix_load(d, f);
-    return 0;
-}
-
 static const MemoryRegionOps b0_ops =3D {
     .read =3D vmxnet3_io_bar0_read,
     .write =3D vmxnet3_io_bar0_write,
@@ -2176,11 +2161,6 @@ static const MemoryRegionOps b1_ops =3D {
     },
 };
=20
-static SaveVMHandlers savevm_vmxnet3_msix =3D {
-    .save_state =3D vmxnet3_msix_save,
-    .load_state =3D vmxnet3_msix_load,
-};
-
 static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
 {
     uint64_t dsn_payload;
@@ -2203,7 +2183,6 @@ static uint64_t vmxnet3_device_serial_num(VMXNET3St=
ate *s)
=20
 static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(pci_dev);
     VMXNET3State *s =3D VMXNET3(pci_dev);
     int ret;
=20
@@ -2249,8 +2228,6 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
         pcie_dev_ser_num_init(pci_dev, VMXNET3_DSN_OFFSET,
                               vmxnet3_device_serial_num(s));
     }
-
-    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmxnet3_msi=
x, s);
 }
=20
 static void vmxnet3_instance_init(Object *obj)
@@ -2440,29 +2417,6 @@ static const VMStateDescription vmstate_vmxnet3_in=
t_state =3D {
     }
 };
=20
-static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
-{
-    VMXNET3State *s =3D VMXNET3(opaque);
-
-    return !(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE);
-}
-
-static bool vmxnet3_vmstate_test_pci_device(void *opaque, int version_id=
)
-{
-    return !vmxnet3_vmstate_need_pcie_device(opaque);
-}
-
-static const VMStateDescription vmstate_vmxnet3_pcie_device =3D {
-    .name =3D "vmxnet3/pcie",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .needed =3D vmxnet3_vmstate_need_pcie_device,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_vmxnet3 =3D {
     .name =3D "vmxnet3",
     .version_id =3D 1,
@@ -2470,9 +2424,8 @@ static const VMStateDescription vmstate_vmxnet3 =3D=
 {
     .pre_save =3D vmxnet3_pre_save,
     .post_load =3D vmxnet3_post_load,
     .fields =3D (VMStateField[]) {
-            VMSTATE_STRUCT_TEST(parent_obj, VMXNET3State,
-                                vmxnet3_vmstate_test_pci_device, 0,
-                                vmstate_pci_device, PCIDevice),
+            VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
+            VMSTATE_MSIX(parent_obj, VMXNET3State),
             VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
             VMSTATE_BOOL(rx_vlan_stripping, VMXNET3State),
             VMSTATE_BOOL(lro_supported, VMXNET3State),
@@ -2508,7 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 =3D=
 {
     },
     .subsections =3D (const VMStateDescription*[]) {
         &vmxstate_vmxnet3_mcast_list,
-        &vmstate_vmxnet3_pcie_device,
         NULL
     }
 };
--=20
2.21.0


