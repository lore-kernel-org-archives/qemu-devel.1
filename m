Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F678C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A012207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D78OqL6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A012207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSioQ-0007tS-Lm
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSikE-0003PB-M9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSikD-0006rE-FB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:42 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:32891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSikD-0006qW-AU
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:41 -0500
Received: by mail-il1-x141.google.com with SMTP id m5so1983338ilq.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=P81pi/aFpNUz2jl2QCoIMjM2nAAnpNgeMkCmUYxdLK8=;
 b=D78OqL6sJuO6eId6ZAti9eYygpAG4cYmxu5kVwbTyCftqLti4Y9nH5b/P+W6+s7qAP
 WBazpSfXp22luIACvEqGRtcI9RSCFzIujD71IO98RCFPxiGdxoQkNoMd8HU3AIwlUN/6
 bsuIEjVnb1jyJOkw+kqugMW6lE+8Dc9giPfc0ub3g7vYw5yqqUhzaydKV0D/m31i5HLF
 uIfqjSfSeAPBU8F4AgHwEo3Vu6F/IcEiI1aVrtrKdH6o5/B2xKjrlgQd/sMgnCOuuLrM
 DsOeMO2QTINbOph+Qh0T+XW5r+k8AK/t4w7spWWs2WZNzMb3iEPVsh42R7+ZEVJCKJJD
 /GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=P81pi/aFpNUz2jl2QCoIMjM2nAAnpNgeMkCmUYxdLK8=;
 b=QkEZQlAmZMBVs3SL7OqsOBVzGTWcjvwWF1O4lF6s8GiSq6/Yq4GrZInOPn1z5Kt+6Q
 nuFUC7tEEDl5PT0n0x5b/FflfeVi2RFzE0cIlSf3e90FHds0J+gvPnsQcvdfobi+70e9
 Blv5jmMJrSb8vJ5GY4mZ3hFNQXWJ1ErPMaAsk8zPdWv4u2yWLl5ta5NJkr9tM105nuEg
 UElaKaLSa+RF1UrJs/axxPUVx+sw5TtC7eqGx9z/2KS5hMl20X8tAvqxGN7ZBu+MdJ4s
 H1VWlvjlygUILDvn0PAL8LFGnkUSSyBK+fV96dC6V7jd5vIEO0fWjiAu8UqQD4HX2qvb
 SdrA==
X-Gm-Message-State: APjAAAW5ehilDaO2Iii26rPP3+HRn82KgNLeyuw25123sQwUk/9dR7qf
 ajfvlonyAogXrRxKO9pgmbVx9tcIqu8=
X-Google-Smtp-Source: APXvYqxu48to3XqyROkUJm5s69O1TOuSTxy1WI+WaPKuR4PHn3My8FMlSd7rIzEHu/EiQqfq3glYKQ==
X-Received: by 2002:a17:90a:7608:: with SMTP id
 s8mr5523373pjk.75.1573136800279; 
 Thu, 07 Nov 2019 06:26:40 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id f8sm3375502pgd.64.2019.11.07.06.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:26:39 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] Added tests for close and change of logfile.
Date: Thu,  7 Nov 2019 09:26:13 -0500
Message-Id: <20191107142613.2379-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107142613.2379-1-robert.foley@linaro.org>
References: <20191107142613.2379-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One test ensures that the logfile handle is still valid even if
the logfile is changed during logging.
The other test validates that the logfile handle remains valid under
the logfile lock even if the logfile is closed.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/test-logging.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index a12585f70a..a3190ff92c 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -108,6 +108,76 @@ static void test_parse_path(gconstpointer data)
     error_free_or_abort(&err);
 }
 
+static void test_logfile_write(gconstpointer data)
+{
+    QemuLogFile *logfile;
+    gchar const *dir = data;
+    Error *err = NULL;
+    gchar *file_path;
+    gchar *file_path1;
+    FILE *orig_fd;
+
+    file_path = g_build_filename(dir, "qemu_test_log_write0.log", NULL);
+    file_path1 = g_build_filename(dir, "qemu_test_log_write1.log", NULL);
+
+    /*
+     * Test that even if an open file handle is changed,
+     * our handle remains valid due to RCU.
+     */
+    qemu_set_log_filename(file_path, &err);
+    g_assert(!err);
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    orig_fd = logfile->fd;
+    g_assert(logfile && logfile->fd);
+    fprintf(logfile->fd, "%s 1st write to file\n", __func__);
+    fflush(logfile->fd);
+
+    /* Change the logfile and ensure that the handle is still valid. */
+    qemu_set_log_filename(file_path1, &err);
+    g_assert(!err);
+    g_assert(logfile->fd == orig_fd);
+    fprintf(logfile->fd, "%s 2nd write to file\n", __func__);
+    fflush(logfile->fd);
+    rcu_read_unlock();
+
+    g_free(file_path);
+    g_free(file_path1);
+}
+
+static void test_logfile_lock(gconstpointer data)
+{
+    FILE *logfile;
+    gchar const *dir = data;
+    Error *err = NULL;
+    gchar *file_path;
+
+    file_path = g_build_filename(dir, "qemu_test_logfile_lock0.log", NULL);
+
+    /*
+     * Test the use of the logfile lock, such
+     * that even if an open file handle is closed,
+     * our handle remains valid for use due to RCU.
+     */
+    qemu_set_log_filename(file_path, &err);
+    logfile = qemu_log_lock();
+    g_assert(logfile);
+    fprintf(logfile, "%s 1st write to file\n", __func__);
+    fflush(logfile);
+
+    /*
+     * Initiate a close file and make sure our handle remains
+     * valid since we still have the logfile lock.
+     */
+    qemu_log_close();
+    fprintf(logfile, "%s 2nd write to file\n", __func__);
+    fflush(logfile);
+    qemu_log_unlock(logfile);
+
+    g_assert(!err);
+    g_free(file_path);
+}
+
 /* Remove a directory and all its entries (non-recursive). */
 static void rmdir_full(gchar const *root)
 {
@@ -134,6 +204,10 @@ int main(int argc, char **argv)
 
     g_test_add_func("/logging/parse_range", test_parse_range);
     g_test_add_data_func("/logging/parse_path", tmp_path, test_parse_path);
+    g_test_add_data_func("/logging/logfile_write_path",
+                         tmp_path, test_logfile_write);
+    g_test_add_data_func("/logging/logfile_lock_path",
+                         tmp_path, test_logfile_lock);
 
     rc = g_test_run();
 
-- 
2.17.1


