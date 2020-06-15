Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B387C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE4520679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUu8Qqov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE4520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmYN-0007W6-CS
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jkmU0-0000xz-8m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:36:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jkmTy-0007SS-4o
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592217409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wILdVeQQePVjwaoswacZyVPQPAG30iuleWLwrAprDyM=;
 b=jUu8QqovjmfwgJi8z5zvBurlCnErpQE7V4ijhm9oPTZc41H2BcpZ1Z0fWzkTPyqvNpvE9Z
 2QU/ZTIAVOOKXmD+77ZATcV5hB3wMgHenMDJHQBaOQd7yJ1aT7jlj7i0fweu6Y8/+9dzpg
 0iW7l8vLt6HHBVATwJ9XLjpqCyhKPIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-o-XHveDwMa-HcPuYlgeCsg-1; Mon, 15 Jun 2020 06:36:45 -0400
X-MC-Unique: o-XHveDwMa-HcPuYlgeCsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44001106B243;
 Mon, 15 Jun 2020 10:36:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 155135D9CC;
 Mon, 15 Jun 2020 10:36:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] test-crypto-secret: add 'secret_keyring' object tests.
Date: Mon, 15 Jun 2020 11:36:32 +0100
Message-Id: <20200615103633.300208-5-berrange@redhat.com>
In-Reply-To: <20200615103633.300208-1-berrange@redhat.com>
References: <20200615103633.300208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Krasikov <alex-krasikov@yandex-team.ru>

Add tests:
  test_secret_keyring_good;
  test_secret_keyring_revoked_key;
  test_secret_keyring_expired_key;
  test_secret_keyring_bad_serial_key;
  test_secret_keyring_bad_key_access_right;

Added tests require libkeyutils. The absence of this library is not
critical, because these tests will be skipped in this case.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                  |  24 ++++++
 tests/Makefile.include     |   4 +
 tests/test-crypto-secret.c | 158 +++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/configure b/configure
index 3fbb61905a..07202acb9e 100755
--- a/configure
+++ b/configure
@@ -6330,6 +6330,27 @@ but not implemented on your system"
     fi
 fi
 
+##########################################
+# check for usable keyutils.h
+
+if test "$linux" = "yes" ; then
+
+    have_keyutils=no
+    cat > $TMPC << EOF
+#include <errno.h>
+#include <asm/unistd.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <keyutils.h>
+int main(void) {
+    return request_key("user", NULL, NULL, 0);
+}
+EOF
+    if compile_prog "" "-lkeyutils"; then
+        have_keyutils=yes
+    fi
+fi
+
 
 ##########################################
 # End of CC checks
@@ -7702,6 +7723,9 @@ fi
 
 if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
+  if test "$have_keyutils" = "yes" ; then
+    echo "CONFIG_TEST_SECRET_KEYRING=y" >> $config_host_mak
+  fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c2397de8ed..5607c7290d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -540,6 +540,10 @@ tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-c
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
 tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
 
+ifeq ($(CONFIG_TEST_SECRET_KEYRING),y)
+tests/test-crypto-secret.o-libs := -lkeyutils
+endif
+
 tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
 tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
 tests/pkix_asn1_tab.o-cflags := $(TASN1_CFLAGS)
diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
index 13fc6c4c75..603a093f10 100644
--- a/tests/test-crypto-secret.c
+++ b/tests/test-crypto-secret.c
@@ -24,6 +24,10 @@
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#ifdef CONFIG_TEST_SECRET_KEYRING
+#include "crypto/secret_keyring.h"
+#include <keyutils.h>
+#endif
 
 static void test_secret_direct(void)
 {
@@ -124,6 +128,147 @@ static void test_secret_indirect_emptyfile(void)
     g_free(fname);
 }
 
