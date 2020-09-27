Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87365C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EC923718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="S72lexkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EC923718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVWd-0004lN-Vb
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cc6109fcc03d47a68d01ceac5ade71fe8467a3f7@lizzy.crudebyte.com>)
 id 1kMVVv-0004Kl-Tn
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:10:47 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cc6109fcc03d47a68d01ceac5ade71fe8467a3f7@lizzy.crudebyte.com>)
 id 1kMVVu-0005my-Fw
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=pY75VwLoxKQv1SwLMelW/wR9FrH1mMMB6Kt18BguEts=; b=S72le
 xkgu6wO/TsIAJF+t+qD5n7mqxgQT9v8faJPW5K6kfMLCUIkP+qYlug6q7bNJDmC8VsoGaStYNSFS9
 XZjWkvnyFar914F0t17K4PpWwkxa7cc3V8iExH5ZsLjkgdhkyv4X3Z3SvdUpGMFJet3PD0b2EKIyO
 FbaUZW2cf3Awoh6XsVLODM4UoryoKQA/9SYALRi+2nYt8Z9Jbe13EIDHtAgdKknjCSf2BPSAshItE
 gmHMzP29uDr9SIukPHVR/QOieD/8oLneLYcGpuHcuidXoGjTeolqgpe1uXFYnmPuxYoNHpa6aW50j
 wIjz+cC/S4SHwOx/wAG4r0yqSgAPw==;
Message-Id: <cc6109fcc03d47a68d01ceac5ade71fe8467a3f7.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:40:07 +0200
Subject: [PATCH 06/12] tests/qtest/qos-test: add environment variable
 QTEST_DEBUG
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=cc6109fcc03d47a68d01ceac5ade71fe8467a3f7@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now this new environment variable QTEST_DEBUG will cause the
assembled qemu command line to be printed before running each test.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/qos-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 4b1a1922fc..571d1e140a 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -89,6 +89,9 @@ static void qos_set_machines_devices_available(void)
 
 static void restart_qemu_or_continue(char *path)
 {
+    if (getenv("QTEST_DEBUG") != NULL) {
+        printf("run QEMU with: '%s'\n", path);
+    }
     /* compares the current command line with the
      * one previously executed: if they are the same,
      * don't restart QEMU, if they differ, stop previous
-- 
2.20.1


