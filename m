Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C146C21872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shS4+Yob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C146C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXiO-0007GW-Ce
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgf-0005yX-90
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgd-0002LY-Up
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:33 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iUXgc-0002KC-Nj
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:31 -0500
Received: by mail-pf1-x444.google.com with SMTP id z4so13498415pfn.12
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rb+rwwDtLFyVaqPrueQVfE7R//yL4u5e6ReAZf9CRts=;
 b=shS4+Yob2T10+TBH7EpS7n8xqgnny/KicLtIVo3u0KVgTP+P5xXtOj+6gRDtuDMIFf
 ACWEUdU0IM+aBHHWg25ALdGaaXkY6vMSTs4ijVPnrTl1u17lJVRjVz0PQbuF0ukKmSmQ
 HD5Z7ZIeVQI+gmGFcqRIElYsX+RNESVfTKAxtGWV1UgVyoMEi7l/HMdjyLu14IoD9I/K
 1U56f4D6PXsnkdwNF1dINYP4+cONHwIYnaCiFGCCr6Bzw/kT3hZ70gbNH9BG2BZuldS3
 W8EQLjMwbbYkQL7iKcqgRA4EXyyC9h4ROgLHoBtDJQ0CZ06k1Uxqtx4cTkT2VJFKKQc8
 wxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rb+rwwDtLFyVaqPrueQVfE7R//yL4u5e6ReAZf9CRts=;
 b=ehGYMNxF9R5xqYonLAQL5n2fA5Y8u5nQbVFKHK1/HmvbOHVhH/cs2QeLfHQNgPyhFB
 CrCiPKERTNZGBaGnLfrF7ly4jHEiVDZx6vBbTY6kE36w3TwdFvQ3Ej3vP4dmJp1PD3Dg
 dF4GVdZTm+Z2hsYoYdzHuKak3DNatV3FRB0kOMr/2UfdDRGQHLujgxlSTNC4eEBEpw/Q
 cqKmup9rd5kaNmxaWsZiE5EFUJw5v/91yE0NxMJCVF+SXtuUlMnU7MSgrjV5vzCTEhLy
 STfEhScEoZp+uxIpAWtjh1wMXl1HPx+NKpceoJNuBeTVyW7frhLWCk5uR0T/Bc1Ptt6O
 StEA==
X-Gm-Message-State: APjAAAXOYVP4SmN8Y8KFmgUhFz+Ziw2Jrjg7WB8KLHre+rXFMJZn1dpX
 N/wCqdhkwH9JxtEw9anQjTSFfSs4BH0=
X-Google-Smtp-Source: APXvYqz5mweUN4ztCDtRcE94U2VxoV2dCK8+OX2pRtSMnH6ehFpuV99a4Ehidq+7LroM8F6WCaTcpg==
X-Received: by 2002:a65:5885:: with SMTP id d5mr34710063pgu.278.1573570949400; 
 Tue, 12 Nov 2019 07:02:29 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id a3sm8235511pfo.71.2019.11.12.07.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 07:02:28 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] Added tests for close and change of logfile.
Date: Tue, 12 Nov 2019 10:01:04 -0500
Message-Id: <20191112150105.2498-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112150105.2498-1-robert.foley@linaro.org>
References: <20191112150105.2498-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
--
v1
    - Changes for first round of code review comments.
    - Added in use of g_autofree, removed the g_free()s.
    - Added in use of logfile2 and changed sequence of asserts.
---
 tests/test-logging.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index a12585f70a..1e646f045d 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -108,6 +108,82 @@ static void test_parse_path(gconstpointer data)
     error_free_or_abort(&err);
 }
 
+static void test_logfile_write(gconstpointer data)
+{
+    QemuLogFile *logfile;
+    QemuLogFile *logfile2;
+    gchar const *dir = data;
+    Error *err = NULL;
+    g_autofree gchar *file_path;
+    g_autofree gchar *file_path1;
+    FILE *orig_fd;
+
+    /*
+     * Before starting test, set log flags, to ensure the file gets
+     * opened below with the call to qemu_set_log_filename().
+     * In cases where a logging backend other than log is used,
+     * this is needed.
+     */
+    qemu_set_log(CPU_LOG_TB_OUT_ASM);
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
+    logfile2 = atomic_rcu_read(&qemu_logfile);
+    g_assert(logfile->fd == orig_fd);
+    g_assert(logfile2->fd != logfile->fd);
+    fprintf(logfile->fd, "%s 2nd write to file\n", __func__);
+    fflush(logfile->fd);
+    rcu_read_unlock();
+}
+
+static void test_logfile_lock(gconstpointer data)
+{
+    FILE *logfile;
+    gchar const *dir = data;
+    Error *err = NULL;
+    g_autofree gchar *file_path;
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
+}
+
 /* Remove a directory and all its entries (non-recursive). */
 static void rmdir_full(gchar const *root)
 {
@@ -134,6 +210,10 @@ int main(int argc, char **argv)
 
     g_test_add_func("/logging/parse_range", test_parse_range);
     g_test_add_data_func("/logging/parse_path", tmp_path, test_parse_path);
+    g_test_add_data_func("/logging/logfile_write_path",
+                         tmp_path, test_logfile_write);
+    g_test_add_data_func("/logging/logfile_lock_path",
+                         tmp_path, test_logfile_lock);
 
     rc = g_test_run();
 
-- 
2.17.1


