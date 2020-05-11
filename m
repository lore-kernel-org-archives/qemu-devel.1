Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF07C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB87205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB+6pskm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB87205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYB3c-0007fW-7n
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0V-0002WR-9Q
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0U-0001A1-CB
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589213417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=v6NxqcYEzK4ft0LoCoTz3Wn4loJq3RbuOWoQob7rOWk=;
 b=DB+6pskmGNBwJ4kAMHELhA7DnK6CC0KPu1MIcZIVI+7QHj5Kf9V5wUUxqHszsvqMLd1x9n
 g+deqt6tdWZsGj/tUWbWOji/h+f2gPBXLIy1JkfbOnMjbnIhUzkxHU7Fj4eJ23/VlBN0Tt
 a5eNs6+5uJbWLu4jiSEwIm9xq/CDde4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-2kxTre3wMHuXfFizGc1jaw-1; Mon, 11 May 2020 12:10:13 -0400
X-MC-Unique: 2kxTre3wMHuXfFizGc1jaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADA8B475;
 Mon, 11 May 2020 16:10:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C746A5C1B5;
 Mon, 11 May 2020 16:10:10 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] virtio-scsi: don't touch scsi devices that are not yet
 realized or about to be un-realized
Date: Mon, 11 May 2020 19:09:49 +0300
Message-Id: <20200511160951.8733-6-mlevitsk@redhat.com>
In-Reply-To: <20200511160951.8733-1-mlevitsk@redhat.com>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/virtio-scsi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index b0f4a35f81..1cc1fc557c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -35,13 +35,30 @@ static inline int virtio_scsi_get_lun(uint8_t *lun)
 
 static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
 {
+    SCSIDevice *device = NULL;
+
     if (lun[0] != 1) {
         return NULL;
     }
     if (lun[2] != 0 && !(lun[2] >= 0x40 && lun[2] < 0x80)) {
         return NULL;
     }
-    return scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
+
+    device = scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
+
+    /*
+     * This function might run on the IO thread and we might race against
+     * main thread hot-plugging the device.
+     *
+     * We assume that as soon as .realized is set to true we can let
+     * the user access the device.
+     */
+
+    if (!device || !atomic_load_acquire(&device->qdev.realized)) {
+        return NULL;
+    }
+
+    return device;
 }
 
 void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req)
-- 
2.17.2


