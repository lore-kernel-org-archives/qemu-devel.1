Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC22207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZDJ3dWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC22207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMSF-0001U4-3O
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMO4-000258-Gh
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:32:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMO3-0006dr-47
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590687129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kekca5TgxhCTuA3iWE5rHj7nsO0dupRjp/t2vrZeRK4=;
 b=RZDJ3dWp7l4lc8H4F3q0NKY6P6Kkcu8eKvSH+kmhI8gaCCJMGQTSibuMy3BuheymM8Kmc3
 emGDTcvF490t5pyD4K849R+p3X2GiAKeAoLKQ7I16TWCA5QROzM0x6lkEAdsrFR1LMOfSF
 kMv/aRS6wt9UNDxkM0un1BdP4GReWFQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-_LXV9mj1M-6yc-6ugOujjw-1; Thu, 28 May 2020 13:32:04 -0400
X-MC-Unique: _LXV9mj1M-6yc-6ugOujjw-1
Received: by mail-wr1-f69.google.com with SMTP id y7so12828430wrd.12
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kekca5TgxhCTuA3iWE5rHj7nsO0dupRjp/t2vrZeRK4=;
 b=G8kr6Mo03vE7kK16eCIYYCG7IFKxdxOVVPRy7xRu8EXPAL2YRvs+0XPYuzFSlsKGQd
 EeFM+OF8Btyy8WpkVzh5EH/J7G8/v5VmZZnJHZ3P1DPFbCm6XrLl5zjCyqzOhihr6g/z
 ao20h0TErmNWYRlOCftWtrwPHuCfmp9LkDRSvDQVVkbZdKc1bMVJhba8ejFBD+3XJE6v
 0Q+ZakkkY93wiXgtfCjm5h3lqZnAASw/6e0yDinuTjIMJ9vF/gt3kX/GlOlSrY9mWKhX
 1P7IAeZKftXY8HknPGHaaqzsDaAKKekaqpJ8anG16JSZbDJuMIeumWh2nd2UQ97np3o4
 rWYQ==
X-Gm-Message-State: AOAM532FfEbwwB2Olim3nqcvi0qcLK+T/aihdFSk4YtKf17v9fDA/yWw
 JjPoTC/lkwjjmO5huuImcPAmfnUJeyGfsSo4/kkA9Hbb4K7MmoAxZs61uUtY5P0Aa9y+9QkNxgL
 h3O+8ZfSiNUQAzn4=
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr4499823wrj.227.1590687122709; 
 Thu, 28 May 2020 10:32:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCR+XP9GZCWEFHntH0IImBUe06vsnB3EZU4XdWvfrgyWmk0qvjChUNte4mWsMBMMqLbjChZw==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr4499797wrj.227.1590687122378; 
 Thu, 28 May 2020 10:32:02 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id 186sm2203453wma.45.2020.05.28.10.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:32:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 4/5] crypto: Add tls-cipher-suites object
