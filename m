Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC687C4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F0C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBXwwGS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F0C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEh1y-0001eW-Lh
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEgz8-00077m-A2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEgz6-0002yt-MM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEgz6-0002uP-IG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584569779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeEHK9Sx8t6AXiTFLTWFvKSptha4OqjzTNismwhWFps=;
 b=gBXwwGS/hv+mKVdXUNaDvxjbKYZn5Pil+YB92VemduvKI5Og5oDULWI5J3OLzBvKFtQJ6i
 49sEU2eu87dNkyQbmheQmoWVWvXdnNeCH06qp+/GwTDYAMTZ4nbTAz//fOv+sFnkPt67Kh
 eDuhymkO60eaDIrWsnJbXG7EaGco2b0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-26Ywi6ZfMn-gJN6QHS3-0g-1; Wed, 18 Mar 2020 18:16:16 -0400
X-MC-Unique: 26Ywi6ZfMn-gJN6QHS3-0g-1
Received: by mail-wm1-f72.google.com with SMTP id s15so184423wmc.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b9/KhMfASXD2M2Z1I1eCb0K3Fgg3R8b7JyXoYWPGOtM=;
 b=rsMxwnSzugGpBZnNdusDShH2lLCeH2vQgxq/uXzf5rFLI0EK/sMnyp86/gUGj27nzy
 O3JCIfnhDYC46c0Q3SmxZ0V0rzHkICYrGAHMfW3xyt2x9rl5cXGq+xrzxSs0W15vieF1
 hhrOAg6htjPniD6g+wzo0W473znBp2zJzhpjUb1BIqlm6heL7BUCtmLDteX1HtSenI14
 bI6ifBXO6P8Hb6ryUHgT5ZixfX+q5KqPKDdV1Uqu9GUI9wGfKGEdVST6QkomyEqV98uP
 +Pcyp2QXPWA1cKGw7YrHmtU4CxQFrCTLeHjN6jTw6/F/+hvrGPgqyCAES/pxyS/LLSz2
 5ZYw==
X-Gm-Message-State: ANhLgQ07vh0jYjca+6ZR+3S1Zb/KongAcGJkYzNtx4z4LVpqOqDFmIKS
 fGNS4WwqKLXLNf2FBvWiBz+dDTxXfNPQaEOCLjf0HZlOeCD7NJxpM8MjOBRw76T+aohYIRYxVTN
 03dfIog8saJu6Rm8=
X-Received: by 2002:a05:6000:1212:: with SMTP id
 e18mr44377wrx.371.1584569774742; 
 Wed, 18 Mar 2020 15:16:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvoDD27h1xw0tuHgyTskPemjYFjJgdVL/Nzzn86xiv5YeD2dNfsX1lz9f6WuoF3CDX6pLERuw==
X-Received: by 2002:a05:6000:1212:: with SMTP id
 e18mr44348wrx.371.1584569774403; 
 Wed, 18 Mar 2020 15:16:14 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e5sm280607wru.92.2020.03.18.15.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:16:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 2/2] hw/acpi/piix4: Restrict system-hotplug-support to
 x86 i440fx PC machine
Date: Wed, 18 Mar 2020 23:15:31 +0100
Message-Id: <20200318221531.22910-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318221531.22910-1-philmd@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PC (i440fx) machine is the only one using the PIIX4 PM
specific system-hotplug-support feature.

Enable this feature in pc_init1(), and let the callers of
piix4_create() get a simple PIIX4 device.
This is the case of the MIPS Malta board.

