Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A72C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F46020729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6/IEii/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F46020729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafVb-0002x1-DJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUB-0001Fq-02
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafU9-0003Qp-Bv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VBYicJ6FWuL5UYNPKwg9SuCEm4GOXsnfoC15oaHUDc=;
 b=C6/IEii/ulNn+pZA3ItTSOuTHWrEpV4JTtoy0XpjSk06TO0CeHYDplFYeVSJunLWZqRXqz
 dLOtSRWPLAvW97whjkJJGNH6wkTKlsmmCx+OfkgwfqcNUBWEyBuqis/Us1c7fGOKDUga3o
 of+Po4GUO57qII7yMNXGfESEAOvEyBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-b7MDyTKtPoqZV_6EDo2QaA-1; Thu, 05 Nov 2020 08:39:25 -0500
X-MC-Unique: b7MDyTKtPoqZV_6EDo2QaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0793805F04;
 Thu,  5 Nov 2020 13:39:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF874DA35;
 Thu,  5 Nov 2020 13:39:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8DDAA9D15; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] x86: rewrite gsi_handler()
Date: Thu,  5 Nov 2020 14:39:13 +0100
Message-Id: <20201105133923.23821-3-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Rewrite function to use switch() for IRQ number mapping.
Check i8259_irq exists before raising it so the function
also works in case no i8259 (aka pic) is present.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/x86.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 5944fc44edca..b67e7b789f89 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -588,11 +588,17 @@ void gsi_handler(void *opaque, int n, int level)
     GSIState *s = opaque;
 
     trace_x86_gsi_interrupt(n, level);
-    if (n < ISA_NUM_IRQS) {
-        /* Under KVM, Kernel will forward to both PIC and IOAPIC */
-        qemu_set_irq(s->i8259_irq[n], level);
+    switch (n) {
+    case 0 ... ISA_NUM_IRQS - 1:
+        if (s->i8259_irq[n]) {
+            /* Under KVM, Kernel will forward to both PIC and IOAPIC */
+            qemu_set_irq(s->i8259_irq[n], level);
+        }
+        /* fall through */
+    case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
+        qemu_set_irq(s->ioapic_irq[n], level);
+        break;
     }
-    qemu_set_irq(s->ioapic_irq[n], level);
 }
 
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
-- 
2.27.0


