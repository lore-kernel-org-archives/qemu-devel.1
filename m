Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F7C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7D9206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvqY0DFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7D9206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sBY-0003y1-Ro
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnU-0004eD-Tz
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnS-00072p-Ey
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnS-00072E-1j
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so8933470wrj.6
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SXBAqhquP2Lg4Ybq8pMEcyecszVWdFjmxwIvTxGKiO0=;
 b=WvqY0DFd3ahqD6PJc4Eokd0KPmTwnsPDUrgGli1ZJcCrndiQ/uMwDHtK0sdf3eGS5C
 nYTbZaAdtBA3hgjGz4Nh5apol5XdJuqIw8Nh1UqDZdZz9osomXyL8A/vCgshougEdl1G
 M/DrmVa6Ch6xN2ldAa1AY7OL0XBUcra2+1pVjbCIbmBE/sX000qN7tUJVBxFxJzwRXMl
 WpiEY1M8oDhUgu4howcH4ZfEQ9qK5JCMspsYPgL/deMaWoUSMdgSI0/zOMa0KXlE7Sgs
 XO7PET144AhppOFjte9qO/UGSk8Nvpmzf1uSxvJF60Gb6OOsuSuFBGCOIxOfYbAgEXLt
 ciyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SXBAqhquP2Lg4Ybq8pMEcyecszVWdFjmxwIvTxGKiO0=;
 b=V3gwwiZMnMX/2XlIDdJOFUXKgIYrf5vtTEOsBSAS30jawxe6Cdh6VjTtZrlefZwHo8
 uqjjw/s39RxHTFSRBYaowmVVeC1Qp6QxkitJ4jYBSBUoAdVUShhMPsK+cNu693Dd2yN6
 XNdgjyh24MENvKzDopo+NmfyEEg0mLrXodjURyJ2iZzKlwb8GttSiTitBXiiGKBJk9dc
 7XD8c8/jpvopKIs4bq3zrtdIDKYgkwmAAXbar9PtxJivkI4GXj8u5P/e+E+IZ4y3GQRE
 X8p6oPmcUXSKTw6eZFeOErU+GFlNrhiC8fOzdx8Z2uurPldDth4gbzLrroZFaDPDaM2D
 pfdA==
X-Gm-Message-State: APjAAAWgRLcqCRF69G/sHoYXu/vbGmJTndoZXsKRwfN+WfQr4PvQV2d3
 hkYLjol2qhg2KL72orDJT9O+bA4D7pQvyg==
X-Google-Smtp-Source: APXvYqw/2Y0ATN8S7+P+F/py2zDH5OqUBFFPXksWf9VBp2G0HIhK/dvtiULlxkR/pr7zM+q/w/fvNQ==
X-Received: by 2002:adf:de03:: with SMTP id b3mr40938wrm.14.1568643365067;
 Mon, 16 Sep 2019 07:16:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:16:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:44 +0100
Message-Id: <20190916141544.17540-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 15/15] target/arm/arm-semi: Implement
 SH_EXT_STDOUT_STDERR extension
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SH_EXT_STDOUT_STDERR is a v2.0 semihosting extension: the guest
can open ":tt" with a file mode requesting append access in
order to open stderr, in addition to the existing "open for
read for stdin or write for stdout". Implement this and
report it via the :semihosting-features data.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-semi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index f65d8c907e8..6f7b6d801bf 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -516,13 +516,14 @@ static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
 
 /* Feature bits reportable in feature byte 0 */
 #define SH_EXT_EXIT_EXTENDED (1 << 0)
+#define SH_EXT_STDOUT_STDERR (1 << 1)
 
 static const uint8_t featurefile_data[] = {
     SHFB_MAGIC_0,
     SHFB_MAGIC_1,
     SHFB_MAGIC_2,
     SHFB_MAGIC_3,
-    SH_EXT_EXIT_EXTENDED, /* Feature byte 0 */
+    SH_EXT_EXIT_EXTENDED | SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
 };
 
 static void init_featurefile_guestfd(int guestfd)
@@ -710,7 +711,21 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
 
         if (strcmp(s, ":tt") == 0) {
-            int result_fileno = arg1 < 4 ? STDIN_FILENO : STDOUT_FILENO;
+            int result_fileno;
+
+            /*
+             * We implement SH_EXT_STDOUT_STDERR, so:
+             *  open for read == stdin
+             *  open for write == stdout
+             *  open for append == stderr
+             */
+            if (arg1 < 4) {
+                result_fileno = STDIN_FILENO;
+            } else if (arg1 < 8) {
+                result_fileno = STDOUT_FILENO;
+            } else {
+                result_fileno = STDERR_FILENO;
+            }
             associate_guestfd(guestfd, result_fileno);
             unlock_user(s, arg0, 0);
             return guestfd;
-- 
2.20.1


