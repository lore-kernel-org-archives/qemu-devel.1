Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E42C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA77D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8IFiy+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA77D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtbO-0007TN-N3
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF7-0004zx-Ta
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF6-0007Oa-Te
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:09 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF6-0007N0-NR
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:08 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so8071166wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pjbTZJVQkWoecdrgqsxX2UzKvVamT9j+zNM3ivmXyv0=;
 b=Y8IFiy+eT1SteUHtWczyl6GHl2CI3iEysPHnG5JRyIpsM6WMrQVhuohLDzlFnhCV62
 dg6izOUGj3fzHCLh/mcGRQm+YXu9J7MEK+CjbeG19NZ3j4ngGMyPtR4sN4NZ0kEWGukX
 eg7S1h/iH2A5vHZ2lqpnG5NtXDislmFyOujAS5p/vqFFe9w9T+WOeEiFylTJbRVfzuwp
 cQT6ToUv2VMK5fPmyHGjGHVBcxovnCJcgkEoE641gDBJffeJzqZrPIYUo56+pXozGidC
 D4FmmcPClXeU4W4vrk/VGaBtsE4KWcN8c7EszCRzMguasuJGdbqCnYgTz/KnHPsYAd83
 heMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pjbTZJVQkWoecdrgqsxX2UzKvVamT9j+zNM3ivmXyv0=;
 b=bDP3wNWUHbpW1+RaRlg9CXWwPb+5Ln4bO2rDSHDAa5nW/knkdKhhaU5CpeRItK/1/2
 Zq3k+AD+hm5vJdqD0XG3kgtu2qzJ5+dX701upp21z0D0VhW75fpygTtkvwQtfgK6sZfs
 +AK24XOnZ2GMRALF7JskSHrTavXwof6KcLT9wHmjG5Pn3rKoU0fIGAMFeTh1WP6xr5M7
 YTL9HQJgHYO8uPixC2XqZsYXKyTT6E+HEjEUFOLvKETIIdqFDa1FW5wH4jU3yEsqxsaV
 HQ06+e0lThEI3zFPUUyqiq9p097i/A9lsOlPSqVkL3ZMDODDFBRIuza48Slv0Jm8iXtS
 s7eQ==
X-Gm-Message-State: APjAAAUVEDuq50tgzF7atRJOJ2qc61o5FhdTTzB6mi7oCm2oqHMHT5GE
 5Ubsb3Yuao4f08H+DHZ9Z+ov4Ibz
X-Google-Smtp-Source: APXvYqxFzQz3KzrPXQa+UM1slSEDO1diog/8M6VnDnnhX3qo6PMbkYitU/G0OovAiGTFGAGlgdj8zg==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr30482915wro.195.1576513747579; 
 Mon, 16 Dec 2019 08:29:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/62] vl: warn for unavailable accelerators, clarify messages
Date: Mon, 16 Dec 2019 17:28:04 +0100
Message-Id: <1576513726-53700-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far, specifying an accelerator that was not compiled in did not result
in an error; fix that.

While at it, clarify the mysterious "Back to TCG" message.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 9bd27e1..46e4ec3 100644
--- a/vl.c
+++ b/vl.c
@@ -2848,6 +2848,8 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     int ret;
 
     if (!ac) {
+        *p_init_failed = true;
+        error_report("invalid accelerator %s", acc);
         return 0;
     }
     ret = accel_init_machine(ac, current_machine);
@@ -2902,6 +2904,9 @@ static void configure_accelerators(const char *progname)
              */
             if (accel_find(*tmp)) {
                 qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
+            } else {
+                init_failed = true;
+                error_report("invalid accelerator %s", *tmp);
             }
         }
     } else {
@@ -2921,7 +2926,7 @@ static void configure_accelerators(const char *progname)
 
     if (init_failed) {
         AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
-        error_report("Back to %s accelerator", ac->name);
+        error_report("falling back to %s", ac->name);
     }
 
     if (use_icount && !(tcg_enabled() || qtest_enabled())) {
-- 
1.8.3.1



