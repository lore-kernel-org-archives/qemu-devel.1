Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE52C43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709E622200
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="APk9QHWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709E622200
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbky-0008Pc-GK
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b563d3c73c6391ec927a2622c9f65c09ca56bd83@lizzy.crudebyte.com>)
 id 1kQbk5-0007Yt-P5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:38:21 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b563d3c73c6391ec927a2622c9f65c09ca56bd83@lizzy.crudebyte.com>)
 id 1kQbk3-0007wn-Nz
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=MaW9AGz3TC/jD9p/paco9fK6sQsRANI0w8QNYjkewy4=; b=APk9Q
 HWIjm7D+5SIjsD9yYGhrAf3xLBOAu2Qs5f8BD3vQ33yodSjY1ymitVjFNu5YeekrPbh21jc6/kKqq
 rpKcPS1u/II1C/wF6gjWLupCADkX4TL8jmvtnnPopdNWeJwGOQsVPIlaxClDoBcAFfatx6dP79g7i
 c+MR371Qx3wukukr0b3BVCmNuUjgJ829g+bZeU2jK5cUFkPLJ+DtONRF2MTNtTVrDWroLufD76de6
 foNLuPOcr2+XMuGPC3kx3pPZzUk0rGC5863ZFelhwkG3mko/cI19fX9LOH89dz/ch0fRtUYCHOwkb
 vxOFKMsnRcAJ/D8RzDcM65tEwFJ5A==;
Message-Id: <b563d3c73c6391ec927a2622c9f65c09ca56bd83.1602182956.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1602182956.git.qemu_oss@crudebyte.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 8 Oct 2020 20:34:56 +0200
Subject: [PATCH v4 11/12] tests/9pfs: add virtio_9p_test_path()
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
    Laurent Vivier <lvivier@redhat.com>,
    Paolo Bonzini <pbonzini@redhat.com>,
    Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
    Greg Kurz <groug@kaod.org>,
    "Daniel P. Berrangé" <berrange@redhat.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b563d3c73c6391ec927a2622c9f65c09ca56bd83@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 15:12:00
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
index bd53498041..1524982634 100644
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


