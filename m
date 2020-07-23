Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C01C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AC620737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyrNkFoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AC620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYej-0008NR-Vh
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYdj-000748-HF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:39:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYdh-0006Od-V1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595500789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtNs8VuwihTgshljERkoFHj70ClwopH4n+3eavsWdDE=;
 b=MyrNkFoGQtaiEbYPkIqXuZjm24trV+tVrTFKaW7m1kl5E+XgAlhX0Z2agUcpT6Yf+EBwFl
 of1Tk+mSLzghHRoYTrcR9yYCF+C+bgshUAnFBDaf6Q0FR9lODzYWQB3OWYyMV+l3eOJYPL
 YbRBiyaX4p/C1kqYgyCaBzXCpHR1PXs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-wQQTrWFsOuOcIxm0tnBrEQ-1; Thu, 23 Jul 2020 06:39:47 -0400
X-MC-Unique: wQQTrWFsOuOcIxm0tnBrEQ-1
Received: by mail-wm1-f71.google.com with SMTP id z74so2212519wmc.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UtNs8VuwihTgshljERkoFHj70ClwopH4n+3eavsWdDE=;
 b=swxfEq0c2btHNsLl509jxeEWACXgMPvJFt/xBX31wxVRnNIaTPmWyAevtqgV0rtexI
 w1mIteiF18aT6yFfW6tnFGnY8a/JkdCXrY2YlfYJJJkUzOcQfqDif3jyiMT/+DwP59Gv
 bRKcrn311zno/zuPY3upPqr25Xp+cYO7bemYuO/mGSq145U5NIQqGPRWESxqINPPPHqL
 YnYmbtShMuQKLMvu22IxK0wJya6DSYpiKgVrbu0eWCd/KezI3kQrP+CYWACk4Xp0MtgV
 TNe2um5aN+8IAiJz633aewT6GoBkVIzKnMzD7KjlzWI83C/M51qkmGG67c4TPe3b+JQd
 IRGg==
X-Gm-Message-State: AOAM530jlKNAVVF/PBrC2RJScwKS4VsLKH62jxC2UZ0BSURsm5j3aq0I
 +EvtEPGrLJEcddW9X2qWUrmHwW8wFdXrXoLNOeHvp3c/Pj957k3C6eswC8Rbg2sUGbkGte1l7kE
 8yxyg5bSDYH5Yk3U=
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr3398242wmk.127.1595500786313; 
 Thu, 23 Jul 2020 03:39:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxANh/5uaqCtdERd+zBUOH65xjwFMNI2cWxOtc+A82JuG4eL9aIZASiUOnO8fBXtpE+B34rIg==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr3398231wmk.127.1595500786076; 
 Thu, 23 Jul 2020 03:39:46 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u16sm2980346wmn.11.2020.07.23.03.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 03:39:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 1/2] tpm: Display when no backend is available
Date: Thu, 23 Jul 2020 12:39:38 +0200
Message-Id: <20200723103939.19624-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200723103939.19624-1-philmd@redhat.com>
References: <20200723103939.19624-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Display "No TPM backend available in this binary." error when
no backend is available.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tpm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tpm.c b/tpm.c
index fe03b24858..e36803a64d 100644
--- a/tpm.c
+++ b/tpm.c
@@ -41,6 +41,22 @@ tpm_be_find_by_type(enum TpmType type)
     return TPM_BACKEND_CLASS(oc);
 }
 
+/*
+ * Walk the list of available TPM backend drivers and count them.
+ */
+static int tpm_backend_drivers_count(void)
+{
+    int count = 0, i;
+
+    for (i = 0; i < TPM_TYPE__MAX; i++) {
+        const TPMBackendClass *bc = tpm_be_find_by_type(i);
+        if (bc) {
+            count++;
+        }
+    }
+    return count;
+}
+
 /*
  * Walk the list of available TPM backend drivers and display them on the
  * screen.
@@ -87,6 +103,11 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     TPMBackend *drv;
     int i;
 
+    if (!tpm_backend_drivers_count()) {
+        error_setg(errp, "No TPM backend available in this binary.");
+        return 1;
+    }
+
     if (!QLIST_EMPTY(&tpm_backends)) {
         error_setg(errp, "Only one TPM is allowed.");
         return 1;
-- 
2.21.3


