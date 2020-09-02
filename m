Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E259C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D388B2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sf0RZVf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D388B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNsm-0004pi-0a
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNpX-0007wG-Ef
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:09:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59743
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNpV-0001sm-M9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8S1is3V+uNMDSCkr5ooDmUvJBA2c6esYl0AjU7GwsP8=;
 b=Sf0RZVf+PJTUjrd+N6MJj/pORzabfb2JLsDbRfIFEZhHCyD8AXcoyz77jCnNXCVlxrsy8F
 VRUe6Zndt8Nf8Zm8S8uGbuJZHRocIi3nDUEjhv42wC/2mxst+b9z45u6a6ozWB86zgFH86
 3MfD082HbAYbU3NSYWeHRLhFJmotW8A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-P9kje0oePUiO7Fjw4IoUHg-1; Wed, 02 Sep 2020 04:09:15 -0400
X-MC-Unique: P9kje0oePUiO7Fjw4IoUHg-1
Received: by mail-wr1-f72.google.com with SMTP id g3so1646185wrx.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8S1is3V+uNMDSCkr5ooDmUvJBA2c6esYl0AjU7GwsP8=;
 b=jeWwWdXclJkYiohFtUH2jb2LLfCQPEX2EZ9uCtiekTI5d1KPQYv0xoF3UA6zgMj/cc
 1eT8S/AKjUO6UWLEFeowmEo3Z2rhCrK7eFcx37GB7VcieQzl3Gq1LOL9k2v4QcbVcpVH
 mWUtfyIDb8Ivft/hi67zjPQJEcB8nkohtFgGHscY3vvWkkojtpdPyuV2MclYYT9kjk9o
 6/hH+UoYq8YF3qjQO7ffDo8lDPVd8KM0fqnwGGpz85+W3x3UmgjWdQcL1TXkQdM97KqS
 egQfdwmcxhynNluUavEyVeOhjPud91l21BoaT7QdGCW9EbbYcZ35EszAyWa9brmIIRhf
 Kw3w==
X-Gm-Message-State: AOAM5315GV0ONsfyiIiozQUK4Tv38vitcfQMACrxYj34id9ebOoO7hQT
 1BZE4hl4DjgK4BHQO26geAUIimCuRU1ebv2ajZ2rAJNTgLLl0TzMa+ebus5Sz0XF8D21paYqGvO
 JtQBtuA0purdkRG8=
X-Received: by 2002:a1c:9a8c:: with SMTP id c134mr5311970wme.136.1599034151469; 
 Wed, 02 Sep 2020 01:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdELmA+vA0BeUn53E71O8OpMVJpZEBfRMTyxXaR+ksUAWaLzsPPsi+Zkr1u6d+sRm3xCV+Lw==
X-Received: by 2002:a1c:9a8c:: with SMTP id c134mr5311952wme.136.1599034151313; 
 Wed, 02 Sep 2020 01:09:11 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id d18sm5618291wrm.10.2020.09.02.01.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:09:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/tpm: Declare input buffers const and static
Date: Wed,  2 Sep 2020 10:09:09 +0200
Message-Id: <20200902080909.161034-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions using these arrays expect a "const unsigned char *"
argument, it is safe to declare these as 'static const'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/tpm-tests.c |  4 ++--
 tests/qtest/tpm-util.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index a2f2838e15b..70c80f8379a 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -59,7 +59,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
     tpm_util_startup(s, tx);
     tpm_util_pcrextend(s, tx);
 
-    unsigned char tpm_pcrread_resp[] =
+    static const unsigned char tpm_pcrread_resp[] =
         "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
         "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
         "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
@@ -107,7 +107,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     tpm_util_startup(src_qemu, tx);
     tpm_util_pcrextend(src_qemu, tx);
 
-    unsigned char tpm_pcrread_resp[] =
+    static const unsigned char tpm_pcrread_resp[] =
         "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
         "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
         "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index e2b29ef0f8c..3ed6c8548a6 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -98,9 +98,9 @@ void tpm_util_tis_transfer(QTestState *s,
 void tpm_util_startup(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
-    unsigned char tpm_startup[] =
+    static const unsigned char tpm_startup[] =
         "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
-    unsigned char tpm_startup_resp[] =
+    static const unsigned char tpm_startup_resp[] =
         "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
 
     tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
@@ -112,14 +112,14 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
 void tpm_util_pcrextend(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
-    unsigned char tpm_pcrextend[] =
+    static const unsigned char tpm_pcrextend[] =
         "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
         "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
         "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x00";
 
-    unsigned char tpm_pcrextend_resp[] =
+    static const unsigned char tpm_pcrextend_resp[] =
         "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
         "\x01\x00\x00";
 
@@ -133,7 +133,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_size)
 {
     unsigned char buffer[1024];
-    unsigned char tpm_pcrread[] =
+    static const unsigned char tpm_pcrread[] =
         "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
         "\x03\x00\x04\x00";
 
-- 
2.26.2


