Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF7C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECA420EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJrWgLSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECA420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKL0N-0002nK-Ry
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKKtR-0004VU-Mv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKKtQ-0000Bm-5j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFAhFyha1dr/ayw6Q6yCDQIHRvmzlKL9CI6hQL7NrCk=;
 b=NJrWgLSVzAvJiZ2Q3G4YBiT7pXi44C24PsA5v5TwJZb1vBmKuZqSwaFa8iopCB0KzliPIO
 gq68Q/fDkh9snb2EoW6jmhQRYjXUVVGCNPaboflVlqajm/EZMVbL7rUzjIjTYlTSyHOuUr
 0KvE3SYR+MYP2SOXM5eQV586Pi9N4xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-wHM_UKR0PhmWoh__8eonmg-1; Mon, 21 Sep 2020 08:26:00 -0400
X-MC-Unique: wHM_UKR0PhmWoh__8eonmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5A08064B4;
 Mon, 21 Sep 2020 12:25:57 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-150.ams2.redhat.com
 [10.36.113.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83D216E70B;
 Mon, 21 Sep 2020 12:25:49 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 3/4] vhost-user-vsock-pci: force virtio version 1
Date: Mon, 21 Sep 2020 14:25:05 +0200
Message-Id: <20200921122506.82515-4-sgarzare@redhat.com>
In-Reply-To: <20200921122506.82515-1-sgarzare@redhat.com>
References: <20200921122506.82515-1-sgarzare@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
 Qian Cai <caiqian@redhat.com>, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9b3a35ec82 ("virtio: verify that legacy support is not
accidentally on") added a safety check that requires to set
'disable-legacy=on' on vhost-user-vsock-pci device:

    $ ./qemu-system-x86_64 ... \
    -chardev socket,id=char0,reconnect=0,path=/tmp/vhost4.socket \
    -device vhost-user-vsock-pci,chardev=char0
        qemu-system-x86_64: -device vhost-user-vsock-pci,chardev=char0:
        device is modern-only, use disable-legacy=on

virtio-vsock was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.

This patch forces virtio version 1 and removes the 'transitional_name'
property, as done for vhost-vsock-pci, removing the need to specify
'disable-legacy=on' on vhost-user-vsock-pci device.

Cc: qemu-stable@nongnu.org
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
 - added comment in the code [Cornelia]
v2:
 - fixed commit message [Cornelia]
---
 hw/virtio/vhost-user-vsock-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index 763f89984e..72a96199cd 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -41,6 +41,9 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    /* unlike vhost-vsock, we do not need to care about pre-5.1 compat */
+    virtio_pci_force_virtio_1(vpci_dev);
+
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
@@ -69,7 +72,6 @@ static void vhost_user_vsock_pci_instance_init(Object *obj)
 static const VirtioPCIDeviceTypeInfo vhost_user_vsock_pci_info = {
     .base_name             = TYPE_VHOST_USER_VSOCK_PCI,
     .generic_name          = "vhost-user-vsock-pci",
-    .transitional_name     = "vhost-user-vsock-pci-transitional",
     .non_transitional_name = "vhost-user-vsock-pci-non-transitional",
     .instance_size = sizeof(VHostUserVSockPCI),
     .instance_init = vhost_user_vsock_pci_instance_init,
-- 
2.26.2


