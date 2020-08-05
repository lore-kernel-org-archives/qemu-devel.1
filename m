Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F216C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DF522B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="funIogXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DF522B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FDu-0006G9-7o
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3FD3-000539-2L
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:55:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3FD1-00012x-Cl
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M46m4CKnd0h2fnbiaQwpYocPzWV6Ty9hunqocvBwXyI=;
 b=funIogXkOb4549Ke41IgC+zci+n5xioiqHl/RAK1EpkmKP5aNKS7Dixb1iWB9qe3FK4d3C
 ZJTu/LkM7kMr+maLenScj5H2PMmjUMZoevqfi2m6bHQzVGOueOYoPpBqOcLO+MOMJ+5HbS
 se1jZNd1nptxiHasLZScpkA/b4B51WU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-flaDf9iTOteftXmkBO_O9A-1; Wed, 05 Aug 2020 04:55:35 -0400
X-MC-Unique: flaDf9iTOteftXmkBO_O9A-1
Received: by mail-wr1-f71.google.com with SMTP id s23so13179586wrb.12
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M46m4CKnd0h2fnbiaQwpYocPzWV6Ty9hunqocvBwXyI=;
 b=XQKca+KupDubwxIoeL+0MjPkfZnEsxrWzAw7U9IGk+HR5CrGgfybx680M5UBKMeWd5
 syrLVHm1k7yLnnYYZ+ncps5WdcevaNUDrU/OVX80fSl5cNHShuJY0iSQbcrwNVV8Ir5J
 sI0n50lB6iZQ6gChNCQ/nmJ3GN8tYG/NGsVqK0WkOCjCYPTnwCyqHRM9QJTYLF2hNa+K
 DMLS0peOdjP6LjEnocq49f45kHqZyVw8tVQuShjkycF6XtzWOfDvhY0wcxBbJ0U7SvIX
 i5O2gej//u7zmW3j8QMz0SXGIvd+DQABc7P5Qbz7qFo2c7kzw052Sy6I1ZTPUhJ5EYuz
 FANg==
X-Gm-Message-State: AOAM5311CHYeTp4Jxg851Zb0MhbuOc/Is5Vp5sceKzvZmEtmNEhL1Dxu
 3nSJC/8w7OvXqkUNc+MrXDDBJhPICmG4yHd8Gdo1TXotVSYXeGvfN/+tQzcrl8qdjyNnKGGHiQf
 Jm9ayfHTiDuZJsmU=
X-Received: by 2002:a1c:c1:: with SMTP id 184mr2466544wma.105.1596617733921;
 Wed, 05 Aug 2020 01:55:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydxgo4GeZ1jNy74ol7cYEnLCBZrlch0Vc7FDMC0pj+rlFXELJjCw2NbFUUIKDGPrHpabS9Wg==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr2466523wma.105.1596617733624;
 Wed, 05 Aug 2020 01:55:33 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id a10sm1780858wro.35.2020.08.05.01.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 01:55:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 1/2] exec: Restrict icount to softmmu
Date: Wed,  5 Aug 2020 10:55:25 +0200
Message-Id: <20200805085526.9787-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200805085526.9787-1-philmd@redhat.com>
References: <20200805085526.9787-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'icount' feature is only meaningful when using softmmu.
Move it out of the globally used exec.c, and define it as
'false' in user-mode emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/cpus.h | 4 ++++
 exec.c                | 4 ----
 softmmu/cpus.c        | 7 +++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3c1da6a018..d8442aa9f0 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -11,9 +11,13 @@ void pause_all_vcpus(void);
 void cpu_stop_current(void);
 void cpu_ticks_init(void);
 
+#if !defined(CONFIG_USER_ONLY)
 void configure_icount(QemuOpts *opts, Error **errp);
 extern int use_icount;
 extern int icount_align_option;
+#else
+#define use_icount false
+#endif
 
 /* drift information for info jit command */
 extern int64_t max_delay;
diff --git a/exec.c b/exec.c
index 6f381f98e2..a89ffa93c1 100644
--- a/exec.c
+++ b/exec.c
@@ -102,10 +102,6 @@ uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
 #if !defined(CONFIG_USER_ONLY)
-/* 0 = Do not count executed instructions.
-   1 = Precise instruction counting.
-   2 = Adaptive rate instruction counting.  */
-int use_icount;
 
 typedef struct PhysPageEntry PhysPageEntry;
 
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..a4772034c0 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -81,6 +81,13 @@
 
 #endif /* CONFIG_LINUX */
 
+/*
+ * 0 = Do not count executed instructions.
+ * 1 = Precise instruction counting.
+ * 2 = Adaptive rate instruction counting.
+ */
+int use_icount;
+
 static QemuMutex qemu_global_mutex;
 
 int64_t max_delay;
-- 
2.21.3