Doing so we fix a bug on the Malta where a guest writing to
I/O port 0xaf00 crashes QEMU:

  qemu-system-mips: hw/acpi/cpu.c:197: cpu_hotplug_hw_init: Assertion `mc->=
possible_cpu_arch_ids' failed.
  Aborted (core dumped)
  (gdb) bt
  #0 0x00007f6fd748957f in raise () at /lib64/libc.so.6
  #1 0x00007f6fd7473895 in abort () at /lib64/libc.so.6
  #2 0x00007f6fd7473769 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
  #3 0x00007f6fd7481a26 in .annobin_assert.c_end () at /lib64/libc.so.6
  #4 0x00005646d58ca7bd in cpu_hotplug_hw_init (as=3D0x5646d6ae3300, owner=
=3D0x5646d6fd5b10, state=3D0x5646d6fd7a30, base_addr=3D44800) at hw/acpi/cp=
u.c:197
  #5 0x00005646d58c5284 in acpi_switch_to_modern_cphp (gpe_cpu=3D0x5646d6fd=
7910, cpuhp_state=3D0x5646d6fd7a30, io_port=3D44800) at hw/acpi/cpu_hotplug=
.c:107
  #6 0x00005646d58c3431 in piix4_set_cpu_hotplug_legacy (obj=3D0x5646d6fd5b=
10, value=3Dfalse, errp=3D0x5646d61cdb28 <error_abort>) at hw/acpi/piix4.c:=
617
  #7 0x00005646d5b00c70 in property_set_bool (obj=3D0x5646d6fd5b10, v=3D0x5=
646d7697d30, name=3D0x5646d5cf3a90 "cpu-hotplug-legacy", opaque=3D0x5646d70=
7d110, errp=3D0x5646d61cdb28 <error_abort>) at qom/object.c:2076
  #8 0x00005646d5afeee6 in object_property_set (obj=3D0x5646d6fd5b10, v=3D0=
x5646d7697d30, name=3D0x5646d5cf3a90 "cpu-hotplug-legacy", errp=3D0x5646d61=
cdb28 <error_abort>) at qom/object.c:1268
  #9 0x00005646d5b01fb8 in object_property_set_qobject (obj=3D0x5646d6fd5b1=
0, value=3D0x5646d75b5450, name=3D0x5646d5cf3a90 "cpu-hotplug-legacy", errp=
=3D0x5646d61cdb28 <error_abort>) at qom/qom-qobject.c:26
  #10 0x00005646d5aff1cb in object_property_set_bool (obj=3D0x5646d6fd5b10,=
 value=3Dfalse, name=3D0x5646d5cf3a90 "cpu-hotplug-legacy", errp=3D0x5646d6=
1cdb28 <error_abort>) at qom/object.c:1334
  #11 0x00005646d58c4fce in cpu_status_write (opaque=3D0x5646d6fd7910, addr=
=3D0, data=3D0, size=3D1) at hw/acpi/cpu_hotplug.c:44
  #12 0x00005646d569c707 in memory_region_write_accessor (mr=3D0x5646d6fd79=
20, addr=3D0, value=3D0x7ffc18053068, size=3D1, shift=3D0, mask=3D255, attr=
s=3D...) at memory.c:503
  #13 0x00005646d569c917 in access_with_adjusted_size (addr=3D0, value=3D0x=
7ffc18053068, size=3D1, access_size_min=3D1, access_size_max=3D4, access_fn=
=3D0x5646d569c61e <memory_region_write_accessor>, mr=3D0x5646d6fd7920, attr=
s=3D...) at memory.c:569
  #14 0x00005646d569f8f3 in memory_region_dispatch_write (mr=3D0x5646d6fd79=
20, addr=3D0, data=3D0, size=3D1, attrs=3D...) at memory.c:1497
  #15 0x00005646d563e5c5 in flatview_write_continue (fv=3D0x5646d751b000, a=
ddr=3D44800, attrs=3D..., buf=3D0x7ffc180531d4 "", len=3D4, addr1=3D0, l=3D=
1, mr=3D0x5646d6fd7920) at exec.c:3324
  #16 0x00005646d563e70a in flatview_write (fv=3D0x5646d751b000, addr=3D448=
00, attrs=3D..., buf=3D0x7ffc180531d4 "", len=3D4) at exec.c:3363
  #17 0x00005646d563ea0f in address_space_write (as=3D0x5646d618abc0 <addre=
ss_space_io>, addr=3D44800, attrs=3D..., buf=3D0x7ffc180531d4 "", len=3D4) =
at exec.c:3453
  #18 0x00005646d5696ee5 in cpu_outl (addr=3D44800, val=3D0) at ioport.c:80

Buglink: https://bugs.launchpad.net/qemu/+bug/1835865
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/southbridge/piix.h | 3 ++-
 hw/acpi/piix4.c               | 4 +++-
 hw/i386/pc_piix.c             | 1 +
 hw/isa/piix4.c                | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 152628c6d9..3a54409cab 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -18,7 +18,8 @@
=20
 I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
-                      int smm_enabled, DeviceState **piix4_pm);
+                      int smm_enabled, bool system_hotplug_enabled,
+                      DeviceState **piix4_pm);
=20
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9c970336ac..ec4869452b 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -515,7 +515,8 @@ static void piix4_pm_realize(PCIDevice *dev, Error **er=
rp)
=20
 I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
-                      int smm_enabled, DeviceState **piix4_pm)
+                      int smm_enabled, bool system_hotplug_enabled,
+                      DeviceState **piix4_pm)
 {
     DeviceState *dev;
     PIIX4PMState *s;
@@ -533,6 +534,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t =
smb_io_base,
     if (xen_enabled()) {
         s->use_acpi_pci_hotplug =3D false;
     }
+    s->use_acpi_system_hotplug =3D system_hotplug_enabled;
=20
     qdev_init_nofail(dev);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e2d98243bc..8441f44a14 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -283,6 +283,7 @@ else {
         pcms->smbus =3D piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
                                     x86ms->gsi[9], smi_irq,
                                     x86_machine_is_smm_enabled(x86ms),
+                                    true,
                                     &piix4_pm);
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
=20
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 7edec5e149..6d6802d15d 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -262,7 +262,7 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa=
_bus,
     pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
     if (smbus) {
         *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
-                               isa_get_irq(NULL, 9), NULL, 0, NULL);
+                               isa_get_irq(NULL, 9), NULL, 0, false, NULL)=
;
    }
=20
     return dev;
--=20
2.21.1


