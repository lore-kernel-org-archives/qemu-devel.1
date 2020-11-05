Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0160EC55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4779F206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/h6UQ1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4779F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafbM-0001gc-3a
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUN-0001WT-8g
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUJ-0003Xj-QU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+ORTAV4QV7qK7W4rX+ydMFdvM78hX0Yyjib+4Eqz9U=;
 b=V/h6UQ1fI95S1eECPuHHPeGY3+JOeJ2kSaW28im+MMDN38572gava5B/0/YTWAdugXqbHR
 ABtbD/mTwxSfLWBwizk+o3fbBarXwI2EsT7gFlYYJsy/4szN28RhdNl0vuxKaaBQsHw1BS
 VEOF71Q6mqfuWwfxx0E0QWA6HeDeZr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-6rAN_pvYMJWBxnC75IGtLA-1; Thu, 05 Nov 2020 08:39:35 -0500
X-MC-Unique: 6rAN_pvYMJWBxnC75IGtLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F92C1084C80;
 Thu,  5 Nov 2020 13:39:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E87E55798;
 Thu,  5 Nov 2020 13:39:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AA7429D17; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/12] microvm: make number of virtio transports runtime
 configurable
Date: Thu,  5 Nov 2020 14:39:15 +0100
Message-Id: <20201105133923.23821-5-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h | 2 +-
 hw/i386/microvm.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 0fc216007777..c5d60bacb5e8 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -52,7 +52,6 @@
 
 /* Platform virtio definitions */
 #define VIRTIO_MMIO_BASE      0xfeb00000
-#define VIRTIO_NUM_TRANSPORTS 8
 #define VIRTIO_CMDLINE_MAXLEN 64
 
 #define GED_MMIO_BASE         0xfea00000
@@ -98,6 +97,7 @@ struct MicrovmMachineState {
 
     /* Machine state */
     uint32_t virtio_irq_base;
+    uint32_t virtio_num_transports;
     bool kernel_cmdline_fixed;
     Notifier machine_done;
     Notifier powerdown_req;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 5428448b7059..e92f236bf442 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -178,8 +178,13 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
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


