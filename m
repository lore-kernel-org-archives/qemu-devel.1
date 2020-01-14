Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EACC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10D82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDCPG2VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10D82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irCUO-0005wN-QG
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 22:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54220)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3Qy8dXgMKCg4xyDu22uzs.q204s08-rs9sz121u18.25u@flex--jkz.bounces.google.com>)
 id 1irCTO-0004ov-8Z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3Qy8dXgMKCg4xyDu22uzs.q204s08-rs9sz121u18.25u@flex--jkz.bounces.google.com>)
 id 1irCTM-0000wW-W6
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:30 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649]:42946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3Qy8dXgMKCg4xyDu22uzs.q204s08-rs9sz121u18.25u@flex--jkz.bounces.google.com>)
 id 1irCTM-0000vA-Qc
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:28 -0500
Received: by mail-pl1-x649.google.com with SMTP id b4so4427492plr.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=3/g1o8RhSPCGsbPDNuvg/1lJsdGuvn96YgC53DZHyWw=;
 b=tDCPG2VSPNat9zq2qB50z6NSON2Z3KdStdEwMQypP/ijBHlHHC0e88njq8MimO9/fL
 3Gjll88y34y7IwtymYRWlqz87O5JOxKbjMztmYhbjNSjWq7vcxub5P6bQCaX+fGiO62H
 9FxgVh2aUl31RYVc+UWVc14fpaeRTHcE5369Jbx/9bEjzWodiGr/p6ekGrjMku/K8EvB
 oUHfVrd2awptmcwp+TYQH4O8v+W4Q1duf8Nn3CwoIRI2IxAqWJiMWF4X4k4ezEkfCXJF
 ZPdkD2sfODVCDe4zMGihhukb4coTkn0EnSSH6alXvBOO7qpDMrzKbVt1w3s8K/S4W+3j
 6I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=3/g1o8RhSPCGsbPDNuvg/1lJsdGuvn96YgC53DZHyWw=;
 b=aX2gHUg20BBhc53HN6h1HGmEURByLkAkIqP9Dvm6EyfA70VWkiOqAdDYg1Dba8gi4i
 nfUc8Li5Q7tEnwQjXuWRmVmVp3n/l/upXe1xacVCGlvi3o1vplym1PBdQ5AUd6/a3BLQ
 GpULWyDz08HYDSkj5Kf3zdsdRplSgBxmqsLuQQTAhojVwYGYcMNqgMAFfr/TH/6s9tMZ
 GZ8UrzkIBrVfT3mAwF5pnxf5PB93aHgHigNPnxbxIyxCA3+FbeqLt0qWzFEj3/NdC4qE
 73Bu5LjYKF4nxerUBSFOEuzWB58oa5WveNAl31WHJF0GSbnzGIGea9qdDP0nHlrrF50x
 6+HA==
X-Gm-Message-State: APjAAAVV3Hbcrk7Y+/5R1x6ys0TmvlgX2OW6UXieSXB4DBLEVUER9DfE
 cdts0FN+YvkRfkLVf/8kKoTVrueel+PIxWujGMGtVL7y7Laq2UkjzMAhwcAhZYjzuijtA7D4QRs
 gp8F3OtWxBcbVFPVNaXX//xGJD2ksYXiOMFMuvxN/iEpo7MH3FY3K
X-Google-Smtp-Source: APXvYqzXn3r9wSIe8/WzpbWxsCwxyjePh7iDQ2u4MHY8Uaj0PqA2azRJW5dzl9u+Y5B80aDUKSsoLKw=
X-Received: by 2002:a63:1110:: with SMTP id g16mr23843048pgl.84.1578970947241; 
 Mon, 13 Jan 2020 19:02:27 -0800 (PST)
Date: Mon, 13 Jan 2020 19:01:37 -0800
In-Reply-To: <20200114030138.260347-1-jkz@google.com>
Message-Id: <20200114030138.260347-4-jkz@google.com>
Mime-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 3/4] linux-user: remove gemu_log from the linux-user tree
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::649
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

Now that all uses have been migrated to `qemu_log' it is no longer
needed.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/main.c | 9 ---------
 linux-user/qemu.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 0bf40c4d27..945b6adf3a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -108,15 +108,6 @@ const char *qemu_uname_release;
    by remapping the process stack directly at the right place */
 unsigned long guest_stack_size = 8 * 1024 * 1024UL;
 
-void gemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-}
-
 #if defined(TARGET_I386)
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 02c6890c8a..329b409e65 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -210,7 +210,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
-void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 extern __thread CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 const char *target_strerror(int err);
-- 
2.25.0.rc1.283.g88dfdc4193-goog


