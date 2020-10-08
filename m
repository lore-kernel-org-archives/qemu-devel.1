Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5477C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1716820657
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="i+aW99FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1716820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnDb-0003oK-9F
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a45b2829da0af55c8344fa83876d59f9c4b0cf78@lizzy.crudebyte.com>)
 id 1kTn8g-000606-NQ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:24:55 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a45b2829da0af55c8344fa83876d59f9c4b0cf78@lizzy.crudebyte.com>)
 id 1kTn8f-000632-6V
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=yDG/u17bdmxsKZTdFz3D0Y47pkgPagiwF3adJJ/WwAw=; b=i+aW9
 9FBEXa+nIiAmIArkLCRDXvcq1wYcdZBQHipjoeCFxGoYHcMxaJL/IXn98l8kVz2q3T/J+Unzf1soW
 RMPsPitJyxX5fRRD4qTZn6nuf7l4hk7GgCPIuVpH6XLLQo1S7gisrGMwdrRsxJqBmCsCewxw7V6jb
 1w7ShDIcnVxc5Y5iI/JS1O9kQqvdyojRHx29+b0M/OL5PQwtl20dw4s0ykpfAeJF14fLBYb6MU261
 iTw92iICmyozFqMN/IKqJ40ddkHOWJRu++EjwHQf9kcmnobs5aCl92Dp0AqFEdJtStlPcERtf/Z6E
 zwoF9LjYs3m1APZkqEqzpHg5I/A2A==;
Message-Id: <a45b2829da0af55c8344fa83876d59f9c4b0cf78.1602943547.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1602943547.git.qemu_oss@crudebyte.com>
References: <cover.1602943547.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 8 Oct 2020 20:34:56 +0200
Subject: [PULL v2 3/5] tests/9pfs: wipe local 9pfs test directory
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=a45b2829da0af55c8344fa83876d59f9c4b0cf78@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 10:23:34
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

Before running the first 9pfs test case, make sure the test directory
for running the 9pfs 'local' tests on is entirely empty. For that
reason simply delete the test directory (if any) before (re)creating
it on test suite startup.

Note: The preferable precise behaviour would be the test directory
only being wiped once *before* a test suite run. Right now the test
directory is also wiped at the *end* of a test suite run because
libqos is calling the virtio_9p_register_nodes() callback for some
reason also when a test suite completed. This is suboptimal as
developers cannot immediately see what files and directories the
9pfs local tests created precisely after the test suite completed.
But fortunately the test directory is not wiped if some test failed.
So it is probably not worth it drilling another hole into libqos
for this issue.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <b30776ea3289dc40dabc7d0063d825d21d9a65bf.1602182956.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index ee331166de..8ee2a134bc 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -53,6 +53,18 @@ static void create_local_test_dir(void)
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 }
 
+/* Deletes directory previously created by create_local_test_dir(). */
+static void remove_local_test_dir(void)
+{
+    g_assert(local_test_path != NULL);
+    char *cmd = g_strdup_printf("rm -r '%s'\n", local_test_path);
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
@@ -230,6 +242,7 @@ static void virtio_9p_register_nodes(void)
 
     /* make sure test dir for the 'local' tests exists and is clean */
     init_local_test_path();
+    remove_local_test_dir();
     create_local_test_dir();
 
     QPCIAddress addr = {
-- 
2.20.1


