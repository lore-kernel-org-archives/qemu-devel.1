Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F6C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7277C20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPbXCAXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7277C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j021o-00074d-MN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01zA-0002vP-D5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z9-0005nY-8U
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:48 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01z9-0005kY-1f
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id w15so2300332wru.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dX/a2gresk53+psqLbyuBofhTGzw6h0OJ4TRN4KF5Rs=;
 b=sPbXCAXk5cCzYRP0ufajfHkLOm40bdnTZL4Hre7sKhylpHb0uDyPJdHsQu6PgUx93X
 csd5PCRxJ3lh7sUzaRJEsHU+YRJ0Ogb+N5HU6xrJWcjWc13VG3EAZvMxRJV6YZg0jL8V
 7gpx6O83rLxeeQEY2iCm9e4mvv4CnFVfKfHq9nc0SIX+1Z+gtHQhLfm5vxRBUIlIXwam
 fDLYPbWPYNVrOHHkoSaucX22rztsdme8bZ3+ZJ5dmyQc6Mcam8W3O/C1BB3fKybU68Bs
 L/28HUdo9l9ESuaI8Tu4ymu3hajTREp6XL+bNvRPyyRkU0terIiWc7CarVsd7AIhJgkU
 /KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dX/a2gresk53+psqLbyuBofhTGzw6h0OJ4TRN4KF5Rs=;
 b=RFyFcarYmMVmGx+jRqoK7sHFemEflQq7J5/5LOTfFLv5IaLS8KpkUUh9+KhLkeqyzw
 jm5IAWm7H1mF/7P+32baVfBqw8Zs3ori1SmQ+Gy2Aiwb/QluWrzv1HxXoOTT69FnJXql
 9b9pguyNTdgfR/IX7OePIQssXK1ZrMqWz6OyZO9LEZQERrVQDRn0lia6OMUses8lrQ4H
 qMDGFL6MeQOXHF7BlxjoX/AWmgIhrunQtQdFjD/sB59c+Y2pIDR0KfXXs0aCeQfJzUDh
 7dmXL+bSacU9cyJwgyZ9a8x0nJXVH7utA4hpIgxnUl9OsyaRsHifU96UM1u6Ig933Xuc
 Dtvg==
X-Gm-Message-State: APjAAAUcvvpqTSfLKLISyI71vyEw8h7rCd+ievbB1PNaUg8AiO602V5C
 0bPPlLY5TAD0NGtdrupLpz3Lcw==
X-Google-Smtp-Source: APXvYqwBc5GdkCbXOFLbzeAleQ6dHS6EoRhNNtXh3B64bZblbUWXLkmY1o/gyfTkZVlWw2WZtVK+qQ==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr4500676wrq.178.1581075586034; 
 Fri, 07 Feb 2020 03:39:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm3039338wmj.33.2020.02.07.03.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:39:42 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C6D021FF91;
 Fri,  7 Feb 2020 11:39:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] tests/rcutorture: mild documenting refactor of update
 thread
Date: Fri,  7 Feb 2020 11:39:38 +0000
Message-Id: <20200207113939.9247-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207113939.9247-1-alex.bennee@linaro.org>
References: <20200207113939.9247-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mainly to help with reasoning what the test is trying to do.
We can move rcu_stress_idx to a local variable as there is only ever
one updater thread. I've also added an assert to catch the case where
we end up updating the current structure to itself which is the only
way I can see the mberror cases we are seeing on Travis.

We shall see if the rcutorture test failures go away now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/rcutorture.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 256d24ed5ba..9559f13cd1f 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -236,7 +236,6 @@ struct rcu_stress {
 
 struct rcu_stress rcu_stress_array[RCU_STRESS_PIPE_LEN] = { { 0 } };
 struct rcu_stress *rcu_stress_current;
-int rcu_stress_idx;
 int n_mberror;
 
 /* Updates protected by counts_mutex */
@@ -288,29 +287,48 @@ static void *rcu_read_stress_test(void *arg)
     return NULL;
 }
 
+/*
+ * Stress Test Updater
+ *
+ * The updater cycles around updating rcu_stress_current to point at
+ * one of the rcu_stress_array_entries and resets it's pipe_count. It
+ * then increments pipe_count of all the other entries. The pipe_count
+ * will be read under an rcu_read_lock() and distribution of values
+ * calculated. The final result gives an indication of how many
+ * previously current rcu_stress entries are in flight until the RCU
+ * cycle complete.
+ */
 static void *rcu_update_stress_test(void *arg)
 {
-    int i;
-    struct rcu_stress *p;
+    int i, rcu_stress_idx = 0;
+    struct rcu_stress *cp = atomic_read(&rcu_stress_current);
 
     rcu_register_thread();
-
     *(struct rcu_reader_data **)arg = &rcu_reader;
+
     while (goflag == GOFLAG_INIT) {
         g_usleep(1000);
     }
+
     while (goflag == GOFLAG_RUN) {
-        i = rcu_stress_idx + 1;
-        if (i >= RCU_STRESS_PIPE_LEN) {
-            i = 0;
+        struct rcu_stress *p;
+        rcu_stress_idx++;
+        if (rcu_stress_idx >= RCU_STRESS_PIPE_LEN) {
+            rcu_stress_idx = 0;
         }
-        p = &rcu_stress_array[i];
+        p = &rcu_stress_array[rcu_stress_idx];
+        /* catching up with ourselves would be a bug */
+        assert(p != cp);
         p->mbtest = 0;
         smp_mb();
         p->pipe_count = 0;
         p->mbtest = 1;
         atomic_rcu_set(&rcu_stress_current, p);
-        rcu_stress_idx = i;
+        cp = p;
+        /*
+         * New RCU structure is now live, update pipe counts on old
+         * ones.
+         */
         for (i = 0; i < RCU_STRESS_PIPE_LEN; i++) {
             if (i != rcu_stress_idx) {
                 rcu_stress_array[i].pipe_count++;
-- 
2.20.1


