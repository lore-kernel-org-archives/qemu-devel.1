Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF05DC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8512075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPy3yN3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8512075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrtg-0003I0-Qu
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpQ-0004xU-6C
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpP-000676-N7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpP-00064K-9U; Tue, 21 Apr 2020 08:16:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so3417100wmh.3;
 Tue, 21 Apr 2020 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=suzA1mVxEZBQKnRRP2Gao+Iu8bshykLk7J9aBD7X5OY=;
 b=UPy3yN3rdRSn7/7rXCowU8U1nMW0j/I3Q5YkHBGZYHQML5L8nBizIzU40XmFWcFw4K
 K7xNLH8/7y5wVy0BUo0gi2U0fzfdoWkZNbhUCGdET8QEXD/9P0xJiRCT1ksp8REUCp7K
 tTw+SekC5XwCeA7OtAUbcpnEgbutTZmyVgb8R6NwSMQgOvFNqEqm9XgXmLpdQ3K6+W42
 hhtm9toZOmL7PAPdgfvraIGxoOTFGqGvxc553HN9zVVFE16PlWvdJ2wWexgjUsfnh668
 0ZNAmLAhgDhPsUROioePfp0HnZBV08qrhkugAiks+TjRX9GRO0g80LBJGUNcTsNGo3vO
 mJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=suzA1mVxEZBQKnRRP2Gao+Iu8bshykLk7J9aBD7X5OY=;
 b=VgceEd6RyGsw2d1osBVfQhT0pS9KYuEfdv9VX/tk2DG5RdMpoZ5gFKCa7D2n/jU18q
 4imO6hjZkO2Z5w7I1R99LWcxvDr6Sje1ewW8blyBb2ycIS+Bqi3emm27v+KLJUFCTWRG
 0onL5QHI3fCz4NGtDuu13wV3tqf/82yVxGOBhg7oaE6hvWEgl744FPXMPfx0+nHr0g86
 3RguftEeBMuvRgTTXu+iD4BDTFtChrCIGXDnInYZivhfyFt48AjTSxZ6YU7AoT7p6TC1
 UXrmHJWgVI/WuNcVS7RZztrLfaTAqrE9Pi623i0stD4t1aH0LC15yD/5HWWy8kHkwVjl
 cmtQ==
X-Gm-Message-State: AGi0PubPJJyn3/NUbKLQQBzFLu7lqRs6PN3WJFIPmQE9HHvqal8wf3AC
 8lY/q4PN5DMCfdYLT5P0H6rr+Is+bMM=
X-Google-Smtp-Source: APiQypKMhUFf3vKrVdSLtgrz2RLyPcd9qxCxwkO9UqqIstDoCYMsf/1iL+Y8OoMXEjgjqEvT0D+nlg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4665135wma.32.1587471396775; 
 Tue, 21 Apr 2020 05:16:36 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/17] hw/misc/tmp105: Extract get_temp_mC() and
 set_temp_mC() helpers
Date: Tue, 21 Apr 2020 14:16:13 +0200
Message-Id: <20200421121626.23791-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are going to reuse this code, extract it as helpers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/tmp105.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 75ddad3a12..754c8a6eb4 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -56,11 +56,28 @@ static void tmp105_alarm_update(TMP105State *s)
     tmp105_interrupt_update(s);
 }
 
+static int64_t get_temp_mC(TMP105State *s)
+{
+    return s->temperature * 1000 / 256;
+}
+
+static void set_temp_mC(TMP105State *s, int64_t temp_mC, Error **errp)
+{
+    if (temp_mC >= 128000 || temp_mC < -128000) {
+        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of range",
+                   temp_mC / 1000, temp_mC % 1000);
+        return;
+    }
+
+    s->temperature = (int16_t) (temp_mC * 256 / 1000);
+
+    tmp105_alarm_update(s);
+}
+
 static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    TMP105State *s = TMP105(obj);
-    int64_t value = s->temperature * 1000 / 256;
+    int64_t value = get_temp_mC(TMP105(obj));
 
     visit_type_int(v, name, &value, errp);
 }
@@ -71,7 +88,6 @@ static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
 static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    TMP105State *s = TMP105(obj);
     Error *local_err = NULL;
     int64_t temp;
 
@@ -80,15 +96,8 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
         error_propagate(errp, local_err);
         return;
     }
-    if (temp >= 128000 || temp < -128000) {
-        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of range",
-                   temp / 1000, temp % 1000);
-        return;
-    }
 
-    s->temperature = (int16_t) (temp * 256 / 1000);
-
-    tmp105_alarm_update(s);
+    set_temp_mC(TMP105(obj), temp, errp);
 }
 
 static const int tmp105_faultq[4] = { 1, 2, 4, 6 };
-- 
2.21.1


