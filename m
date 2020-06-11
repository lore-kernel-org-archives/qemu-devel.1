Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E35CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E41A206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi3MJvwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E41A206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPnh-0000Vr-SP
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgV-0006iz-Sh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:04:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgU-0000wP-5I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQSuJDxId+eIi5LOLR+uHKFmqgbML9RlTNVSEbvu1dk=;
 b=bi3MJvwF2Yz35nJIFDDLlMsCY348HHiflPLc/zJ7HlbNVZI42Hrosp6z5qsqSoSchDvdzg
 lxkJIs+ltgfG81EBYUN1yY36D/HzfGnXTcoZRENtYpgyCux5gaMv4blpQo6Kgp8hCDK1zp
 D6iPHkrV0Dq5UBG5HmJKYJhzCLe6W/o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-6zSOUtSEOyqosN2OTi2xtA-1; Thu, 11 Jun 2020 12:03:52 -0400
X-MC-Unique: 6zSOUtSEOyqosN2OTi2xtA-1
Received: by mail-wm1-f71.google.com with SMTP id 11so1225778wmj.6
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xQSuJDxId+eIi5LOLR+uHKFmqgbML9RlTNVSEbvu1dk=;
 b=rXNTcWZNGIFLHZ3KoSCEQNweG2hQFJx69G4EApBKEh/9hN/Y+HUw0rDPjHhLp/9+yu
 pnOzAt23CJ+ZEkWOkFIPifEbF7Bk5SlLf3squ1k/9H+ltitzYEe1WKwBNx8rjDUv7ewk
 qbDc14ZOMj7RQRlAFCPB2xb8su7uZrmabOx+q2uLGtvrr/YuwRbkHh5Zn32gBECEQXm7
 nSDll0opWoAIyarnjsVNnBNTy6yxliiFlJOXsgKgBN8BVfD8TStSEieJ7Myn6XZv/zB0
 do6/1pkHWZcc1NI6fmNP8tBjOaaweTWTRYVzbTcJjlTMGE2JljQYCs6svtQOwUaOGcts
 JYrg==
X-Gm-Message-State: AOAM530rqVo65VVkoT1mH2XuWZpuAEajKp+9gd/D6pcYaC+7bi9Y59/h
 PugSdw/bjo1H0Q0BYFRTTuyp3bXtjVhhfWRQ93mFcZQHMi3+rAwDfbIUc8IKk2yBMUPKf1Y48kT
 q0KZ9mitTDl2jg3Q=
X-Received: by 2002:a5d:4446:: with SMTP id x6mr9906069wrr.119.1591891430739; 
 Thu, 11 Jun 2020 09:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvPnc0zlH5xdZMbH/e4XltSwwnYw3bBzPbd6sDfqW8DUaJqaLs0pcq5i1BBOIcCVx8eEOXvw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr9906047wrr.119.1591891430578; 
 Thu, 11 Jun 2020 09:03:50 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k21sm5913606wrd.24.2020.06.11.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/11] hw/tpm: Move few declarations from 'tpm_util.h' to
 'tpm_int.h'
Date: Thu, 11 Jun 2020 18:03:03 +0200
Message-Id: <20200611160306.2751-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to make "tpm_util.h" publicly accessible by
moving it to the include/ directory in a pair of commits.
Keep declarations internals to hw/tpm/ in "tpm_int.h".

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_int.h  | 11 +++++++++++
 hw/tpm/tpm_util.h | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index fd5ebc6489..9f72879d89 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -13,6 +13,7 @@
 #define TPM_TPM_INT_H
 
 #include "qemu/option.h"
+#include "sysemu/tpm.h"
 
 #define TPM_STANDARD_CMDLINE_OPTS \
     { \
@@ -74,4 +75,14 @@ struct tpm_resp_hdr {
 #define TPM_RC_FAILURE            0x101
 #define TPM_RC_LOCALITY           0x907
 
+int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
+                             size_t *buffersize);
+
+typedef struct TPMSizedBuffer {
+    uint32_t size;
+    uint8_t  *buffer;
+} TPMSizedBuffer;
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
+
 #endif /* TPM_TPM_INT_H */
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 7889081fba..d524935576 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -66,19 +66,9 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
     stl_be_p(b + 6, error);
 }
 
-int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
-                             size_t *buffersize);
-
 #define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
     DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
 
-typedef struct TPMSizedBuffer {
-    uint32_t size;
-    uint8_t  *buffer;
-} TPMSizedBuffer;
-
-void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
-
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string);
 
-- 
2.21.3


