Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D01BC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437EF20726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3+G7rP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437EF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKaS-0005Z6-MI
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXv-0003R9-6B
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXu-0001LO-41
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXt-0001Jh-T5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id g206so15858045wme.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ao+CKbm0NQNbGegskrGYo8y8CuAn4vbfunlF0Syx/cM=;
 b=d3+G7rP0lWhKEOvGVFGS42Smio2d6mWODdRa4p89XmAkmd14rHSEgH43uqbrhF3EG2
 uzqo3NqVCCCewGxfc4ylTxALG9qzdGMVhHjn6aAohz4wtX6RBoeDsUaPCAZhQEVb+Jb9
 0L+wSB561BwQ6GZ05NmKzluLyyKcK/+CzjlxhfqQ5Ly5KYnkQCu3UF5v12cVFMtpNq8f
 XKf/V5gWNViQes+x63z/O41FD7DC5ACw2WEZz18ANxzSbTgcrXk0YmuGxkVdL1+dHQS4
 fVuj/SQG63CVTp2+EvpJ4RgcDYuj3TPH3vCoIw3MQSal6stVmd7TYr+GOXljqskwDFKH
 Pq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ao+CKbm0NQNbGegskrGYo8y8CuAn4vbfunlF0Syx/cM=;
 b=T9m3vuNVIBsODq3eNgjoZmcWyIS1xK1v6eQT3WKKBoVSAxECB9pa9lrbl8eTnNMSh3
 WW+GT05m5MsOOpqw1MzKntOvUt9qF/ca9YWYVHxNiaktGCq/QRMVFaYSW+W43FZaiy/Y
 N0RrTCzEJd0pMZvn9Q85bCKIH2UXr8n9tvIxE1HamvP19Ymt1wlnvDIk6Xot7hzA8XIj
 d4smGlKPuHUaAEpImJJNJU+452eGQs6uMQrvz97Zj7qn3USBQD1MxI73tdA3IbmANeKg
 O9TlCq98zULsJkZsaaNS91JmZgyTbjf7YJjW3V08c0RlOeA7dBhc0OsLaeQAM/hG3Yp6
 D4Pg==
X-Gm-Message-State: APjAAAXjujhZ8CeXZEEqAz02hVkMGzgxXbg5npWZcfmzjt09m7cm6SNU
 vz9qpvCZBgwc084C6SyGH2jEnCqh
X-Google-Smtp-Source: APXvYqwrtK077Y9tfRzN7DJHYQFIOmAyRcECmdZ9rE0hwHbhOKTeP2u/q2KflY6s3w8dJhpcHvjEfA==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr13037613wma.32.1575903716730; 
 Mon, 09 Dec 2019 07:01:56 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/18] vl: warn for unavailable accelerators,
 clarify messages
Date: Mon,  9 Dec 2019 16:01:36 +0100
Message-Id: <1575903705-12925-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: thuth@redhat.com, elmarco@redhat.com
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
index f0cb438..58aad4f 100644
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
 
     if (!tcg_enabled() && use_icount) {
-- 
1.8.3.1



