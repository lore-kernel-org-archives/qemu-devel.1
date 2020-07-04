Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3250220723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR+EJsN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3250220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlE4-0001yl-Cl
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCb-0008EX-NF
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlCY-0005QZ-Ts
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593880782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGgpow3fwqJFSNYPiLjkxhuOpLJ3WBNs9Q9LxXK/UYk=;
 b=OR+EJsN7QaiPm77/WRGL9/fZ7tmUo52H3CsOm/WXzbPBxHY44X4QIvsgpXDVVZCztwN8jg
 1CbrknUFbbFOlc9lX4saMNdsbP3/7ezbWoWuyYugH0FZ75/R2ihm2KwN3pJGSBVgKJcEBB
 wsCwwIr7rKoRoJ2rxMznfoDMn+pKX0Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-HYY6zhycPmiXQpKZBXNflQ-1; Sat, 04 Jul 2020 12:39:36 -0400
X-MC-Unique: HYY6zhycPmiXQpKZBXNflQ-1
Received: by mail-wr1-f69.google.com with SMTP id j3so16494149wrq.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tGgpow3fwqJFSNYPiLjkxhuOpLJ3WBNs9Q9LxXK/UYk=;
 b=Oo/NFLPZrtWX7KMZLWllAVSjvxRDZFcM4Lst3bzFXV+ZdpUE6H+QzBDwMmk/aTbVCV
 QaxV+HtVC0dNmWY0gv8lJdcp0PYp1PyUiYpKNpQYMBe6OJ5m/cpQ19fCOb8dsRACd7C/
 XAT19Qd0Lf+SqafoTooBlhkO6gDl60vYHTG4RN2MHudo2SV9vzgY52gNWALsXF00JFiW
 19JG7BNpftJ7evuX5I1WY4WCbkxqGTeoidBm74tpY+3kQZvJ2dNSnVbtw1Z0gJ103+qp
 H+8nRgtIduDyF7Z9nOz+LqWno729mThy64zw3kg2lUOvUuXHLFY9AeCEA/FQ+QsELPs8
 cyzQ==
X-Gm-Message-State: AOAM532azBU1nL3CryfkDEYghYeRnKyHb4l/r6mzmaRcRkLUFh8giYmX
 dzyNYvGMV1rwkuoaKmrLn4F83mOehlIBv2jTvZ0exud8fsxhntl/v+HoK8h1j7XubuoArMmF35P
 /UtK3wsy0Xb0pEMQ=
X-Received: by 2002:a05:600c:2483:: with SMTP id
 3mr2535081wms.120.1593880775332; 
 Sat, 04 Jul 2020 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv/k7RO+RQuZB9oZZkiFzi2raaBePLIpC0SLyxIrAPEFeX3z5iGrBLf48Fm8a7wskDFjRdqw==
X-Received: by 2002:a05:600c:2483:: with SMTP id
 3mr2535067wms.120.1593880775000; 
 Sat, 04 Jul 2020 09:39:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z25sm16145518wmk.28.2020.07.04.09.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 09:39:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] crypto: Add tls-cipher-suites object
Date: Sat,  4 Jul 2020 18:39:23 +0200
Message-Id: <20200704163927.28188-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704163927.28188-1-philmd@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On the host OS, various aspects of TLS operation are configurable.
In particular it is possible for the sysadmin to control the TLS
cipher/protocol algorithms that applications are permitted to use.

* Any given crypto library has a built-in default priority list
  defined by the distro maintainer of the library package (or by
  upstream).

* The "crypto-policies" RPM (or equivalent host OS package)
  provides a config file such as "/etc/crypto-policies/config",
  where the sysadmin can set a high level (library-independent)
  policy.

  The "update-crypto-policies --set" command (or equivalent) is
  used to translate the global policy to individual library
  representations, producing files such as
  "/etc/crypto-policies/back-ends/*.config". The generated files,
  if present, are loaded by the various crypto libraries to
  override their own built-in defaults.

  For example, the GNUTLS library may read
  "/etc/crypto-policies/back-ends/gnutls.config".

* A management application (or the QEMU user) may overide the
  system-wide crypto-policies config via their own config, if
  they need to diverge from the former.

Thus the priority order is "QEMU user config" > "crypto-policies
system config" > "library built-in config".

Introduce the "tls-cipher-suites" object for exposing the ordered
list of permitted TLS cipher suites from the host side to the
guest firmware, via fw_cfg. The list is represented as an array
of bytes.

The priority at which the host-side policy is retrieved is given
by the "priority" property of the new object type. For example,
"priority=@SYSTEM" may be used to refer to
"/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU
uses GNUTLS).

The firmware uses the IANA_TLS_CIPHER array for configuring
guest-side TLS, for example in UEFI HTTPS Boot.

[Description from Daniel P. Berrangé, edited by Laszlo Ersek.]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200623172726.21040-2-philmd@redhat.com>
---
 include/crypto/tls-cipher-suites.h |  39 ++++++++++
 crypto/tls-cipher-suites.c         | 115 +++++++++++++++++++++++++++++
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 ++
 qemu-options.hx                    |  19 +++++
 5 files changed, 179 insertions(+)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
