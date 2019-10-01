Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F75C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5318C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5318C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFpP-0000jC-GV
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFFkT-0003bE-NJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFFkO-0007Rh-9C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iFFkO-0007P1-3C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 596DD81F25;
 Tue,  1 Oct 2019 10:51:08 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C3B6261A0;
 Tue,  1 Oct 2019 10:51:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/5] Disallow colons in the parameter of "-accel"
Date: Tue,  1 Oct 2019 12:50:57 +0200
Message-Id: <20191001105057.3949-6-thuth@redhat.com>
In-Reply-To: <20191001105057.3949-1-thuth@redhat.com>
References: <20191001105057.3949-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 01 Oct 2019 10:51:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Everybody who used something like "-machine accel=kvm:tcg" in the past
might be tempted to specify a similar list with the -accel parameter,
too, for example "-accel kvm:tcg". However, this is not how this
options is thought to be used, since each "-accel" should only take care
of one specific accelerator.

In the long run, we really should rework the "-accel" code completely,
so that it does not set "-machine accel=..." anymore internally, but
is completely independent from "-machine". For the short run, let's
make sure that users cannot use "-accel xyz:tcg", so that we avoid
that we have to deal with such cases in the wild later.

Message-Id: <20190930123505.11607-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/cdrom-test.c | 2 +-
 vl.c               | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 05611da648..34e9974634 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -120,7 +120,7 @@ static void test_cdboot(gconstpointer data)
 {
     QTestState *qts;
 
-    qts = qtest_initf("-accel kvm:tcg -no-shutdown %s%s", (const char *)data,
+    qts = qtest_initf("-M accel=kvm:tcg -no-shutdown %s%s", (const char *)data,
                       isoimage);
     boot_sector_test(qts);
     qtest_quit(qts);
diff --git a/vl.c b/vl.c
index 630f5c5e9c..002bf4919e 100644
--- a/vl.c
+++ b/vl.c
@@ -3554,6 +3554,11 @@ int main(int argc, char **argv, char **envp)
                     g_slist_free(accel_list);
                     exit(0);
                 }
+                if (optarg && strchr(optarg, ':')) {
+                    error_report("Don't use ':' with -accel, "
+                                 "use -M accel=... for now instead");
+                    exit(1);
+                }
                 opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
                                         false, &error_abort);
                 qemu_opt_set(opts, "accel", optarg, &error_abort);
-- 
2.18.1


