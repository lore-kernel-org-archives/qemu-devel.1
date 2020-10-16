Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE7FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944D32084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfyR+Sqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944D32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTODq-0000HV-7A
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO9A-0002Lw-3w
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO98-0002Ez-9L
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7n9AqGVaGzPTAWJH2VRtnK1oRJEqNaPfQpn1YdvIyTs=;
 b=HfyR+SqnRWZbaA0R3SVDDcz57mEnnkTmygjaVoJS3NWOpMvhbYkYeQiPL9deUSZo3Mjmm2
 4r//e7Mis01oB1PUm1T5gsaYwFa5+ZtYcDX3AV1UQT1Ln0INrC3BsNh2uHjDE2tq+kAkpZ
 lG6JjSE87ougkbdah8gJvqTl+OK5ihA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-hrRVvtaqP4ycfSJa6s9ZbQ-1; Fri, 16 Oct 2020 07:43:39 -0400
X-MC-Unique: hrRVvtaqP4ycfSJa6s9ZbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A97C86ABD9;
 Fri, 16 Oct 2020 11:43:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31D0010013DB;
 Fri, 16 Oct 2020 11:43:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 50A521750A; Fri, 16 Oct 2020 13:43:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] microvm: make number of virtio transports runtime
 configurable
Date: Fri, 16 Oct 2020 13:43:25 +0200
Message-Id: <20201016114328.18835-2-kraxel@redhat.com>
In-Reply-To: <20201016114328.18835-1-kraxel@redhat.com>
References: <20201016114328.18835-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h | 2 +-
 hw/i386/microvm.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 91b064575d55..0154ad5bd707 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -52,7 +52,6 @@
 
 /* Platform virtio definitions */
 #define VIRTIO_MMIO_BASE      0xfeb00000
-#define VIRTIO_NUM_TRANSPORTS 8
 #define VIRTIO_CMDLINE_MAXLEN 64
 
 #define GED_MMIO_BASE         0xfea00000
@@ -95,6 +94,7 @@ struct MicrovmMachineState {
 
     /* Machine state */
     uint32_t virtio_irq_base;
+    uint32_t virtio_num_transports;
     bool kernel_cmdline_fixed;
     Notifier machine_done;
     Notifier powerdown_req;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 9dd74458aca4..eaf5da31f7e1 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -177,8 +177,13 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     kvmclock_create(true);
 
-    mms->virtio_irq_base = x86_machine_is_acpi_enabled(x86ms) ? 16 : 5;
-    for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
+    mms->virtio_irq_base = 5;
+    mms->virtio_num_transports = 8;
+    if (x86_machine_is_acpi_enabled(x86ms)) {
+        mms->virtio_irq_base = 16;
+    }
+
+    for (i = 0; i < mms->virtio_num_transports; i++) {
         sysbus_create_simple("virtio-mmio",
                              VIRTIO_MMIO_BASE + i * 512,
                              x86ms->gsi[mms->virtio_irq_base + i]);
-- 
2.27.0


