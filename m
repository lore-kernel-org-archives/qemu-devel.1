Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B985C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D56204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQs/8P7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D56204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6vV-0003uU-3z
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rV-00061V-Ht
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:21:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rT-0008Us-8n
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVQVAAvXbqJcDyYus8SsyTCycxmjXkzrJy0FVLgtSug=;
 b=fQs/8P7tr/O1UTOPK1oN1qGkDvswGxgFYO06bRSPyovhreB8Jbgh4BycshcnyOb2oRpTHV
 PuQIygPUWv38XLG7yazFfZt7die+eUwFM3kNAmnWI4B+Qy7aJLFJ+OXz0rdUsEcGNxRZSZ
 Ge4ks27WdpsbYHVveuMwsWNj28MlYRM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-FBUXAgSxM-a3CCLdDlkl_A-1; Tue, 19 May 2020 14:20:50 -0400
X-MC-Unique: FBUXAgSxM-a3CCLdDlkl_A-1
Received: by mail-wm1-f69.google.com with SMTP id m11so22860wml.5
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LVQVAAvXbqJcDyYus8SsyTCycxmjXkzrJy0FVLgtSug=;
 b=BRSIyRUC2/jt2s/oySSRSzGR9wTrJnMxehWVuhPK1nqew/SGmttzOqr3rnpmKUiVhE
 ru36ZMxVz7Tt8tPEQsnNkixLhtFgKB+xoV7CVrra6dtPN65Ma9WSISN8uBpjrTRR8sZS
 Kfo+1LwZpcLYIgWbpAFEZIaIgf8+TdFhyVHXXIN8PXicp8J44Hpen00fliXAwP6aWG2o
 yWAYO56s5XTW7FQd1FWfuwYrx0RVqzZ8TSTT33Bj/Re+XmhVQ5qQmd3l9qZgOh8stxnh
 DdiX+3Rq+l9BgJldOSRakswzRuMXgghRC+fOzhIQ5qhRKOIhXyMHqCD+YYJ9G3qbMsSA
 eo2w==
X-Gm-Message-State: AOAM531OhkS0eACK6l7aN0R5IiPs9C+Hk6a9FB+ML0Eh8eF+pibJVA67
 LDjEPYiU/hS7+uDUHKuYKKIrYMqUBs6LxoxwY1oejoKhplLZ9QqpruQvVtx7o7tn1fbshcCASSf
 II1agFtJ5CjfohNU=
X-Received: by 2002:a1c:f312:: with SMTP id q18mr643640wmq.175.1589912448955; 
 Tue, 19 May 2020 11:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbccqL21xiOc/RTj3tNHHTOb7oqAs61SOpDqXOBC/cnnoJ8AHVh87T3DWNRuVKFfUvfbIRcQ==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr643608wmq.175.1589912448655; 
 Tue, 19 May 2020 11:20:48 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o24sm463708wmm.33.2020.05.19.11.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:20:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/5] crypto: Add tls-cipher-suites object
