Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDFBC55178
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 15:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C41722246
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 15:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ULDeq4ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C41722246
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZFEM-0004VK-Gz
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 10:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ec90703cbc23d6b612b3672f946d7741f4a16080@lizzy.crudebyte.com>)
 id 1kZFCZ-0003Fx-6l
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 10:23:27 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:36899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ec90703cbc23d6b612b3672f946d7741f4a16080@lizzy.crudebyte.com>)
 id 1kZFCW-0006k0-S3
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 10:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=M4F3q8KaK+NXBeqlbOxwURsCLbUnH74xNhiohvqEx/4=; b=ULDeq
 4obX2L2KJPTUDISmyYF/sKDlJOAZwkI+JTzjc3EBCI9aH8vjlutzDIx52MMcJiIJNs0D4ZwOwVpZN
 CITFnR4LFi+2VACbPHPysOsDfVgFyI3c8T4sfp0MMsQfIjFYjjDVtZAXTdH0rU9zelmwLFXihAE4K
 w/81e8vIWm5oAkRW9PhASGfYPOAkOI/UnfAjiodoZOYJI0tAAToroD5YmULoD+Nz7OGqsm3TXsnae
 YiGvlcT7WqnxqunkzvViAghQ2lRfKh6whLNavI6eb80kGCbR8JVJN2poSjS8bnnpCvc14VQvnNKL2
 qSSJ+nyaWQN7eWX7xN7tlKdkvjxVg==;
Message-Id: <ec90703cbc23d6b612b3672f946d7741f4a16080.1604243521.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604243521.git.qemu_oss@crudebyte.com>
References: <cover.1604243521.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 1 Nov 2020 15:25:14 +0100
Subject: [PATCH v3 1/2] tests/9pfs: make create/remove test dir public
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=ec90703cbc23d6b612b3672f946d7741f4a16080@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 10:22:17
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

Make functions create_local_test_dir() and remove_local_test_dir()
public. They're going to be used in the next patch.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 10 ++++------
 tests/qtest/libqos/virtio-9p.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index d43647b3b7..2736e9ae2a 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -39,8 +39,7 @@ static void init_local_test_path(void)
     g_free(pwd);
 }
 
-/* Creates the directory for the 9pfs 'local' filesystem driver to access. */
-static void create_local_test_dir(void)
+void virtio_9p_create_local_test_dir(void)
 {
     struct stat st;
 
@@ -53,8 +52,7 @@ static void create_local_test_dir(void)
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 }
 
-/* Deletes directory previously created by create_local_test_dir(). */
-static void remove_local_test_dir(void)
+void virtio_9p_remove_local_test_dir(void)
 {
     g_assert(local_test_path != NULL);
     char *cmd = g_strdup_printf("rm -r '%s'\n", local_test_path);
@@ -248,8 +246,8 @@ static void virtio_9p_register_nodes(void)
 
     /* make sure test dir for the 'local' tests exists and is clean */
     init_local_test_path();
-    remove_local_test_dir();
-    create_local_test_dir();
+    virtio_9p_remove_local_test_dir();
+    virtio_9p_create_local_test_dir();
 
     QPCIAddress addr = {
         .devfn = QPCI_DEVFN(4, 0),
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index 19a4d97454..480727120e 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -44,6 +44,16 @@ struct QVirtio9PDevice {
     QVirtio9P v9p;
 };
 
+/**
+ * Creates the directory for the 9pfs 'local' filesystem driver to access.
+ */
+void virtio_9p_create_local_test_dir(void);
+
+/**
+ * Deletes directory previously created by virtio_9p_create_local_test_dir().
+ */
+void virtio_9p_remove_local_test_dir(void);
+
 /**
  * Prepares QEMU command line for 9pfs tests using the 'local' fs driver.
  */
-- 
2.20.1


