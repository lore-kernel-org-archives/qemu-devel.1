Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38AEC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D45A20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx+gaAkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D45A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCrP-0001Oc-Sp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyCqf-0000CX-MS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:23:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyCqe-0007y5-7h
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595417023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5oXpUWch3F8Ua+y75ZO2Q633jp6+26jI2RA6vc9UC8=;
 b=Dx+gaAkSuhmj9A092quog0b+gEKy6olJcQZ8HmhyKxllbu4bXVQBLB3383KAI7D1+N/Sdi
 RNVU+/+DUBHv+pVnOa6NW6QYZBUC0lP7f74B/+ytNRbZbjREJczLvDLpzITKC0Z6vLWIRE
 AG+JE/UqWwoJl8/nxcGbj40j4qNHTmQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-hQ17zt1SMw6u7XsVVAucMA-1; Wed, 22 Jul 2020 07:23:41 -0400
X-MC-Unique: hQ17zt1SMw6u7XsVVAucMA-1
Received: by mail-ed1-f72.google.com with SMTP id k2so640181edn.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h5oXpUWch3F8Ua+y75ZO2Q633jp6+26jI2RA6vc9UC8=;
 b=WRLAiRRg4OKPPsUrEAmIfY5Zrd7xjVTjPtzIjYU24hBdSqAEaZzbOPGfvS80MuPgIL
 yz2KJfh89aXbmFTh9zzdy2e+GrfiTSLAVAzPSqvjXe8WpQINg+nvaWL5+zfMVFCHkPsU
 RbQ86RYH+Dr2sqvlurEh7IWbd33LJDvZu2RZATy/oku7w5isI+Hm0DwfDB0W0M9iCILZ
 3dYQr1bCIb8ioVjCBE/jtnBwiTkusXY04Gb+Z/bE3OSDB24DuCIHLE7Ga1k/1BqIrdHr
 NlnejsvqDeC+7BPDD/+xWyTDz4DuLkUNjBlFlmWwkRVFLWD2YjDzNMDTcF/0Nq++h3QZ
 TRZQ==
X-Gm-Message-State: AOAM532R2vzE67iKJyl9tJ76fnbIVOVrUBUV2axPzDczFw1CqbRudHOG
 L9QYw6a89Rq6LZeDcm1PBQDoBHhE1F6YkXaNoWEG8RYvE8OFvXpQp1v4IA6pP7f2h88zrdMTxrd
 3LFFQbP/AKqbGoaI=
X-Received: by 2002:a17:906:17c1:: with SMTP id
 u1mr20482944eje.536.1595417020356; 
 Wed, 22 Jul 2020 04:23:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/llDMwXF4x09TLsPxBCJhxi+rgC7SA075GNe/B3qIiDjpJPQr0XSMA9BDcWp905ket4MUwQ==
X-Received: by 2002:a17:906:17c1:: with SMTP id
 u1mr20482935eje.536.1595417020190; 
 Wed, 22 Jul 2020 04:23:40 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id e22sm18541984ejd.36.2020.07.22.04.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:23:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 1/2] tpm: Display when no backend is available
Date: Wed, 22 Jul 2020 13:23:32 +0200
Message-Id: <20200722112333.29966-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200722112333.29966-1-philmd@redhat.com>
References: <20200722112333.29966-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


