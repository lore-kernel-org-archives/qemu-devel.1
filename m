Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F51C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87A820DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS4YMCEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87A820DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBH2-0001yl-OT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJB8A-0001FE-7v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJB88-00005g-Mf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600415308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ur9qZSAsLSOK/VR3EirI9d3AW5Xs2qWrYAuAh+6fJ/E=;
 b=jS4YMCEc+WGnxIjt4JH3/GptYhZqRKa0KOEVrng/ATAdkpfOByjJp5/ENg5IdvUVN9Nbbn
 YAUioFlFYntEx0jUN18wa0HWrbEgTNrGi0QPyWRJD+4Xfg1/ObGSt3RiGqt3p/4Uq/5nLt
 9iy/rNe8T5IeF+sku9c46h9JeJk4PHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-YbwsRouvNVOUPrhERK0Bzg-1; Fri, 18 Sep 2020 03:48:24 -0400
X-MC-Unique: YbwsRouvNVOUPrhERK0Bzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CF721084C93;
 Fri, 18 Sep 2020 07:48:23 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-92.ams2.redhat.com
 [10.36.113.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E58C60BEC;
 Fri, 18 Sep 2020 07:48:10 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 4/4] vhost-vsock-ccw: force virtio version 1
Date: Fri, 18 Sep 2020 09:47:10 +0200
Message-Id: <20200918074710.27810-5-sgarzare@redhat.com>
In-Reply-To: <20200918074710.27810-1-sgarzare@redhat.com>
References: <20200918074710.27810-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Qian Cai <caiqian@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio-vsock was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.

This patch forces virtio version 1 as done for vhost-vsock-pci.

To avoid migration issues, we force virtio version 1 only when
legacy check is enabled in the new machine types (>= 5.1).

Cc: qemu-stable@nongnu.org
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
 - forced virtio version 1 only with new machine types
---
 hw/s390x/vhost-vsock-ccw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 0822ecca89..246416a8f9 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -40,9 +40,21 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
 static void vhost_vsock_ccw_instance_init(Object *obj)
 {
     VHostVSockCCWState *dev = VHOST_VSOCK_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+    VirtIODevice *virtio_dev;
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VHOST_VSOCK);
+
+    virtio_dev = VIRTIO_DEVICE(&dev->vdev);
+
+    /*
+     * To avoid migration issues, we force virtio version 1 only when
+     * legacy check is enabled in the new machine types (>= 5.1).
+     */
+    if (!virtio_legacy_check_disabled(virtio_dev)) {
+        ccw_dev->force_revision_1 = true;
+    }
 }
 
 static const TypeInfo vhost_vsock_ccw_info = {
-- 
2.26.2