new file mode 100644
index 0000000000..28b3a73ce1
--- /dev/null
+++ b/include/crypto/tls-cipher-suites.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU TLS Cipher Suites Registry (RFC8447)
+ *
+ * Copyright (c) 2018-2020 Red Hat, Inc.
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
+typedef struct QCryptoTLSCipherSuites {
+    /* <private> */
+    QCryptoTLSCreds parent_obj;
+    /* <public> */
+} QCryptoTLSCipherSuites;
+
+/**
+  * qcrypto_tls_cipher_suites_get_data:
+  * @obj: pointer to a TLS cipher suites object
+  * @errp: pointer to a NULL-initialized error object
+  *
+  * Returns: reference to a byte array containing the data.
+  * The caller should release the reference when no longer
+  * required.
+  */
+GByteArray *qcrypto_tls_cipher_suites_get_data(QCryptoTLSCipherSuites *obj,
+                                               Error **errp);
+
+#endif /* QCRYPTO_TLSCIPHERSUITES_H */
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
new file mode 100644
index 0000000000..a4e0f84307
--- /dev/null
+++ b/crypto/tls-cipher-suites.c
@@ -0,0 +1,115 @@
+/*
+ * QEMU TLS Cipher Suites
+ *
+ * Copyright (c) 2018-2020 Red Hat, Inc.
+ *
+ * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "crypto/tlscreds.h"
+#include "crypto/tls-cipher-suites.h"
+#include "trace.h"
+
+/*
+ * IANA registered TLS ciphers:
+ * https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4
+ */
+typedef struct {
+    uint8_t data[2];
+} QEMU_PACKED IANA_TLS_CIPHER;
+
+GByteArray *qcrypto_tls_cipher_suites_get_data(QCryptoTLSCipherSuites *obj,
+                                               Error **errp)
+{
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(obj);
+    gnutls_priority_t pcache;
+    GByteArray *byte_array;
+    const char *err;
+    size_t i;
+    int ret;
+
+    trace_qcrypto_tls_cipher_suite_priority(creds->priority);
+    ret = gnutls_priority_init(&pcache, creds->priority, &err);
+    if (ret < 0) {
+        error_setg(errp, "Syntax error using priority '%s': %s",
+                   creds->priority, gnutls_strerror(ret));
+        return NULL;
+    }
+
+    byte_array = g_byte_array_new();
+
+    for (i = 0;; i++) {
+        int ret;
+        unsigned idx;
+        const char *name;
+        IANA_TLS_CIPHER cipher;
+        gnutls_protocol_t protocol;
+        const char *version;
+
+        ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
+        if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
+            break;
+        }
+        if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
+            continue;
+        }
+
+        name = gnutls_cipher_suite_info(idx, (unsigned char *)&cipher,
+                                        NULL, NULL, NULL, &protocol);
+        if (name == NULL) {
+            continue;
+        }
+
+        version = gnutls_protocol_get_name(protocol);
+        g_byte_array_append(byte_array, cipher.data, 2);
+        trace_qcrypto_tls_cipher_suite_info(cipher.data[0],
+                                            cipher.data[1],
+                                            version, name);
+    }
+    trace_qcrypto_tls_cipher_suite_count(byte_array->len);
+    gnutls_priority_deinit(pcache);
+
+    return byte_array;
+}
+
+static void qcrypto_tls_cipher_suites_complete(UserCreatable *uc,
+                                               Error **errp)
+{
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(uc);
+
+    if (!creds->priority) {
+        error_setg(errp, "'priority' property is not set");
+        return;
+    }
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
+    .instance_size = sizeof(QCryptoTLSCreds),
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
index 707c02ad37..f1965b1a68 100644
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
index 9e594d30e8..798b6067ab 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -21,3 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
 # tlssession.c
 qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
+
+# tls-cipher-suites.c
+qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
+qcrypto_tls_cipher_suite_info(uint8_t data0, uint8_t data1, const char *version, const char *name) "data=[0x%02x,0x%02x] version=%s name=%s"
+qcrypto_tls_cipher_suite_count(unsigned count) "count: %u"
diff --git a/qemu-options.hx b/qemu-options.hx
index 196f468786..ecc4658e1f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4567,6 +4567,25 @@ SRST
         string as described at
         https://gnutls.org/manual/html_node/Priority-Strings.html.
 
+    ``-object tls-cipher-suites,id=id,priority=priority``
+        Creates a TLS cipher suites object, which can be used to control
+        the TLS cipher/protocol algorithms that applications are permitted
+        to use.
+
+        The ``id`` parameter is a unique ID which frontends will use to
+        access the ordered list of permitted TLS cipher suites from the
+        host.
+
+        The ``priority`` parameter allows to override the global default
+        priority used by gnutls. This can be useful if the system
+        administrator needs to use a weaker set of crypto priorities for
+        QEMU without potentially forcing the weakness onto all
+        applications. Or conversely if one wants wants a stronger
+        default for QEMU than for all other applications, they can do
+        this through this parameter. Its format is a gnutls priority
+        string as described at
+        https://gnutls.org/manual/html_node/Priority-Strings.html.
+
     ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
         Interval t can't be 0, this filter batches the packet delivery:
         all packets arriving in a given interval on netdev netdevid are
-- 
2.21.3


