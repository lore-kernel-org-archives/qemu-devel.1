Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582EBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF2621925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF2621925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSwi-0003Vb-9f
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSn6-0008Ga-UB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSn3-0001oq-1i
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSn1-0001ns-3A
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA56F30738A7;
 Fri, 18 Oct 2019 13:59:32 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D77156046B;
 Fri, 18 Oct 2019 13:59:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/i386/pc: Extract pc_gsi_create()
Date: Fri, 18 Oct 2019 15:59:06 +0200
Message-Id: <20191018135910.24286-2-philmd@redhat.com>
In-Reply-To: <20191018135910.24286-1-philmd@redhat.com>
References: <20191018135910.24286-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 18 Oct 2019 13:59:32 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GSI creation code is common to all PC machines, extract the
common code.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 15 +++++++++++++++
 hw/i386/pc_piix.c    |  9 +--------
 hw/i386/pc_q35.c     |  9 +--------
 include/hw/i386/pc.h |  2 ++
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b1904237e..e3e191a811 100644
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
index f6e7196a82..47bdc64f64 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -189,14 +189,7 @@ static void pc_init1(MachineState *machine,
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
         PIIX3State *piix3;
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
index 833bc6737f..53b2243788 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -178,6 +178,8 @@ typedef struct GSIState {
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


