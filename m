Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4651C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91853206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+dSUKJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91853206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj70E-0008Mu-QM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wR-0003sV-Lp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wQ-0000VV-M4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTmKvMxsRg6TDo1ZOS8kS+0m6cLpvXXwMo5jtOpsK98=;
 b=D+dSUKJYke0YGJ406Em5EYdkEoMQj6FP/lVILKHgii8rjY8GNPHo+GnASTfPnWp9t/0FiB
 knvj3p9qrgnUIvwJDz+/wjFFtG85dJ6gw5W5eJI2MGMKNtlHgGvWJugBZzLR9V1U/NxnZN
 bXjbImahVshXv/WJpsJg+WRCow2HY3E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-CaMsqCKSO-6uZ_yVAlsw2w-1; Wed, 10 Jun 2020 16:03:16 -0400
X-MC-Unique: CaMsqCKSO-6uZ_yVAlsw2w-1
Received: by mail-wm1-f70.google.com with SMTP id p24so734912wmc.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yTmKvMxsRg6TDo1ZOS8kS+0m6cLpvXXwMo5jtOpsK98=;
 b=QbIrXGUhCwj1w2GbIO9p3uzR4i77A913QhZb8eai4SILX4qZMFhRBNQ1t9tdx1RkG/
 stgOyuysyMPWFz/HlqkhawDc9MYIOuRV8v35ETttGqOXwp7MlWU7lM3WrglqW9adIfHf
 MQ8aPkl2KHEYA/awZHJFN090HTOZ0kBfDALN/3/MWGo8uVw2nf1bix3sZBlF+NKc4U0u
 VW9cU8pSXtZFuLFBbG9tvjjdRwylqn+XEElG8vwXGKZtDxRVtDskoljFx788WOOVy3bR
 2WbpqCQrNBC2Ao6lS41zeuwEcJcbhHnrrVNfsGt0XHU8BPCBLx+DYG004kwtaAEvIVOn
 NTXg==
X-Gm-Message-State: AOAM531AQbRK0cRrcwQa1gdNK6czCzv1I4Ntrl0NsEwXH9ysXBswHRwQ
 7vZwdgGyQ6CcTCr57XVApjbucdOERQTwQjpIKRNj2tnoXdS+K4siCn4PPEjNoZqLRLI2E/kCWX5
 j4PRDd/JBESOetWA=
X-Received: by 2002:a5d:4ec3:: with SMTP id s3mr5876517wrv.103.1591819395109; 
 Wed, 10 Jun 2020 13:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV7PU5Hok0cqrjyyL26FLB7N0HI1d3sRfeHGCP5fkiaDuIASYWGuckJO0jZ/GsbIxpZilkRQ==
X-Received: by 2002:a5d:4ec3:: with SMTP id s3mr5876499wrv.103.1591819394890; 
 Wed, 10 Jun 2020 13:03:14 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o18sm996955wme.19.2020.06.10.13.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:03:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] hw/tpm: Move few declarations from 'tpm_util.h' to
 'tpm_int.h'
Date: Wed, 10 Jun 2020 22:02:44 +0200
Message-Id: <20200610200247.21378-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
References: <20200610200247.21378-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:37:41
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to make "tpm_util.h" publicly accessible by
moving it to the include/ directory in a pair of commits.
Keep declarations internals to hw/tpm/ in "tpm_int.h".

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


