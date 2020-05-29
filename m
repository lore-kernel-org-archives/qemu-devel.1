Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41248C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0D22065C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJgSKzWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0D22065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecR8-0005HP-6f
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecN7-0007BS-1W
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecN2-0004xK-Ne
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590748570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU4N+xCmEl4LFT3IKsV7DZx5wVwce7+UUJUf0SQebJQ=;
 b=JJgSKzWPlRZexdHfJ2VSe06P1a7+88onJbO1BXDVkT8M3EtLjr3AitdPfL3+COohGJGnNG
 iu2SyiqprJ3W1TDuRu4GX3VPcNnaUcn/PHtxO8Yeygp2+FpGetIYXaOqNIRDiaKw0rTxqH
 iM5VlxnWFOylOLAyAI4eAs9rXMVmQcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-tuRa-3SzM3eTKi9I9iUzUg-1; Fri, 29 May 2020 06:36:06 -0400
X-MC-Unique: tuRa-3SzM3eTKi9I9iUzUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9252A872FE0;
 Fri, 29 May 2020 10:36:05 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 843991A7C8;
 Fri, 29 May 2020 10:36:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] test-crypto-secret: add 'secret_keyring' object tests.
Date: Fri, 29 May 2020 11:35:54 +0100
Message-Id: <20200529103555.2759928-5-berrange@redhat.com>
In-Reply-To: <20200529103555.2759928-1-berrange@redhat.com>
References: <20200529103555.2759928-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
index d95ff4e0b3..f2ff722f7e 100755
--- a/configure
+++ b/configure
@@ -6305,6 +6305,27 @@ but not implemented on your system"
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
@@ -7674,6 +7695,9 @@ fi
 
 if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
+  if test "$have_keyutils" = "yes" ; then
+    echo "CONFIG_TEST_SECRET_KEYRING=y" >> $config_host_mak
+  fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b60f6..de13908701 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -538,6 +538,10 @@ tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-c
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


