Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304AF2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFTJiknW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304AF2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYTg-0001fM-LN
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3c-0006z8-Sj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3b-0002OI-MH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3b-0002Kb-Ba
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so1985680wrm.11
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3xRW0dWjMhO1EPoHD9jweteGOAO0mpniEjjgSK1VhoQ=;
 b=sFTJiknWNhiykVK/xkhmcw8lZI9VIXn95ayasZ9wFxUJuU0LhINvDhuxe0EtqFp6CQ
 Ov1b+eAj4AgUcWf5LDOeBm2WJkXX9AG1f1O7U6IozW3poC+lk1CuYZu2WaOzbodo+HZg
 FKpyKBluJd9fgWAbgueTndi4TcoeIyDZDM83d/UL6C+J+GZqcRatRiykhuTfVbRc/CEk
 B75dum2GbrlYS0mB9WMes4aI+xN2sILSgiBJ5merz7fVdZ3T5tGLbNAWKb9T4iTbm6Of
 bP1VcPlUzm6mtxqzc1LIhxFZnCMS09xv0RW+mXGfPfzCMdsm3AyqU2pVUHnZxNgDgb/T
 Xclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3xRW0dWjMhO1EPoHD9jweteGOAO0mpniEjjgSK1VhoQ=;
 b=AEscerwK97i3QaKdFMeC7ltJmBowP/Kl/b1bMcchcFBgTgHAb/DJ0MvA3gczXcERYo
 wJ3XNgPkscgQB9JFGswKxQpRbwLnn1BERmrWy6xSB46yTKO/leD7USWoUS7JYH6dorUV
 7ejAJ36EXC7tcd4FBibHLVFqb5DGJ+OpKNu6WAG92GNQEUg88hnRerpcoWnp6gtdhEAU
 boBLqR3SB5V1fK+9xjDHhsTLtLWVAQh/WYPhJqIhVwYKdN05zjeASviOgo2h0Xlg6XYJ
 2sLEyb3kNmtWkzVzeVIhD2CaUIW9bV+cErLACyphwqtlmT4r1uTdF0ciRlrVVAt0EL+I
 dx6Q==
X-Gm-Message-State: APjAAAWQ65p1wgSLonKx5sC9alBV1X5RzkW8rKD8/g65logyt92YHyJa
 jMa8F7EFbuBFoISu9pPyu5q8fv7a
X-Google-Smtp-Source: APXvYqwQ2tpoJX5QYmArLnVaHhW47aKaLqZdz5fQVaSh5OLJN2hIbwraUJQDqERCaCqhDT8elja8CQ==
X-Received: by 2002:adf:f508:: with SMTP id q8mr2447900wro.334.1576670638175; 
 Wed, 18 Dec 2019 04:03:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/87] hw/i386: Simplify ioapic_init_gsi()
Date: Wed, 18 Dec 2019 13:02:20 +0100
Message-Id: <1576670573-48048-55-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All callers of ioapic_init_gsi() provide a parent. We want new
uses to follow the same good practice and provide the parent
name, so do not make this optional: assert the parent name is
provided, and simplify the code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d18a3ef..d8bb5c2 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -307,15 +307,14 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     SysBusDevice *d;
     unsigned int i;
 
+    assert(parent_name);
     if (kvm_ioapic_in_kernel()) {
         dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
     } else {
         dev = qdev_create(NULL, TYPE_IOAPIC);
     }
-    if (parent_name) {
-        object_property_add_child(object_resolve_path(parent_name, NULL),
-                                  "ioapic", OBJECT(dev), NULL);
-    }
+    object_property_add_child(object_resolve_path(parent_name, NULL),
+                              "ioapic", OBJECT(dev), NULL);
     qdev_init_nofail(dev);
     d = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
-- 
1.8.3.1



