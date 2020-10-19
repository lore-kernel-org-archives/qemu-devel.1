Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C182240C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGu6xkad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C182240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUe9p-0003SV-4f
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5y-0007DW-Bo
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5w-0005d6-IY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603148255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Qk8695FHtIdQ59StBPwLf/xWeZh5o7jRbCU96TiP8E=;
 b=SGu6xkadaxeMcHKbL4d0r0DgdSTqgxDgBhELk8jcSGQACqIIpmShLRaT7VmZOcXjM/6YQr
 hIJ3QiRDfrdZcUYaPps8eLllNK4TIFVoZsamWxjpLSomzfXXvHxjXt1lLhLASkof1NF0FC
 +6j09yPRwDSsyxLWHEnVgaRfInCRVdg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-MFErl_7uP_Ket98DtUP2cw-1; Mon, 19 Oct 2020 18:57:33 -0400
X-MC-Unique: MFErl_7uP_Ket98DtUP2cw-1
Received: by mail-il1-f199.google.com with SMTP id e3so1395159ilq.18
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Qk8695FHtIdQ59StBPwLf/xWeZh5o7jRbCU96TiP8E=;
 b=KStywOW9HTOoasBpz6B4g/AYDlRDZANquZYcNMKXUUZNv3eQbWWU3g39VD2YjX0p1b
 OeGiBYI4MJ0I9moinIaBaVGGqvJ9afoF6ECduQS/U4ZNV2nd3diTOV4f9JUxru83l3mS
 4a84J8om19f39Rnc9ylgsqHhQsYgDEOJzUgY/58MekYvgv77j0VMpdkjM7ZsHoI8dOCo
 S8SoXKp9SpQgrhz+EUzZGKGB4vWz+0WbwIyNnjFRUOhBagbaRWc7+gx18kSVv9avKH+h
 YbXcboJE0e09F5SU4bcPCHrZOwkmQYrlI6kUkgsAGt0uREPbY0boolr56BEgL0guriP+
 GRrg==
X-Gm-Message-State: AOAM5318Ufsj6ngJzOh++SVCacu0U67PqZKR1wgUtPCQdaYv12d3WQD+
 wr19DVK8PG+Lh7kTT19km9CSjTkBmsjjzusdzvg1r9hojLFF1w/kbwIGCT4Xx1rhwD1Zlh5kiuF
 +UDxnsZcqDhGeKiA=
X-Received: by 2002:a05:6e02:1247:: with SMTP id
 j7mr1950272ilq.304.1603148252887; 
 Mon, 19 Oct 2020 15:57:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrxD72MWz0Hgf+t7SZJG2lhZVxVXnxHznyuaZj9DDCz1XkLmhKMZloID10PgVQxKMrlWvi2g==
X-Received: by 2002:a05:6e02:1247:: with SMTP id
 j7mr1950262ilq.304.1603148252682; 
 Mon, 19 Oct 2020 15:57:32 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z89sm6017ilk.4.2020.10.19.15.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 15:57:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 6/6] migration-test: Only hide error if !QTEST_LOG
Date: Mon, 19 Oct 2020 18:57:20 -0400
Message-Id: <20201019225720.172743-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019225720.172743-1-peterx@redhat.com>
References: <20201019225720.172743-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
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
index 00a233cd8c..ff9ed70029 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -461,6 +461,10 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 }
 
 typedef struct {
+    /*
+     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
+     * unconditionally, because it means the user would like to be verbose.
+     */
     bool hide_stderr;
     bool use_shmem;
     /* only launch the target process */
@@ -554,7 +558,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     g_free(bootpath);
 
-    if (args->hide_stderr) {
+    if (!getenv("QTEST_LOG") && args->hide_stderr) {
         ignore_stderr = "2>/dev/null";
     } else {
         ignore_stderr = "";
-- 
2.26.2


