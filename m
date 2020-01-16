Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B174C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CED20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FppqSZpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CED20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2tG-0007GH-JK
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is2rj-0005ac-6b
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is2rh-0008NA-Vp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is2rh-0008Mp-QH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579172345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDGEv0wwyRCiswn1dmcYbXoPkWJxDjK0HvmEsSxTJdw=;
 b=FppqSZpHQli43h+43cV36D+TXn2MPd6Kibg5tu3rNL9QWa6x0SnYhJmqtslOTPpFcG/wTg
 DBdSI+SAXyJ2NZWa6kiucoZMjoUpuLtrm7BrAVyS2uAex1SqywXndvEEPmNPlFhuJL/lW8
 zVEaId4lKYI6vt/89/+hjKS+wfTUNHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-l6FyMOLuOLSGf4vhrYwYcQ-1; Thu, 16 Jan 2020 05:59:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0BC1800D50;
 Thu, 16 Jan 2020 10:59:02 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ACAE10842A9;
 Thu, 16 Jan 2020 10:58:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] virtio: add VirtioDeviceClass->get_num_virtqueues()
Date: Thu, 16 Jan 2020 10:58:39 +0000
Message-Id: <20200116105842.271179-3-stefanha@redhat.com>
In-Reply-To: <20200116105842.271179-1-stefanha@redhat.com>
References: <20200116105842.271179-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: l6FyMOLuOLSGf4vhrYwYcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-pci proxy objects have an "nvectors" qdev property to
allocate MSI vectors.  This property defaults to
DEV_NVECTORS_UNSPECIFIED on multi-queue devices and the final value is
based on the number of virtqueues.

The number of virtqueues is typically calculated like this by the
virtio-pci proxy object:

  num_virtqueues =3D NUM_FIXED_VIRTQUEUES + conf.num_queues

where conf.num_queues is a qdev property to allocate virtqueues.

Add VirtioDeviceClass->get_num_virtqueues() so that this calculation can
be performed by the device instead of the proxy object.  This removes
knowledge of virtqueue layout from the proxy object and allows the
device to implement other formulas for calculating the number of
virtqueues.

This patch has no use on its own but keeping it separate eases backports
if someone wants the virtio-blk patch but not virtio-scsi, or vice
versa.  The next patch uses this new function to automatically set
conf.num_queues to -smp N for automatic multi-queue configuration.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b69d517496..048c81fcef 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -163,6 +163,13 @@ typedef struct VirtioDeviceClass {
     int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
     bool (*primary_unplug_pending)(void *opaque);
+
+    /*
+     * Return the number of virtqueues.  Called by transports that need to
+     * allocate per-virtqueue interrupt resources.  This function may be c=
alled
+     * before the device is realized.
+     */
+    uint32_t (*get_num_virtqueues)(VirtIODevice *vdev);
 } VirtioDeviceClass;
=20
 void virtio_instance_init_common(Object *proxy_obj, void *data,
--=20
2.24.1


