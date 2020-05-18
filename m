Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F095C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D6520643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Hv9Qy752"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D6520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamVw-0004RA-C4
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jamNA-0004xA-8D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:28:28 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jamN4-0007rV-Rp
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:28:26 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E246E2E1552;
 Mon, 18 May 2020 23:28:18 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 GjjByeafyV-SITaENv3; Mon, 18 May 2020 23:28:18 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589833698; bh=Ww6jldXdHMl5Cm5BE5xdf+n8Fau1fQHgSCvIq3QihZ4=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=Hv9Qy752QFO8ZMZWeuq22xqdVW5yctDSMyIxk2GhxPX7gjMQ0Js2TqFBIG0YgVv/x
 VPCkh8VtLNx5D9Ynj1Xkx4xjqZXjWH7sS3GaEAGQYnyjtvnxvfGdyIuvFNoVaqA+u+
 pKDtbrpdZSXHw+gaSzj8eI+KQ6yFbXODPW1I9D9I=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:305::1:5])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 nVf2WDt3uL-SIXSWXWW; Mon, 18 May 2020 23:28:18 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] test-crypto-secret: add 'secret_keyring' object tests.
Date: Mon, 18 May 2020 23:28:04 +0300
Message-Id: <20200518202804.3761-4-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518202804.3761-1-alex-krasikov@yandex-team.ru>
References: <20200518202804.3761-1-alex-krasikov@yandex-team.ru>
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=alex-krasikov@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:28:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add tests:
  test_secret_keyring_good;
  test_secret_keyring_revoked_key;
  test_secret_keyring_expired_key;
  test_secret_keyring_bad_serial_key;
  test_secret_keyring_bad_key_access_right;

Added tests require libkeyutils. The absence of this library is not
critical, because these tests will be skipped in this case.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 configure                  |  25 ++++++
 tests/Makefile.include     |   4 +
 tests/test-crypto-secret.c | 154 +++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)

diff --git a/configure b/configure
index 1bae5ec0a1..2ab7d2961c 100755
--- a/configure
+++ b/configure
@@ -6283,6 +6283,28 @@ but not implemented on your system"
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
+#include <linux/keyctl.h>
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
@@ -7650,6 +7672,9 @@ fi
 
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
index 13fc6c4c75..34f5ed75ff 100644
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
@@ -124,6 +128,143 @@ static void test_secret_indirect_emptyfile(void)
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
@@ -426,6 +567,19 @@ int main(int argc, char **argv)
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
2.17.1