Date: Tue, 19 May 2020 20:20:23 +0200
Message-Id: <20200519182024.14638-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200519182024.14638-1-philmd@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Example of use to dump:

  $ qemu-system-x86_64 -S \
    -object tls-cipher-suites,id=mysuite,priority=@SYSTEM,verbose=yes
  Cipher suites for @SYSTEM:
  - TLS_AES_256_GCM_SHA384                                0x13, 0x02      TLS1.3
  - TLS_CHACHA20_POLY1305_SHA256                          0x13, 0x03      TLS1.3
  - TLS_AES_128_GCM_SHA256                                0x13, 0x01      TLS1.3
  - TLS_AES_128_CCM_SHA256                                0x13, 0x04      TLS1.3
  - TLS_ECDHE_RSA_AES_256_GCM_SHA384                      0xc0, 0x30      TLS1.2
  - TLS_ECDHE_RSA_CHACHA20_POLY1305                       0xcc, 0xa8      TLS1.2
  - TLS_ECDHE_RSA_AES_256_CBC_SHA1                        0xc0, 0x14      TLS1.0
  - TLS_ECDHE_RSA_AES_128_GCM_SHA256                      0xc0, 0x2f      TLS1.2
  - TLS_ECDHE_RSA_AES_128_CBC_SHA1                        0xc0, 0x13      TLS1.0
  - TLS_ECDHE_ECDSA_AES_256_GCM_SHA384                    0xc0, 0x2c      TLS1.2
  - TLS_ECDHE_ECDSA_CHACHA20_POLY1305                     0xcc, 0xa9      TLS1.2
  - TLS_ECDHE_ECDSA_AES_256_CCM                           0xc0, 0xad      TLS1.2
  - TLS_ECDHE_ECDSA_AES_256_CBC_SHA1                      0xc0, 0x0a      TLS1.0
  - TLS_ECDHE_ECDSA_AES_128_GCM_SHA256                    0xc0, 0x2b      TLS1.2
  - TLS_ECDHE_ECDSA_AES_128_CCM                           0xc0, 0xac      TLS1.2
  - TLS_ECDHE_ECDSA_AES_128_CBC_SHA1                      0xc0, 0x09      TLS1.0
  - TLS_RSA_AES_256_GCM_SHA384                            0x00, 0x9d      TLS1.2
  - TLS_RSA_AES_256_CCM                                   0xc0, 0x9d      TLS1.2
  - TLS_RSA_AES_256_CBC_SHA1                              0x00, 0x35      TLS1.0
  - TLS_RSA_AES_128_GCM_SHA256                            0x00, 0x9c      TLS1.2
  - TLS_RSA_AES_128_CCM                                   0xc0, 0x9c      TLS1.2
  - TLS_RSA_AES_128_CBC_SHA1                              0x00, 0x2f      TLS1.0
  - TLS_DHE_RSA_AES_256_GCM_SHA384                        0x00, 0x9f      TLS1.2
  - TLS_DHE_RSA_CHACHA20_POLY1305                         0xcc, 0xaa      TLS1.2
  - TLS_DHE_RSA_AES_256_CCM                               0xc0, 0x9f      TLS1.2
  - TLS_DHE_RSA_AES_256_CBC_SHA1                          0x00, 0x39      TLS1.0
  - TLS_DHE_RSA_AES_128_GCM_SHA256                        0x00, 0x9e      TLS1.2
  - TLS_DHE_RSA_AES_128_CCM                               0xc0, 0x9e      TLS1.2
  - TLS_DHE_RSA_AES_128_CBC_SHA1                          0x00, 0x33      TLS1.0
  total: 29 ciphers

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/crypto/tls-cipher-suites.h |  39 +++++++++
 crypto/tls-cipher-suites.c         | 133 +++++++++++++++++++++++++++++
 crypto/Makefile.objs               |   1 +
 3 files changed, 173 insertions(+)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
