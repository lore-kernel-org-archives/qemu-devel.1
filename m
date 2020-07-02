Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A864C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695D620672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIu1gObP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695D620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzF0-0006n0-Hq
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqzDk-0004oG-8W
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:25:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49556
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqzDg-00077F-RU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=x6QjRF25ShyfYsaZEX5gvuOQ/yh4G2XrTloQFcGPnCs=;
 b=OIu1gObPJLw1DdPA0kTkjt1TnBpfplhcfJAH81XBVUPRqZGrfssgP5kwxNZSi7W/lJRiIh
 Dm8igo+785atepH2J9kPRy7doF1NGzltSVPiIHOp9hmwu/mMw5gQ4bQqfyVeUMOcUjz/8X
 FoSo6UGX3xJw1pDGdBS7zId0AkvyKSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-GTJjzZv4OvqPvgCLL7V6_Q-1; Thu, 02 Jul 2020 09:25:38 -0400
X-MC-Unique: GTJjzZv4OvqPvgCLL7V6_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D00EC1054F8B;
 Thu,  2 Jul 2020 13:25:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A58E73FC7;
 Thu,  2 Jul 2020 13:25:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9CA8231EE6; Thu,  2 Jul 2020 15:25:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/20] pc_basic_device_init: drop no_vmport arg
Date: Thu,  2 Jul 2020 15:25:18 +0200
Message-Id: <20200702132525.6849-14-kraxel@redhat.com>
In-Reply-To: <20200702132525.6849-1-kraxel@redhat.com>
References: <20200702132525.6849-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we pass pcms anyway, we don't need the no_vmport arg any more.
No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 3 +--
 hw/i386/pc_piix.c    | 1 -
 hw/i386/pc_q35.c     | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bd447e380b5e..d7690bf4290f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -164,7 +164,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
                           bool create_fdctrl,
-                          bool no_vmport,
                           uint32_t hpet_irqs);
 void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd);
 void pc_cmos_init(PCMachineState *pcms,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9f5153b6f24d..407c782b5d42 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1159,7 +1159,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
                           bool create_fdctrl,
-                          bool no_vmport,
                           uint32_t hpet_irqs)
 {
     int i;
@@ -1226,7 +1225,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     i8257_dma_init(isa_bus, 0);
 
     /* Super I/O */
-    pc_superio_init(isa_bus, create_fdctrl, no_vmport);
+    pc_superio_init(isa_bus, create_fdctrl, pcms->vmport != ON_OFF_AUTO_ON);
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6c1612d0ca45..1ef3f39c55a5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -236,7 +236,6 @@ static void pc_init1(MachineState *machine,
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, true,
-                         (pcms->vmport != ON_OFF_AUTO_ON),
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6faf4458549a..5f8f21b84093 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -276,7 +276,6 @@ static void pc_q35_init(MachineState *machine)
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy,
-                         (pcms->vmport != ON_OFF_AUTO_ON),
                          0xff0104);
 
     /* connect pm stuff to lpc */
-- 
2.18.4


