Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BDC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A18C2073C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhktTi7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A18C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbWN-0004Bn-Qe
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iVbO5-0004ZS-JH
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iVbO4-0004RG-Ba
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:45 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iVbO4-0004R0-5Y
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:44 -0500
Received: by mail-pl1-x642.google.com with SMTP id az9so4638036plb.11
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l2vROXNnUFY1UYlqir6gW1pq2UjcxHQai6CiYsBYIgQ=;
 b=XhktTi7O5+7Mh00Z0888n3UAedn6Aa5bfPNd1m3szElA408i8Ykoyc5EOBxTZptH9U
 ogwOD4jWuWOG7EX5UYmI8eGmdGw+74fbo0X96xmoVj9zPhsLh3soZfTtZ8527EikYKAH
 hc9yEK+cZGYEvBAISOX6M7zfztJcYl8nDdXxMwcooZ9a2SdaR9oGlI+tzOalHUpZ1OTM
 jc0qQIL7o2e3CIITr0RghPuOuG1behMDb4pCVwIggls8zf+Q7ur+/gMcNgWSXa0Qy2I2
 z5JPTEZKEuBlXatiT1NX22J67hHG4bEmpQnsQR3yCSh94tIeOcQOPpfuVx9YlGR5CZVI
 tFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l2vROXNnUFY1UYlqir6gW1pq2UjcxHQai6CiYsBYIgQ=;
 b=CUap0RRcFLQrBh6EHUiP5abY63xXdStirVetUJaSI1bwuDXl1rT+SzG2J23TwHiwTP
 F9P/ur/4UnSQzuuLxES2S/ih+lLYB9EnfAAdGWBDKs9ImN8gNWeWr3eb1/q2mvpp3B3n
 6/gMJyRYfkQaQmQP80ewAGN+HXP4u9IOY3m3kW2AtMVJKf2vSiRKOSKBO0GYPJ3MkRs+
 i6jKB773HT5NvsASaUw8SCOYTnG74hnFje9+Mv08TDRdburGEFQXNakSufyg9dl9UB1k
 /bd2EOvGoMjUN0zCySf3mpr2tzp7bkDl2KCJd9Fv8JZvKazu6bhKTDPFjr32VUeO2I5l
 3Z8Q==
X-Gm-Message-State: APjAAAV6AqczT1RBmzDpBQiXGQfYoPPNfb5Q1d8+z2Ch41cpjncLuxGc
 e6+rIT/+lL4CWC/Gj4aJYEkOoV5WSOU=
X-Google-Smtp-Source: APXvYqzivQOTJ4Af1BvDdiuQCytg3NpTusky1x+ljFEzl8cB2N24NDKM4M1gj+FAf/7ZP/ely08tuA==
X-Received: by 2002:a17:90a:348c:: with SMTP id
 p12mr19372857pjb.105.1573823502875; 
 Fri, 15 Nov 2019 05:11:42 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id w138sm12007249pfc.68.2019.11.15.05.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 05:11:42 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] Added tests for close and change of logfile.
Date: Fri, 15 Nov 2019 08:10:40 -0500
Message-Id: <20191115131040.2834-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115131040.2834-1-robert.foley@linaro.org>
References: <20191115131040.2834-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

---
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


