Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8588C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42556223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCBN4fo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42556223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLoe-0005a4-5y
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLe5-0003J0-Q6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLe0-000261-G1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603315656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5YSDXbpiN58TIENBWrzuM3dPsDH2GwMJZmdPK3XRXc4=;
 b=JCBN4fo+I5hzjpvsGZY0dZZrC1fkAEH7Z7wuOA0hTEJzET2IdQV2o8FN4+Wtb5a0Rvo0Bj
 dXMPRECnF9p0p3xC7judW2fjEHX4qFlohePpQDuJqb8R7uoNMO7W0/lUlWt+W4aKLVWYJG
 AVwdCfKfcfaXFTj7DY+bGLcO/9N9WSI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-7aKQIljoPzubjwG5wGSB5g-1; Wed, 21 Oct 2020 17:27:34 -0400
X-MC-Unique: 7aKQIljoPzubjwG5wGSB5g-1
Received: by mail-qk1-f200.google.com with SMTP id d5so2590460qkg.16
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5YSDXbpiN58TIENBWrzuM3dPsDH2GwMJZmdPK3XRXc4=;
 b=B/K89BPEjnbIeC23zn+0JCRbQwZ2ZOq/jdKs2IoUsHGJEoiTh+52v2UctDedRpYpwy
 GCUUe/oqxBg3KDeXwVhw5AliR2wEuNnPjZ0LvJVMD1y+IJOOpOIuXNQ/Egf9idgI580o
 3/hapxBRqL9pZGdHqYhE1DLZgj7f048DlUoGYydm9H/aBiugC1DHk6EMAJj1MuisyF7o
 Xc22ws9gSbxV54/4Mbo6OokeaVTC4oT/dyuGpDTfCRHDWziIwViSsvjG3AmAwNrgaSZ2
 5YcsQXzM9fn5rMOhtuI5r8NdcnlvHxV3GjGw98wMZsRPf1ZEHRVatZ0dKfMaREkwwTF3
 SjvA==
X-Gm-Message-State: AOAM532oMWO7fCT0es46DVhkWyuIBysP9qJwoYURZCeSeST5103wpmef
 wfQgThip6x4EWElgplZo7uw6iKwxtzJzlCGx7JUQZEPdhXR9RRc4gMouItGgU+FlYvdqr5U+bSB
 an8BCdtBw53MYD+A=
X-Received: by 2002:aed:22fa:: with SMTP id q55mr4936237qtc.229.1603315653849; 
 Wed, 21 Oct 2020 14:27:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsRwuH2QsIYASdsuMXVXoN/2xH0WiD1HQK507D0oTnZ/ZpSmgHCpR9KK+6J+5GGLaMiWjBrw==
X-Received: by 2002:aed:22fa:: with SMTP id q55mr4936217qtc.229.1603315653616; 
 Wed, 21 Oct 2020 14:27:33 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id p187sm2089145qkf.70.2020.10.21.14.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 14:27:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 6/6] migration-test: Only hide error if !QTEST_LOG
Date: Wed, 21 Oct 2020 17:27:21 -0400
Message-Id: <20201021212721.440373-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021212721.440373-1-peterx@redhat.com>
References: <20201021212721.440373-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The errors are very useful when debugging qtest failures, especially when
QTEST_LOG=1 is set.  Let's allow override MigrateStart.hide_stderr when
QTEST_LOG=1 is specified, because that means the user wants to be verbose.

Not very nice to introduce the first QTEST_LOG env access in migration-test.c,
however it should be handy.  Without this patch, I was hacking error_report()
when debugging such errors.  Let's make things easier.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f410ec5996..f2142fbd3c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -464,6 +464,10 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 }
 
 typedef struct {
+    /*
+     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
+     * unconditionally, because it means the user would like to be verbose.
+     */
     bool hide_stderr;
     bool use_shmem;
     /* only launch the target process */
@@ -557,7 +561,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     g_free(bootpath);
 
-    if (args->hide_stderr) {
+    if (!getenv("QTEST_LOG") && args->hide_stderr) {
         ignore_stderr = "2>/dev/null";
     } else {
         ignore_stderr = "";
-- 
2.26.2


