Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABCBC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11B9206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW+oNiYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11B9206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmrY-0004sR-S1
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kUmmJ-0006i7-OC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kUmmH-0001ic-8X
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603181632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HegxmTuUwmkrYCTtISK3mquAYj5KpbIrtQxrdaR1lE=;
 b=SW+oNiYHBQQKu745BvkEwUra3airmjDGuAQ6+RNenjRTt+GWjT1jSrVP/tJdMMA/RTvECV
 Z5YjwyuYuflwKU8/F5fibMR3Spb+xheTzWenHN3kRSxT6oj+4xWtXkoMDmJj9vMkO8N941
 yhAhd3Hi/nwe4owXpW3jp06JYdN3Tq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-lgN6xWmUNLK2kMsrqAoomA-1; Tue, 20 Oct 2020 04:13:50 -0400
X-MC-Unique: lgN6xWmUNLK2kMsrqAoomA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 283D78049D5;
 Tue, 20 Oct 2020 08:13:49 +0000 (UTC)
Received: from localhost (unknown [10.36.110.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E157B1992D;
 Tue, 20 Oct 2020 08:13:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] qga: add *reset argument to ssh-add-authorized-keys
Date: Tue, 20 Oct 2020 12:12:55 +0400
Message-Id: <20201020081257.2054548-6-marcandre.lureau@redhat.com>
In-Reply-To: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
References: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

I prefer 'reset' over 'clear', since 'clear' and keys may have some
other relations or meaning.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++++----
 qga/qapi-schema.json     |  3 ++-
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index a7bc9a1c24..f974bc4b64 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -168,6 +168,7 @@ read_authkeys(const char *path, Error **errp)
 
 void
 qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
+                                  bool has_reset, bool reset,
                                   Error **errp)
 {
     g_autofree struct passwd *p = NULL;
@@ -178,6 +179,7 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     size_t nkeys, nauthkeys;
 
     ERRP_GUARD();
+    reset = has_reset && reset;
 
     if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
         return;
@@ -191,7 +193,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
     authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
 
-    authkeys = read_authkeys(authkeys_path, NULL);
+    if (!reset) {
+        authkeys = read_authkeys(authkeys_path, NULL);
+    }
     if (authkeys == NULL) {
         if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
             !mkdir_for_user(ssh_path, p, 0700, errp)) {
@@ -318,7 +322,7 @@ test_invalid_user(void)
 {
     Error *err = NULL;
 
-    qmp_guest_ssh_add_authorized_keys("", NULL, &err);
+    qmp_guest_ssh_add_authorized_keys("", NULL, FALSE, FALSE, &err);
     error_free_or_abort(&err);
 
     qmp_guest_ssh_remove_authorized_keys("", NULL, &err);
@@ -333,7 +337,8 @@ test_invalid_key(void)
     };
     Error *err = NULL;
 
-    qmp_guest_ssh_add_authorized_keys(g_get_user_name(), &key, &err);
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(), &key,
+                                      FALSE, FALSE, &err);
     error_free_or_abort(&err);
 
     qmp_guest_ssh_remove_authorized_keys(g_get_user_name(), &key, &err);
@@ -346,13 +351,17 @@ test_add_keys(void)
     Error *err = NULL;
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
-                                      (strList *)&test_key2, &err);
+                                      (strList *)&test_key2,
+                                      FALSE, FALSE,
+                                      &err);
     g_assert_null(err);
 
     test_authorized_keys_equal("algo key2 comments");
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
-                                      (strList *)&test_key1_2, &err);
+                                      (strList *)&test_key1_2,
+                                      FALSE, FALSE,
+                                      &err);
     g_assert_null(err);
 
     /*  key2 came first, and should'nt be duplicated */
@@ -360,6 +369,39 @@ test_add_keys(void)
                                "algo key1 comments");
 }
 
+static void
+test_add_reset_keys(void)
+{
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key1_2,
+                                      FALSE, FALSE,
+                                      &err);
+    g_assert_null(err);
+
+    /* reset with key2 only */
+    test_authorized_keys_equal("algo key1 comments\n"
+                               "algo key2 comments");
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2,
+                                      TRUE, TRUE,
+                                      &err);
+    g_assert_null(err);
+
+    test_authorized_keys_equal("algo key2 comments");
+
+    /* empty should clear file */
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)NULL,
+                                      TRUE, TRUE,
+                                      &err);
+    g_assert_null(err);
+
+    test_authorized_keys_equal("");
+}
+
 static void
 test_remove_keys(void)
 {
@@ -393,6 +435,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/qga/ssh/invalid_user", test_invalid_user);
     g_test_add_func("/qga/ssh/invalid_key", test_invalid_key);
     g_test_add_func("/qga/ssh/add_keys", test_add_keys);
+    g_test_add_func("/qga/ssh/add_reset_keys", test_add_reset_keys);
     g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
 
     return g_test_run();
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 90615f95d4..6b7cb86dee 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1312,6 +1312,7 @@
 #
 # @username: the user account to add the authorized keys
 # @keys: the public keys to add (in OpenSSH/sshd(8) authorized_keys format)
+# @reset: ignore the existing content, set it with the given keys only
 #
 # Append public keys to user .ssh/authorized_keys on Unix systems (not
 # implemented for other systems).
@@ -1321,7 +1322,7 @@
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'] },
+  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
   'if': 'defined(CONFIG_POSIX)' }
 
 ##
-- 
2.28.0


