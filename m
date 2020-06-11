Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09222C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C966B206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNu9rwMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C966B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTdx-0000mH-V7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA5-0001I5-OI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA4-0001Lf-1H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xt61GIgecUTg5KOIYFEDCp0QNh8YsQUdYP2PYETJViQ=;
 b=gNu9rwMddAPXsP/+URV6mizoo4ksg0rtZSli9borzoLUfs8u/EZKmNdXUXFxo3x/kslcGl
 WX3Kmkb+3M36ug50g5/u83OR2tcm876vTFG5RswTV5UW+eyFX/9uE8LGKf5WA0Ery7d+ZZ
 hoefsypeAuBas14gl+wOufu8WNoW6Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-JnQ-1lthMLeq4o3ODd1V7w-1; Thu, 11 Jun 2020 15:46:48 -0400
X-MC-Unique: JnQ-1lthMLeq4o3ODd1V7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7275887300F
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:46:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32E4160CD3;
 Thu, 11 Jun 2020 19:46:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 068/115] KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
Date: Thu, 11 Jun 2020 15:44:02 -0400
Message-Id: <20200611194449.31468-69-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

So that kvm_irqchip_assign_irqfd() can have access to the
EventNotifiers, especially the resample event.  It is needed in follow
up patch to cache and kick resamplefds from QEMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200318145204.74483-4-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d06cc04079..b048c10af9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1662,9 +1662,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
     return kvm_update_routing_entry(s, &kroute);
 }
 
-static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int rfd, int virq,
+static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
+                                    EventNotifier *resample, int virq,
                                     bool assign)
 {
+    int fd = event_notifier_get_fd(event);
+    int rfd = resample ? event_notifier_get_fd(resample) : -1;
+
     struct kvm_irqfd irqfd = {
         .fd = fd,
         .gsi = virq,
@@ -1769,7 +1773,9 @@ int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
     return -ENOSYS;
 }
 
-static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int virq, bool assign)
+static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
+                                    EventNotifier *resample, int virq,
+                                    bool assign)
 {
     abort();
 }
@@ -1783,15 +1789,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg)
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n),
-           rn ? event_notifier_get_fd(rn) : -1, virq, true);
+    return kvm_irqchip_assign_irqfd(s, n, rn, virq, true);
 }
 
 int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                           int virq)
 {
-    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n), -1, virq,
-           false);
+    return kvm_irqchip_assign_irqfd(s, n, NULL, virq, false);
 }
 
 int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
-- 
2.26.2



