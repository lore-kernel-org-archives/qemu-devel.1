Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2322BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE971206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrHhCADp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE971206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izbqE-0002KB-4X
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 02:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izbpb-0001vk-3x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izbpY-00031A-JR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:44:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izbpY-0002zc-4t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580975047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jATk4CDyPn7djVf244RTw4ZLaXbczaoluP/aBdgOtw4=;
 b=KrHhCADpiGB3oki0EWxapHXjTL3uFP+BYWigKBRite+X1Q6DDWWLnt19drQ/qwk3DHBVmD
 XOZu7kqAvX3NWyo1mjcgOdvcbuxNXujTB6K844dC3qA6D+uqf9UgGbuFVJWeD9+ReTkL0O
 1KwtNZL0UUOFwP2uh/YKpJSqQM1Kg0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-4v1ntOVTOsS0lGW6SjLH4A-1; Thu, 06 Feb 2020 02:44:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69DCADB60;
 Thu,  6 Feb 2020 07:44:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87CAD1001B07;
 Thu,  6 Feb 2020 07:43:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C6F0B9D7F; Thu,  6 Feb 2020 08:43:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qxl: introduce hardware revision 5
Date: Thu,  6 Feb 2020 08:43:58 +0100
Message-Id: <20200206074358.4274-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4v1ntOVTOsS0lGW6SjLH4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only difference to hardware revision 4 is that the device doesn't
switch to VGA mode in case someone happens to touch a VGA register,
which should make things more robust in configurations with multiple
vga devices.

Swtiching back to VGA mode happens on reset, either full machine
reset or qxl device reset (QXL_IO_RESET ioport command).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h  | 2 +-
 hw/core/machine.c | 2 ++
 hw/display/qxl.c  | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 80eb0d267269..707631a1f573 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -144,7 +144,7 @@ typedef struct PCIQXLDevice {
         }                                                               \
     } while (0)
=20
-#define QXL_DEFAULT_REVISION QXL_REVISION_STABLE_V12
+#define QXL_DEFAULT_REVISION (QXL_REVISION_STABLE_V12 + 1)
=20
 /* qxl.c */
 void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb7f..13a3b2c9c425 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,8 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
+    { "qxl", "revision", "4" },
+    { "qxl-vga", "revision", "4" },
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c33b1915a52c..64884da70857 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1309,7 +1309,8 @@ static void qxl_vga_ioport_write(void *opaque, uint32=
_t addr, uint32_t val)
     PCIQXLDevice *qxl =3D container_of(vga, PCIQXLDevice, vga);
=20
     trace_qxl_io_write_vga(qxl->id, qxl_mode_to_string(qxl->mode), addr, v=
al);
-    if (qxl->mode !=3D QXL_MODE_VGA) {
+    if (qxl->mode !=3D QXL_MODE_VGA &&
+        qxl->revision <=3D QXL_REVISION_STABLE_V12) {
         qxl_destroy_primary(qxl, QXL_SYNC);
         qxl_soft_reset(qxl);
     }
@@ -2121,6 +2122,10 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Er=
ror **errp)
         pci_device_rev =3D QXL_REVISION_STABLE_V12;
         io_size =3D pow2ceil(QXL_IO_RANGE_SIZE);
         break;
+    case 5: /* qxl-5 */
+        pci_device_rev =3D QXL_REVISION_STABLE_V12 + 1;
+        io_size =3D pow2ceil(QXL_IO_RANGE_SIZE);
+        break;
     default:
         error_setg(errp, "Invalid revision %d for qxl device (max %d)",
                    qxl->revision, QXL_DEFAULT_REVISION);
--=20
2.18.1


