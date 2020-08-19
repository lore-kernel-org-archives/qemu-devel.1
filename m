Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03122C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64A7206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSiZ8HG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64A7206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Lj6-00048d-VB
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8Lhw-0001vb-Qm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:52:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k8Lhu-0004Vr-0P
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597834357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=050x6x/nruS+dqlDdRlFvCxjeOafaWjPF0d0fV4cSGs=;
 b=MSiZ8HG1/V+VYY3gMeDW7qSRFnJ5Ljnv+zTV35+cAxYuinETpcZWZRD6T1DSDeP9OqZAOC
 ZW8lrW9uSQUAJqS8pVKslHodltsFCX31f8+lFJ/KVhy7YR1EEqn8KMQ+wavHMVaGX9EiDm
 uysSkyz3VFJ4FX0Pe5kz3wRY8Ac/jco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-2z42ECsHOtiRr_4vSARQxg-1; Wed, 19 Aug 2020 06:52:35 -0400
X-MC-Unique: 2z42ECsHOtiRr_4vSARQxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C28210066FF;
 Wed, 19 Aug 2020 10:52:34 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-132.ams2.redhat.com
 [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 046085C1A3;
 Wed, 19 Aug 2020 10:52:24 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] vhost-vsock-ccw: force virtio version 1
Date: Wed, 19 Aug 2020 12:51:56 +0200
Message-Id: <20200819105156.54163-4-sgarzare@redhat.com>
In-Reply-To: <20200819105156.54163-1-sgarzare@redhat.com>
References: <20200819105156.54163-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio-vsock was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.

This patch forces virtio version 1 as done for vhost-vsock-pci.

Cc: qemu-stable@nongnu.org
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/s390x/vhost-vsock-ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 0822ecca89..0759143efa 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -40,7 +40,9 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
 static void vhost_vsock_ccw_instance_init(Object *obj)
 {
     VHostVSockCCWState *dev = VHOST_VSOCK_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
 
+    ccw_dev->force_revision_1 = true;
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VHOST_VSOCK);
 }
-- 
2.26.2


