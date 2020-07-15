Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75747C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459A320656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byQZhJKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459A320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlh3-00022o-Hs
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 13:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlg8-00016M-PS
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:58:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlg7-0005hS-3z
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwNbw4J4fwt4iAkeKo22NQbxVadDUamDMOSYB4OzAHA=;
 b=byQZhJKEPMWLuCRUGDT+J9kByVjXmf4UQdcLdyeF0IynenspuMQ49k+MgYo+eVD7jNKF67
 hPutKzNCPy4pgARTq5oXKyZwcMwJ6q5x+kAEwRYEklZe6kK/jL0xrOS2KrsV1ss18631P5
 L29BuOP3lP3zN0MrgR1kvK1FwZCv638=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-17-E0ba3NtGaIBxKh7CGow-1; Wed, 15 Jul 2020 13:58:44 -0400
X-MC-Unique: 17-E0ba3NtGaIBxKh7CGow-1
Received: by mail-wm1-f72.google.com with SMTP id w25so4275128wmc.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WwNbw4J4fwt4iAkeKo22NQbxVadDUamDMOSYB4OzAHA=;
 b=e6Z+PC9PXWl/0HDIvQQd4rLV2r+NWheQINVRlmORvhaiqDwC2c3vjh6G0yz+JSSeAi
 KuHTU0sJOib/nho0ZFbq/KqoghRdQH5vZGCirGGF21DQej3ePFhzbRbOqhPhwlExA7Fe
 tTc6eFYnUkPEbqKFTx4mqSx3K3/KcU3eilh1Kq39mlVk4NJ2J2J6iX7yf7PJjVlMOnxj
 E9UIY3NYlGGQ9L0eXOr1lpXS+/DxwtL7HzaBfkGmHOqt1znV+1WrdqXGPLgHdABaSv/a
 mCz0Swwc915ENoHJ3TbFVcX0GPzqQ05ktWO3D/ewQ5OdGNRAJqQHoZYX9IsdPa3Ex2dH
 UsFQ==
X-Gm-Message-State: AOAM532DFYVf5fBactux+FlmL7cfbS8fjK58+8uuaYWNBfznrw27IGW1
 wF5LjcmNdKl0m4NnygSde6xUOkkd+QizFohGP9Vy0q03K2BBVkqo5PlD3ySygH2kKm0yYXJul6E
 Idd81DdgNiNTLg8k=
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr589931wml.183.1594835922692; 
 Wed, 15 Jul 2020 10:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9nz4twGhaa7cfC+uwyb8z6+Ngk6LZ8XC0exRA1psr6kjOlH8qU/YZu74hozAH7cLXFNV5Yg==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr589911wml.183.1594835922499; 
 Wed, 15 Jul 2020 10:58:42 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 92sm4872071wrr.96.2020.07.15.10.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:58:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/5] hw/core/qdev-properties: Simplify
 get_reserved_region()
Date: Wed, 15 Jul 2020 19:58:31 +0200
Message-Id: <20200715175835.27744-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200715175835.27744-1-philmd@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the safer g_strdup_printf() over snprintf() + abort().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 098298c78e..d5f5aa150b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -581,13 +581,10 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
-    char buffer[64];
-    char *p = buffer;
-    int rc;
+    g_autofree char *p;
 
-    rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
-                  rr->low, rr->high, rr->type);
-    assert(rc < sizeof(buffer));
+    p = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
+                        rr->low, rr->high, rr->type);
 
     visit_type_str(v, name, &p, errp);
 }
-- 
2.21.3


