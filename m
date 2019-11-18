Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B943208CE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w66FTDUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B943208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoS2-0005W8-Su
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWoNA-0008T1-Rt
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWoN6-0005jK-VE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:48 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWoN6-0005iw-Pv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:44 -0500
Received: by mail-pg1-x542.google.com with SMTP id h27so10243136pgn.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OGr2NFkF8BEM5m64tXfwHwGdKFCwpo8LWb1oMEbPg1U=;
 b=w66FTDUtPihHMX2BHfUySI1lShJpsxlMXYzG5sImza+QNPvc9eHpRUKKkxTC51RCcL
 BXkPNYuARmCHdBu3VcDrbaIUlOP+iIdUx491+bqhwY8qAGfyqUojCyAWjuIVGH9s6ZBT
 +AJFfJtfDZ23z9IQ6PKu6GRB+CqyvFLuJXxoM/z+qmCQxq9438GZzTVBMJNV6pduxr4g
 DChjbE2HoXNSjldpcuL1GOEgyz1l3XuNPsK8oyPEJsVkwUR1ifDGBWKqka4/F6di252+
 qOAVfZRZK84/n30BA1o6Q0XTgcdnfre5QHEVYVbqrlPNwsOME/UNZSDb9YYu63leDmqh
 +1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OGr2NFkF8BEM5m64tXfwHwGdKFCwpo8LWb1oMEbPg1U=;
 b=elwJ+pu7P8VVO/0gpFCrhaN8JwQYsj5y1UdOyDxLWqNsuQTokUOX+PVxXOv3kr4D0/
 fMoulmFcvWTBB34UEGYT8cSoDca/Feo9kQVGLZk+tZH9eMcF2i39J9pPgxFc7YF5bGjn
 9z4oWgeJyf05fq1Li373QCY0Xy/tQV/IFgWEgpRa8nftKUpSy59DuHrfMPkEEr+zQ/x5
 u7zxqpKPOmBC8LU52/j/j9tRznRCZyO/cRWph6D4ihCbsPMHNmvunDFfgLmtuKssMN7J
 UkddtR9RxHz9QiF/ZZxZsrx6H2oRgD7p1SnJ5+Wv3yuRf50LX6yckKtpSJdsjfaqTV1g
 wSvw==
X-Gm-Message-State: APjAAAWADmuwkj34mGyzK0IkzDazVrSXjQY/5l/+8kGe1D4Kd7byjYDP
 PwerKWh0pezSHIl95xFnT/G/fNIMKFI=
X-Google-Smtp-Source: APXvYqyrMd7+Mlp5RhDXACe0AzWJjc7v4uZ3R1GFYEclSaR7/PqDg+yAvoSG9QW3wzeRh+TpvYXkPQ==
X-Received: by 2002:a62:1ad6:: with SMTP id a205mr1556889pfa.64.1574111743374; 
 Mon, 18 Nov 2019 13:15:43 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id v15sm22301728pfe.44.2019.11.18.13.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 13:15:42 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/6] Cleaned up flow of code in qemu_set_log(),
 to simplify and clarify.
Date: Mon, 18 Nov 2019 16:15:24 -0500
Message-Id: <20191118211528.3221-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118211528.3221-1-robert.foley@linaro.org>
References: <20191118211528.3221-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also added some explanation of the reasoning behind the branches.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v2
    - This is new in patch v2.
---
 util/log.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/util/log.c b/util/log.c
index 4316fe74ee..417d16ec66 100644
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
2.17.1


