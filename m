Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EA0C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C54208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af1XooOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C54208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCW5-0003Kf-7k
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNCO9-0002ou-NQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNCO8-0000sc-2N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:57:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601373455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDgOTF722Tnr9qf/sX0cySEoHobwdrhfgZYLnSfUis8=;
 b=Af1XooOLQW4hJfLVn8f5TcWbMvEOyg44yld907yHCmvMjYAVeO0ewfc8mZwZMmSMWQJuH1
 lXKlDVCSdRZ6ZzRx1EymS+EUBTNI/xIpQpI5jw0g3nKip4Ev//NwOKQeUzuTR+R26mSTmM
 9g0X74jfEbRiu/lQ1eSxO9oTjlu+EZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-lR1Kjf4fOO6vFJCbTeWKeA-1; Tue, 29 Sep 2020 05:57:33 -0400
X-MC-Unique: lR1Kjf4fOO6vFJCbTeWKeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB8531007283;
 Tue, 29 Sep 2020 09:57:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2A745C1BD;
 Tue, 29 Sep 2020 09:57:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D403C31E23; Tue, 29 Sep 2020 11:57:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] virtio-vga: implement big-endian-framebuffer property
Date: Tue, 29 Sep 2020 11:57:16 +0200
Message-Id: <20200929095717.26745-9-kraxel@redhat.com>
In-Reply-To: <20200929095717.26745-1-kraxel@redhat.com>
References: <20200929095717.26745-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allows to switch the (vga mode) framebuffer into bigendian mode
by setting the property, simliar to stdvga.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200928085335.21961-2-kraxel@redhat.com
---
 hw/display/virtio-vga.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index f9410a0c2e61..81f776ee36e7 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -168,6 +168,20 @@ static void virtio_vga_base_reset(DeviceState *dev)
     vga_dirty_log_start(&vvga->vga);
 }
 
+static bool virtio_vga_get_big_endian_fb(Object *obj, Error **errp)
+{
+    VirtIOVGABase *d = VIRTIO_VGA_BASE(obj);
+
+    return d->vga.big_endian_fb;
+}
+
+static void virtio_vga_set_big_endian_fb(Object *obj, bool value, Error **errp)
+{
+    VirtIOVGABase *d = VIRTIO_VGA_BASE(obj);
+
+    d->vga.big_endian_fb = value;
+}
+
 static Property virtio_vga_base_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
@@ -190,6 +204,11 @@ static void virtio_vga_base_class_init(ObjectClass *klass, void *data)
     k->realize = virtio_vga_base_realize;
     pcidev_k->romfile = "vgabios-virtio.bin";
     pcidev_k->class_id = PCI_CLASS_DISPLAY_VGA;
+
+    /* Expose framebuffer byteorder via QOM */
+    object_class_property_add_bool(klass, "big-endian-framebuffer",
+                                   virtio_vga_get_big_endian_fb,
+                                   virtio_vga_set_big_endian_fb);
 }
 
 static TypeInfo virtio_vga_base_info = {
-- 
2.27.0


