Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA89C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C0C21D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC75JjSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C0C21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtKb-0001DZ-HV
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMskL-0003VY-Qb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMskK-0008QD-1e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:59:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601297950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bU29bJZTMasQeNNiJs3vBtDqyXAGJWgpUOEt6l9XHtE=;
 b=BC75JjSZ5lYHl9BVMcvNEjY7HRJHJYy7e80hK6W96AFsCh9rzMh6woSnK3Ly8DbufooicU
 ISK7xq8Zi8lIH4jIMm1Sls0oPf/cqLUp/s/j6le+ovmwijn6jEWmU572QFRICuVHLDoQqZ
 36vDqVPB3+NU7/Uolv7IriMxlJGN0ik=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-yHvfQN3cNhK-1Wp9JsJlxw-1; Mon, 28 Sep 2020 08:59:09 -0400
X-MC-Unique: yHvfQN3cNhK-1Wp9JsJlxw-1
Received: by mail-wr1-f71.google.com with SMTP id o6so388378wrp.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 05:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bU29bJZTMasQeNNiJs3vBtDqyXAGJWgpUOEt6l9XHtE=;
 b=m8JnF6VopScxiiGQYU1xYrIojupkP3PUujCDaRQkJpNK4+VtttjUZARRN0SLFuuYLI
 viM246eL2y1W0VeLvvPXXwuzrP7lXLjYqQH+KxQ679/IoyyEXFRJ52TUvddhsNJSi4ow
 kOYFPACkYgFWHLsQ343aMBOxU6V9f6JoVBmVcNx3FgqNbQXQo4anqplpNmfcxMkVAW0v
 RrKTqq/R7Q/YuIww3QAjtGSF0m/QzM9CqJlHtgwG49nR7aAIzKCnkdNFYyS2qMW/f96C
 E78Vc0vpD9ZSWc1e57yrFcsmAKEGmwdNvKXloXDArXojUQEPv5kCLKIAtWXNvoyFm2/X
 L4CQ==
X-Gm-Message-State: AOAM532uycOxAxKrufxHqYygQ0LdRD+KWwbfjzn2XYHFmFVVuWvJhEvK
 NZV1lkpTWwUDVNZNXWK5ulOXOJspcU7TZa0uXMo7IKfehMRQvUTvJMt2ICiglZ/CTbOv0lEsxdw
 EAZv7tmE40w6XWHY=
X-Received: by 2002:a05:6000:124d:: with SMTP id
 j13mr1702597wrx.182.1601297947712; 
 Mon, 28 Sep 2020 05:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHP9xoNeu6jyrNE81jWruhebydXnrMPVCLnP0CexOt3GmUwsUBAtmmDtx1HP6Vjschk7wS7g==
X-Received: by 2002:a05:6000:124d:: with SMTP id
 j13mr1702580wrx.182.1601297947495; 
 Mon, 28 Sep 2020 05:59:07 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d19sm996387wmd.0.2020.09.28.05.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 05:59:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] qemu/compiler: Simplify as all compilers support
 attribute 'gnu_printf'
Date: Mon, 28 Sep 2020 14:58:57 +0200
Message-Id: <20200928125859.734287-2-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
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

Since commit efc6c070aca ("configure: Add a test for the minimum
compiler version") the minimum compiler version required for GCC
is 4.8, which supports the gnu_printf attribute.

We can safely remove the code introduced in commit 9c9e7d51bf0
("Move macros GCC_ATTR and GCC_FMT_ATTR to common header file").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/compiler.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c76281f3540..207e3bd4feb 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -104,17 +104,14 @@
                                    sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
 
 #if defined __GNUC__
-# if !QEMU_GNUC_PREREQ(4, 4)
-   /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
-#  define GCC_FMT_ATTR(n, m) __attribute__((format(printf, n, m)))
-# else
-   /* Use gnu_printf when supported (qemu uses standard format strings). */
-#  define GCC_FMT_ATTR(n, m) __attribute__((format(gnu_printf, n, m)))
-#  if defined(_WIN32)
-    /* Map __printf__ to __gnu_printf__ because we want standard format strings
-     * even when MinGW or GLib include files use __printf__. */
-#   define __printf__ __gnu_printf__
-#  endif
+  /* Use gnu_printf when supported (qemu uses standard format strings). */
+# define GCC_FMT_ATTR(n, m) __attribute__((format(gnu_printf, n, m)))
+# if defined(_WIN32)
+   /*
+    * Map __printf__ to __gnu_printf__ because we want standard format strings
+    * even when MinGW or GLib include files use __printf__.
+    */
+#  define __printf__ __gnu_printf__
 # endif
 #else
 #define GCC_FMT_ATTR(n, m)
-- 
2.26.2


