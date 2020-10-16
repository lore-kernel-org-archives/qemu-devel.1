Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89267C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15B92084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieHy047F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15B92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOIn-0007Fd-QJ
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO9P-0002t2-5Y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO9M-0002HE-9t
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5IdILfRHW+G6d2qZXMG79TwBJDnNn1wITzb0S2tdm0=;
 b=ieHy047F9/cFrEfSVL6I0CRvA5JNrD5jtYRt8dEumAcDOkQv/iAACFURt7wOX0jYOlZtoh
 C8MSiUZ25014HBakRqP9ruPrsEuWPVweG9frU24SMjITOLMdddfZLORntehH/dx89X66zg
 fbg49WUJxdjQ0MmXi+Ndsua/NZIDiY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-S-eOMZ8SMna8-cfuOcXGWQ-1; Fri, 16 Oct 2020 07:43:50 -0400
X-MC-Unique: S-eOMZ8SMna8-cfuOcXGWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4F7380365F;
 Fri, 16 Oct 2020 11:43:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E52175138;
 Fri, 16 Oct 2020 11:43:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 747D39D5A; Fri, 16 Oct 2020 13:43:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] microvm: reconfigure irqs if second ioapic is available
Date: Fri, 16 Oct 2020 13:43:28 +0200
Message-Id: <20201016114328.18835-5-kraxel@redhat.com>
In-Reply-To: <20201016114328.18835-1-kraxel@redhat.com>
References: <20201016114328.18835-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use GSI 16+ for PCIe (needs acpi_build_madt() tweak).
Use GSI 24+ (second ioapic) for virtio-mmio.
Use all irq lines of the second ioapic
and allow up to 24 virtio-mmio devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-common.c | 2 +-
 hw/i386/microvm.c     | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index f0689392a39f..1653a8315248 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -122,7 +122,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
         intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
     }
 
-    for (i = 1; i < 16; i++) {
+    for (i = 1; i < 24; i++) {
         if (!(x86ms->pci_irq_mask & (1 << i))) {
             /* No need for a INT source override structure. */
             continue;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 15c3e078a4aa..70bb8a4e3954 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -205,7 +205,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     mms->virtio_irq_base = 5;
     mms->virtio_num_transports = 8;
-    if (x86_machine_is_acpi_enabled(x86ms)) {
+    if (ioapic2) {
+        mms->pcie_irq_base = 16;
+        mms->virtio_irq_base = 24;
+        mms->virtio_num_transports = 24;
+    } else if (x86_machine_is_acpi_enabled(x86ms)) {
         mms->pcie_irq_base = 12;
         mms->virtio_irq_base = 16;
     }
-- 
2.27.0


