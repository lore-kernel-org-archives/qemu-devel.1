Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCBC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4981920700
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adxlnLeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4981920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igog0-0001B0-1N
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoMu-0008M5-Rf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoMt-0001nd-Me
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:16:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoMt-0001n8-GQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:16:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so6721802wrm.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g5Hton9Ll56kdz1LBD4VBc8EOQODiYzIByAV4cwmIMQ=;
 b=adxlnLePea+1R2MHKgZeckQIKKiYo8aohlZ3k0K71Qd3T13bx8KeR5qHiZNxeO1lY0
 /bfKeB9iLTeXyKHkgQLyONoHvFD+7O1vv6nTACU3Kl1BZ3SgakoDlvD2hfssaXK3eE2W
 yxNKAaIrb9zcpmsp9o6LFpaj8U2BA7omIKpymBvHa6sb2MGqED9feomY7gIsnE77RlwI
 +IgP4dFHx3ydjs1Vwf514tezgqlirWa/A4HRoA98INNV7Fwxm5jvleQB0u85tLNScHId
 RFcPLiB473J3LTs5W+NaWwBPofwYvb9S4vOSATGUCRHVsKLH69/mZAyeoprZtH/p7zii
 ykFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g5Hton9Ll56kdz1LBD4VBc8EOQODiYzIByAV4cwmIMQ=;
 b=EBEYAqYD319066INmAhlCEyjZca3f9Piaoun3wp0go7Ymxrbqr84mjsLmAUiZcE3Bx
 EX8/cyNWJ1h1ol6iIdf5FwAZe3/7sOi8jT0vmzGx4HR6/UKgW0qEFwtKeTGhv6r63/2l
 PDllv0UpLA4zgT8+LdbP9YTTDGgDIqwee7R/YGcwHvOlFcYKMYdO/x4MAwwXIfuKhQvN
 IEl5Ha8Yc76V1rB+a8a4PSoPC4giXFeXrQxvwUEuk8mKxeXlx5/fQBM/AhC7emL2yozW
 yvh+dn4eRewqr3Cyv0pwX54ndeaCqx2Q7V8RQxB34DJjg0BtP40USI/4Wx3EWS8p5oD0
 e1hw==
X-Gm-Message-State: APjAAAWqiV81vYpq5bZiOpKqAuz4qv60H/Qm4LaYnVM6wznk8KB/EmaH
 Z8UscSui3bfKwPQm/fd5T2ie+w==
X-Google-Smtp-Source: APXvYqwLca8B+qO00U7g1tyvKCQ906VKhP0ByN6/wt1RR+mr/Wx2DyrgPMfdwyJmgoTVENk5gE4f7Q==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr28592175wrt.208.1576495008979; 
 Mon, 16 Dec 2019 03:16:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h66sm1793582wme.41.2019.12.16.03.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:16:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 412A81FF9C;
 Mon, 16 Dec 2019 11:07:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 12/16] Cleaned up flow of code in qemu_set_log(),
 to simplify and clarify.
Date: Mon, 16 Dec 2019 11:07:28 +0000
Message-Id: <20191216110732.24027-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Also added some explanation of the reasoning behind the branches.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191118211528.3221-3-robert.foley@linaro.org>
---
 util/log.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/util/log.c b/util/log.c
index 4316fe74eee..417d16ec66e 100644
--- a/util/log.c
+++ b/util/log.c
@@ -54,12 +54,25 @@ static bool log_uses_own_buffers;
 /* enable or disable low levels log */
 void qemu_set_log(int log_flags)
 {
+    bool need_to_open_file = false;
     qemu_loglevel = log_flags;
 #ifdef CONFIG_TRACE_LOG
     qemu_loglevel |= LOG_TRACE;
 #endif
-    if (!qemu_logfile &&
-        (is_daemonized() ? logfilename != NULL : qemu_loglevel)) {
+    /*
+     * In all cases we only log if qemu_loglevel is set.
+     * Also:
+     *   If not daemonized we will always log either to stderr
+     *     or to a file (if there is a logfilename).
+     *   If we are daemonized,
+     *     we will only log if there is a logfilename.
+     */
+    if (qemu_loglevel && (!is_daemonized() || logfilename)) {
+        need_to_open_file = true;
+    }
+    if (qemu_logfile && !need_to_open_file) {
+        qemu_log_close();
+    } else if (!qemu_logfile && need_to_open_file) {
         if (logfilename) {
             qemu_logfile = fopen(logfilename, log_append ? "a" : "w");
             if (!qemu_logfile) {
@@ -93,10 +106,6 @@ void qemu_set_log(int log_flags)
             log_append = 1;
         }
     }
-    if (qemu_logfile &&
-        (is_daemonized() ? logfilename == NULL : !qemu_loglevel)) {
-        qemu_log_close();
-    }
 }
 
 void qemu_log_needs_buffers(void)
-- 
2.20.1


