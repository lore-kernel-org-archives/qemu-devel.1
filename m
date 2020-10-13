Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559F1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4594247BF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7ndtEqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4594247BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKxH-0000GJ-Pd
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKvz-0007VG-JA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:05:47 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:44436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKvx-0006KP-TV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:05:47 -0400
Received: by mail-qt1-x841.google.com with SMTP id m65so1620122qte.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UycC6Mqg0Rldvi+xLfIHf2k2nJwmsZhNp06Zk4OLYro=;
 b=j7ndtEqKZgLfhAIljTN576v9T9UpCWsu0U9cLrcooB4UsntSbD8jLHzUpXYboRcdB6
 xg24x4dJuq1mnuALDZ4kMJqlppQhKH646glr2UJe5kaF5x1YvONk2+Zm7qHJ0XRBBHfp
 Tz5IuAC4nBfmmMivSwG4PDO1BeOUw22sOu/iFiIUGPVvGXyiAnHUgCiun2c5ezeh9nFX
 vaZbC0dzmgtf70WiwI+mSNJVwmzm62rbfzirisiihcBm8LqUa+B6iZ93H3j1PwGSQye5
 7B+SyxIKRZR61/xzJVz+b1BfEccu3Gu6qiEJJw0nSBLxsJJNMEBXNf1o/p1O2pz8Uptt
 h+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UycC6Mqg0Rldvi+xLfIHf2k2nJwmsZhNp06Zk4OLYro=;
 b=PJlDpJrXJ+w9qWYOm4QZZpq1bHg78YtXT9a+XUalw2z/Ogi2B3hsB77aDkShL3yZVM
 7RGUd0oRPVsaHQWT4DLQ+OyVNYJNaZywhU8GMaOsOXkrV8mlZmkL6wkKmoBz3Iqnx/x3
 OM6k2rSxNSiVwrjKwjhYEODkdwqCnfg8CH8ZOKbhSJ+UO4jJpnQAYy8x/G3nNIl66SXP
 1m8iSI8KU4uK3PdmffBd5+A0TQxpRnLqOi+zss5xtTEcM5UnQIcX7if8nONlbLEDbOyB
 sy7hX4nqRoDTYWWXpLSnho05/30H76P40UW3R0om7EVpRi0wIa6m/eGE/dwgT9RWultW
 7HAg==
X-Gm-Message-State: AOAM530oGHhJI6EwmUE9Vk0RWTMWKMAFOnJYNrC0e6EPjzKsk3ju2xlZ
 02uBNO0KiMi9oiHhDp44pYWibxNuU38=
X-Google-Smtp-Source: ABdhPJxUcSJMH0vexXm8bfZ5KPesXIY3PrRKUllw+uhLUbCprr03cyb2b3g9FvVW/5EEWgbjfajJcQ==
X-Received: by 2002:ac8:3984:: with SMTP id v4mr15402217qte.240.1602597944593; 
 Tue, 13 Oct 2020 07:05:44 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:2df1:3321:942a:fbce])
 by smtp.gmail.com with ESMTPSA id z26sm13793609qki.40.2020.10.13.07.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 07:05:43 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] accel: Remove _WIN32 ifdef from qtest-cpus.c
Date: Tue, 13 Oct 2020 10:05:09 -0400
Message-Id: <20201013140511.5681-2-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013140511.5681-1-jandryuk@gmail.com>
References: <20201013140511.5681-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=jandryuk@gmail.com; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dummy-cpus.c is only compiled with CONFIG_POSIX, so the _WIN32 condition
will never evaluate true.  Remove it.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v2: New in v2
---
 accel/qtest/qtest-cpus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/qtest/qtest-cpus.c b/accel/qtest/qtest-cpus.c
index 7c5399ed9d..db094201c1 100644
--- a/accel/qtest/qtest-cpus.c
+++ b/accel/qtest/qtest-cpus.c
@@ -29,10 +29,6 @@
 
 static void *qtest_cpu_thread_fn(void *arg)
 {
-#ifdef _WIN32
-    error_report("qtest is not supported under Windows");
-    exit(1);
-#else
     CPUState *cpu = arg;
     sigset_t waitset;
     int r;
@@ -69,7 +65,6 @@ static void *qtest_cpu_thread_fn(void *arg)
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
-#endif
 }
 
 static void qtest_start_vcpu_thread(CPUState *cpu)
-- 
2.25.1


