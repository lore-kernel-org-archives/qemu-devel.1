Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A309DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C57E222B9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="U3aZvfSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57E222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWYb-0007LN-0Z
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8db193c4108e09996923a4d716b51fc98efb7f3a@lizzy.crudebyte.com>)
 id 1kZWTD-0001W4-2Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:49:47 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:60689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8db193c4108e09996923a4d716b51fc98efb7f3a@lizzy.crudebyte.com>)
 id 1kZWTB-0006Zo-FL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=qnTnQy0Xa8xQsWTotjLWOzYssCe4FirszozZZ3yzRxU=; b=U3aZv
 fSDPmOLIhwk7P213qMHgGj2PFnwe21hxvBPwZ8lIEZBSfSCPbTyLPQp1CRkOsIPkcrOLP89D2pGRu
 vh+47QYITqQhZDxPmnGms+za6odk6lUVvcaxsycbB9ghe32MMBDB3UzDyr00ngAZ+rs4heSsH0/qs
 g8yMifPcQqXL9cP90jZlxfM6AJGXLf1HcYESelwKirsRkPpMlH+DDN//F+lbgtsf1rrpwwtG7Ukjb
 54DJW3U6DvJvptBwQ14o9GUOd5ufHxlIjBOSEKd8xc8PlB9+t6qRMHpr4w/WAbxvpJMK7oo3SDd0W
 eqfQEM4Er0eE0YviiY9haxqRk8Dvg==;
Message-Id: <8db193c4108e09996923a4d716b51fc98efb7f3a.1604309512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604309512.git.qemu_oss@crudebyte.com>
References: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 1 Nov 2020 15:25:14 +0100
Subject: [PULL v3 01/17] tests/9pfs: make create/remove test dir public
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=8db193c4108e09996923a4d716b51fc98efb7f3a@lizzy.crudebyte.com;
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

Make functions create_local_test_dir() and remove_local_test_dir()
public. They're going to be used in the next patch.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <ec90703cbc23d6b612b3672f946d7741f4a16080.1604243521.git.qemu_oss@crudebyte.com>
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


