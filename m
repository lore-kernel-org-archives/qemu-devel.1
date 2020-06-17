Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A69212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDY0LSf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A69212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jld0V-0000m0-2n
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwg-0003X8-Ua
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwe-00089H-W8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6gS0XpUEexvKH9TWdrCUd6VNkzeKsuPrPQa4iYz43E=;
 b=SDY0LSf+XxWiENy6Pe5xPBc6KY3nSn+y4vlqreEF2o8LORm28vgDfZ1gx5pbVU+n1Pk/+k
 NqhBlgZniLt19ybBTPlynByrPsVuX0A+XW+eGYvOgKLwF/33vYG7E1BAf5OeGSsdnmAJL6
 q1AP1fHpl/tlaUNt6Yyh76vOPwZx2uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-oAWPekAIPY2l4DXGWHHdyw-1; Wed, 17 Jun 2020 14:37:54 -0400
X-MC-Unique: oAWPekAIPY2l4DXGWHHdyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F318A8015CB;
 Wed, 17 Jun 2020 18:37:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A03B5EE0E;
 Wed, 17 Jun 2020 18:37:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 05/12] tests/migration: fix unreachable path in stress test
Date: Wed, 17 Jun 2020 19:37:26 +0100
Message-Id: <20200617183733.186168-6-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

If stressone() or stress() exits it's because of a failure
because the test runs forever otherwise, so change stressone
and stress type to void to make the exit_failure() as the exit
function of main().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200603080904.997083-3-maozhongyi@cmss.chinamobile.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration/stress.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index f9626d50ee..a062ef6b55 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -167,7 +167,7 @@ static unsigned long long now(void)
     return (tv.tv_sec * 1000ull) + (tv.tv_usec / 1000ull);
 }
 
-static int stressone(unsigned long long ramsizeMB)
+static void stressone(unsigned long long ramsizeMB)
 {
     size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
     g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
@@ -186,7 +186,7 @@ static int stressone(unsigned long long ramsizeMB)
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
 
     if (random_bytes(data, PAGE_SIZE) < 0) {
-        return -1;
+        return;
     }
 
     before = now();
@@ -225,7 +225,7 @@ static void *stressthread(void *arg)
     return NULL;
 }
 
-static int stress(unsigned long long ramsizeGB, int ncpus)
+static void stress(unsigned long long ramsizeGB, int ncpus)
 {
     size_t i;
     unsigned long long ramsizeMB = ramsizeGB * 1024 / ncpus;
@@ -238,8 +238,6 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
     }
 
     stressone(ramsizeMB);
-
-    return 0;
 }
 
 
@@ -335,8 +333,7 @@ int main(int argc, char **argv)
     fprintf(stdout, "%s (%05d): INFO: RAM %llu GiB across %d CPUs\n",
             argv0, gettid(), ramsizeGB, ncpus);
 
-    if (stress(ramsizeGB, ncpus) < 0)
-        exit_failure();
+    stress(ramsizeGB, ncpus);
 
-    exit_success();
+    exit_failure();
 }
-- 
2.26.2


