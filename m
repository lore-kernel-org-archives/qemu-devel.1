Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13AC4725A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098A92075A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXgroUQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098A92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGlo-0005S5-67
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGho-0005dn-0T
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:51:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhm-000557-Vi
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wV4EATbXKx0yfoicp1MyNawAoP7R4yGLGPwFlFlYLgg=;
 b=ZXgroUQ5ADz76gkSLhp0cBw7Nhcujc5ffCl0EEtErxrTL0o2RQ64+pNGwuTphSWWkznNx3
 cBezQEvOt9vJ7t4nttxOeIWOZkjhHXoWhaeOwVzNoSU4FwhSwhVBN1MfW780gsxC1pQXZQ
 GmogX+/fthTDlWxbXRLqu4HnYAJgBl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-9weV7qJ5NwavGmfRKWAGNA-1; Wed, 06 May 2020 05:51:04 -0400
X-MC-Unique: 9weV7qJ5NwavGmfRKWAGNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66226835B43;
 Wed,  6 May 2020 09:51:03 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6285C1BD;
 Wed,  6 May 2020 09:51:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 16/17] virtio-mem: Allow notifiers for size changes
Date: Wed,  6 May 2020 11:49:47 +0200
Message-Id: <20200506094948.76388-17-david@redhat.com>
In-Reply-To: <20200506094948.76388-1-david@redhat.com>
References: <20200506094948.76388-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to send qapi events in case the size of a virtio-mem device
changes. This allows upper layers to always know how much memory is
actually currently consumed via a virtio-mem device.

Unfortuantely, we have to report the id of our proxy device. Let's provid=
e
an easy way for our proxy device to register, so it can send the qapi
events. Piggy-backing on the notifier infrastructure (although we'll
only ever have one notifier registered) seems to be an easy way.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c         | 21 ++++++++++++++++++++-
 include/hw/virtio/virtio-mem.h |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index e25b2c74f2..88a99a0d90 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -198,6 +198,7 @@ static int virtio_mem_state_change_request(VirtIOMEM =
*vmem, uint64_t gpa,
     } else {
         vmem->size -=3D size;
     }
+    notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
     return VIRTIO_MEM_RESP_ACK;
 }
=20
@@ -253,7 +254,10 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         return -EBUSY;
     }
     bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
-    vmem->size =3D 0;
+    if (vmem->size !=3D 0) {
+        vmem->size =3D 0;
+        notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
+    }
=20
     virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
     return 0;
@@ -594,6 +598,18 @@ static MemoryRegion *virtio_mem_get_memory_region(Vi=
rtIOMEM *vmem, Error **errp)
     return &vmem->memdev->mr;
 }
=20
+static void virtio_mem_add_size_change_notifier(VirtIOMEM *vmem,
+                                                Notifier *notifier)
+{
+    notifier_list_add(&vmem->size_change_notifiers, notifier);
+}
+
+static void virtio_mem_remove_size_change_notifier(VirtIOMEM *vmem,
+                                                   Notifier *notifier)
+{
+    notifier_remove(notifier);
+}
+
 static void virtio_mem_get_size(Object *obj, Visitor *v, const char *nam=
e,
                                 void *opaque, Error **errp)
 {
@@ -705,6 +721,7 @@ static void virtio_mem_instance_init(Object *obj)
     VirtIOMEM *vmem =3D VIRTIO_MEM(obj);
=20
     vmem->block_size =3D VIRTIO_MEM_MIN_BLOCK_SIZE;
+    notifier_list_init(&vmem->size_change_notifiers);
=20
     object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_ge=
t_size,
                         NULL, NULL, NULL, &error_abort);
@@ -743,6 +760,8 @@ static void virtio_mem_class_init(ObjectClass *klass,=
 void *data)
=20
     vmc->fill_device_info =3D virtio_mem_fill_device_info;
     vmc->get_memory_region =3D virtio_mem_get_memory_region;
+    vmc->add_size_change_notifier =3D virtio_mem_add_size_change_notifie=
r;
+    vmc->remove_size_change_notifier =3D virtio_mem_remove_size_change_n=
otifier;
 }
=20
 static const TypeInfo virtio_mem_info =3D {
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-me=
m.h
index 27158cb611..5820b5c23e 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -66,6 +66,9 @@ typedef struct VirtIOMEM {
     /* block size and alignment */
     uint32_t block_size;
     uint32_t migration_block_size;
+
+    /* notifiers to notify when "size" changes */
+    NotifierList size_change_notifiers;
 } VirtIOMEM;
=20
 typedef struct VirtIOMEMClass {
@@ -75,6 +78,8 @@ typedef struct VirtIOMEMClass {
     /* public */
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo =
*vi);
     MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
+    void (*add_size_change_notifier)(VirtIOMEM *vmem, Notifier *notifier=
);
+    void (*remove_size_change_notifier)(VirtIOMEM *vmem, Notifier *notif=
ier);
 } VirtIOMEMClass;
=20
 #endif
--=20
2.25.3


