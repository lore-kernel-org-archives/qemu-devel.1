Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFCE207FC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIiwL/4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFCE207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GKx-00076p-9A
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3GF0-0006RH-0v
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3GEx-0000Wk-UY
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLGUCPzB2NCSpVTvR3653iI6lwL6bempAHIge/kknyw=;
 b=CIiwL/4lf0kgEOygNquZPf2gilLQ/s/8LrEOsknr2QEXbL4XuipXnWSfh9FjrmccwQ1MeR
 UJyYFhGdRZy/RfwquCxYxenaaTsp68fowK/rQgAc1b58/qSPC2N96dpRZ4PfHkvqmlocR/
 5YRkhqlI7xiT0V8FyaIx/yU+z7qmvgA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-VKpoifDLOr6rAW4sH5LcjQ-1; Wed, 05 Aug 2020 06:01:41 -0400
X-MC-Unique: VKpoifDLOr6rAW4sH5LcjQ-1
Received: by mail-wr1-f69.google.com with SMTP id z12so13453113wrl.16
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 03:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hLGUCPzB2NCSpVTvR3653iI6lwL6bempAHIge/kknyw=;
 b=A8kimYYHmuY2G8oEmUPm2nwBnu+zyCUh7tTJCUbADP8oUMvst7NZQRflV2mj/6hx57
 dHqJ3X2me4EO3Zh4fjmawIyF4TAAEvcIkC5r4w5Ah363Eu+DRJ5nZbS8uIDFDJRySO/K
 OViW4NX7f57m388hOUzSoR7/Vr4Qxln7+iRgIQuQfWn3r3ZAeokPLY4hnD8RiFf7fCAV
 7HFOwVVvFlYEMWN38q+Chsc2k+QDKFWiCr9E6W5gdpSb7DEaZhvRMMNRM5toGRPAtw08
 8BAzhvaYGpOgJCSQvYRaHmrte0x6r588EM3UlwO+KkGQoGLbZH/hx2Yin0rZsJ8lIHWA
 3ANA==
X-Gm-Message-State: AOAM530s+2FBGgq3sZRCsur90U6GqQmSRo+fPOShwDQjss28Ec3C5I4v
 C3SzoGafO9Uci0nfT6tp8TEUehBSKxJsgJThdG64jSqtS2hxHTRYPuVXzotvMtsUK1abhujraIl
 v5yKnUE2YnaNDQFY=
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr2573421wme.70.1596621699764; 
 Wed, 05 Aug 2020 03:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf2ELNKrJ9YYUTqNwfgXFZMpR+PVoY/AkCppcowenHs2T1ThBe+w3Tbe+Oa+JbDwcVhiCcFQ==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr2573399wme.70.1596621699588; 
 Wed, 05 Aug 2020 03:01:39 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z67sm2062698wmg.28.2020.08.05.03.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 03:01:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 2/2] stubs: Remove qemu_notify_event()
Date: Wed,  5 Aug 2020 12:01:26 +0200
Message-Id: <20200805100126.25583-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200805100126.25583-1-philmd@redhat.com>
References: <20200805100126.25583-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the qemu_notify_event() stub anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 stubs/cpu-get-icount.c | 2 +-
 stubs/notify-event.c   | 6 ------
 stubs/Makefile.objs    | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)
 delete mode 100644 stubs/notify-event.c

diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
index b35f844638..4578217fe2 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -17,5 +17,5 @@ int64_t cpu_get_icount_raw(void)
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 {
-    qemu_notify_event();
+    /* Nothing to do. */
 }
diff --git a/stubs/notify-event.c b/stubs/notify-event.c
deleted file mode 100644
index 827bb52d1a..0000000000
--- a/stubs/notify-event.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/main-loop.h"
-
-void qemu_notify_event(void)
-{
-}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index d42046afe4..cb374c96db 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -12,7 +12,6 @@ stub-obj-y += isa-bus.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
 stub-obj-y += monitor-core.o
-stub-obj-y += notify-event.o
 stub-obj-y += pci-bus.o
 stub-obj-y += qmp_memory_device.o
 stub-obj-y += qtest.o
-- 
2.21.3


