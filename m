Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4119C207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4dhNb/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4119C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMRt-0000Y5-Er
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMO4-00024D-6H
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:32:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMO3-0006eC-By
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590687130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXuTo3is2py9vIRdq7hNRL5VkVqGS5UwbURK4RrjWrY=;
 b=L4dhNb/r7y7KfMv0RpQuxwcPiYO5oQRhvrdsfoXBqpzwLGm5H559jY1ax6jkmVLt+7fHFF
 ITq7J3xDXfL7RV0kANwUKRB+QY6dPQzVBcmQr/kyLSt4m2L0sSANNPBpDkb6RKOqNd5mTh
 b51gs2vqEsYBd8I5Mzt1UtiCg6O0dNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-syp0XlBwO6qziLVWO15znw-1; Thu, 28 May 2020 13:32:08 -0400
X-MC-Unique: syp0XlBwO6qziLVWO15znw-1
Received: by mail-wm1-f69.google.com with SMTP id k185so1224811wme.8
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zXuTo3is2py9vIRdq7hNRL5VkVqGS5UwbURK4RrjWrY=;
 b=RYTnkulqZSWTXtuQDv8mm2jirdA3PWd38m3W/xdTy2lfaTK5burv65r/TZi1ozq+jV
 8uDgY2/nqk1eiT1fKOPbLGVTVfoR6abI3WRb+s1R3B/Td9IyidEsuah6jFF3804Er56o
 +SFEKAaCgoS4a20HBAeLNARy8dgRYqtX4qvKSWzeEzpuodgmdX93bEzahUKCQ9CtZEIh
 Dacjtq0+TWZeZJt3o9ZuH8z9WxsMnPcbcpX7Tsr/6vLHIugQRlIgANWEurz5GHB3u6EW
 B0th0MRS9ThvMenbVn5oYPpeWCvH8S9D400BKe2rTa0ObnjIdrFemwj6BfP60dR7NqdP
 eaIw==
X-Gm-Message-State: AOAM531FBiliCbrOyGQTxOqeWLVCRS+k6wv6ofUj2hKG1/O57HwfDrY+
 Zhhonvl0jTLNLFJWu2XYgZa08TtSk9MdzmC5KsgFwPm9fVO99rPr4ivyiQkKjmdSQfkazhN+/vE
 Ywx2yx44KgWjL/y0=
X-Received: by 2002:a5d:4c8f:: with SMTP id z15mr4500723wrs.19.1590687127411; 
 Thu, 28 May 2020 10:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9eMzt0M3yERQ1wZqJtS9xffsyZ1dtSCc0hb4pWDej9wB3YQICPxlR2oziok2otvn5PuhjsQ==
X-Received: by 2002:a5d:4c8f:: with SMTP id z15mr4500703wrs.19.1590687127162; 
 Thu, 28 May 2020 10:32:07 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u13sm6565317wrp.53.2020.05.28.10.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:32:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 5/5] crypto/tls-cipher-suites: Produce fw_cfg consumable
 blob
Date: Thu, 28 May 2020 19:31:41 +0200
Message-Id: <20200528173141.17495-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528173141.17495-1-philmd@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since our format is consumable by the fw_cfg device,
we can implement the FW_CFG_DATA_GENERATOR interface.

Acked-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 crypto/tls-cipher-suites.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index f02a041f9a..d6ea0ed190 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "crypto/tlscreds.h"
 #include "crypto/tls-cipher-suites.h"
+#include "hw/nvram/fw_cfg.h"
 #include "trace.h"
 
 static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
@@ -99,11 +100,28 @@ static void qcrypto_tls_cipher_suites_finalize(Object *obj)
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
 }
 
 static const TypeInfo qcrypto_tls_cipher_suites_info = {
@@ -115,6 +133,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
     .class_init = qcrypto_tls_cipher_suites_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
     }
 };
-- 
2.21.3


