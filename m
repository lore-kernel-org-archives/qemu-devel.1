Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D96229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D96229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfjJ-00054C-Ej
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49020)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfic-00039x-41
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfia-0001ua-U5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:45 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfia-0001uQ-QH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:44 -0400
Received: by mail-qt1-f173.google.com with SMTP id k10so49552268qtq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aZQ83NSi+JcZNuG+1ehF+2gFpu3e5ooLMfv+8bQIwY4=;
 b=RsbulNXo8bejLk/hEMqc3qVbj0K5XLH7+J5XqAczigj31RcQ2V/F8BOKSX96bzVbKe
 Yl3iPapR1m1Qu6RxkasnxgHES05cqzk0kZ+FhQXJNB+PLy+K3Sd/b/RNkb9r+vJ1Y+C8
 kuPq0FaNMrI3/HNuHcxdWQQnP1q+SEU/Ai9X6BnJBWixMETlzzjt1rZa9Xx7vttqwDT2
 dz/NKQp0S6u3fkc9Dq++0Rm4hWSH5j5nXKxp6+vGsjBhriZscCPRNAWZVlvfni2ydpLW
 YlVG/nVCLkDdAvRkrXe3NqhrTwVguZr1AvSJZ8ULb0V7FS+fbb+T3/NdbanjFY1hbN/6
 nrLw==
X-Gm-Message-State: APjAAAVUfiGwVo8hzZOi5PlQDkaaG23yLlf9BgPRl3bZ92rTsptq+BTK
 6hycmFkWI1LVPj4nLdDGoRYG9Hp1ZV0bZQ==
X-Google-Smtp-Source: APXvYqxSIN+5TI26NL2d2NXdZGJkxUjZ6qbxn+XlkQ82OdzUXYuV9fy78T0ZUM3KYjhL6hs5Wq2Mkw==
X-Received: by 2002:ac8:4413:: with SMTP id j19mr62227643qtn.281.1564068704037; 
 Thu, 25 Jul 2019 08:31:44 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 m5sm20955089qkb.117.2019.07.25.08.31.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:43 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL 03/12] ioapic: kvm: Skip route updates for
 masked pins
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153139.hUz7WiCDtBzksxO071d84wIOGTmmJ3lMihOduhlnYJ8@z>

From: Jan Kiszka <jan.kiszka@siemens.com>

Masked entries will not generate interrupt messages, thus do no need to
be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
the kind

qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=0, high=0xff00, low=0x100)

if the masked entry happens to reference a non-present IRTE.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/ioapic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index c408749876..e99c37cceb 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -197,9 +197,11 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
             MSIMessage msg;
             struct ioapic_entry_info info;
             ioapic_entry_parse(s->ioredtbl[i], &info);
-            msg.address = info.addr;
-            msg.data = info.data;
-            kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
+            if (!info.masked) {
+                msg.address = info.addr;
+                msg.data = info.data;
+                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
+            }
         }
         kvm_irqchip_commit_routes(kvm_state);
     }
-- 
MST


