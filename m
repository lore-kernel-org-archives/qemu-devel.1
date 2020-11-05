Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDDC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86152072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSpNOBvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86152072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafYI-0006d2-GY
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUK-0001Oz-I0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUI-0003X9-Rj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQSyVFvqV+tEgAGmEnC97qBsAQgtHbwKse28WqGZH7g=;
 b=FSpNOBvYGQ/J97rvpFlpZTAxT4doynEwk0l7YIXAwEsC6DywXdttTtXD4JY4iJyh2H+d+l
 dKm6MtlPkhDKbYlsfaaq6zBrRjnn2h9YBxY4KdMlpN/MaQrc2l6jq7GwYRTXBfm1tNENql
 TCVNQ+msRUAp6kJ9VevBtvf8/I5Bikk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-zQA_vjPePFaxAdRlRqWX8A-1; Thu, 05 Nov 2020 08:39:34 -0500
X-MC-Unique: zQA_vjPePFaxAdRlRqWX8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 036B9805F14;
 Thu,  5 Nov 2020 13:39:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 577D05B4CC;
 Thu,  5 Nov 2020 13:39:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 845C59D10; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] [testing] disable xhci msix
Date: Thu,  5 Nov 2020 14:39:12 +0100
Message-Id: <20201105133923.23821-2-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 hw/usb/hcd-xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index b78fcd2bb2d5..0a0954042ff3 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -239,7 +239,7 @@ static void qemu_xhci_instance_init(Object *obj)
     XHCIState *xhci = &s->xhci;
 
     s->msi      = ON_OFF_AUTO_OFF;
-    s->msix     = ON_OFF_AUTO_AUTO;
+    s->msix     = ON_OFF_AUTO_OFF;
     xhci->numintrs = XHCI_MAXINTRS;
     xhci->numslots = XHCI_MAXSLOTS;
     xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
-- 
2.27.0


