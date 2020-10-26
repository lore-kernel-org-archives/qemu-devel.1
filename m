Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F2B205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeLOnuhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F2B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Q3-0003bW-Dv
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5Ey-0005CZ-Mx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5Eu-0000OR-Hg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603729254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeSYKSnUUTv72sw4cyfXobZIwEsSZnxB3Iqlyr17jUc=;
 b=EeLOnuhJKiRqE0Og4gTuJDeKgE+roMEh8Ivbg76kq5hBAunqMk3lqxGaF1wKEgnVBQoFUn
 XynL3TVrtSOVmabDu+JUlj9tlxRhilb0TXyXFUGNqK8oaHDCgMf4FQjINwsOHyHV8YCWnZ
 y4IbrxuSgaihT9CUEkgWucBONWuw5EM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-PaK8-H47Oa-ZrKxcqmYGpA-1; Mon, 26 Oct 2020 12:20:52 -0400
X-MC-Unique: PaK8-H47Oa-ZrKxcqmYGpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34E47101F7A0;
 Mon, 26 Oct 2020 16:20:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 036945D9E4;
 Mon, 26 Oct 2020 16:20:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, yubihong@huawei.com, peterx@redhat.com,
 peter.maydell@linaro.org
Subject: [PULL 16/16] migration-test: Only hide error if !QTEST_LOG
Date: Mon, 26 Oct 2020 16:19:52 +0000
Message-Id: <20201026161952.149188-17-dgilbert@redhat.com>
In-Reply-To: <20201026161952.149188-1-dgilbert@redhat.com>
References: <20201026161952.149188-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

The errors are very useful when debugging qtest failures, especially when
QTEST_LOG=1 is set.  Let's allow override MigrateStart.hide_stderr when
QTEST_LOG=1 is specified, because that means the user wants to be verbose.

Not very nice to introduce the first QTEST_LOG env access in migration-test.c,
however it should be handy.  Without this patch, I was hacking error_report()
when debugging such errors.  Let's make things easier.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20201021212721.440373-7-peterx@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.28.0


