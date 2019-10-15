Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A98ECE596
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F21E20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F21E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPyU-00063Z-EZ
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPj1-0003s5-KE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPiz-0006Go-UN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPiz-0006Fa-MO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51DDC3090FC6;
 Tue, 15 Oct 2019 16:31:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B2C319C58;
 Tue, 15 Oct 2019 16:30:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/32] hw/i386/pc: Extract pc_gsi_create()
Date: Tue, 15 Oct 2019 18:26:53 +0200
Message-Id: <20191015162705.28087-21-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 15 Oct 2019 16:31:04 +0000 (UTC)
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

The GSI creation code is common to all PC machines, extract the
common code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 15 +++++++++++++++
 hw/i386/pc_piix.c    |  9 +--------
 hw/i386/pc_q35.c     |  9 +--------
 include/hw/i386/pc.h |  2 ++
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bcda50efcc..a7597c6c44 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -357,6 +357,21 @@ void gsi_handler(void *opaque, int n, int level)
     qemu_set_irq(s->ioapic_irq[n], level);
 }
=20
+GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
+{
+    GSIState *s;
+
+    s =3D g_new0(GSIState, 1);
+    if (kvm_ioapic_in_kernel()) {
+        kvm_pc_setup_irq_routing(pci_enabled);
+        *irqs =3D qemu_allocate_irqs(kvm_pc_gsi_handler, s, GSI_NUM_PINS=
);
+    } else {
+        *irqs =3D qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
+    }
+
+    return s;
+}
+
 static void ioport80_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 431965d921..452b107e1b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -188,14 +188,7 @@ static void pc_init1(MachineState *machine,
         xen_load_linux(pcms);
     }
=20
-    gsi_state =3D g_malloc0(sizeof(*gsi_state));
-    if (kvm_ioapic_in_kernel()) {
-        kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
-                                       GSI_NUM_PINS);
-    } else {
-        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM=
_PINS);
-    }
+    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
=20
     if (pcmc->pci_enabled) {
         pci_bus =3D i440fx_init(host_type,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8fad20f314..52261962b8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -210,14 +210,7 @@ static void pc_q35_init(MachineState *machine)
     }
=20
     /* irq lines */
-    gsi_state =3D g_malloc0(sizeof(*gsi_state));
-    if (kvm_ioapic_in_kernel()) {
-        kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
-                                       GSI_NUM_PINS);
-    } else {
-        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM=
_PINS);
-    }
+    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
=20
     /* create pci host bus */
     q35_host =3D Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE)=
);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b63fc7631e..d0c6b9d469 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -174,6 +174,8 @@ typedef struct GSIState {
=20
 void gsi_handler(void *opaque, int n, int level);
=20
+GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
+
 /* vmport.c */
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
--=20
2.21.0


