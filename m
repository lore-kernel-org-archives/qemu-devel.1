Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBD620862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGP4fBmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBD620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOye9-0001GT-Kl
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 02:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iOycv-0007s9-MG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iOycu-0007mQ-BZ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iOycu-0007mE-81
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572244539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fuw48XRF32YYLQXUaTJftLwF7yl/U7ecUZNqNcY/RpI=;
 b=MGP4fBmJ29qbuMSshzkrcyq7AW4241kstVAKvuqlse2KFsMO6WUygjPGbnzsXB46LJ6eGD
 xeT6tjMPMO+EDq3Eb+HWQwxlgwCrG62e/dmz9AJTzB3cfKjW6et4u2wO8Z5mQTQsmeen0r
 ezwdh5NwlQWD0XLYAOtf/cLi1knXcfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-tc821_mCMUSEuBz5JgqL0w-1; Mon, 28 Oct 2019 02:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13E8E80183E;
 Mon, 28 Oct 2019 06:35:35 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-12.pek2.redhat.com
 [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5EDB5C1D4;
 Mon, 28 Oct 2019 06:35:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 2/4] virtio: new post_load hook
Date: Mon, 28 Oct 2019 14:35:18 +0800
Message-Id: <1572244520-14737-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
References: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tc821_mCMUSEuBz5JgqL0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>,
 Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Post load hook in virtio vmsd is called early while device is processed,
and when VirtIODevice core isn't fully initialized.  Most device
specific code isn't ready to deal with a device in such state, and
behaves weirdly.

Add a new post_load hook in a device class instead.  Devices should use
this unless they specifically want to verify the migration stream as
it's processed, e.g. for bounds checking.

Cc: qemu-stable@nongnu.org
Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c         | 7 +++++++
 include/hw/virtio/virtio.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03..54a46e2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,6 +2291,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int=
 version_id)
     }
     rcu_read_unlock();
=20
+    if (vdc->post_load) {
+        ret =3D vdc->post_load(vdev);
+        if (ret) {
+            return ret;
+        }
+    }
+
     return 0;
 }
=20
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04..ca4f9c0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -158,6 +158,12 @@ typedef struct VirtioDeviceClass {
      */
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
+    /* Post load hook in vmsd is called early while device is processed, a=
nd
+     * when VirtIODevice isn't fully initialized.  Devices should use this=
 instead,
+     * unless they specifically want to verify the migration stream as it'=
s
+     * processed, e.g. for bounds checking.
+     */
+    int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
 } VirtioDeviceClass;
=20
--=20
2.5.0


