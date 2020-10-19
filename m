Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3878EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14A522284
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="F40rIl4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14A522284
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeuC-00089A-Kw
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <63a6783a516398a55a8e91dd678d3926abb7e138@lizzy.crudebyte.com>)
 id 1kUekG-0007Jd-Ni
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:39:18 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:39773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <63a6783a516398a55a8e91dd678d3926abb7e138@lizzy.crudebyte.com>)
 id 1kUekF-0002TY-2k
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Vr1PjD7KFp1uXG16reokhh/83DBLWQIiNOAMtOR6Lqk=; b=F40rI
 l4ek2Nh+vNnqHzQSuNT9VrbTLcWbGVGWZ5c9p4ks3iQLPYhVkfwGeUaVMts8MiI8JlEADBwcAB8EA
 +xm1wfdR+cZzZz0ahhAEVHYJnXH7NqH5Olpb5mDf6wHI/WvRjmsEB2lGStCAKFd3e+Ziq+jcJ/iZv
 LMLo02V8QwxH+IuJDlsRd5RaOWZbNhpBi4PJY4tA40yy5qjczpRoXVKIsyUDNrD46iK+N34S/g3sB
 rB3RAsfPbDS6P1WkIHSoBz1pUtSiQru4OSoVarIMoQRuvfciu3XMCWOxinFm2IMTNTvhMn7NGovQ7
 8wQlQbubpW+g6Pbuq+XK+5hTXypYA==;
Message-Id: <63a6783a516398a55a8e91dd678d3926abb7e138.1603149434.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 01:13:24 +0200
Subject: [PATCH 8/8] tests/9pfs: add local unlinkat hard link test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=63a6783a516398a55a8e91dd678d3926abb7e138@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 19:37:26
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

This test case uses a Tunlinkat request to remove a previously hard
linked file by using the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 447d8e3344..2e50445745 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1378,6 +1378,39 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(real_file);
 }
 
+static void fs_unlinkat_hardlink(void *obj, void *data,
+                                 QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    P9Req *req;
+    uint32_t dfid, fid;
+    struct stat st_real, st_link;
+    char *real_file = virtio_9p_test_path("08/real_file");
+    char *hardlink_file = virtio_9p_test_path("08/hardlink_file");
+
+    fs_attach(v9p, NULL, t_alloc);
+    fs_mkdir(v9p, data, t_alloc, "/", "08");
+    fid = fs_lcreate(v9p, data, t_alloc, "08", "real_file");
+    g_assert(stat(real_file, &st_real) == 0);
+    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
+
+    dfid = fs_walk_fid(v9p, data, t_alloc, "08");
+
+    req = v9fs_tlink(v9p, dfid, fid, "hardlink_file", 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlink(req);
+    g_assert(stat(hardlink_file, &st_link) == 0);
+
+    fs_unlinkat(v9p, data, t_alloc, "08", "hardlink_file", 0);
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
@@ -1424,6 +1457,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
     qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink, &opts);
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
+    qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


