Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB72ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB6820650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB6820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPwY-0003vq-SD
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPiX-0003F7-Ho
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPiW-0005st-Jh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:30:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPiW-0005rm-Ds
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:30:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AF671DA2;
 Tue, 15 Oct 2019 16:30:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B8CE19C58;
 Tue, 15 Oct 2019 16:30:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/32] hw/mips/mips_malta: Create IDE hard drive array
 dynamically
Date: Tue, 15 Oct 2019 18:26:50 +0200
Message-Id: <20191015162705.28087-18-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 15 Oct 2019 16:30:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we'll refactor the PIIX4 code out of
mips_malta_init(). As a preliminary step, add the 'ide_drives'
variable and create the drive array dynamically.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 528c34a1c3..774bb810f6 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1235,7 +1235,8 @@ void mips_malta_init(MachineState *machine)
     int piix4_devfn;
     I2CBus *smbus;
     DriveInfo *dinfo;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    const size_t ide_drives =3D MAX_IDE_BUS * MAX_IDE_DEVS;
+    DriveInfo **hd;
     int fl_idx =3D 0;
     int be;
=20
@@ -1406,7 +1407,8 @@ void mips_malta_init(MachineState *machine)
     pci_bus =3D gt64120_register(s->i8259);
=20
     /* Southbridge */
-    ide_drive_get(hd, ARRAY_SIZE(hd));
+    hd =3D g_new(DriveInfo *, ide_drives);
+    ide_drive_get(hd, ide_drives);
=20
     pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
                                           true, TYPE_PIIX4_PCI_DEVICE);
@@ -1421,6 +1423,7 @@ void mips_malta_init(MachineState *machine)
     }
=20
     pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
+    g_free(hd);
     pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
     smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
--=20
2.21.0


