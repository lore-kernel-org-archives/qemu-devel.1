Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348DC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD632075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="dbXpZ34j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPza-0007B3-UQ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <73a2acc5ca29f95d6d2e5ce60ec69c62bd55f637@lizzy.crudebyte.com>)
 id 1kYPyO-0006J6-5e
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:41:24 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <73a2acc5ca29f95d6d2e5ce60ec69c62bd55f637@lizzy.crudebyte.com>)
 id 1kYPyM-000432-57
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=FZEBSYePsIFOW2CmW0yoFTgrrrEQwM44sA87p65ipA8=; b=dbXpZ
 34jgapHQihclKMWs9JdtFKg2YEEiUSUnQ3YaKj/+ysBEBR21N6OHMWWg1Iy0XJo0PdgsYtpaWWCoP
 ndC3xNeBFQDZFK8e7POSPBUJACu7P7XKXzQmMJUkMNHfz1yEDRseeF7tyH9P16LLvmKB25nEFqKcb
 J8MieD2v1aC7PApDJJ47IrjLnw8NHqQNdiBzTJbzFesqNnQSv8ARLzMtqapjelTNcx1+4NOEOskxO
 qADOzG8r+HFQ5DBB7aCt+15y3TT8bs8C/DLprFH8hhtChjxXILo4CxCNj5micoPXWwF3qHC5Y3T0M
 aUauyDekJJA8tsLCl7UV+BfDl9ZVQ==;
Message-Id: <73a2acc5ca29f95d6d2e5ce60ec69c62bd55f637.1604046404.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604046404.git.qemu_oss@crudebyte.com>
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 30 Oct 2020 09:19:46 +0100
Subject: [PATCH 1/2] tests/9pfs: fix test dir for parallel tests
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=73a2acc5ca29f95d6d2e5ce60ec69c62bd55f637@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 04:40:14
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

Use mkdtemp() to generate a unique directory for the 9p 'local' tests.

This fixes occasional 9p test failures when running 'make check -jN' if
QEMU was compiled for multiple target architectures, because the individual
architecture's test suites would run in parallel and interfere with each
other's data as the test directory was previously hard coded and hence the
same directory was used by all of them simultaniously.

This also requires a change how the test directory is created and deleted:
As the test path is now randomized and virtio_9p_register_nodes() being
called in a somewhat undeterministic way, that's no longer an appropriate
place to create and remove the test directory. Use a constructor and
destructor function for creating and removing the test directory instead.
Unfortunately libqos currently does not support setup/teardown callbacks
to handle this more cleanly.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index d43647b3b7..6b22fa0e9a 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -35,7 +35,12 @@ static char *concat_path(const char* a, const char* b)
 static void init_local_test_path(void)
 {
     char *pwd = g_get_current_dir();
-    local_test_path = concat_path(pwd, "qtest-9p-local");
+    char *template = concat_path(pwd, "qtest-9p-local-XXXXXX");
+    local_test_path = mkdtemp(template);
+    if (!local_test_path) {
+        g_test_message("mkdtemp('%s') failed: %s", template, strerror(errno));
+    }
+    g_assert(local_test_path);
     g_free(pwd);
 }
 
@@ -246,11 +251,6 @@ static void virtio_9p_register_nodes(void)
     const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
     const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
 
-    /* make sure test dir for the 'local' tests exists and is clean */
-    init_local_test_path();
-    remove_local_test_dir();
-    create_local_test_dir();
-
     QPCIAddress addr = {
         .devfn = QPCI_DEVFN(4, 0),
     };
@@ -278,3 +278,16 @@ static void virtio_9p_register_nodes(void)
 }
 
 libqos_init(virtio_9p_register_nodes);
+
+static void __attribute__((constructor)) construct_virtio_9p(void)
+{
+    /* make sure test dir for the 'local' tests exists */
+    init_local_test_path();
+    create_local_test_dir();
+}
+
+static void __attribute__((destructor)) destruct_virtio_9p(void)
+{
+    /* remove previously created test dir when test suite completed */
+    remove_local_test_dir();
+}
-- 
2.20.1


