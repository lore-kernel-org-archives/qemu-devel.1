Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD37CC04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A42217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="comklrI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A42217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47552 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Rf-0003bG-P6
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:36:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MO-0007OC-T7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MN-000644-V1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MN-00063b-OR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:03 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so3578722pfo.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/ZYAcflQLE8QxLnv1PzgjeCpnaQ2OAMJAHbK0JDJ8Y8=;
	b=comklrI7vJRFkDR9OWFu6hwuKVFU1zNt6vn/glu/slrjyzVypYPxPtSUORzW9gLIjW
	mGmGbPusUItMMbzgTQ1Ki5BgWQatG5y5+NxnZ1NtwgD6VMdLDhm2GN7qyoUa7sOxchnL
	ydwFyWN3HHpOKZP3mVO4/+BbAsELB6j580cGVQdhzipVPUsRjycy6qof1ezw9p6TpNiJ
	0fVohOg38OnEhJdMhrqvMlvWOXW9JqLUga0M6mzDZqGh0IycE3lC9rPLFJHuJjAo23Wu
	u1Q/hMhIi7fAJqKtr2sgHiOhVYph+d7kOdVqidz80CcK9lslw+XxMHprd+XrJMCgNQdX
	Is/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/ZYAcflQLE8QxLnv1PzgjeCpnaQ2OAMJAHbK0JDJ8Y8=;
	b=lDLXbCvlRvBCM0vPp37lL5zqv2oKc63cGlQG/Rl3nSvzQBzx1WSegWg3GqCz11CEbj
	42L8MlkjqRIcNUm0tMLgHbGbzcalUkil+4r/0p9+tUyxhoFTwmRKIMqYHfZwVfCOU3z9
	FtFkWcKP6bt5oByoqqFf9IxMjW0Mj5zf1wC4UMhEjgmZ442iVOHniOnUs6guydy0PoRc
	8Z/KLqJ4jX5e+upesZYTSQWEF4THFyX5LfWTjVHjV+dhy1jX3Mkpd5wsAoYX+Yg0IYQg
	aAo+a5grCUbHdsQANGjICUWkddW7eszFVX2OZG8ZbK/HT8B1klCNA+TkwGbBgC1dxKhw
	s66Q==
X-Gm-Message-State: APjAAAVcN/24vV/lApcXj6CZ4WiTentXeNDE9h49GzEyczhpwGhpaIl4
	CCJHMA3tnH0Brn0mUyyvnDHpg8L67jU=
X-Google-Smtp-Source: APXvYqzZTCPyz3HMkRhNyTS8i/8z1CC+JQA7iXROe+5rWd8IWi3pVzFMs41J8I5TUZcZXYsqhOSm2Q==
X-Received: by 2002:a63:7989:: with SMTP id u131mr6596432pgc.180.1557509462453;
	Fri, 10 May 2019 10:31:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:33 -0700
Message-Id: <20190510173049.28171-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v6 09/25] ui/vnc: Use gcrypto_random_bytes for
 start_auth_vnc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a better interface for random numbers than rand().
Fail gracefully if for some reason we cannot use the crypto system.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use qcrypto_random_bytes, not qemu_getrandom, as there is
    no need for deterministic results for this interface.
v3: Fail gracefully in the event qcrypto_random_bytes fails.
---
 ui/vnc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 785edf3af1..d83f4a6ff9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredsx509.h"
+#include "crypto/random.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
 #include "io/dns-resolver.h"
@@ -2547,16 +2548,6 @@ static void authentication_failed(VncState *vs)
     vnc_client_error(vs);
 }
 
-static void make_challenge(VncState *vs)
-{
-    int i;
-
-    srand(time(NULL)+getpid()+getpid()*987654+rand());
-
-    for (i = 0 ; i < sizeof(vs->challenge) ; i++)
-        vs->challenge[i] = (int) (256.0*rand()/(RAND_MAX+1.0));
-}
-
 static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
 {
     unsigned char response[VNC_AUTH_CHALLENGE_SIZE];
@@ -2628,7 +2619,16 @@ reject:
 
 void start_auth_vnc(VncState *vs)
 {
-    make_challenge(vs);
+    Error *err = NULL;
+
+    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &err)) {
+        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
+                            error_get_pretty(err));
+        error_free(err);
+        authentication_failed(vs);
+        return;
+    }
+
     /* Send client a 'random' challenge */
     vnc_write(vs, vs->challenge, sizeof(vs->challenge));
     vnc_flush(vs);
-- 
2.17.1


