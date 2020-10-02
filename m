Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6243AC47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05761206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lbqA845C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05761206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKdB-0005ER-7K
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a6b048f6393d0d8dfcf760dc875557ea15addc2a@lizzy.crudebyte.com>)
 id 1kOKXP-0000Ss-U5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:51:53 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a6b048f6393d0d8dfcf760dc875557ea15addc2a@lizzy.crudebyte.com>)
 id 1kOKXM-0008K0-1v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=AnO5hDBjL13vnsmw8rZQ8n8acmgU4cSW+h2SSlexQGo=; b=lbqA8
 45CJu2X5ca51znopA8OYHtd1OkuLulyXFFROBUSr9aec5OrvXDgRRijoW2V+LszAjIf6ug0pbM/F6
 lH5wMDKaeQqn21VPElijio63aPBlcG1+R6Xcnjf9Ms/hZx4mCmLFfdKNu4SYF9nqTtHYVnVXZbQ6U
 Cv6xDzJyawLtaw/O457pupTRyssrXRm5eu+gD6oo59yhyqhzRYIN36XeGZzv5SpjT5EKQT1wyZc7T
 X+vNKncE4voieKp4prCdraU+zjhyc95o1TrWMfmj3NHNi+5HZQCEp/xsqj1ixDV0EgibWxEXxJuUn
 3aFRCxhwso3yZn5UWh10Gd5dOyOOA==;
Message-Id: <a6b048f6393d0d8dfcf760dc875557ea15addc2a.1601639563.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601639563.git.qemu_oss@crudebyte.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 13:51:54 +0200
Subject: [PATCH v2 09/11] tests/9pfs: wipe local 9pfs test directory
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=a6b048f6393d0d8dfcf760dc875557ea15addc2a@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 08:18:24
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

Before running the first 9pfs test case, make sure the test directory
for running the 9pfs 'local' tests on is entirely empty. For that
reason simply delete the test directory (if any) before (re)creating
it on test suite startup.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 86e40e5d56..6cd8c8964b 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -82,6 +82,18 @@ static void create_local_test_dir(void)
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 }
 
+/* Deletes directory previously created by create_local_test_dir(). */
+static void remove_local_test_dir(void)
+{
+    g_assert(local_test_path != NULL);
+    char *cmd = strpr("rm -r '%s'\n", local_test_path);
+    int res = system(cmd);
+    if (res < 0) {
+        /* ignore error, dummy check to prevent compiler error */
+    }
+    g_free(cmd);
+}
+
 static void virtio_9p_cleanup(QVirtio9P *interface)
 {
     qvirtqueue_cleanup(interface->vdev->bus, interface->vq, alloc);
@@ -249,6 +261,7 @@ static void virtio_9p_register_nodes(void)
 
     /* make sure test dir for the 'local' tests exists and is clean */
     init_local_test_path();
+    remove_local_test_dir();
     create_local_test_dir();
 
     QPCIAddress addr = {
-- 
2.20.1


