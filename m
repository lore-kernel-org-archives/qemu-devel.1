Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F50C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03572078E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI1NF15m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03572078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5W31-0000Hc-Td
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1S-0006PX-HQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:17:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1Q-0000cv-UK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597159024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYm/E2Wo6qfVLKyq/CcNoD/hCMqV5D8p7xguVa2y5Zo=;
 b=TI1NF15mQx6jz3ZKn+cKRq7zoscWOigzi0vUInDM+gFuNv02w4d0swEMWoOujIcB7aeS18
 OvkGq2qv8IjuiSwpkFBuiVG34m9zmDGKlgr82Dr2rt1yikdaCjopdRhQFWocCxnS+HCcN9
 wnFHjOZ1IXeGHrJgsYYuk7CPoEXmyrI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-pDpoaNsrOjm0HepLky8TUQ-1; Tue, 11 Aug 2020 11:17:02 -0400
X-MC-Unique: pDpoaNsrOjm0HepLky8TUQ-1
Received: by mail-wm1-f69.google.com with SMTP id c184so790176wme.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYm/E2Wo6qfVLKyq/CcNoD/hCMqV5D8p7xguVa2y5Zo=;
 b=e7cQgBnJOprfAmLM0pytn9sIMLgr+ru+NH5HFHpeV2EOkKdwF27NwER8WxljF5hgwX
 8k0JIWq+cYQN9nJkI7u8ubPk8sTfTKZvQ8ZVOCIuxgHA2f5W79lLEQmWB7GWkgOtnpc3
 O3sDo9hxRC/AvaU9srMTKMak+evA67nUcw8D+ANxkprqUFw5S4XmMlDj+mwUH12z+B22
 xIe1HZP3w6OnwD8iNcYjHl4rOwXyDF4V2xDXLPRdevAw80l44V+mYAq7MMKQg56CNVQJ
 TPVsMpdL/f3ecOFovLu5S3cI8ldIIsEPO+/GNsc/M+VqjadqRtmLpPnhdl8tl8eX0EcN
 zrow==
X-Gm-Message-State: AOAM533fN8qcozS8uNWcuNGhxxIcNYRVGoVJPzsV0BYECNCOiYo2eA5V
 UTLZxlJPQdwhk9qNlTmVVSdhfNCxVxNNLUEtWDXH6tOF2NLzPGwXcAgY0gDAeR+iMTSeV31SGCv
 wJqKbn3W5k2Pd+w0=
X-Received: by 2002:a1c:28d5:: with SMTP id o204mr4631375wmo.104.1597159020932; 
 Tue, 11 Aug 2020 08:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwblnJKzh66Is96SUBwlzOgKe5GQW8aNd2Fo28K0C5cZ7Rhr4V8QnK1XLKlgPPpScad9uTsgA==
X-Received: by 2002:a1c:28d5:: with SMTP id o204mr4631358wmo.104.1597159020721; 
 Tue, 11 Aug 2020 08:17:00 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z12sm27297339wrp.20.2020.08.11.08.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 08:17:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/3] util/vfio-helpers: Fix typo in description
Date: Tue, 11 Aug 2020 17:16:43 +0200
Message-Id: <20200811151643.21293-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200811151643.21293-1-philmd@redhat.com>
References: <20200811151643.21293-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the second 'and' introduced in commit 418026ca43
("util: Introduce vfio helpers").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index e399e330e2..583bdfb36f 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -173,7 +173,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
 }
 
 /**
- * Initialize device IRQ with @irq_type and and register an event notifier.
+ * Initialize device IRQ with @irq_type and register an event notifier.
  */
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp)
@@ -505,7 +505,7 @@ static IOVAMapping *qemu_vfio_find_mapping(QEMUVFIOState *s, void *host,
 }
 
 /**
- * Allocate IOVA and and create a new mapping record and insert it in @s.
+ * Allocate IOVA and create a new mapping record and insert it in @s.
  */
 static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
                                           void *host, size_t size,
-- 
2.21.3


