Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F261C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEF0205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxjpFmBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEF0205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFKc-0000Iw-2H
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEx0-0003sG-KJ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:35:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46520
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEww-00010I-48
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKBg489UvBQaihTp0WQ97c7cEJhAfL3iNmIIgh7rIBI=;
 b=DxjpFmBE88Z4jue2nhjCxliGmEn1p8MonFxINONyJJtLAiI1/6E4MYhn9oUqMsYXA0BDqt
 gasLGqtqfwDVWGTi0R4UzVzjbIxutFjL/ggSAUt/Pcw9r0/M2Lu1RLA8YjYIy1R2Ql8FuR
 7D8ZnrpMm4HYJATD9LV881dzk6fXe7A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Y7myE9dnPlWAFM0MbpGuog-1; Thu, 14 May 2020 10:34:59 -0400
X-MC-Unique: Y7myE9dnPlWAFM0MbpGuog-1
Received: by mail-wr1-f71.google.com with SMTP id w9so1682629wrr.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dKBg489UvBQaihTp0WQ97c7cEJhAfL3iNmIIgh7rIBI=;
 b=M6mhi2HsQsqpuIkhE9oX/e5bbane5/fHDzoexacsFPeq+unnIgVbfUUOki5xRaEb5a
 pJl1ZSCK/0wP93MO8jBG1YgU7Ny3n/AlMZak6fW6r6zbW94Ck9k7MvMbbpUHSMTwmyps
 1ZTcpSuPnEujP1zEQ7Z9zaUE5zhejcD0jHYB648oMCDJWEIjQyVttaIc9yXKKYIhGwwQ
 T+RKxOsjJmkN+Hr6v0n6kvH+wKrQH3znW20kw4SxIDjyq0gKPNUa2JImhjP6TWHjx5kx
 6XO//b6+YLglWPyvc0+5a2KbDzctxSjvs47A+zNz1H6wfPLr38yxQvnYJp7TsPbzlIFo
 rgZg==
X-Gm-Message-State: AOAM531yG8H5h1dnLgClKJoPNRLHKd8lbqu4l0k2HszfOl2eKXeRSKzO
 OH02EKdUcRSkl+s0SX/6fbh+k7gBC1gn75VaqNyAcSq1Ac+AaSsrF8qZT80X9r2Na/rptDe5B7x
 s35tAnITsCn20/is=
X-Received: by 2002:adf:fac5:: with SMTP id a5mr6191433wrs.210.1589466898398; 
 Thu, 14 May 2020 07:34:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf4mP97oGpyO8sYY7ImQ/EDLo5CIbK8M5c6ZcsL1f4Kc7V5VEfyWI02QONOGNA9XmcI3jrfw==
X-Received: by 2002:adf:fac5:: with SMTP id a5mr6191419wrs.210.1589466898241; 
 Thu, 14 May 2020 07:34:58 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s8sm4329464wrg.34.2020.05.14.07.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:34:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] tests/fuzz: Extract pciconfig_fuzz_qos() method
Date: Thu, 14 May 2020 16:34:32 +0200
Message-Id: <20200514143433.18569-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the generic pciconfig_fuzz_qos() method from
i440fx_fuzz_qos(). This will help to write tests not
specific to the i440FX controller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/fuzz/i440fx_fuzz.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index c197b026db..558fa17c93 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -84,7 +84,7 @@ static void i440fx_fuzz_qtest(QTestState *s,
     flush_events(s);
 }
 
-static void i440fx_fuzz_qos(QTestState *s,
+static void pciconfig_fuzz_qos(QTestState *s, QPCIBus *bus,
         const unsigned char *Data, size_t Size) {
     /*
      * Same as i440fx_fuzz_qtest, but using QOS. devfn is incorporated into the
@@ -97,11 +97,6 @@ static void i440fx_fuzz_qos(QTestState *s,
         uint32_t value;
     } a;
 
-    static QPCIBus *bus;
-    if (!bus) {
-        bus = qpci_new_pc(s, fuzz_qos_alloc);
-    }
-
     while (Size >= sizeof(a)) {
         memcpy(&a, Data, sizeof(a));
         switch (a.opcode % ACTION_MAX) {
@@ -130,6 +125,19 @@ static void i440fx_fuzz_qos(QTestState *s,
     flush_events(s);
 }
 
+static void i440fx_fuzz_qos(QTestState *s,
+                            const unsigned char *Data,
+                            size_t Size)
+{
+    static QPCIBus *bus;
+
+    if (!bus) {
+        bus = qpci_new_pc(s, fuzz_qos_alloc);
+    }
+
+    pciconfig_fuzz_qos(s, bus, Data, Size);
+}
+
 static void i440fx_fuzz_qos_fork(QTestState *s,
         const unsigned char *Data, size_t Size) {
     if (fork() == 0) {
-- 
2.21.3