Date: Thu, 28 May 2020 19:31:40 +0200
Message-Id: <20200528173141.17495-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528173141.17495-1-philmd@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Example of use to dump:

  $ qemu-system-x86_64 -S \
    -object tls-cipher-suites,id=mysuite,priority=@SYSTEM \
    -trace qcrypto\*
  1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
  1590664444.197219:qcrypto_tls_cipher_suite_info data:[0x13, 0x02] version:TLS1.3 name:TLS_AES_256_GCM_SHA384
  1590664444.197228:qcrypto_tls_cipher_suite_info data:[0x13, 0x03] version:TLS1.3 name:TLS_CHACHA20_POLY1305_SHA256
  1590664444.197233:qcrypto_tls_cipher_suite_info data:[0x13, 0x01] version:TLS1.3 name:TLS_AES_128_GCM_SHA256
  1590664444.197236:qcrypto_tls_cipher_suite_info data:[0x13, 0x04] version:TLS1.3 name:TLS_AES_128_CCM_SHA256
  1590664444.197240:qcrypto_tls_cipher_suite_info data:[0xc0, 0x30] version:TLS1.2 name:TLS_ECDHE_RSA_AES_256_GCM_SHA384
  1590664444.197245:qcrypto_tls_cipher_suite_info data:[0xcc, 0xa8] version:TLS1.2 name:TLS_ECDHE_RSA_CHACHA20_POLY1305
  1590664444.197250:qcrypto_tls_cipher_suite_info data:[0xc0, 0x14] version:TLS1.0 name:TLS_ECDHE_RSA_AES_256_CBC_SHA1
  1590664444.197254:qcrypto_tls_cipher_suite_info data:[0xc0, 0x2f] version:TLS1.2 name:TLS_ECDHE_RSA_AES_128_GCM_SHA256
  1590664444.197258:qcrypto_tls_cipher_suite_info data:[0xc0, 0x13] version:TLS1.0 name:TLS_ECDHE_RSA_AES_128_CBC_SHA1
  1590664444.197261:qcrypto_tls_cipher_suite_info data:[0xc0, 0x2c] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
  1590664444.197266:qcrypto_tls_cipher_suite_info data:[0xcc, 0xa9] version:TLS1.2 name:TLS_ECDHE_ECDSA_CHACHA20_POLY1305
  1590664444.197270:qcrypto_tls_cipher_suite_info data:[0xc0, 0xad] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_256_CCM
  1590664444.197274:qcrypto_tls_cipher_suite_info data:[0xc0, 0x0a] version:TLS1.0 name:TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
  1590664444.197278:qcrypto_tls_cipher_suite_info data:[0xc0, 0x2b] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
  1590664444.197283:qcrypto_tls_cipher_suite_info data:[0xc0, 0xac] version:TLS1.2 name:TLS_ECDHE_ECDSA_AES_128_CCM
  1590664444.197287:qcrypto_tls_cipher_suite_info data:[0xc0, 0x09] version:TLS1.0 name:TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
  1590664444.197291:qcrypto_tls_cipher_suite_info data:[0x00, 0x9d] version:TLS1.2 name:TLS_RSA_AES_256_GCM_SHA384
  1590664444.197296:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9d] version:TLS1.2 name:TLS_RSA_AES_256_CCM
  1590664444.197300:qcrypto_tls_cipher_suite_info data:[0x00, 0x35] version:TLS1.0 name:TLS_RSA_AES_256_CBC_SHA1
  1590664444.197304:qcrypto_tls_cipher_suite_info data:[0x00, 0x9c] version:TLS1.2 name:TLS_RSA_AES_128_GCM_SHA256
  1590664444.197308:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9c] version:TLS1.2 name:TLS_RSA_AES_128_CCM
  1590664444.197312:qcrypto_tls_cipher_suite_info data:[0x00, 0x2f] version:TLS1.0 name:TLS_RSA_AES_128_CBC_SHA1
  1590664444.197316:qcrypto_tls_cipher_suite_info data:[0x00, 0x9f] version:TLS1.2 name:TLS_DHE_RSA_AES_256_GCM_SHA384
  1590664444.197320:qcrypto_tls_cipher_suite_info data:[0xcc, 0xaa] version:TLS1.2 name:TLS_DHE_RSA_CHACHA20_POLY1305
  1590664444.197325:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9f] version:TLS1.2 name:TLS_DHE_RSA_AES_256_CCM
  1590664444.197329:qcrypto_tls_cipher_suite_info data:[0x00, 0x39] version:TLS1.0 name:TLS_DHE_RSA_AES_256_CBC_SHA1
  1590664444.197333:qcrypto_tls_cipher_suite_info data:[0x00, 0x9e] version:TLS1.2 name:TLS_DHE_RSA_AES_128_GCM_SHA256
  1590664444.197337:qcrypto_tls_cipher_suite_info data:[0xc0, 0x9e] version:TLS1.2 name:TLS_DHE_RSA_AES_128_CCM
  1590664444.197341:qcrypto_tls_cipher_suite_info data:[0x00, 0x33] version:TLS1.0 name:TLS_DHE_RSA_AES_128_CBC_SHA1
  1590664444.197345:qcrypto_tls_cipher_suite_count count: 29

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v7:
- Use Laszlo's loop with enum mode (lersek)
- Convert debug printf to trace events (danpb)
- Use buildsys CONFIG_GNUTLS instead of C ifdef'ry (danpb)
---
 include/crypto/tls-cipher-suites.h |  38 +++++++++
 crypto/tls-cipher-suites.c         | 127 +++++++++++++++++++++++++++++
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 ++
 4 files changed, 171 insertions(+)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
