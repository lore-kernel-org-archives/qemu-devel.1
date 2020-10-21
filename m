Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE0BC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B914820EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="f2nXm9BN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B914820EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvfo-0006nd-Mu
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ee01926a11b1f9bffcd6cdec0961dd9d1882da71@lizzy.crudebyte.com>)
 id 1kVvZ6-0005Ei-7m
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:49:01 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:34933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ee01926a11b1f9bffcd6cdec0961dd9d1882da71@lizzy.crudebyte.com>)
 id 1kVvZ4-0004TJ-Se
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=xsjARTJMRsIzsvTagiZQBElZfq3230JVVbcEUvQWxjk=; b=f2nXm
 9BNnnHJZza8fCfbtzrDNrp0kgw8U0XFv/GjZkLIW7Yb47gM2ZTZ/2WlB6ULR/qNfKyrKYEiDtQnv0
 Kpky4L6NBe23gKeH7AReVL0tXrGJEQvxEh+BOdAIhSO0B6LnDBs1zNxYqbmX+1OqV1w+QNGV1EyGC
 kOGyiFFfv2pITCDBSqQcWlzIFLv/yaMciSujnPGs7enYDV9B/Uc4R4cm1ALKCXLqYq/R4HxmLawL/
 YrCATvyjyfNsKnLtRCGBs2BJLVqhi9x4SRowGdMNMpB+nJGOhsJR47KsBU35AR3Uefz2azKC4hfrM
 fqF/lmSq7+dsGnGPFTE0jD7w+vWVg==;
Message-Id: <ee01926a11b1f9bffcd6cdec0961dd9d1882da71.1603452058.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603452058.git.qemu_oss@crudebyte.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:55:46 +0200
Subject: [PULL 13/13] tests/9pfs: add local Tunlinkat hard link test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=ee01926a11b1f9bffcd6cdec0961dd9d1882da71@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 07:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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


