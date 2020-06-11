Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1A7206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwb0IxYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1A7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPrF-00082e-1n
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPlJ-00059v-9F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:09:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPlH-0002BE-5t
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lWB0Ui4g7romPhYjN7+fNOLPfWPt76YM8vzgCCtMno=;
 b=gwb0IxYj5TWBf4KsI3wfl/uc65N+1AnSekdSOxXojDFFc8qZSZ9XTluWx3+FLpAl+nkWbN
 KV3b69Z6J/LFhC8R21b20+svLIt9a27QSPcmj40Rj/9swpfcGTkY1bLydQfPfHWwztwwbO
 UZzgTsvnRR8mCDSonkNu5bKdtW7PmZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-a85W7eDBN8O4ZI2y4J6cYg-1; Thu, 11 Jun 2020 12:03:27 -0400
X-MC-Unique: a85W7eDBN8O4ZI2y4J6cYg-1
Received: by mail-wr1-f71.google.com with SMTP id p10so2723258wrn.19
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8lWB0Ui4g7romPhYjN7+fNOLPfWPt76YM8vzgCCtMno=;
 b=lUPmbC/YixhFqPR+Y02yxvYEvqmV/gAmjppmH77zmuhPvAuhinahllVHzjdBxAEGgz
 kugWGbYEOw/zlEvfNuI4xLKb0415SXJxMs7RHG90Vc6QyQ9MkWggsVtkQPAIPp37Okno
 JyGXbfvHU6VMZw54g7bfvGi1a5IPoBjwQ0LKu5WoQvNmfZ1/OCfG1XmSCAO9phWkNTRs
 8V1vSWfY+SprI5gQTrExqv+Kg+cx5YWEr+7Rq7wl8z4f3w4piwtrJlHLLm3aWWOP4tkJ
 v1OoJLs5Q7s4vg1iWpju3jS1V9y9kk4XDzFM2aCL/D9viV57Cfuyyx2FRAjt7spIMo5A
 89Gw==
X-Gm-Message-State: AOAM531ChYv4lGkA54FevzucHE0ezPP4I8FNNjv8t2Xur9r2Ul/CIJwy
 La2Gz+CZ48oCYuSKO7h4ncQv7EFOX76kflrTTZlZsnQ3jEJZhJfYGx2TcP09fByKSf6q8DDYG34
 1VVLw/lmRHSZ62Rg=
X-Received: by 2002:adf:e78a:: with SMTP id n10mr10677300wrm.114.1591891406198; 
 Thu, 11 Jun 2020 09:03:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztQUYXO6NNQtaF8o4BnQnfggb8b2XxntyaTl90JbG0uqF9bBRx+torpCUTWf7j1IM777kLcQ==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr10677271wrm.114.1591891405969; 
 Thu, 11 Jun 2020 09:03:25 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d2sm5880260wrs.95.2020.06.11.09.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/11] hw/tpm: Rename TPMDEV as TPM_BACKEND in Kconfig
Date: Thu, 11 Jun 2020 18:02:58 +0200
Message-Id: <20200611160306.2751-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The TPMDEV describe TPM backends. Use the TPM_BACKEND config
name which is self-explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 4794e7fe28..5028fd8880 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,4 +1,4 @@
-config TPMDEV
+config TPM_BACKEND
     bool
     depends on TPM
 
@@ -15,26 +15,26 @@ config TPM_TIS_SYSBUS
 config TPM_TIS
     bool
     depends on TPM
-    select TPMDEV
+    select TPM_BACKEND
 
 config TPM_CRB
     bool
     depends on TPM && PC
-    select TPMDEV
+    select TPM_BACKEND
 
 config TPM_PASSTHROUGH
     bool
     default y
     # FIXME: should check for x86 host as well
-    depends on TPMDEV && LINUX
+    depends on TPM_BACKEND && LINUX
 
 config TPM_EMULATOR
     bool
     default y
-    depends on TPMDEV
+    depends on TPM_BACKEND
 
 config TPM_SPAPR
     bool
     default y
     depends on TPM && PSERIES
-    select TPMDEV
+    select TPM_BACKEND
-- 
2.21.3


