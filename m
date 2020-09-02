Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F9C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F5A20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt+yRxgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F5A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSeO-0000lw-1S
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kDSYf-00060D-Pg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:12:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kDSYe-0000TF-7T
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599052331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o47dQDdkQ0vaT/koY2t6z4yS+OElzNgDKhfCAIXh/eE=;
 b=bt+yRxgCkDc49n7yTD8l9QYJmLGYCnpIiplP5LZj5EfZj+fI8N3fWtJLMhJl2ekkYz4Irx
 r3YeegQnzYXZreXuluxtxzK8CwkMgb/cSqURCWucUn3FN7wvwzopRNWIJ4HMx8FS0tRHDR
 RwRpcWe37T6in1qlBiaIRGcY5P22Nrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-nuER-uHmMn-QfDUpC6a0zg-1; Wed, 02 Sep 2020 09:12:09 -0400
X-MC-Unique: nuER-uHmMn-QfDUpC6a0zg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D73A718B9EC0;
 Wed,  2 Sep 2020 13:12:08 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEBD95D9CC;
 Wed,  2 Sep 2020 13:12:06 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 cohuck@redhat.com, mst@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH 1/2] virtio-iommu: Check gtrees are non null before destroying
 them
Date: Wed,  2 Sep 2020 15:11:51 +0200
Message-Id: <20200902131152.1219-2-eric.auger@redhat.com>
In-Reply-To: <20200902131152.1219-1-eric.auger@redhat.com>
References: <20200902131152.1219-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jean-philippe@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If realize fails, domains and endpoints trees may be NULL. On
unrealize(), this produces asseryions:
 "GLib: g_tree_destroy: assertion 'tree != NULL' failed"

Check the tree are non NULL before destroying them.

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 5d56865e56..21ec63b108 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -801,8 +801,12 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
     g_hash_table_destroy(s->as_by_busptr);
-    g_tree_destroy(s->domains);
-    g_tree_destroy(s->endpoints);
+    if (s->domains) {
+        g_tree_destroy(s->domains);
+    }
+    if (s->endpoints) {
+        g_tree_destroy(s->endpoints);
+    }
 
     virtio_delete_queue(s->req_vq);
     virtio_delete_queue(s->event_vq);
-- 
2.21.3


