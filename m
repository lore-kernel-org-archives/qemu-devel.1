Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D399BC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6904123718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="pTUXGOOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6904123718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVxg-0001AI-K4
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b1a9c16b687b8d0fe8f13986a50ba413a13be36e@lizzy.crudebyte.com>)
 id 1kMVwk-0000HD-4Z
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:38:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:36839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b1a9c16b687b8d0fe8f13986a50ba413a13be36e@lizzy.crudebyte.com>)
 id 1kMVwg-0000FT-Gh
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=z8Q8TmVLfHNYUvSNhYvsSyw1bjj67qrXdlwp0bqoAd4=; b=pTUXG
 OOtTxP0DVqE7TdzaGbfKGVqprdIFX6xwDmkVdRqfHpOZlO1zYZzVcFr1Erd/pLjRShaK2DzH1ODbb
 MI381OtUkSqFfRw6rEgQaWRISuyiwNtL7s3uJaJuSA7JvTyvoLySY/oVUvbY9ApDSCgTmiqWSCpcX
 8hwvm4RSc4oYVHygxy1bJJOQZYNIUNsu39ZO9FjGLbd3Iahgumk+5dPQfLSx/21QP0Ak5yagM45je
 lh+eF0QzEF95SD07oJvaTUirPdzJRAt8MZGCpAqvQDu9bEw4Mf5XvINtdN16szLEeySPNm4pStEhk
 xgaFAVCB7U3TxErHiEnasG9wwDk5w==;
Message-Id: <b1a9c16b687b8d0fe8f13986a50ba413a13be36e.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:41:13 +0200
Subject: [PATCH 11/12] tests/9pfs: add virtio_9p_test_path()
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b1a9c16b687b8d0fe8f13986a50ba413a13be36e@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
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

This new public function virtio_9p_test_path() allows 9pfs
'local' tests to translate a path from guest scope to host
scope. For instance by passing an empty string it would
return the root path on host of the exported 9pfs tree.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 6 ++++++
 tests/qtest/libqos/virtio-9p.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index b44fc4ad63..599b73a9d7 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -92,6 +92,12 @@ static void remove_local_test_dir(void)
     g_free(cmd);
 }
 
+char *virtio_9p_test_path(const char *path)
+{
+    g_assert(local_test_path);
+    return concat_path(local_test_path, path);
+}
+
 static void virtio_9p_cleanup(QVirtio9P *interface)
 {
     qvirtqueue_cleanup(interface->vdev->bus, interface->vq, alloc);
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index 20d1fc6270..052882ef7c 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -45,4 +45,9 @@ struct QVirtio9PDevice {
     QVirtio9P v9p;
 };
 
+/**
+ * Returns path on host to the passed guest path. Result must be freed.
+ */
+char *virtio_9p_test_path(const char *path);
+
 #endif
-- 
2.20.1


