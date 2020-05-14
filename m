Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B16EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5836D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYFEOY+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5836D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFJQ-0006Es-Cl
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwo-0003ei-H6
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwn-0000vs-Cv
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQICVOUmn0GmgHY69lut7hQVpNY+iYPUxS659CEWKSg=;
 b=eYFEOY+cfzSu4GPq/1te9cqDguci/MRKlqplynf9UY2j/uY7WG8pI7zt1QxGo8w2wzdpg4
 GEDPlmjAe1sqojIZzNiT+BWD/6r8hDuALx6vQcqeCTRjRbgH5vVvSX+RfqG1cSkV9QyR9i
 4TK2MXqBPCTqKBNCcxEJT3SSkVENSiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-IRv18QBPNimhnSzOCEuvig-1; Thu, 14 May 2020 10:34:50 -0400
X-MC-Unique: IRv18QBPNimhnSzOCEuvig-1
Received: by mail-wm1-f72.google.com with SMTP id x11so3910930wmc.9
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XQICVOUmn0GmgHY69lut7hQVpNY+iYPUxS659CEWKSg=;
 b=CDKAVvRXsV9niaj/ld2ZsYyiYCYV611jBluxgn67qWhjJMJfXKs+9UFILkwD3FuthH
 HAm1D7DzYpynTX+4VnP9y7clZpxjr9kaS3P1whI5RAh3OczvTsVPzrdA5KvzZJNGobIw
 UpMXOmAHP2Re2WCyxeGnRBQ8blLe42ORxw6O+VDAOlAIuUReRT2TOm8ObFIxWPM4qOiq
 KhP9xQrrY8i6cEXPO9QJ2yeYsVJCQp4f6Unv0z7fiCuePnVbsrIX1YNcRtpfNRyygDcE
 vZpY3tr/IAQ9B6soDnXvelzQ7gg3MfYVA6zcVlwWKuuEBE/1hMjsDBQJ4wM7TMMkiWkh
 wW8Q==
X-Gm-Message-State: AOAM531wObtQxRVwTocNG1yFxZrmFjwib2p1h8R4diqSdAKzmH6RjpGe
 8MH2Fra33tYNST5Of37yU5HE5YpWRI2O/bQvNP9UWGjWOz3UIq6sCqaJz36w4d0rqlKlYU8F6lS
 dCTAvDWh2wVEmOtg=
X-Received: by 2002:adf:face:: with SMTP id a14mr5701245wrs.397.1589466889177; 
 Thu, 14 May 2020 07:34:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIviuCGVPPeKwNGTvWdOys/g/tHCSHkAAH2BJ5U5uwIYtCpJ90NkD6twCV15ZejiWE3CQXFg==
X-Received: by 2002:adf:face:: with SMTP id a14mr5701225wrs.397.1589466888977; 
 Thu, 14 May 2020 07:34:48 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u10sm17279760wmc.31.2020.05.14.07.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] tests/fuzz: Add missing space in test description
Date: Thu, 14 May 2020 16:34:30 +0200
Message-Id: <20200514143433.18569-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Note: The descriptions are not very accurate (copy/paste?)
---
 tests/qtest/fuzz/i440fx_fuzz.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index ab5f112584..96fed9ff12 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -159,7 +159,7 @@ static void register_pci_fuzz_targets(void)
     /* Uses simple qtest commands and reboots to reset state */
     fuzz_add_target(&(FuzzTarget){
                 .name = "i440fx-qtest-reboot-fuzz",
-                .description = "Fuzz the i440fx using raw qtest commands and"
+                .description = "Fuzz the i440fx using raw qtest commands and "
                                "rebooting after each run",
                 .get_init_cmdline = i440fx_argv,
                 .fuzz = i440fx_fuzz_qtest});
@@ -167,7 +167,7 @@ static void register_pci_fuzz_targets(void)
     /* Uses libqos and forks to prevent state leakage */
     fuzz_add_qos_target(&(FuzzTarget){
                 .name = "i440fx-qos-fork-fuzz",
-                .description = "Fuzz the i440fx using raw qtest commands and"
+                .description = "Fuzz the i440fx using raw qtest commands and "
                                "rebooting after each run",
                 .pre_vm_init = &fork_init,
                 .fuzz = i440fx_fuzz_qos_fork,},
@@ -182,7 +182,7 @@ static void register_pci_fuzz_targets(void)
      */
     fuzz_add_qos_target(&(FuzzTarget){
                 .name = "i440fx-qos-noreset-fuzz",
-                .description = "Fuzz the i440fx using raw qtest commands and"
+                .description = "Fuzz the i440fx using raw qtest commands and "
                                "rebooting after each run",
                 .fuzz = i440fx_fuzz_qos,},
                 "i440FX-pcihost",
-- 
2.21.3


