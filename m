Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C22C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94DD205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bs6cLFRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94DD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFIo-0004mr-Ng
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwi-0003TH-Vq
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwh-0000tF-QC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wMp/XuOBwT8pOPQVaxGqTdCRCcjqyuE5pzfypPMZ2U=;
 b=bs6cLFRkfj7Bune6ns/LgYLcaQbWav1UkdD5sWnX9x8NqKKOVpW6k++BBOucG7iENIVlSz
 h4FIPNUKyUw0CxPQBBRe8jWv3bKyV1TtkhZRF3uS4lxNnZfwgbNBxhRZKe2QU2IXeMIk4G
 2NLqz6xRUTgF3HUo2YdQI5Sky44xr6E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-7Yrlo0N2Mr2-1KpsFrzAgQ-1; Thu, 14 May 2020 10:34:45 -0400
X-MC-Unique: 7Yrlo0N2Mr2-1KpsFrzAgQ-1
Received: by mail-wr1-f69.google.com with SMTP id g10so1670132wrr.10
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7wMp/XuOBwT8pOPQVaxGqTdCRCcjqyuE5pzfypPMZ2U=;
 b=A2lNT4TyKebbm68Dese7vAr0QCLzi2uuJ3WTcPueco8O0/Pp0iv7rbt1PCI4Fr3GI3
 FAgRjxf2EbUnJKVET6e2EV5/c5UGdNYjt7i7s5ZbokaDDqoeo1c/nzxeCO/Zsuj28IN0
 o9AZZJ+0/Z4krDiH9x3qjZPwu3WUQ/mBMrJd6ObKb4v/5dyYEa1qtNg1npF23siq0gHf
 fxImr6XAAKwDnfTtqHwRpp2F1+4r0PwB9D3Q007F9oIYzP/qSb8SPcypfQURfKNLuN/9
 cgo8EUhKok0nwY2b6D/muAX9k2zUQ4db54QXKYS0J9J4W2ZBl/w0ilRLMeLQgFeOHV5a
 fu2g==
X-Gm-Message-State: AOAM531e+D0vqNiJh9PuLMo8Q+GevI8CkpX9D4NSFIc9JwgAMESH3wMq
 RXU01CHSFPyO/MDGNvi1EI90GGVtGLFJV+mHRv2t2AzYoDxKS8ZXJEjFvA6oKcvriEVO7HCHz+J
 CiLmhPqvb/0NqlVM=
X-Received: by 2002:a5d:614b:: with SMTP id y11mr6175874wrt.77.1589466884269; 
 Thu, 14 May 2020 07:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0HLo6T+C3GXvIMYkzIEsH9/8M7eocEEV031RX83rgxNeAAkwQTaYu0mnxQVUxzzcpWtmqMg==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr6175852wrt.77.1589466884075; 
 Thu, 14 May 2020 07:34:44 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h1sm40860124wme.42.2020.05.14.07.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:34:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] Makefile: List fuzz targets in 'make help'
Date: Thu, 14 May 2020 16:34:29 +0200
Message-Id: <20200514143433.18569-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

List softmmu fuzz targets in 'make help' output:

  $ make help
  ...
  Architecture specific targets:
  aarch64-softmmu/all            - Build for aarch64-softmmu
  aarch64-softmmu/fuzz           - Build fuzzer for aarch64-softmmu
  alpha-softmmu/all              - Build for alpha-softmmu
  alpha-softmmu/fuzz             - Build fuzzer for alpha-softmmu
  arm-softmmu/all                - Build for arm-softmmu
  arm-softmmu/fuzz               - Build fuzzer for arm-softmmu
  ...

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 34275f57c9..40e4f7677b 100644
--- a/Makefile
+++ b/Makefile
@@ -1252,7 +1252,11 @@ endif
 	@$(if $(TARGET_DIRS), \
 		echo 'Architecture specific targets:'; \
 		$(foreach t, $(TARGET_DIRS), \
-		$(call print-help-run,$(t)/all,Build for $(t));) \
+		$(call print-help-run,$(t)/all,Build for $(t)); \
+		$(if $(CONFIG_FUZZ), \
+			$(if $(findstring softmmu,$(t)), \
+				$(call print-help-run,$(t)/fuzz,Build fuzzer for $(t)); \
+		))) \
 		echo '')
 	@$(if $(TOOLS), \
 		echo 'Tools targets:'; \
-- 
2.21.3


