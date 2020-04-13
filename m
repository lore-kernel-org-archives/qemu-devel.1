Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC3C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028DA20656
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFE/8x7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028DA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO61Y-0004cK-4l
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO60a-000462-RP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO60Z-0006Sf-LX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:48:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO60Z-0006SQ-Dh
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:48:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id d17so4783936wrg.11
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QAjTCOX4eYcBvo0NrQxhDD/AdRXkPtS7fHXUdXwRsWc=;
 b=gFE/8x7kkbFHz/b5BvCGcR7URVWeW+lqsq4kXNyXDKfqV1MKg6PQgq+s5u3OTaxTX+
 3t4oJZ/Z3EwuccXMV5mpItr7I/fNOASsK9BV0+3KGMpHmUEg+/p7NIQjOtzqZR5u7+zl
 cazOUAzWNjC84dJ2Rayf/xkjwJKukRP4B9YV7qeN5GjZ2aiHbe1pCWL4CvH2wgWhbeEm
 Ph1XW3wPrtn0cjhTYZnMUra2aFY4x4Oe4KTkK1XufVbF/qu++n/w7L4TSN0Eak5L0JYi
 Xe+iIXpwrAI3RkINrWppMfMN8EeLgHucWc4ww2TsN4JHJoDVgfEzWIxsaeR0n2XefI2n
 1gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QAjTCOX4eYcBvo0NrQxhDD/AdRXkPtS7fHXUdXwRsWc=;
 b=YlsyLcmnItXpchqx6HpPImya8NMuCyy9DhDqjjN19UdKZGM7AA2nYWWsRUuAlUBOoC
 Bcn2guKgypzPcW5yfn3LBVop89iCxJop2QXd7ui0mMLnWQaItoQb+rUb3vyGivfoLCfZ
 I9oE7Lk5bV2j7e9lg/4jdnuYqBmj9bZmGlNf5lkUKk0Y52VWl9cmCgFB5Zj+T4zA2ya+
 PHpxVeijPRfDFUXhJHMbiNRifbQts+PdgDpomK+9yuj/KZKthUv6dxN+tGTmDk34cQ9h
 hBJMFjcau0TypA+amp/0dQw5d9IdJaIsdvQQ8J+8vZsBJVGd2glVErCoPiOTwNmX9KL5
 N+Ag==
X-Gm-Message-State: AGi0PuaDv8B6sW0KhIapxFz+gh3EsBAGshTfdW6IcFWmBnsF2vjKYssu
 SaXTbXLlz3KuqucqSCMteCtbM3GrMUc=
X-Google-Smtp-Source: APiQypJuwJybL4KFdUf1xPYjwq/1jojjgv5s2XJngrS/eiKAvcWNO198gAOHl05rcm35gn/G5DEG1w==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr21012044wro.2.1586810921547;
 Mon, 13 Apr 2020 13:48:41 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y16sm16404922wrp.78.2020.04.13.13.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:48:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 1/7] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
Date: Mon, 13 Apr 2020 22:48:32 +0200
Message-Id: <20200413204832.404-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The instance_init() calls are not suppose to fail. Add a
Coccinelle script to use &error_abort instead of ignoring
errors by using a NULL Error*.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Improved script (Vladimir Sementsov-Ogievskiy suggestions)

 .../use-error_abort-in-instance_init.cocci    | 45 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 scripts/coccinelle/use-error_abort-in-instance_init.cocci

diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
new file mode 100644
index 0000000000..706c60163c
--- /dev/null
+++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
@@ -0,0 +1,45 @@
+// Use &error_abort in TypeInfo::instance_init()
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init.cocci \
+//  --keep-comments --in-place
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692500.html
+// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637.html
+
+
+@ has_qapi_error @
+@@
+    #include "qapi/error.h"
+
+
+@ match_instance_init @
+TypeInfo info;
+identifier instance_initfn;
+@@
+    info.instance_init = instance_initfn;
+
+
+@ use_error_abort_in_instance_init @
+identifier match_instance_init.instance_initfn;
+identifier func_with_error != {qbus_create_inplace, object_initialize_child};
+position pos;
+@@
+void instance_initfn(...)
+{
+   <+...
+   func_with_error@pos(...,
+-                           NULL);
++                           &error_abort);
+   ...+>
+}
+
+
+@ depends on use_error_abort_in_instance_init && !has_qapi_error @
+@@
+    #include ...
++   #include "qapi/error.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index f996e72780..77b93612bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2060,6 +2060,7 @@ F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
 F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
+F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 F: scripts/coccinelle/use-error_propagate-in-realize.cocci
 
-- 
2.21.1


