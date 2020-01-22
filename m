Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C40AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5AB24656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFYDrYzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5AB24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu69b-0002D6-2E
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65e-0005Tp-RW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65d-0002is-RH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:58 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65d-0002iS-M0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:57 -0500
Received: by mail-pg1-x544.google.com with SMTP id r11so2650178pgf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xHv4f0JmN5WxUUYKqDgfyhWuDMzuO34D5maeyp28uZ4=;
 b=NFYDrYzsEiXiFYYbW4USPAmua5f8Npmj+m+mYCEudC0NUWYWZ2faantl21NKuTQ8q4
 631VKIcE4qB6Ez9P5IOl27kU9PzawLNgoYZ7nNYrIJTy5Bm/0Rk73kA7X3hQiAPP08EK
 voYasp1iDBFICU7at5mpngeytBIsn3cXB7vfCAARM7yUmV0Q85a+cswosVXHsXMxvifH
 Uhohre08e44uN+Z+J0iiPSt5s/hXG3K/HsnAVOszP7aTXUREiAZr/WK4zGBzg0+Mn+CS
 pUKChB4Nh0neSoMhrF8MqJpgekOFw0YcGf1pfFeP7hG8u9WhSSmyZV39kCCK1wnb+Cxv
 Ik1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xHv4f0JmN5WxUUYKqDgfyhWuDMzuO34D5maeyp28uZ4=;
 b=R3J5RoBQtD0sqG8pzobLP9IOdHKrU7+fImhHI6T5YcMWZGFihJdy+DrZmoQDt0qukF
 c2e8sA7otqro3E9uh25W866nO45GBbePuohoSr/EKR7ZMvX7w0bBa/Muhzbs3MybItt+
 hl1bbWzFQ6+b1Z70smKiwZNsXIKn88d/iW3wUHPyHnoJ4eLt7BgcGbEJlFy1XJsCJksZ
 kartVi1+9HxbC33s+ZI1uUD/yoYKdLetzqUHM9hq8FvfMJawzQo8vMGmIFOLcEmHlBZF
 sE3js41Pv0hmBoZqJuK1f1Mgg2c9I5yZyZU40Tmg9cm+J02vgV26rAsz+v0PPPq0SaEd
 xFrA==
X-Gm-Message-State: APjAAAWTJ7y58zmZBEx3fMGD/OBnRko7YFCs1Lcq/y6FiaSR0OXs3Wu2
 Uqtp3t1VuR2Mf0pd+9GVcBSvih6pVaw=
X-Google-Smtp-Source: APXvYqxDP1hX6sU/hqn/k8qPf2sb8xq47lVzm+qDTCZ0/iOCE+pvm1Y5vm9DH0jKiEs6OXFqLHwYIw==
X-Received: by 2002:aa7:9729:: with SMTP id k9mr610452pfg.72.1579661396404;
 Tue, 21 Jan 2020 18:49:56 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:49:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] vl: Reduce scope of variables in configure_accelerators
Date: Tue, 21 Jan 2020 16:49:34 -1000
Message-Id: <20200122024946.28484-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

The accel_list and tmp variables are only used when manufacturing
-machine accel, options based on -accel.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index da5bf2de27..94c9301e7f 100644
--- a/vl.c
+++ b/vl.c
@@ -2755,7 +2755,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 static void configure_accelerators(const char *progname)
 {
     const char *accel;
-    char **accel_list, **tmp;
     bool init_failed = false;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
@@ -2763,6 +2762,8 @@ static void configure_accelerators(const char *progname)
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
+        char **accel_list, **tmp;
+
         if (accel == NULL) {
             /* Select the default accelerator */
             if (!accel_find("tcg") && !accel_find("kvm")) {
-- 
2.20.1


