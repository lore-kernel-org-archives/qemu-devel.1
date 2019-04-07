Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B5EC10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 09:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898A320B1F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 09:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898A320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD42E-00010e-QU
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 05:24:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hD41Q-0000hI-2V
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hD41O-000425-3Q
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:23:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hD41M-00041N-AM
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 05:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20C6959441;
	Sun,  7 Apr 2019 09:23:23 +0000 (UTC)
Received: from thuth.com (ovpn-116-79.ams2.redhat.com [10.36.116.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 194E257BF;
	Sun,  7 Apr 2019 09:23:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>
Date: Sun,  7 Apr 2019 11:23:14 +0200
Message-Id: <20190407092314.11066-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Sun, 07 Apr 2019 09:23:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190407092314.4DR6o6frxrtLE0iuqPG9Ri_WTADAEkPyBGZyNDrJmzw@z>

QEMU currently crashes when you try to hot-plug an "nvdimm" device
on older machine types:

$ qemu-system-x86_64 -monitor stdio -M pc-1.1
QEMU 3.1.92 monitor - type 'help' for more information
(qemu) device_add nvdimm,id=3Dnvdimmn1
qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
 Assertion `*errp =3D=3D ((void *)0)' failed.
Aborted (core dumped)

The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
added recently before the check whether nvdimm is enabled. It should
be done after the check. And while we're at it, also check the errp
after the hotplug_handler_pre_plug(), otherwise errors are silently
ignored here.

Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6077d27361..f2c15bf1f2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
     const MachineState *ms =3D MACHINE(hotplug_dev);
     const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
     const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
+    Error *local_err =3D NULL;
=20
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
         return;
     }
=20
-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
-
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
         return;
     }
=20
+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, =
errp);
 }
--=20
2.21.0


