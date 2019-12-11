Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB516C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6F920836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0uNsFNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6F920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if37F-0001tM-Cx
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2uk-0006SP-V9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2uj-0004UR-M4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:24:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2uj-0004SB-Fc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:24:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so2749234wro.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6P+O7fP7RdRxtrVlibSaBNIUsO6tN03n2SE/FwGlPpk=;
 b=l0uNsFNfQ2lywr02LWYhFULRgQI+/K+QVKVG/VwAgpMz2+vS0ef7h+40S5IHvN0nnE
 PuIgzhTMfrU2f86pw2fAE9WOGlvRDGX6AROERAenwZcgKsIQbIfOXjgDjn8f88BxYpjO
 9F3a4f0uFMONQKErc8t9VCOD/PxwM9m0haWg9XRTr1SV99ovEgtakwUqD9Gjuw3Afxf/
 37nk/UKaSx3UamtmuD/JNHMTLZb1g73K3fsIE+cjkJW73qDdYZlWX9cjTrT5BXmJVfzJ
 M933phMnMrRZj7zxC39n4slMi7l8f5PEeWIv7POtWIxwXxpqeRbY1b7OvdmDMmQW65Ub
 2Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6P+O7fP7RdRxtrVlibSaBNIUsO6tN03n2SE/FwGlPpk=;
 b=GHZEphoKBAUK6zWYEtDfT6Mjf7qwJtT0Od3w1+5yCjqVkatZS7jz4QU24ytb5+zAWZ
 2G4Q/Rhok7vKT+wAhKNjV2Ut6978uMJEgO6Icsve5f4uTTDg1m3LWcI5xemn4R5iEco3
 qLqZwwWYdnr8FgMAPiMR1Yq5z3Z79NZgJ/1tHG0d8HqDcI+hEaqEVYS4wN/FsSdN8OkP
 71PtH2CDWJoyaqqS44GIkBK+5gzQA9MEGN0mapvY/06+pByhaQEZtAW1JlRc88mZw7aZ
 YAbpYb1S4cdU65Kqa1fTlvFk8zBW11qdoyLKuIv5gWITH2xlnpcoSXKNFlVhcPGum1KA
 Da1Q==
X-Gm-Message-State: APjAAAV6zQ5oaZIh1wa9OfR9o9ZdHMJ38fwQ396BS5DJlcWPi0LgDCC/
 dgneezRnXS6s1Y20Obz5MqXNVX0i
X-Google-Smtp-Source: APXvYqzj5dN64kbSxo0CFeODPpIH1dEJvzzW2C0PBbdUO+/aiSgWWBbwdzIAb8l0cxg2sl4rYQ9eUQ==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr96260wrt.70.1576074268281;
 Wed, 11 Dec 2019 06:24:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b10sm2391123wrt.90.2019.12.11.06.24.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:24:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] os-posix: simplify os_find_datadir
Date: Wed, 11 Dec 2019 15:24:26 +0100
Message-Id: <1576074266-53158-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use g_build_filename instead of sprintf, and g_autofree instead of
manual freeing.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 os-posix.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 86cffd2..3cd52e1 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -80,41 +80,26 @@ void os_setup_signal_handling(void)
     sigaction(SIGTERM, &act, NULL);
 }
 
-/* Find a likely location for support files using the location of the binary.
-   For installed binaries this will be "$bindir/../share/qemu".  When
-   running from the build tree this will be "$bindir/../pc-bios".  */
-#define SHARE_SUFFIX "/share/qemu"
-#define BUILD_SUFFIX "/pc-bios"
+/*
+ * Find a likely location for support files using the location of the binary.
+ * When running from the build tree this will be "$bindir/../pc-bios".
+ * Otherwise, this is CONFIG_QEMU_DATADIR.
+ */
 char *os_find_datadir(void)
 {
-    char *dir, *exec_dir;
-    char *res;
-    size_t max_len;
+    g_autofree char *exec_dir = NULL;
+    g_autofree char *dir = NULL;
 
     exec_dir = qemu_get_exec_dir();
-    if (exec_dir == NULL) {
-        return NULL;
-    }
-    dir = g_path_get_dirname(exec_dir);
-
-    max_len = strlen(dir) +
-        MAX(strlen(SHARE_SUFFIX), strlen(BUILD_SUFFIX)) + 1;
-    res = g_malloc0(max_len);
-    snprintf(res, max_len, "%s%s", dir, SHARE_SUFFIX);
-    if (access(res, R_OK)) {
-        snprintf(res, max_len, "%s%s", dir, BUILD_SUFFIX);
-        if (access(res, R_OK)) {
-            g_free(res);
-            res = NULL;
-        }
+    g_return_val_if_fail(exec_dir != NULL, NULL);
+
+    dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
+    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
+        return g_steal_pointer(&dir);
     }
 
-    g_free(dir);
-    g_free(exec_dir);
-    return res;
+    return g_strdup(CONFIG_QEMU_DATADIR);
 }
-#undef SHARE_SUFFIX
-#undef BUILD_SUFFIX
 
 void os_set_proc_name(const char *s)
 {
-- 
1.8.3.1


