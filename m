Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0778BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD51222B9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="i+LNF9yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD51222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWcF-0004c9-8M
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <136b7af22774a6f0fb44c9c1b8c088b52e2e92ed@lizzy.crudebyte.com>)
 id 1kZWTL-0001sw-NS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:49:55 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:58301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <136b7af22774a6f0fb44c9c1b8c088b52e2e92ed@lizzy.crudebyte.com>)
 id 1kZWTJ-0006cm-V8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=tO675tDFEeFMR7lltQjZleg7qUOrV75TbEgjX8683Fk=; b=i+LNF
 9yp3r/ZqfvduzDsaF4v1EjTAvW/n1nwIugLSmdxtjSH7UyKz+4VaePRv0Rg/BQu/n4eOxyK16lw9C
 WwqPf+NKFgGfjxeoLikIXn5olCPzIc4SkE0vDp0UCIvS354BTTfTwa8ODoZ+L4ZvxCuCvQtM93bLj
 CB6JZLmTeVS0ZoHmBrlLsCJAHVVnfvWnA+45Ef/rZ3MrTKKuNu7ycn1RxDOwPAkwfm9o7h5z2P3xp
 0k4BbjGdTEHZOI9DOSfUfSd+rH/lBKNitsIJsXQZPeMHreaqKDOYD7sBMQx+orPjsUsESGwj28eU+
 5DV427lH3GXKlChJwv/FKzSdoX8fg==;
Message-Id: <136b7af22774a6f0fb44c9c1b8c088b52e2e92ed.1604309512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604309512.git.qemu_oss@crudebyte.com>
References: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 1 Nov 2020 15:37:12 +0100
Subject: [PULL v3 02/17] tests/9pfs: fix test dir for parallel tests
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=136b7af22774a6f0fb44c9c1b8c088b52e2e92ed@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:48:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

The constructor functions needs to be in virtio-9p-test.c, not in
virtio-9p.c, because in the latter location it would cause all apps that
link to libqos (i.e. entirely unrelated test suites) to create a 9pfs
test directory as well, which would even break other test suites.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Message-Id: <7746f42d8f557593898d3d9d8e57c46e872dfb4f.1604243521.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 14 ++++++++------
 tests/qtest/virtio-9p-test.c   | 12 ++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 2736e9ae2a..586e700b24 100644
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
 
@@ -43,6 +48,8 @@ void virtio_9p_create_local_test_dir(void)
 {
     struct stat st;
 
+    init_local_test_path();
+
     g_assert(local_test_path != NULL);
     mkdir(local_test_path, 0777);
 
@@ -244,11 +251,6 @@ static void virtio_9p_register_nodes(void)
     const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
     const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
 
-    /* make sure test dir for the 'local' tests exists and is clean */
-    init_local_test_path();
-    virtio_9p_remove_local_test_dir();
-    virtio_9p_create_local_test_dir();
-
     QPCIAddress addr = {
         .devfn = QPCI_DEVFN(4, 0),
     };
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c15908f27b..6401d4f564 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1076,3 +1076,15 @@ static void register_virtio_9p_test(void)
 }
 
 libqos_init(register_virtio_9p_test);
+
+static void __attribute__((constructor)) construct_9p_test(void)
+{
+    /* make sure test dir for the 'local' tests exists */
+    virtio_9p_create_local_test_dir();
+}
+
+static void __attribute__((destructor)) destruct_9p_test(void)
+{
+    /* remove previously created test dir when test suite completed */
+    virtio_9p_remove_local_test_dir();
+}
-- 
2.20.1


