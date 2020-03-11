Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B78C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CA0206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="VlS8t4uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CA0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4oM-0000Fg-FO
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1jC4mS-0005R9-UW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1jC4mR-0000Kp-PN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1jC4mR-0000IP-Hh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id 25so2919949wmk.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eSv9284q8MG06RruZ/p/CHxaIz5RieO9SFvqfvgFmec=;
 b=VlS8t4uKTaE1Lh2HNc6hKsAWQl/qJcaY0wQLnL76I1DwePEBUYI9EahdcUcp4fHtUC
 x/REYszirBtyEXqC1vcMzFPkqYxmq+LLp0wk3s9Q/ojXZorR7Jq2kItoa4Ml/DI/3pYw
 QsE21l/DtcgE0mazB9y4voFHWX8r1niiKSoBxd1sNAlsCqB4t6GSV4SIUXPnOsA1/7e1
 V6Epju39TvGtSDUAi48RpR2aGtTrF6LM3rY3jkh5L4hknuJPzkWB9X8wYqCsqlbLOnox
 Vspz0o71HTEBErmqVaUpL7O7K8YbsbD7w6HmHFjsPBaX4lTySNb4mXD5E5QYB/rXJP35
 7ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eSv9284q8MG06RruZ/p/CHxaIz5RieO9SFvqfvgFmec=;
 b=X2VLwhTL37RbAqOUG1u2t2EzGhuHqrS1pOc3lwR2dcrI67xkjBr2pgQyzx5yqPkdAh
 CbuB+UO9jd+yNdYuPyKRAj/Vd0lVBPmxSEKxFpOtgSwDvB2MvEu41oKM5HeD1aPRTz1w
 opbXTo0ig16xwFnvGREpWObOXwQG5GqU4H4MOqadHWW6MOx95dXPpPnSxJvgHW2iQPqc
 EgVEFZU+1YV5NRK3VQ/tD/ld3VTDLiZxAFCAKx+gxpjBAqok/R7F/+HxkwPq21249iFZ
 Kj5VoFMB99iNx0XCuzMPoQ25oMnx0t5bd7SbzD0g9P9u+tyYVw2i0hqz0iZTzxConEBi
 OTuA==
X-Gm-Message-State: ANhLgQ2pM+M9+C9Ul65BXeiRkUXYxGMEtiEJbpq1v66UgVvTxKKvMXNB
 y2+XKHelcBo+HCq+WRt5upPuiWkEFVY=
X-Google-Smtp-Source: ADFU+vuQIvX2UdDmFMa71OI/yFMNNSs+sBen2t6e+FmtBWKV1j3dK4A12GO2PKmpO5rQuDc8XFUXtQ==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr4472154wmj.157.1583946266327; 
 Wed, 11 Mar 2020 10:04:26 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-110-34-91.static-ip.bezeqint.net.
 [84.110.34.91])
 by smtp.gmail.com with ESMTPSA id o26sm8510925wmc.33.2020.03.11.10.04.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 10:04:25 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v3 3/3] qga-win: prevent crash when executing guest-file-read
 with large count
Date: Wed, 11 Mar 2020 19:04:17 +0200
Message-Id: <20200311170417.13415-4-basil@daynix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200311170417.13415-1-basil@daynix.com>
References: <20200311170417.13415-1-basil@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BZ: #1594054
guest-file-read command is currently implemented to read from a
file handle count number of bytes. when executed with a very large count number
qemu-ga crashes.
after some digging turns out that qemu-ga crashes after trying to allocate
a buffer large enough to save the data read in it, the buffer was allocated using
g_malloc0 which is not fail safe, and results a crash in case of failure.
g_malloc0 was replaced with g_try_malloc0() which returns NULL on failure,
A check was added for that case in order to prevent qemu-ga from crashing
and to send a response to the qemu-ga client accordingly.

Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/commands-win32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 9c744d6405..b49920e201 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -343,7 +343,13 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     }
 
     fh = gfh->fh;
-    buf = g_malloc0(count+1);
+    buf = g_try_malloc0(count + 1);
+    if (!buf) {
+        error_setg(errp,
+                   "failed to allocate sufficient memory "
+                   "to complete the requested service");
+        return NULL;
+    }
     is_ok = ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-- 
2.17.2


