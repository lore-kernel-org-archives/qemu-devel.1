Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D0C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893332223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="C4J6VDAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893332223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeq8-0005CQ-DM
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <edbf7a206a22138ee6f52c47c4a83b4d0b9fc3ea@lizzy.crudebyte.com>)
 id 1kUek6-0006zX-0j
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:39:06 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <edbf7a206a22138ee6f52c47c4a83b4d0b9fc3ea@lizzy.crudebyte.com>)
 id 1kUek3-0002SU-2F
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=r/iJwChibh2f/TaLqYdY0eeLo2OoiLI8PniUVxzhabk=; b=C4J6V
 DAFKWRZ7hHdHhKRT3jE3c1sKNQOHM5RPFTaz5gIsmday8CrZUDKx+hIp0RBiTkNJ2jVSuPCw6cNE0
 jy+T7KddU4tWWIK/v1yl0jYt89M7jpLvmxyQIcVJ/8Ds2aZXQudrMPDUWlF9AziUjskBSkFJSdJGs
 Cymj1TfuyzjfqwRPGU33BoaeUxjizwUn/6pg+YiU/9Axtt/lkVroGNVszIE5NXc0guCQDXMvi9jWp
 Uf69kpKuDV4sv37Cco67YFn+xS4geoihhQn0zuqHXK2+xeUaDMQh1PkaqhE89FdxntXatjSC+Tw9W
 m5/jm60HpkK3PPVrd+PZh6RXX3aXw==;
Message-Id: <edbf7a206a22138ee6f52c47c4a83b4d0b9fc3ea.1603149434.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 01:13:24 +0200
Subject: [PATCH 6/8] tests/9pfs: add local unlinkat symlink test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=edbf7a206a22138ee6f52c47c4a83b4d0b9fc3ea@lizzy.crudebyte.com;
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

This test case uses a Tunlinkat request to remove a symlink using
the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 78f4ed7e5f..f7d18f6274 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1293,6 +1293,31 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(real_file);
 }
 
+static void fs_unlinkat_symlink(void *obj, void *data,
+                                QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    struct stat st;
+    char *real_file = virtio_9p_test_path("06/real_file");
+    char *symlink_file = virtio_9p_test_path("06/symlink_file");
+
+    fs_attach(v9p, NULL, t_alloc);
+    fs_mkdir(v9p, data, t_alloc, "/", "06");
+    fs_lcreate(v9p, data, t_alloc, "06", "real_file");
+    g_assert(stat(real_file, &st) == 0);
+    g_assert((st.st_mode & S_IFMT) == S_IFREG);
+
+    fs_symlink(v9p, data, t_alloc, "06", "symlink_file", "real_file");
+    g_assert(stat(symlink_file, &st) == 0);
+
+    fs_unlinkat(v9p, data, t_alloc, "06", "symlink_file", 0);
+    /* symlink should be gone now */
+    g_assert(stat(symlink_file, &st) != 0);
+
+    g_free(symlink_file);
+    g_free(real_file);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1337,6 +1362,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
     qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
     qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
+    qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


