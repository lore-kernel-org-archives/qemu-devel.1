Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C02CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20DB206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHNy4d5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20DB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFU4-0008JK-1k
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEx1-0003tU-VP
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:35:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEx1-00013U-1x
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3QIbJXM9pRHScH3rDPsZVXm/otU1/pByMMT1prfehI=;
 b=KHNy4d5yT7L7cr7QYULeo2hfZuWf358vU0NJCY8Ih+SOMIhP/c7xxT6DddH062B+w2KqMN
 uc/k2RYDv2QNp3t/S3KCJIxzgt+dtqbGwwEFnCUjYM+Fp7i4O3f2WymNMHcLCvQXsphKP4
 MtapFwmFbGWy4e8pgDTjCXeYJPQSHC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-6LXpoPmPPH2jSa8KQ72AlQ-1; Thu, 14 May 2020 10:35:04 -0400
X-MC-Unique: 6LXpoPmPPH2jSa8KQ72AlQ-1
Received: by mail-wm1-f70.google.com with SMTP id a67so7443586wme.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q3QIbJXM9pRHScH3rDPsZVXm/otU1/pByMMT1prfehI=;
 b=Lvd5O7Sl5Sqs2QVycHRsYrtEnzwk8475E1JZPF+nU7DFwvA7UMZthHdFx3Xxg+nUrU
 +V21z9eJKIFtZ7wlwki4fxlGt9CwDTFFn2PLF64dhXaWuDVMWF93vBy7aTA9wb8Bp/AW
 Sj7GAY41yxM+9/VUZdh0Utlqaw/Q46vkP4ollQRC8UNEdlVwJRdIqm3H+JrEtfo3HADz
 GRf+7OmlTJfAngC21hkav8BYANJI9jm4DH9Q1jAckng1ESjhzPxO6FP+qj5S9WFojdo8
 Qb4NTPmbhGwXflIvuoGkRtt+A2smTBx2aAwOn9zwpLBT255bjc/3wNTouU2XEaLmNJS3
 hZYA==
X-Gm-Message-State: AGi0PubiR8SQvsUuzUCsjeKW8CHnKLjX+W++B7ZgVqkwVea8Bgsh9/aH
 /Qn40czKcnrYDMNhl3H3EwInS4bQCp2j5JtNDHFOq+meHJHNLMQxubyEBhulJm4eumjqqe/Vxt8
 b7lvGHxIDENzrLUo=
X-Received: by 2002:a1c:7513:: with SMTP id o19mr46198977wmc.9.1589466903178; 
 Thu, 14 May 2020 07:35:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypIONK3Ds0IOOywOiutQSJ69nJA31MfqA8Tmk9/E8YaCrFKUG562DUxyD3H+uKCZezZNxa2ckA==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr46198955wmc.9.1589466902941; 
 Thu, 14 May 2020 07:35:02 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t4sm4882445wri.54.2020.05.14.07.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:35:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] tests/fuzz: Extract ioport_fuzz_qtest() method
Date: Thu, 14 May 2020 16:34:33 +0200
Message-Id: <20200514143433.18569-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

Extract generic ioport_fuzz_qtest() method from
i440fx_fuzz_qtest(). This will help to write tests
not specific to the i440FX controller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/fuzz/i440fx_fuzz.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index 558fa17c93..bcd6769b4c 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -39,7 +39,7 @@ enum action_id {
     ACTION_MAX
 };
 
-static void i440fx_fuzz_qtest(QTestState *s,
+static void ioport_fuzz_qtest(QTestState *s,
         const unsigned char *Data, size_t Size) {
     /*
      * loop over the Data, breaking it up into actions. each action has an
@@ -84,10 +84,17 @@ static void i440fx_fuzz_qtest(QTestState *s,
     flush_events(s);
 }
 
+static void i440fx_fuzz_qtest(QTestState *s,
+                              const unsigned char *Data,
+                              size_t Size)
+{
+    ioport_fuzz_qtest(s, Data, Size);
+}
+
 static void pciconfig_fuzz_qos(QTestState *s, QPCIBus *bus,
         const unsigned char *Data, size_t Size) {
     /*
-     * Same as i440fx_fuzz_qtest, but using QOS. devfn is incorporated into the
+     * Same as ioport_fuzz_qtest, but using QOS. devfn is incorporated into the
      * value written over Port IO
      */
     struct {
-- 
2.21.3


