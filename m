Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9F122B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6JSjLt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9F122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FDw-0006Me-QD
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3FD6-00056q-0r
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:55:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29791
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3FD4-000135-Cc
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1FhaTOycuvEOwdTFxqEseFbzAWqSh1HQLKcV71KICA=;
 b=g6JSjLt0AnN5hX/sJoPpUybV+U7ji8SXYu+raJhgyMH5Q0lMpC+zyVjUR2X0YDy62YZHRo
 KQWDAeIou07adOUaGcTekQ/iQjup9/WqJtNarHnXV6klfBKFK2VjlYhiQoWQcq/mpaxiAa
 NVyeglrOm9IQIEc9TDsMZbGgVUKt90U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-iJvLvoN0NOWyifwzeOps1g-1; Wed, 05 Aug 2020 04:55:40 -0400
X-MC-Unique: iJvLvoN0NOWyifwzeOps1g-1
Received: by mail-wm1-f69.google.com with SMTP id v8so2202768wma.6
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V1FhaTOycuvEOwdTFxqEseFbzAWqSh1HQLKcV71KICA=;
 b=R5+cyzrUzy6tqEa9BKV+hUy9qMnyLynJaPaLTFXvgkRQbjD5iT/JDjV1J05bpQ2jow
 4IoKMQOCRDwS8Ndzk/BifqIS9x1d83FjqYil058wUxv9iL6dKihAY2b4I94uociKeC4F
 T/eWJTciu5IiwfedLO1sbM6zHOEvYrjDjkHkYTjAuWy0qKFHpkcrX9qu+LJmLvbksv19
 cAbyJ8+xE2g0yhLZ4TSAFGDKVcgO+dxa4CsTieQd2RQ28G0zwao428X8gwJRAGMdT9X6
 lEQxPVeX/I7e8JV0gplJUHA54acE6fnkBZqZqLG6Vi2hHwMHCANxoiPMmnTQX17y5ghT
 cXkQ==
X-Gm-Message-State: AOAM533f65I5PmtfcYhcRLGTXAD7vYXjtHF/a6CKKWFUIUtQCW3EuQVA
 4jQipcNTJwvFu4Zljlh1soWUTgdOjMw/A7vKiwnwIZASY4cJWbBMhgR/yzToAhF71G2KdtHOT0W
 x3L4rcrHpZm7o2+E=
X-Received: by 2002:adf:a351:: with SMTP id d17mr1803268wrb.111.1596617738804; 
 Wed, 05 Aug 2020 01:55:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuUYushjX0k9M+owXFOYlQ7TQ+r5Xf3OAaR/qhRqx9B5m47UkDc2t/Aze9M4dfQ124sZUYrQ==
X-Received: by 2002:adf:a351:: with SMTP id d17mr1803243wrb.111.1596617738545; 
 Wed, 05 Aug 2020 01:55:38 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z15sm1809439wrn.89.2020.08.05.01.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 01:55:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 2/2] stubs: Remove qemu_notify_event()
Date: Wed,  5 Aug 2020 10:55:26 +0200
Message-Id: <20200805085526.9787-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200805085526.9787-1-philmd@redhat.com>
References: <20200805085526.9787-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index b35f844638..8962dfd71f 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -17,5 +17,5 @@ int64_t cpu_get_icount_raw(void)
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 {
-    qemu_notify_event();
+    abort();
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


