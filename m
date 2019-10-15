Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E05CECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0266C2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0266C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQ2t-0003JX-PW
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPjX-0004E5-HQ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPjW-0006hj-Fv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPjW-0006gw-9M
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6136810C093C;
 Tue, 15 Oct 2019 16:31:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7337A19C58;
 Tue, 15 Oct 2019 16:31:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/32] hw/i386/pc: Move gsi_state creation code
Date: Tue, 15 Oct 2019 18:26:55 +0200
Message-Id: <20191015162705.28087-23-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 15 Oct 2019 16:31:37 +0000 (UTC)
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

The block code related to IRQ start few lines later. Move
the comment and the pc_gsi_create() call where we start
to use the IRQs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc_q35.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 52261962b8..6d096eff28 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -209,9 +209,6 @@ static void pc_q35_init(MachineState *machine)
                        rom_memory, &ram_memory);
     }
=20
-    /* irq lines */
-    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
-
     /* create pci host bus */
     q35_host =3D Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE)=
);
=20
@@ -245,6 +242,9 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_link(OBJECT(machine), OBJECT(lpc),
                              PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
=20
+    /* irq lines */
+    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
+
     ich9_lpc =3D ICH9_LPC_DEVICE(lpc);
     lpc_dev =3D DEVICE(lpc);
     for (i =3D 0; i < GSI_NUM_PINS; i++) {
--=20
2.21.0


