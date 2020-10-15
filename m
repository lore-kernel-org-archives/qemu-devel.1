Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E75AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916BD2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3IUWTPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916BD2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAQ9-00048z-6Q
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kTAPJ-0003cy-Dq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kTAPG-0007j7-Vx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602795805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u6WCwAlxaesohkE9ws6IWap07LA/fWznWJXS/If8M9g=;
 b=h3IUWTPVVdRFf6cJvu79l+sJw4TuKr+Rtr6LUXySx+oaqLANGlgZlwH7/AvZhliEOYAEU/
 3Pxj6yhe83LfhdCPEw/MxeK9+/4MTpPWFbk3/qx5fDGt58+WjqfYNnTsJ7BeMNoPFzjChf
 Eg2BkqMPIXKpQjpuE5rZtE0v/xY95XY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-xkbvcJlWPfm9rR3Rq0DiFw-1; Thu, 15 Oct 2020 17:03:23 -0400
X-MC-Unique: xkbvcJlWPfm9rR3Rq0DiFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB86186ABCF;
 Thu, 15 Oct 2020 21:03:21 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 207C45C1BD;
 Thu, 15 Oct 2020 21:03:19 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ppc/spapr: re-assert IRQs during event-scan if there are
 pending
Date: Thu, 15 Oct 2020 23:03:18 +0200
Message-Id: <20201015210318.117386-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we hotplug a CPU during the first second of the kernel boot,
the IRQ can be sent to the kernel while the RTAS event handler
is not installed. The event is queued, but the kernel doesn't
collect it and ignores the new CPU.

As the code relies on edge-triggered IRQ, we can re-assert it
during the event-scan RTAS call if there are still pending
events (as it is already done in check-exception).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr_events.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 1069d0197b4f..1add53547ec3 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1000,10 +1000,22 @@ static void event_scan(PowerPCCPU *cpu, SpaprMachineState *spapr,
                        target_ulong args,
                        uint32_t nret, target_ulong rets)
 {
+    int i;
     if (nargs != 4 || nret != 1) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
     }
+
+    for (i = 0; i < EVENT_CLASS_MAX; i++) {
+        if (rtas_event_log_contains(EVENT_CLASS_MASK(i))) {
+            const SpaprEventSource *source =
+                spapr_event_sources_get_source(spapr->event_sources, i);
+
+            g_assert(source->enabled);
+            qemu_irq_pulse(spapr_qirq(spapr, source->irq));
+        }
+    }
+
     rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
 }
 
-- 
2.26.2


