Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA2C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810E02087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6jhPu+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810E02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6EE-0008UT-Cg
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65k-0005bt-2m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65h-0002kY-HA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:03 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65h-0002kC-Ad
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:01 -0500
Received: by mail-pj1-x1042.google.com with SMTP id d5so2383858pjz.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2rUEM0gwnbOEePRjkDj6MANZGx/QWCSdQiyiEsobitQ=;
 b=L6jhPu+qwOtZaprrpA9lBOjcOWjdsHQU53tfQivMEMDzLVZ8PeM2++n7oVPig9QFtD
 8l0IunoTgc63/g8Yu36geQ3Y1yS1sbuk3jAZgktwbSdfqAiIIfAtRiCTlpeMNUuwk3m+
 WP9krt/o81SeM713J/zlMw39/2fy1IhE7PcU8GGW75QAR7Mh91PUY9/jBr/1ZGoI56Wf
 XsrAcgd1Fs4rAAJ0wHvw3Ypdp4RW7suMyh9GExXUfCpxRfbRhoxPxRiM9n6PNj7yiT5j
 4s9r17Fk7HbdiFvRRsAiWxyYyejepBB7X+Jfp8B3aANV9FChrMmOqDkRvj/6KF9DK5x7
 rxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2rUEM0gwnbOEePRjkDj6MANZGx/QWCSdQiyiEsobitQ=;
 b=YonZy2RIeykRdhDKpxXTIuF7bZKw31SSp1Es9864wpy775EaOqiGLlLakdYu84L6c2
 wmY7YB9hPzSFx6wdMAIh86m/Ix0DSegOL1sx91C4qV9HlW56TPKtEHct2dTlvzdKgGVh
 rLbWuindw/lAzrHi2Je10YWbBIPpLyv/JBziRMaKIlIYHMcgI+Tw4dTxSoNAGq7UNp1L
 w6aXo36iof0Re31GaMqDJDN8/66Mq1BBG1n+nREeMHKuJXhv+4LVdNZ1vKTF4CflQ/h6
 t0l5qVmCrXRY8S2SqbW4mjGDu9FuCN8wM9KsmoURXaQ1vUkTxx58qiHbY1Dxh544oIg1
 UBpg==
X-Gm-Message-State: APjAAAWRPFrwGWBgqK19KK3MPhXK67rb7+qLoSSQ72wWgbSUW+wZF2vz
 GITCdbDLZbvzFPopkrmwGCXh9nF9GLQ=
X-Google-Smtp-Source: APXvYqyH9PJVNPKJBbtdIxv6O+KwFD9AglAKOL5yk9SoR+qY64Dcn7xoE8qLnlzNGLVYz8zBAqvS1w==
X-Received: by 2002:a17:902:7296:: with SMTP id
 d22mr8926428pll.55.1579661400071; 
 Tue, 21 Jan 2020 18:50:00 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:49:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] vl: Only choose enabled accelerators in
 configure_accelerators
Date: Tue, 21 Jan 2020 16:49:36 -1000
Message-Id: <20200122024946.28484-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By choosing "tcg:kvm" when kvm is not enabled, we generate
an incorrect warning: "invalid accelerator kvm".

At the same time, use g_str_has_suffix rather than open-coding
the same operation.

Presumably the inverse is also true with --disable-tcg.

Fixes: 28a0961757fc
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 1e5e9b9aeb..4c5033842c 100644
--- a/vl.c
+++ b/vl.c
@@ -2766,21 +2766,26 @@ static void configure_accelerators(const char *progname)
 
         if (accel == NULL) {
             /* Select the default accelerator */
-            if (!accel_find("tcg") && !accel_find("kvm")) {
-                error_report("No accelerator selected and"
-                             " no default accelerator available");
-                exit(1);
-            } else {
-                int pnlen = strlen(progname);
-                if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+            bool have_tcg = accel_find("tcg");
+            bool have_kvm = accel_find("kvm");
+
+            if (have_tcg && have_kvm) {
+                if (g_str_has_suffix(progname, "kvm")) {
                     /* If the program name ends with "kvm", we prefer KVM */
                     accel = "kvm:tcg";
                 } else {
                     accel = "tcg:kvm";
                 }
+            } else if (have_kvm) {
+                accel = "kvm";
+            } else if (have_tcg) {
+                accel = "tcg";
+            } else {
+                error_report("No accelerator selected and"
+                             " no default accelerator available");
+                exit(1);
             }
         }
-
         accel_list = g_strsplit(accel, ":", 0);
 
         for (tmp = accel_list; *tmp; tmp++) {
-- 
2.20.1


