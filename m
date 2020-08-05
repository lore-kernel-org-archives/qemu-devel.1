Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA87AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AF92173E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF9mPqNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AF92173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GIk-0003yk-M5
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3GEu-0006Nj-Q2
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3GEs-0000W6-Kd
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M46m4CKnd0h2fnbiaQwpYocPzWV6Ty9hunqocvBwXyI=;
 b=XF9mPqNQXOnUd309tLBMB2w8GGcrc7c7Rm46LHXXTpQN+CvTGfMPZVj4gwx9Dm5ugLaqa3
 m7Y4awWfylGOk0ijWLPEUjp/8mCiVB8UN90RQmhf9T0Nr4OvVb+TG7XXP85//WcTGkSHQE
 tyIdu5buc3s4xVtjx5LVOxLIJ03onD0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-CYKpt7L1O5qeTrOlAZzefw-1; Wed, 05 Aug 2020 06:01:36 -0400
X-MC-Unique: CYKpt7L1O5qeTrOlAZzefw-1
Received: by mail-wm1-f72.google.com with SMTP id t26so2523450wmn.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 03:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M46m4CKnd0h2fnbiaQwpYocPzWV6Ty9hunqocvBwXyI=;
 b=fF3k8abBNg+eoa+gToQP9lsmmox0/BMzzJz1ekdE4RZBXt4eq0OUDvANZkreqNFRtA
 +Gf1wRibwBxW5cEqLF7GlQMR98UB8DD92D8i+78utniXDnDAGvSOCIY2l0eYf7rlnrA2
 QadwP0ZJWRNNpS0a/n7VaKknoVJBjO/MVBn02lpELpBvacbcnzohJATfTLCt596LfkGJ
 YuV+SUDNbQCkE6PuQEaniUJx5mFbamS06Mn9hueBFrgBX6aG6hbgt1pI33Rk3G5XXGuI
 p8vfXoap1rvXkNSPQlg86MVU3yrBpXM3dp+NN7TQ7hXOss+riuYRbmtqQ6kbEA1mrTwz
 3t8g==
X-Gm-Message-State: AOAM5312LDIoUcdP3PtUW5YOYeoNvYIs4D7pS1brc0WDkex0cWPRnm5d
 bu/sHvvj7R5QmkHmZbgANrXIxlw1aLlkzvmk1x7c1b+7hsWBiyhgGBxKEjYr74iZHejzT1X11on
 nfz9UL/N2VSD+P50=
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr2528992wme.0.1596621694578;
 Wed, 05 Aug 2020 03:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbeQHObhqTa9jGSblN270zrEuTO6JHwmSt4e+3vPHNIUpFcXoaN3s6xQsCr3ZQVCin5T2+zg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr2528963wme.0.1596621694332;
 Wed, 05 Aug 2020 03:01:34 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id j4sm2037950wmi.48.2020.08.05.03.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 03:01:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 1/2] exec: Restrict icount to softmmu
Date: Wed,  5 Aug 2020 12:01:25 +0200
Message-Id: <20200805100126.25583-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200805100126.25583-1-philmd@redhat.com>
References: <20200805100126.25583-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


