Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F4C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E302389F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mH6i+gLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E302389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVTK-0002cU-OV
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fcbcd16ad20daa20680665dd38942f01b3a310aa@lizzy.crudebyte.com>)
 id 1kMVSb-0002CX-Tf
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:07:21 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:53175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fcbcd16ad20daa20680665dd38942f01b3a310aa@lizzy.crudebyte.com>)
 id 1kMVSa-0005Zb-3t
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=801Pvm947DyXbU4TP1t/rbST7LiYXx1aSU7SF7Jmwnw=; b=mH6i+
 gLeUEpTWIpbDriWXjmN8BDTgtZNEsICYwcck03PeHh0i8mJyTIe7pgdqk+fnLPxOIaZhghp/2aVzv
 PQqouvxTljX4mAStDXQweZXXw6USammrenfZqwWNFvQvRV/ifZCb1GPzsExgxW+mOak8epgABwv9l
 GcZydITUkc8L0hvlkFIRjcW/roR+3w/tt/QAoyFTeVdjy27nqitZn1yJ5fv5Y0X/as4llQ2R00l26
 oBe48E/CISV1q9AUcGmpVaxIROBUqmwXE+pG8+db7t6zFwQ5gqPy5VNGdZJ4cWZ79b6EWj8N2dMGQ
 BrGZKehyQY9M3zNpt9wBOOWnf0QJQ==;
Message-Id: <fcbcd16ad20daa20680665dd38942f01b3a310aa.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:39:54 +0200
Subject: [PATCH 05/12] tests/qtest/qos-test: add QTEST_DUMP_ENV environment
 variable
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=fcbcd16ad20daa20680665dd38942f01b3a310aa@lizzy.crudebyte.com;
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

If this new QTEST_DUMP_ENV is set, it will cause all environment
variables to be dumped to stdout.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/qos-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index db667e16da..4b1a1922fc 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -313,8 +313,15 @@ static void walk_path(QOSGraphNode *orig_path, int len)
  *   machine/drivers/test objects
  * - Cleans up everything
  */
-int main(int argc, char **argv)
+int main(int argc, char **argv, char** envp)
 {
+    if (getenv("QTEST_DUMP_ENV") != NULL) {
+        printf("ENVIRONMENT VARIABLES: {\n");
+        for (char **env = envp; *env != 0; env++) {
+            printf("\t%s\n", *env);
+        }
+        printf("}\n");
+    }
     g_test_init(&argc, &argv, NULL);
     qos_graph_init();
     module_call_init(MODULE_INIT_QOM);
-- 
2.20.1


