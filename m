Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC622C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB662074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/RjjNIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB662074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMswj-0005tI-CW
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMskV-0003c2-TP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMskU-0008Qr-3i
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:59:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601297960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6PGjLSw3kSK6ARw73eSqwNVErLiz9tgI0uJe1vk+sQ=;
 b=e/RjjNIfj94AgcK3I2YY3zDtNvmNJ2JD/ZQ0lhpmpyFAzrGnEQl97mi/3vVJzFifXosQtc
 25EAGeig3FRd+F7bwba7Dby257PS74M41YBwPwnNBVEGGCN3YvCb9VACBUNPEEIIuzPZm8
 FmFtOBXaxI8K3Wprheddyprj7nV9chQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-BblTGt9xNMe2aEDzd5IUVQ-1; Mon, 28 Sep 2020 08:59:14 -0400
X-MC-Unique: BblTGt9xNMe2aEDzd5IUVQ-1
Received: by mail-wr1-f70.google.com with SMTP id a10so363441wrw.22
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 05:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v6PGjLSw3kSK6ARw73eSqwNVErLiz9tgI0uJe1vk+sQ=;
 b=g2fSIJBLpCKcz+AyzHSQ27Tuf6+dOj1R7oKxPy3F/F6y7rQA5lhWGfkCJ90VKAEthG
 suGdzUeaA/BP+1TuAwJzLYSQsezCGo6sm3X7A0Gn0g9jiZybtaPNz68YxuGEQ98C8Snt
 8SOsRZKJKSrnHdz/WmfxKcetuKOjxB5r+G+B+Y4zAEK9cjn+cD4ThdbbVVAYU7aDJde5
 dyINXMinUq47pA+5CB7loQeCUWtut6oar+jWlXzvM11Qp8FCH5BeDzYiCK6bkikwJlUV
 qgmT+1WPQbE4NJMlQRrxI7YBOOpaeu1bIUwkbocn5KBl/d7ZM6w4FTR0GkBo0HpyJGLC
 0EVw==
X-Gm-Message-State: AOAM5321P5vrmAVGMex89HwXtACUDN20q4EuLByYYPpA+Ihg0rwxroKZ
 CWSC1XCDUdHi9ZwH8e8ksMdZ/ONnX2PgtowgJFwbtB+rcJEO/vzyDcl6WpRC4usr66fcjjzuSuS
 fSIYaCN6jPlSumKU=
X-Received: by 2002:adf:fd12:: with SMTP id e18mr1677850wrr.96.1601297953010; 
 Mon, 28 Sep 2020 05:59:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy51qV0gl8YBMCmmGG7e3hY0ATWkyT+tJ+uJmjlEfM2JwyBMN36ZcpD7qVM0V/bebKJrKynpA==
X-Received: by 2002:adf:fd12:: with SMTP id e18mr1677831wrr.96.1601297952846; 
 Mon, 28 Sep 2020 05:59:12 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id c16sm1502529wrx.31.2020.09.28.05.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 05:59:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qemu/atomic: Drop special case for unsupported compiler
Date: Mon, 28 Sep 2020 14:58:58 +0200
Message-Id: <20200928125859.734287-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928125859.734287-1-philmd@redhat.com>
References: <20200928125859.734287-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit efc6c070aca ("configure: Add a test for the
minimum compiler version") the minimum compiler version
required for GCC is 4.8, which has the GCC BZ#36793 bug fixed.

We can safely remove the special case introduced in commit
a281ebc11a6 ("virtio: add missing mb() on notification").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/atomic.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index c1d211a3519..8f4b3a80fbd 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -241,23 +241,6 @@
 
 #else /* __ATOMIC_RELAXED */
 
-/*
- * We use GCC builtin if it's available, as that can use mfence on
- * 32-bit as well, e.g. if built with -march=pentium-m. However, on
- * i386 the spec is buggy, and the implementation followed it until
- * 4.3 (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=36793).
- */
-#if defined(__i386__) || defined(__x86_64__)
-#if !QEMU_GNUC_PREREQ(4, 4)
-#if defined __x86_64__
-#define smp_mb()    ({ asm volatile("mfence" ::: "memory"); (void)0; })
-#else
-#define smp_mb()    ({ asm volatile("lock; addl $0,0(%%esp) " ::: "memory"); (void)0; })
-#endif
-#endif
-#endif
-
-
 #ifdef __alpha__
 #define smp_read_barrier_depends()   asm volatile("mb":::"memory")
 #endif
-- 
2.26.2