new file mode 100644
index 0000000000..31e92916e1
--- /dev/null
+++ b/include/crypto/tls-cipher-suites.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU TLS Cipher Suites
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QCRYPTO_TLSCIPHERSUITES_H
+#define QCRYPTO_TLSCIPHERSUITES_H
+
+#include "qom/object.h"
+#include "crypto/tlscreds.h"
+
+#define TYPE_QCRYPTO_TLS_CIPHER_SUITES "tls-cipher-suites"
+#define QCRYPTO_TLS_CIPHER_SUITES(obj) \
+    OBJECT_CHECK(QCryptoTLSCipherSuites, (obj), TYPE_QCRYPTO_TLS_CIPHER_SUITES)
+
+/*
+ * IANA registered TLS ciphers:
+ * https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4
+ */
+typedef struct {
+    uint8_t data[2];
+} IANA_TLS_CIPHER;
+
+typedef struct QCryptoTLSCipherSuites {
+    /* <private> */
+    QCryptoTLSCreds parent_obj;
+
+    /* <public> */
+    bool verbose;
+    IANA_TLS_CIPHER *cipher_list;
+    unsigned cipher_count;
+} QCryptoTLSCipherSuites;
+
+#endif /* QCRYPTO_TLSCIPHERSUITES_H */
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
new file mode 100644
index 0000000000..c6c51359bd
--- /dev/null
+++ b/crypto/tls-cipher-suites.c
@@ -0,0 +1,133 @@
+/*
+ * QEMU TLS Cipher Suites
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/error-report.h"
+#include "crypto/tlscreds.h"
+#include "crypto/tls-cipher-suites.h"
+
+static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
+                                const char *priority_name, Error **errp)
+{
+#ifdef CONFIG_GNUTLS
+    int ret;
+    unsigned int idx;
+    const char *name;
+    const char *err;
+    gnutls_protocol_t version;
+    gnutls_priority_t pcache;
+
+    assert(priority_name);
+    ret = gnutls_priority_init(&pcache, priority_name, &err);
+    if (ret < 0) {
+        error_setg(errp, "Syntax error using priority '%s': %s",
+                   priority_name, gnutls_strerror(ret));
+        return;
+    }
+
+    if (s->verbose) {
+        fprintf(stderr, "Cipher suites for %s:\n", priority_name);
+    }
+    for (size_t i = 0;; i++) {
+        ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
+        if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
+            break;
+        }
+        if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
+            continue;
+        }
+        s->cipher_list = g_renew(IANA_TLS_CIPHER,
+                                 s->cipher_list, s->cipher_count + 1);
+
+        name = gnutls_cipher_suite_info(idx,
+                                        s->cipher_list[s->cipher_count].data,
+                                        NULL, NULL, NULL, &version);
+        if (name != NULL) {
+            if (s->verbose) {
+                fprintf(stderr, "- %-50s\t0x%02x, 0x%02x\t%s\n", name,
+                        s->cipher_list[s->cipher_count].data[0],
+                        s->cipher_list[s->cipher_count].data[1],
+                        gnutls_protocol_get_name(version));
+            }
+            s->cipher_count++;
+       }
+    }
+    if (s->verbose) {
+        fprintf(stderr, "total: %u ciphers\n", s->cipher_count);
+    }
+    gnutls_priority_deinit(pcache);
+#else
+    error_setg(errp, "GNU TLS not available");
+#endif /* CONFIG_GNUTLS */
+}
+
+static void qcrypto_tls_cipher_suites_complete(UserCreatable *uc, Error **errp)
+{
+    QCryptoTLSCreds *s = QCRYPTO_TLS_CREDS(uc);
+
+    if (!s->priority) {
+        error_setg(errp, "'priority' property is not set");
+        return;
+    }
+    parse_cipher_suites(QCRYPTO_TLS_CIPHER_SUITES(s), s->priority, errp);
+}
+
+static void qcrypto_tls_cipher_suites_set_verbose(Object *obj, bool value,
+                                                 Error **errp G_GNUC_UNUSED)
+{
+    QCRYPTO_TLS_CIPHER_SUITES(obj)->verbose = value;
+}
+
+
+static bool qcrypto_tls_cipher_suites_get_verbose(Object *obj,
+                                                 Error **errp G_GNUC_UNUSED)
+{
+    return QCRYPTO_TLS_CIPHER_SUITES(obj)->verbose;
+}
+
+static void qcrypto_tls_cipher_suites_finalize(Object *obj)
+{
+    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
+
+    g_free(s->cipher_list);
+}
+
+static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    ucc->complete = qcrypto_tls_cipher_suites_complete;
+
+    object_class_property_add_bool(oc, "verbose",
+                                   qcrypto_tls_cipher_suites_get_verbose,
+                                   qcrypto_tls_cipher_suites_set_verbose);
+}
+
+static const TypeInfo qcrypto_tls_cipher_suites_info = {
+    .parent = TYPE_QCRYPTO_TLS_CREDS,
+    .name = TYPE_QCRYPTO_TLS_CIPHER_SUITES,
+    .instance_size = sizeof(QCryptoTLSCipherSuites),
+    .instance_finalize = qcrypto_tls_cipher_suites_finalize,
+    .class_size = sizeof(QCryptoTLSCredsClass),
+    .class_init = qcrypto_tls_cipher_suites_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void qcrypto_tls_cipher_suites_register_types(void)
+{
+    type_register_static(&qcrypto_tls_cipher_suites_info);
+}
+
+type_init(qcrypto_tls_cipher_suites_register_types);
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index c2a371b0b4..ce706d322a 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
+crypto-obj-y += tls-cipher-suites.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredspsk.o
-- 
2.21.3


