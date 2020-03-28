Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB92C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 14:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF5F206F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ic0nQMeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF5F206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jICpA-0004LU-Sa
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jI9pI-00087L-HQ
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 07:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jI9pE-0005Fl-Jm
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 07:40:30 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:47348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jI9pD-0005C3-T1
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 07:40:28 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 450152E09D9;
 Sat, 28 Mar 2020 14:40:22 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 txwmjhNGTR-eM8iv00B; Sat, 28 Mar 2020 14:40:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1585395622; bh=4eVtLQG3em9wzX00O5mcBGQDiDZUIbsALFFrNXvVOaE=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=ic0nQMeWWDucDA7H5XVq3ws5imhsbVerEngPFVKZMs2cZ3Kzbhfi3QXb6az8odYBG
 q9wvuBeHbVXwvZYMBEeaQR2Y7JZTznHe9kbJqU8xpAnPTI5LJLrCita+hyBzEMDdSJ
 2keehLg03dwyB9SMfmei6Muw6W1F5K0S4WtF8j1c=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8404::1:3])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 6lMAd8fQ0l-eLWWloOM; Sat, 28 Mar 2020 14:40:21 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH] crypto/secret: support fetching secrets from Linux keyring
Date: Sat, 28 Mar 2020 14:40:14 +0300
Message-Id: <20200328114014.6362-1-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
X-Mailman-Approved-At: Sat, 28 Mar 2020 10:51:49 -0400
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

Add the ability for the secret object to obtain secret data from the
Linux in-kernel key managment and retention facility, as an extra option
to the existing ones: reading from a file or passing directly as a
string.

The secret is identified by the key serial number.  The upper layers
need to instantiate the key and make sure the QEMU process has access
rights to read it.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 crypto/secret.c         | 88 +++++++++++++++++++++++++++++++++++++++--
 include/crypto/secret.h |  3 ++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/crypto/secret.c b/crypto/secret.c
index 1cf0ad0ce8..2e8be6241c 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -19,6 +19,8 @@
  */
 
 #include "qemu/osdep.h"
+#include <asm/unistd.h>
+#include <linux/keyctl.h>
 #include "crypto/secret.h"
 #include "crypto/cipher.h"
 #include "qapi/error.h"
@@ -28,6 +30,40 @@
 #include "trace.h"
 
 
+static inline
+long keyctl_read(key_serial_t key, uint8_t *buffer, size_t buflen)
+{
+#ifdef __NR_keyctl
+    return syscall(__NR_keyctl, KEYCTL_READ, key, buffer, buflen, 0);
+#else
+    errno = ENOSYS;
+    return -1;
+#endif
+}
+
+static
+long keyctl_read_alloc(key_serial_t key, uint8_t **buffer)
+{
+    uint8_t *loc_buf;
+    long retcode = keyctl_read(key, NULL, 0);
+    if (retcode < 0) {
+        return retcode;
+    }
+    loc_buf = g_malloc(retcode + 1);
+    retcode = keyctl_read(key, loc_buf, retcode + 1);
+   /*
+    * We don't have key operations locks between syscalls.
+    * For example, the key could have been removed or expired.
+    */
+    if (retcode >= 0) {
+        loc_buf[retcode] = '\0';
+        *buffer = loc_buf;
+    } else {
+        g_free(loc_buf);
+    }
+    return retcode;
+}
+
 static void
 qcrypto_secret_load_data(QCryptoSecret *secret,
                          uint8_t **output,
@@ -41,10 +77,28 @@ qcrypto_secret_load_data(QCryptoSecret *secret,
     *output = NULL;
     *outputlen = 0;
 
-    if (secret->file) {
+    if (secret->syskey) {
+        uint8_t *buffer = NULL;
+        long retcode;
+        if (secret->data || secret->file) {
+            error_setg(errp,
+                       "'syskey', 'file' and 'data' are mutually exclusive");
+            return;
+        }
+        retcode = keyctl_read_alloc(secret->syskey, &buffer);
+        if (retcode < 0) {
+            error_setg_errno(errp, errno,
+                       "Unable to read serial key %08x",
+                       secret->syskey);
+            return;
+        } else {
+            *outputlen = retcode;
+            *output = buffer;
+        }
+    } else if (secret->file) {
         if (secret->data) {
             error_setg(errp,
-                       "'file' and 'data' are mutually exclusive");
+                       "'syskey', 'file' and 'data' are mutually exclusive");
             return;
         }
         if (!g_file_get_contents(secret->file, &data, &length, &gerr)) {
@@ -60,7 +114,8 @@ qcrypto_secret_load_data(QCryptoSecret *secret,
         *outputlen = strlen(secret->data);
         *output = (uint8_t *)g_strdup(secret->data);
     } else {
-        error_setg(errp, "Either 'file' or 'data' must be provided");
+        error_setg(errp,
+                   "Either 'syskey' or 'file' or 'data' must be provided");
     }
 }
 
@@ -298,6 +353,29 @@ qcrypto_secret_prop_get_file(Object *obj,
 }
 
 
+static void
+qcrypto_secret_prop_set_syskey(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    int32_t value;
+    visit_type_int32(v, name, &value, errp);
+    secret->syskey = value;
+}
+
+
+static void
+qcrypto_secret_prop_get_syskey(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    int32_t value = secret->syskey;
+    visit_type_int32(v, name, &value, errp);
+}
+
+
 static void
 qcrypto_secret_prop_set_iv(Object *obj,
                            const char *value,
@@ -384,6 +462,10 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data)
                                   qcrypto_secret_prop_get_file,
                                   qcrypto_secret_prop_set_file,
                                   NULL);
+    object_class_property_add(oc, "syskey", "key_serial_t",
+                                  qcrypto_secret_prop_get_syskey,
+                                  qcrypto_secret_prop_set_syskey,
+                                  NULL, NULL, NULL);
     object_class_property_add_str(oc, "keyid",
                                   qcrypto_secret_prop_get_keyid,
                                   qcrypto_secret_prop_set_keyid,
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index 5e07e29bae..9d350e35ed 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -31,6 +31,8 @@
 typedef struct QCryptoSecret QCryptoSecret;
 typedef struct QCryptoSecretClass QCryptoSecretClass;
 
+typedef int32_t key_serial_t;
+
 /**
  * QCryptoSecret:
  *
@@ -125,6 +127,7 @@ struct QCryptoSecret {
     QCryptoSecretFormat format;
     char *data;
     char *file;
+    key_serial_t syskey;
     char *keyid;
     char *iv;
 };
-- 
2.17.1


