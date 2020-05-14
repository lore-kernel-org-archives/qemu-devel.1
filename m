Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F82C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A594D20643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh90yliI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A594D20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFNA-0003iD-Np
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEws-0003jB-4C
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwr-0000yR-8W
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZ1u6qNZotSgU2037p6zpII9seREemya6EtGwZgs+40=;
 b=bh90yliIuMyuWCFH3bMIFpvrbYr+lEBYqUJdd9zNt5MUskEB4YxZF/9wk72fx7GvpmyHmI
 ixWGKSezsU73dcWa+jgfGTRXdE+thPqxLTiAaju+VsQa1mXfZen9NizpbpLx/X5KofyAM9
 rrusECA4cysfb6HfuxusOlMY/Xfi3TI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-L44-yClhM2ODLziVKGjt1A-1; Thu, 14 May 2020 10:34:55 -0400
X-MC-Unique: L44-yClhM2ODLziVKGjt1A-1
Received: by mail-wm1-f72.google.com with SMTP id q5so13575547wmc.9
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZ1u6qNZotSgU2037p6zpII9seREemya6EtGwZgs+40=;
 b=Sd8RueTkmd+W2uHFWsXDFA2K7pQmucPDUELBNtSK6Tpb0khoNab8OCuvk9rvjZ4BEU
 cNTmwbvVA6Kz5o/62avA+fZwkNhBjCsMrS9X9/ob42G6Bnsp8YoQM9zkLXZIrFFu5Xhw
 twgoDoePjBNgY+lit2kP9z03hXK46OIKFeR14x2rPPRCe1WTFJilnMRfd+m6HZXKxcPe
 kA0BWvi+D7uoVVJ+S4tQ+RX1U7VeO80ataym0whmZUwFSk9GnwUs+kLBJYSZR3mft0NX
 JKPcZUIgtSv3hSevS2rE2QDqErDbwiZHALsFC5iU1nWf6zeWDvks/ujiF0dbCeArXmHb
 yJIw==
X-Gm-Message-State: AOAM530gX/pwFuxxwnDhf8WJaRaovfE8ufAH3t7CvAEKOkY2ryXIZrgy
 72Ppvou1QDEYp9FD2Qpobqv3c+4nOhlF9D6ocGjXnJHyKsiybyK9cUzvyYwBra2TUUq1NyOWZzC
 5bhN+DcBllljNTdU=
X-Received: by 2002:a5d:5105:: with SMTP id s5mr5887749wrt.202.1589466893760; 
 Thu, 14 May 2020 07:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYhEwP2vSKQSTCH6UQ0+PvQcHOfYvpcR5pJ8b2UKz9ijVcmwRgA+DFo8SxlApETN+s1XUYkg==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr5887740wrt.202.1589466893614; 
 Thu, 14 May 2020 07:34:53 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s14sm38387741wmh.18.2020.05.14.07.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:34:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] tests/fuzz: Remove unuseful/unused typedefs
Date: Thu, 14 May 2020 16:34:31 +0200
Message-Id: <20200514143433.18569-5-philmd@redhat.com>
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

These typedefs are not used. Use a simple structure,
remote the typedefs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/fuzz/i440fx_fuzz.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index 96fed9ff12..c197b026db 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -45,12 +45,11 @@ static void i440fx_fuzz_qtest(QTestState *s,
      * loop over the Data, breaking it up into actions. each action has an
      * opcode, address offset and value
      */
-    typedef struct QTestFuzzAction {
+    struct {
         uint8_t opcode;
         uint8_t addr;
         uint32_t value;
-    } QTestFuzzAction;
-    QTestFuzzAction a;
+    } a;
 
     while (Size >= sizeof(a)) {
         /* make a copy of the action so we can normalize the values in-place */
@@ -91,19 +90,18 @@ static void i440fx_fuzz_qos(QTestState *s,
      * Same as i440fx_fuzz_qtest, but using QOS. devfn is incorporated into the
      * value written over Port IO
      */
-    typedef struct QOSFuzzAction {
+    struct {
         uint8_t opcode;
         uint8_t offset;
         int devfn;
         uint32_t value;
-    } QOSFuzzAction;
+    } a;
 
     static QPCIBus *bus;
     if (!bus) {
         bus = qpci_new_pc(s, fuzz_qos_alloc);
     }
 
-    QOSFuzzAction a;
     while (Size >= sizeof(a)) {
         memcpy(&a, Data, sizeof(a));
         switch (a.opcode % ACTION_MAX) {
-- 
2.21.3


