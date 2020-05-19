Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC212C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CA62075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9KaKeFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CA62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6sh-0007BM-UQ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rK-0005kp-7D
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rJ-0008T4-0E
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4M1Sk471/wpIRr2uPISQE7oxsTBasuxbJF2aNsWx5U=;
 b=K9KaKeFA6rdwCgPgovi9w/sopaHItPBQKDx9kR23klJjlrMAyQ9qKrKdcYvTxvBVao4rOz
 oDOYgBG+141fuxkQAB5mpbY4tXDZcuqxggxW2XJQWMtcraDYKGbuE8AJ26lRHJAQ3c6YDZ
 SqwzFp87HSWzEBYJdVzBve5DQmqRZUE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-R6PWDmI2OzqBnFOBMJvlVg-1; Tue, 19 May 2020 14:20:54 -0400
X-MC-Unique: R6PWDmI2OzqBnFOBMJvlVg-1
Received: by mail-wr1-f72.google.com with SMTP id y7so194422wrd.12
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G4M1Sk471/wpIRr2uPISQE7oxsTBasuxbJF2aNsWx5U=;
 b=sr6pFF7KxqjrnOyzc69WHkIMISfpjDk2zL5KkpY+Z6XVECjBnnFxU7DjopQWp7oe0H
 e9sfkfe6SqRx/1k2wZGTGYklra1AZJ1DXuS1/Ct6lH1D7H19JRNqyjKCv1nm+EgOd5Ij
 CTPrXSg/AbWjQP3QPUVEkd0duIPj3SX+np3DOYg+blP4EqSvx0VnXuCKmo9KaTvuCKjZ
 yjFnnC/zUqZz7LiGrNN7PppmEVLGOxSVs0yybpNGNUcIvL8HyogIdBbys22tDpgIaKQ9
 7Go/wWNZuz9OFvNqSsP+E0k6hHYTao3px7dGyTLhsGZE3KC4VYUu07KTTMoimMPHh3px
 NyDQ==
X-Gm-Message-State: AOAM5332dFvkdC7ksyaphMh5hI+lC9OrqExyh2yk6fsaS9ebVUBzQxvE
 rpUl1AZOWn8pj+JRUzVyVUd3xPnYiTQuo+DaP/87F29jWlB2YmZq1qGjoz+Eqz0NjaHisosAyir
 /zkHyj0Bzz8j2fYw=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr669849wmk.3.1589912453406;
 Tue, 19 May 2020 11:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCDUw75o4IQMRaKPxCeuqA75BeOP+5lHCao1PqwaGEZPGR24a4wgHmYR1RE27KrFwivzX0oA==
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr669828wmk.3.1589912453248;
 Tue, 19 May 2020 11:20:53 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r9sm280010wra.52.2020.05.19.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:20:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/5] crypto/tls-cipher-suites: Product fw_cfg consumable
 blob
Date: Tue, 19 May 2020 20:20:24 +0200
Message-Id: <20200519182024.14638-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200519182024.14638-1-philmd@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Since our format is consumable by the fw_cfg device,
we can implement the FW_CFG_DATA_GENERATOR interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 crypto/tls-cipher-suites.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index c6c51359bd..11872783eb 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "crypto/tlscreds.h"
 #include "crypto/tls-cipher-suites.h"
+#include "hw/nvram/fw_cfg.h"
 
 static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
                                 const char *priority_name, Error **errp)
@@ -101,11 +102,28 @@ static void qcrypto_tls_cipher_suites_finalize(Object *obj)
     g_free(s->cipher_list);
 }
 
+static const void *qcrypto_tls_cipher_suites_get_data(Object *obj)
+{
+    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
+
+    return s->cipher_list;
+}
+
+static size_t qcrypto_tls_cipher_suites_get_length(Object *obj)
+{
+    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
+
+    return s->cipher_count * sizeof(IANA_TLS_CIPHER);
+}
+
 static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
 
     ucc->complete = qcrypto_tls_cipher_suites_complete;
+    fwgc->get_data = qcrypto_tls_cipher_suites_get_data;
+    fwgc->get_length = qcrypto_tls_cipher_suites_get_length;
 
     object_class_property_add_bool(oc, "verbose",
                                    qcrypto_tls_cipher_suites_get_verbose,
@@ -121,6 +139,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
     .class_init = qcrypto_tls_cipher_suites_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
     }
 };
-- 
2.21.3


