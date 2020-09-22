Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB4CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599C820773
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdgZOUof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599C820773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKp2H-0002Z7-49
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 16:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKp1V-00028p-0P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKp1R-0001sx-1P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600806979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/uq1ydAD3WSjGkI4P2e9ZsRKctZ5UuVc07zSVeRW7bI=;
 b=EdgZOUofMcIb4zblp0tXorwxw6qZNEzAbqbzgx2vVEAZCL+BX4A5HD3Xveb4DGnpp08GON
 9wzQds/XZS3JhaSJwuRb8o8VAzQ6EHmf/x263xi9l2zztb7f8/4egkULUKykOgHlmm4Z91
 Vpz55HtahnpeMdvmzuJbkh2tnadJOU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-stfvHO0ZOfqDt8Ev0brejQ-1; Tue, 22 Sep 2020 16:36:17 -0400
X-MC-Unique: stfvHO0ZOfqDt8Ev0brejQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7645C64086;
 Tue, 22 Sep 2020 20:36:16 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B35767367E;
 Tue, 22 Sep 2020 20:36:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] kvm: Correct documentation of kvm_irqchip_*()
Date: Tue, 22 Sep 2020 16:36:12 -0400
Message-Id: <20200922203612.2178370-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When split irqchip support was introduced, the meaning of
kvm_irqchip_in_kernel() changed: now it only means the LAPIC is
in kernel.  The PIC, IOAPIC, and PIT might be in userspace if
irqchip=split was set.  Update the doc comment to reflect that.

While at it, remove the "the user asked us" part in
kvm_irqchip_is_split() doc comment.  That macro has nothing to do
with existence of explicit user-provided options.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/kvm.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 5bbea538830..23fce48b0be 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -51,23 +51,22 @@ extern bool kvm_msi_use_devid;
 /**
  * kvm_irqchip_in_kernel:
  *
- * Returns: true if the user asked us to create an in-kernel
- * irqchip via the "kernel_irqchip=on" machine option.
+ * Returns: true if an in-kernel irqchip was created.
  * What this actually means is architecture and machine model
- * specific: on PC, for instance, it means that the LAPIC,
- * IOAPIC and PIT are all in kernel. This function should never
- * be used from generic target-independent code: use one of the
- * following functions or some other specific check instead.
+ * specific: on PC, for instance, it means that the LAPIC
+ * is in kernel.  This function should never be used from generic
+ * target-independent code: use one of the following functions or
+ * some other specific check instead.
  */
 #define kvm_irqchip_in_kernel() (kvm_kernel_irqchip)
 
 /**
  * kvm_irqchip_is_split:
  *
- * Returns: true if the user asked us to split the irqchip
- * implementation between user and kernel space. The details are
- * architecture and machine specific. On PC, it means that the PIC,
- * IOAPIC, and PIT are in user space while the LAPIC is in the kernel.
+ * Returns: true if the irqchip implementation is split between
+ * user and kernel space.  The details are architecture and
+ * machine specific.  On PC, it means that the PIC, IOAPIC, and
+ * PIT are in user space while the LAPIC is in the kernel.
  */
 #define kvm_irqchip_is_split() (kvm_split_irqchip)
 
-- 
2.26.2


