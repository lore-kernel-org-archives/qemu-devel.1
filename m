Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC521C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C2B20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0LgB9cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C2B20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBWE-0000Fe-Fv
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipBVA-0007Jp-5m
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipBV8-0004jK-OA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:36:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipBV8-0004i6-Hm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:35:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id u2so2524713wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6xRyv19a65AkckLvk7hDMNMBMxxO7kHnyttZlntZGko=;
 b=b0LgB9cQlZUFZRI8vhFVOmEzO8rIU8yblKaABNzhbBE61tbuIQ8uiyTM482H7Mr3FZ
 zZ45LZFL1vEPk0xt6FkTQu1aG8lDNLZy72ZuLQWvY0dO4jlDT56HkiBNH4M7ZQDViOBR
 mFgMEhVO0wTl7fWasmtLVewg0rqShpUaAfbJOaUQgFa4lO69B5Fbns58tcXnmMe5WcNr
 fg/aigH9WTw/9PZfw5DIie5SAdSHIGyBZDbp19/8LiAcTqLIQobX7N0LEqlFHCS52rXC
 0+LrcvI+sFulecVDHhv6bO3Khv/wFuv31k9EGTN/LW1OzI0a642w43LeAfxpUnWjrJHR
 ikiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6xRyv19a65AkckLvk7hDMNMBMxxO7kHnyttZlntZGko=;
 b=nTGrxcg/fo1uBt9s9bdrZMbm9Yj03mSX89PA0lrZu+nJVa4FGn0qK35j6OLT3Nbz/V
 f9Z7MZY4mMgtqc63Qs173EbmCO66E6KXsH3mnFBc2YYfB9vOJzDcFHj1OmZ3605TFES3
 v1BHnkJJQR3i/FUfwdSONiP3rxowiE5Ywzz9MIMRWcLs+sYhaMH4DsX85uyQIBOsRu6i
 nFN4pH8xQ9DU7NunmcvcjeN0ZUXv0/3W5R7mYduEwKR/P5aJSy9jdsNrUX3I0mAK2lsn
 8iDz6OXOIpEkJFOzpg9ANT0PjL9NggjpDjWtYQ7Zb+REyQoRIdDC0ufDVsV2PSl7VDjj
 YhfA==
X-Gm-Message-State: APjAAAXr2JszyURZy6OVnKy1F+UnhP81tB+Gf70BQy1HBwalVVE08rLo
 xR03Y1yELHaykJDxcTM3LzcrfCwz
X-Google-Smtp-Source: APXvYqwhO5hUMd7rAEL8M+4M7sh8HysGcflo0kjlwsiXKttdTinj2YcLFdfKSbnHz/1aQTYIzb6EGw==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr3777928wmg.86.1578490556850;
 Wed, 08 Jan 2020 05:35:56 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id f1sm3028235wmc.45.2020.01.08.05.35.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 05:35:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests: fix test-qga on macosx
Date: Wed,  8 Jan 2020 14:35:55 +0100
Message-Id: <1578490555-6363-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Fix Unix socket connection & skip commands that are not implemented.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  2 +-
 tests/test-qga.c       | 25 ++++++++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49e3b0d..192a08e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -119,7 +119,7 @@ check-unit-$(CONFIG_BLOCK) += tests/test-crypto-secret$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) += tests/test-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
+check-unit-$(call land,$(CONFIG_POSIX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
 check-unit-y += tests/test-timed-average$(EXESUF)
 check-unit-$(CONFIG_INOTIFY1) += tests/test-util-filemonitor$(EXESUF)
diff --git a/tests/test-qga.c b/tests/test-qga.c
index d2b2435..191bfca 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -17,17 +17,17 @@ typedef struct {
 
 static int connect_qga(char *path)
 {
-    int s, ret, len, i = 0;
+    int s, ret, i = 0;
     struct sockaddr_un remote;
 
     s = socket(AF_UNIX, SOCK_STREAM, 0);
     g_assert(s != -1);
 
+    memset(&remote, 0, sizeof(struct sockaddr_un));
     remote.sun_family = AF_UNIX;
     do {
-        strcpy(remote.sun_path, path);
-        len = strlen(remote.sun_path) + sizeof(remote.sun_family);
-        ret = connect(s, (struct sockaddr *)&remote, len);
+        strncpy(remote.sun_path, path, sizeof(remote.sun_path) - 1);
+        ret = connect(s, (struct sockaddr *)&remote, sizeof(struct sockaddr_un));
         if (ret == -1) {
             g_usleep(G_USEC_PER_SEC);
         }
@@ -305,6 +305,7 @@ static void test_qga_info(gconstpointer fix)
     qobject_unref(ret);
 }
 
+#if defined(CONFIG_LINUX)
 static void test_qga_get_vcpus(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -324,7 +325,9 @@ static void test_qga_get_vcpus(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
+#if defined(CONFIG_LINUX)
 static void test_qga_get_fsinfo(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -348,6 +351,7 @@ static void test_qga_get_fsinfo(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
 static void test_qga_get_memory_block_info(gconstpointer fix)
 {
@@ -394,6 +398,7 @@ static void test_qga_get_memory_blocks(gconstpointer fix)
     qobject_unref(ret);
 }
 
+#if defined(CONFIG_LINUX)
 static void test_qga_network_get_interfaces(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -412,6 +417,7 @@ static void test_qga_network_get_interfaces(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
 static void test_qga_file_ops(gconstpointer fix)
 {
@@ -682,7 +688,7 @@ static void test_qga_blacklist(gconstpointer data)
     qobject_unref(ret);
 
     /* check something work */
-    ret = qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
+    ret = qmp_fd(fix.fd, "{'execute': 'guest-info'}");
     qmp_assert_no_error(ret);
     qobject_unref(ret);
 
@@ -766,6 +772,7 @@ static void test_qga_config(gconstpointer data)
     g_key_file_free(kf);
 }
 
+#if defined(CONFIG_LINUX)
 static void test_qga_fsfreeze_status(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -781,6 +788,7 @@ static void test_qga_fsfreeze_status(gconstpointer fix)
 
     qobject_unref(ret);
 }
+#endif
 
 static void test_qga_guest_exec(gconstpointer fix)
 {
@@ -976,12 +984,17 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
     g_test_add_data_func("/qga/ping", &fix, test_qga_ping);
     g_test_add_data_func("/qga/info", &fix, test_qga_info);
+#if defined(CONFIG_LINUX)
     g_test_add_data_func("/qga/network-get-interfaces", &fix,
                          test_qga_network_get_interfaces);
     if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
         g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
     }
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
+    g_test_add_data_func("/qga/fsfreeze-status", &fix,
+                         test_qga_fsfreeze_status);
+#endif
+
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
                          test_qga_get_memory_block_info);
     g_test_add_data_func("/qga/get-memory-blocks", &fix,
@@ -993,8 +1006,6 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
-    g_test_add_data_func("/qga/fsfreeze-status", &fix,
-                         test_qga_fsfreeze_status);
 
     g_test_add_data_func("/qga/blacklist", NULL, test_qga_blacklist);
     g_test_add_data_func("/qga/config", NULL, test_qga_config);
-- 
1.8.3.1