new file mode 100644
index 0000000000..20a7c74edf
--- /dev/null
+++ b/include/crypto/tls-cipher-suites.h
@@ -0,0 +1,38 @@
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
+} QEMU_PACKED IANA_TLS_CIPHER;
+
+typedef struct QCryptoTLSCipherSuites {
+    /* <private> */
+    QCryptoTLSCreds parent_obj;
+
+    /* <public> */
+    IANA_TLS_CIPHER *cipher_list;
+    unsigned cipher_count;
+} QCryptoTLSCipherSuites;
+
+#endif /* QCRYPTO_TLSCIPHERSUITES_H */
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
new file mode 100644
index 0000000000..f02a041f9a
--- /dev/null
+++ b/crypto/tls-cipher-suites.c
@@ -0,0 +1,127 @@
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
+#include "trace.h"
+
+static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
+                                const char *priority_name, Error **errp)
+{
+    int ret;
+    const char *err;
+    gnutls_priority_t pcache;
+    enum { M_ENUMERATE, M_GENERATE, M_DONE } mode;
+
+    assert(priority_name);
+    trace_qcrypto_tls_cipher_suite_priority(priority_name);
+    ret = gnutls_priority_init(&pcache, priority_name, &err);
+    if (ret < 0) {
+        error_setg(errp, "Syntax error using priority '%s': %s",
+                   priority_name, gnutls_strerror(ret));
+        return;
+    }
+
+    for (mode = M_ENUMERATE; mode < M_DONE; mode++) {
+        size_t i;
+
+        for (i = 0;; i++) {
+            int ret;
+            unsigned idx;
+            const char *name;
+            IANA_TLS_CIPHER cipher;
+            gnutls_protocol_t protocol;
+
+            ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
+            if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
+                break;
+            }
+            if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
+                continue;
+            }
+
+            name = gnutls_cipher_suite_info(idx, (unsigned char *)&cipher,
+                                            NULL, NULL, NULL, &protocol);
+            if (name == NULL) {
+                continue;
+            }
+
+            if (mode == M_GENERATE) {
+                const char *version;
+
+                version = gnutls_protocol_get_name(protocol);
+                trace_qcrypto_tls_cipher_suite_info(cipher.data[0],
+                                                    cipher.data[1],
+                                                    version, name);
+                s->cipher_list[s->cipher_count] = cipher;
+            }
+            s->cipher_count++;
+        }
+
+        if (mode == M_ENUMERATE) {
+            if (s->cipher_count == 0) {
+                break;
+            }
+            s->cipher_list = g_new(IANA_TLS_CIPHER, s->cipher_count);
+            s->cipher_count = 0;
+        }
+    }
+    trace_qcrypto_tls_cipher_suite_count(s->cipher_count);
+    gnutls_priority_deinit(pcache);
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
index c2a371b0b4..1c1b5e21ff 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
+crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredspsk.o
diff --git a/crypto/trace-events b/crypto/trace-events
index 9e594d30e8..c07a752b50 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -21,3 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
 # tlssession.c
 qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
+
+# tls-cipher-suites.c
+qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
+qcrypto_tls_cipher_suite_info(uint8_t data0, uint8_t data1, const char *version, const char *name) "data:[0x%02x, 0x%02x] version:%s name:%s"
+qcrypto_tls_cipher_suite_count(unsigned count) "count: %u"
-- 
2.21.3


