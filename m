Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D43C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E15120665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Akkb9MHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E15120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOfz-0006zl-8u
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ba79fe0a0b095c4936ac785cf51232aa9eec52aa@lizzy.crudebyte.com>)
 id 1kOOf9-00062t-UD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:16:08 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:58511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ba79fe0a0b095c4936ac785cf51232aa9eec52aa@lizzy.crudebyte.com>)
 id 1kOOf6-0000W0-9p
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=KUID9zcYFNagetFBTikouPXhrAw+dJp4Vkto9BQA5BA=; b=Akkb9
 MHQEICxB7P0SP3FKoTxRWDv3FllfdhFhTTLQyqbRLgYANBz8g6wYwK0p51THytAWH47XX0NyWjSA5
 fMr+homwxcwUHKro/9GQUdBI2hQXq3O1S4WC4YNs2OvCdo9FNfd5I9dHNXvj5WYIZYX1wouzusS4n
 BlZPHhUAmD+wEtgwc0Nr9Z1Z/nzd79EoDFJLNII2CLvzhd/wP+UbrYoCBKh+I6BpoGTyyI0YAsVow
 Tsr4lbhVWTOsSEdVlv4C/zHP5YcS7txODybAfB1W4LMXncT++lLjNlruh3ITmzByhVul6ZbwTHNDi
 X+WlRsiQZO41A1CgcsmOJQC9XNx2w==;
Message-Id: <ba79fe0a0b095c4936ac785cf51232aa9eec52aa.1601655308.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601655308.git.qemu_oss@crudebyte.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 18:15:05 +0200
Subject: [PATCH v3 10/11] tests/9pfs: add virtio_9p_test_path()
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, berrange@redhat.com
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=ba79fe0a0b095c4936ac785cf51232aa9eec52aa@lizzy.crudebyte.com;
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
index 41a7c2baaa..10a5760cf4 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -65,6 +65,12 @@ static void remove_local_test_dir(void)
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
index 326a603f72..19a4d97454 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -49,4 +49,9 @@ struct QVirtio9PDevice {
  */
 void virtio_9p_assign_local_driver(GString *cmd_line, const char *args);
 
+/**
+ * Returns path on host to the passed guest path. Result must be freed.
+ */
+char *virtio_9p_test_path(const char *path);
+
 #endif
-- 
2.20.1


