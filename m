Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F4C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCD4206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KEbF9j5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCD4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOqUp-0005S9-78
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 18:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTZ-0003qn-3E
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTX-0003tl-Or
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:45 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jOqTX-0003s4-CQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:43 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 4F7AB2E164A;
 Thu, 16 Apr 2020 01:25:38 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 8Pd0U4H8GE-PcMmR27f; Thu, 16 Apr 2020 01:25:38 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586989538; bh=MfMY9q2td2b1MJFytz7fXEPP8IsDFnaKFqm3ffWfda8=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=KEbF9j5BwobLA/6k54UZCNzJJ499d7Dnx+KinynLnY9lDTk1/rKtkyISVS9HFzH+A
 hG6cWD9oLHVCduCZIxlFmiyLMIva5OV8Ex5q0hrelcLXrmdSBxB7UWKXvFgqT54OAH
 RzsOK5TQqG9UkD4HXeJtT7HYYCg3oLenwnuz1M2A=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:e])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 0wmBaV4yMk-PcXa2cD0; Thu, 16 Apr 2020 01:25:38 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 5/5] test-crypto-secret: add 'syskey' object tests.
Date: Thu, 16 Apr 2020 01:25:25 +0300
Message-Id: <20200415222525.4022-5-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
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

* test_secret_seckey_bad_key_access_right() is not working yet.
  We don't know yet if this due a bag in the Linux kernel or
  whether it's normal syscall behavior.
  We've requested information from kernel maintainer.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 tests/test-crypto-secret.c | 138 +++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
index 13fc6c4c75..6b17fe3a81 100644
--- a/tests/test-crypto-secret.c
+++ b/tests/test-crypto-secret.c
@@ -22,8 +22,10 @@
 
 #include "crypto/init.h"
 #include "crypto/secret.h"
+#include "crypto/linux_keyring.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include <keyutils.h>
 
 static void test_secret_direct(void)
 {
@@ -125,6 +127,132 @@ static void test_secret_indirect_emptyfile(void)
 }
 
 
+#define DESCRIPTION "qemu_test_secret"
+#define PAYLOAD "Test Payload"
+
+
+static void test_secret_seckey_good(void)
+{
+    char key_str[16];
+    Object *sec;
+    key_serial_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+
+    g_assert(key >= 0);
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
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
+static void test_secret_seckey_revoked_key(void)
+{
+    char key_str[16];
+    Object *sec;
+    key_serial_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+    g_assert(key >= 0);
+    g_assert_false(keyctl_revoke(key));
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
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
+static void test_secret_seckey_expired_key(void)
+{
+    char key_str[16];
+    Object *sec;
+    key_serial_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+    g_assert(key >= 0);
+    g_assert_false(keyctl_set_timeout(key, 1));
+    sleep(1);
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
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
+static void test_secret_seckey_bad_serial_key(void)
+{
+    Object *sec;
+
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET,
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
+
+static void test_secret_seckey_bad_key_access_right(void)
+{
+    char key_str[16];
+    Object *sec;
+    key_serial_t key = add_key("user", DESCRIPTION, PAYLOAD,
+                               strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
+    g_assert(key >= 0);
+    g_assert_false(keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_READ)));
+
+    snprintf(key_str, sizeof(key_str), "0x%08x", key);
+
+    sec = object_new_with_props(
+        TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
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
+
 static void test_secret_noconv_base64_good(void)
 {
     Object *sec = object_new_with_props(
@@ -425,6 +553,16 @@ int main(int argc, char **argv)
                     test_secret_indirect_badfile);
     g_test_add_func("/crypto/secret/indirect/emptyfile",
                     test_secret_indirect_emptyfile);
+    g_test_add_func("/crypto/secret/seckey/good",
+                    test_secret_seckey_good);
+    g_test_add_func("/crypto/secret/seckey/revoked_key",
+                    test_secret_seckey_revoked_key);
+    g_test_add_func("/crypto/secret/seckey/expired_key",
+                    test_secret_seckey_expired_key);
+    g_test_add_func("/crypto/secret/seckey/bad_serial_key",
+                    test_secret_seckey_bad_serial_key);
+    g_test_add_func("/crypto/secret/seckey/bad_key_access_right",
+                    test_secret_seckey_bad_key_access_right);
 
     g_test_add_func("/crypto/secret/noconv/base64/good",
                     test_secret_noconv_base64_good);
-- 
2.17.1


