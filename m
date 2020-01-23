Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAAC2064C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRy8iOPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAAC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueOW-0003bk-A6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrY-0005Ei-Pe
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrX-0003pm-PI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:36 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrX-0003lj-Iy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p17so2626280wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ep2zLWRWUErqyW26G/7lhPUdGhrXWSwt7t7lct6ZAZY=;
 b=sRy8iOPNqjb9Q0e2dDwtuRigFidACVrae3MelcvgkdCPP+ArYPOnJAlPxN21NoOPS0
 4sct7Lr1t7i6GZe2+TVWQTIGbzCn75rWzZyh2b9T2YGp/WRPYmo3hyPy63NMu+kP5IGp
 SqKwMKwKiicnAonCavYGT+14n8nxy6AbPIzpoIF4N6qHSwa/emeigKZhnf8qdqmwc8I9
 chyUg/GKnjtGgP/5l/Vb1dMBSDKeYrP1WJp/jA9onsw6dj3GtujQW7iWc2QyWkssmBAV
 7qR1dUUa2pcVrUtQHm6E8bfIAobPZaYYrpHzq3yOJVby2HAahgCuFEs7XUfJxBx4rqYp
 YFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ep2zLWRWUErqyW26G/7lhPUdGhrXWSwt7t7lct6ZAZY=;
 b=N9UXYUhbE40jQu9WvaPna8oJZOEik0wqcBFrFP//3ZdiyGi3UgTjnru/T3nX5m/XYI
 oTL+5fHPOy1IY5RDtd/AXcID/UzhFyQqCKFqKfJC3tB1lxnL1WGxLJmEgAC038XiERK7
 9tIZH+TaVFZDcZiYCYHz+vWaVbREviiuULAgOcRk4bnhqmvZ3k9BVAa/McHLG3w+7LDD
 QwuUha9q+ziRBt6hBI4Pi6EDiYIoG+Dfm1xbP+cWTZYQSsMRwi3crJWYCIbP0JkRxQ+H
 Wx8a/b1PojwIm8S9guReJebUeVbkOSd/xGYlPXvcMVWR6WDF+37uqdUAG6lv3sLO1d4q
 MIRQ==
X-Gm-Message-State: APjAAAWTX2dhwEWbyvbSZRBoMcm12vgp3LrUFXKjJm33uASMphA9YnN0
 RbXj+KUjqK7NyfxXXhgBLhWD2C/6
X-Google-Smtp-Source: APXvYqyPtPwo4u5aktCz6eQ0F5hMEgXvZG5rGa+U9tUQtKJcRAcTxTBgGp82kgslX/PZCP7WeVXpgw==
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr4320665wmc.124.1579787374395; 
 Thu, 23 Jan 2020 05:49:34 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/59] object: add extra sanity checks
Date: Thu, 23 Jan 2020 14:48:34 +0100
Message-Id: <1579787342-27146-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Type system checked that children class_size >= parent class_size, but
not instances. Fix that.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200110153039.1379601-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/object.c b/qom/object.c
index 90155fa..dcb6863 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -307,6 +307,7 @@ static void type_initialize(TypeImpl *ti)
         int i;
 
         g_assert(parent->class_size <= ti->class_size);
+        g_assert(parent->instance_size <= ti->instance_size);
         memcpy(ti->class, parent->class, parent->class_size);
         ti->class->interfaces = NULL;
         ti->class->properties = g_hash_table_new_full(
-- 
1.8.3.1



