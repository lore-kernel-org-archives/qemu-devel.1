Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622F1C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F60221F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeXzGWYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F60221F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBIX-0003ju-BJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFd-000883-5k
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFb-00045V-V2
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36626
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jPBFb-00045E-Ra
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587069403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCfvYIFWj9x4jvO82y2dyfecH7qtqDb9QbAc2gJHHU0=;
 b=LeXzGWYY+ggVmvmMyuna4ZK440KfWVN1myzVVyiKhHDhvTwAhRD9lK0EPvsx8v5XTn+htv
 IqLo9OvORvnba9rh7mtJVcZvX3SmNuEETR5RZRd3cL2XVe0ysQB+ozdtNh7GsL+pwapLIb
 +UB2uviTpdW2t7zNf5stpKZj0o6MVOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-ekIrcDidM3eogEqhEeWr7g-1; Thu, 16 Apr 2020 16:36:41 -0400
X-MC-Unique: ekIrcDidM3eogEqhEeWr7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD30107ACC9;
 Thu, 16 Apr 2020 20:36:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDD296092D;
 Thu, 16 Apr 2020 20:36:38 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] virtio-scsi: don't touch scsi devices that are not yet
 realized
Date: Thu, 16 Apr 2020 23:36:24 +0300
Message-Id: <20200416203624.32366-5-mlevitsk@redhat.com>
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1812399

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/virtio-scsi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index b0f4a35f81..e360b4e03e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -35,13 +35,29 @@ static inline int virtio_scsi_get_lun(uint8_t *lun)
=20
 static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *=
lun)
 {
+    SCSIDevice *device =3D NULL;
+
     if (lun[0] !=3D 1) {
         return NULL;
     }
     if (lun[2] !=3D 0 && !(lun[2] >=3D 0x40 && lun[2] < 0x80)) {
         return NULL;
     }
-    return scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
+
+    device =3D scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lu=
n));
+
+    /* This function might run on the IO thread and we might race against
+     * main thread hot-plugging the device.
+     *
+     * We assume that as soon as .realized is set to true we can let
+     * the user access the device.
+     */
+
+    if (!device || !atomic_read(&device->qdev.realized)) {
+        return NULL;
+    }
+
+    return device;
 }
=20
 void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req=
)
--=20
2.17.2


