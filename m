Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C4EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43C62075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GIe+rADf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43C62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVir-0006EK-KK
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69067bf1436aab1c84b98b8461e81a9633ec7872@lizzy.crudebyte.com>)
 id 1kYVfs-0002U5-8j
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:41 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69067bf1436aab1c84b98b8461e81a9633ec7872@lizzy.crudebyte.com>)
 id 1kYVfq-0003QK-IR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=xsjARTJMRsIzsvTagiZQBElZfq3230JVVbcEUvQWxjk=; b=GIe+r
 ADfFJ2z8oGCgZik0dxBvlpxt/Jr16LVxlgl6d8fZ7EocQ/qE1oVxO1FO+JQxrNWmJJ/Dgp781GEvB
 Esfa4h6y+q9nnNCQ1cHtlzNLscSNE7QyUnm2ffCVP1f+pwdYp7nZx1mnZEJ8RK0V7qVNgQIixeHY3
 LQdmuH0GSsk7WKQQ6d665SWFzdID3umLYd7XVuB0kH1mf1O1NodShCJmH/5Ftx/62nzpyCvCCytoF
 1yFAG2xHZvB7+FIdn082Zcb+p6FR6Wm6anGzkU5+z8c5DDvbnasuD29eQn5BcMhGPLqgXEbdHqZi1
 EcfAAjPWg2jwT4sgChxwKOrZVSEgw==;
Message-Id: <69067bf1436aab1c84b98b8461e81a9633ec7872.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:55:46 +0200
Subject: [PULL v2 16/16] tests/9pfs: add local Tunlinkat hard link test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=69067bf1436aab1c84b98b8461e81a9633ec7872@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
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

This test case uses a Tunlinkat request to remove a previously hard
linked file by using the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <9bec33a7d8f006ef8f80517985d0d6ac48650d53.1603285620.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 460fa49fe3..23433913bb 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1391,6 +1391,34 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(real_file);
 }
 
+static void fs_unlinkat_hardlink(void *obj, void *data,
+                                 QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    struct stat st_real, st_link;
+    char *real_file = virtio_9p_test_path("08/real_file");
+    char *hardlink_file = virtio_9p_test_path("08/hardlink_file");
+
+    do_attach(v9p);
+    do_mkdir(v9p, "/", "08");
+    do_lcreate(v9p, "08", "real_file");
+    g_assert(stat(real_file, &st_real) == 0);
+    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
+
+    do_hardlink(v9p, "08", "hardlink_file", "08/real_file");
+    g_assert(stat(hardlink_file, &st_link) == 0);
+
+    do_unlinkat(v9p, "08", "hardlink_file", 0);
+    /* symlink should be gone now */
+    g_assert(stat(hardlink_file, &st_link) != 0);
+    /* and old file should still exist */
+    g_assert(stat(real_file, &st_real) == 0);
+
+    g_free(hardlink_file);
+    g_free(real_file);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1438,6 +1466,8 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
                  &opts);
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
+    qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
+                 &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