+#ifdef CONFIG_TEST_SECRET_KEYRING
+
+#define DESCRIPTION "qemu_test_secret"
+#define PAYLOAD "Test Payload"
+
+
+static void test_secret_keyring_good(void)
+{
+    char key_str[16];
+    Object *sec;
+    int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                          strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+
+    g_assert(key >= 0);
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_KEYRING,
+        object_get_objects_root(),
+        "sec0",
+        &error_abort,
+        "serial", key_str,
+        NULL);
+
+    assert(0 <= keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING));
+    char *pw = qcrypto_secret_lookup_as_utf8("sec0",
+                                             &error_abort);
+    g_assert_cmpstr(pw, ==, PAYLOAD);
+
+    object_unparent(sec);
+    g_free(pw);
+}
+
+
+static void test_secret_keyring_revoked_key(void)
+{
+    char key_str[16];
+    Object *sec;
+    int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                          strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+    g_assert(key >= 0);
+    g_assert_false(keyctl_revoke(key));
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_KEYRING,
+        object_get_objects_root(),
+        "sec0",
+        NULL,
+        "serial", key_str,
+        NULL);
+
+    g_assert(errno == EKEYREVOKED);
+    g_assert(sec == NULL);
+
+    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
+}
+
+
+static void test_secret_keyring_expired_key(void)
+{
+    char key_str[16];
+    Object *sec;
+    int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                          strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+    g_assert(key >= 0);
+    g_assert_false(keyctl_set_timeout(key, 1));
+    sleep(1);
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_KEYRING,
+        object_get_objects_root(),
+        "sec0",
+        NULL,
+        "serial", key_str,
+        NULL);
+
+    g_assert(errno == EKEYEXPIRED);
+    g_assert(sec == NULL);
+
+    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
+}
+
+
+static void test_secret_keyring_bad_serial_key(void)
+{
+    Object *sec;
+
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_KEYRING,
+        object_get_objects_root(),
+        "sec0",
+        NULL,
+        "serial", "1",
+        NULL);
+
+    g_assert(errno == ENOKEY);
+    g_assert(sec == NULL);
+}
+
+/*
+ * TODO
+ * test_secret_keyring_bad_key_access_right() is not working yet.
+ * We don't know yet if this due a bug in the Linux kernel or
+ * whether it's normal syscall behavior.
+ * We've requested information from kernel maintainers.
+ * See: <https://www.spinics.net/lists/keyrings/index.html>
+ * Thread: 'security/keys: remove possessor verify after key permission check'
+ */
+
+static void test_secret_keyring_bad_key_access_right(void)
+{
+    char key_str[16];
+    Object *sec;
+
+    g_test_skip("TODO: Need responce from Linux kernel maintainers");
+    return;
+
+    int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                          strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+    g_assert(key >= 0);
+    g_assert_false(keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_READ)));
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_KEYRING,
+        object_get_objects_root(),
+        "sec0",
+        NULL,
+        "serial", key_str,
+        NULL);
+
+    g_assert(errno == EACCES);
+    g_assert(sec == NULL);
+
+    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
+}
+
+#endif /* CONFIG_TEST_SECRET_KEYRING */
 
 static void test_secret_noconv_base64_good(void)
 {
@@ -426,6 +571,19 @@ int main(int argc, char **argv)
     g_test_add_func("/crypto/secret/indirect/emptyfile",
                     test_secret_indirect_emptyfile);
 
+#ifdef CONFIG_TEST_SECRET_KEYRING
+    g_test_add_func("/crypto/secret/keyring/good",
+                    test_secret_keyring_good);
+    g_test_add_func("/crypto/secret/keyring/revoked_key",
+                    test_secret_keyring_revoked_key);
+    g_test_add_func("/crypto/secret/keyring/expired_key",
+                    test_secret_keyring_expired_key);
+    g_test_add_func("/crypto/secret/keyring/bad_serial_key",
+                    test_secret_keyring_bad_serial_key);
+    g_test_add_func("/crypto/secret/keyring/bad_key_access_right",
+                    test_secret_keyring_bad_key_access_right);
+#endif /* CONFIG_TEST_SECRET_KEYRING */
+
     g_test_add_func("/crypto/secret/noconv/base64/good",
                     test_secret_noconv_base64_good);
     g_test_add_func("/crypto/secret/noconv/base64/bad",
-- 
2.26.2


