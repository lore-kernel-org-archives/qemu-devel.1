Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC00C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7983220722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BprNefb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7983220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ljr-0004Ti-N1
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXc-00066g-5x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXa-0005dB-8N
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXa-0005bL-27
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gva/oijUn2ukqqFeWUu5GYV/ONiMfg1SXT6HuIycNbc=;
 b=BprNefb0a5nrJoeVazx4d/BDq9xFbFY1DkG0KAmdpVQNabycvrnAB2LK+F0UbDV8GfjsxA
 qAt4Db5u0ZAsSM7hmPWkgXgY+aRK7YG7NOPRw0aNU1LpavK5Hp8Ad7Oel0DaHtdnIH5uFN
 SZHy7QF4A2UdPaOSw9BAFNI4pLAtPIo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-jhGHXd59N96uovvU4eJdBQ-1; Thu, 20 Feb 2020 08:06:47 -0500
Received: by mail-wr1-f71.google.com with SMTP id p8so1714155wrw.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=epBBiJe/BiipnhOxinjfU345ql1651dsm1KJ2Eg1l+8=;
 b=NNNXJLYFQNSx1pzcjH68Cc/mzX3aOiaZhE6zGeVv5KUAg3a2s+OvE+JXPVkknDZV8A
 ppzDjzBT4mJ7K2O9lfWlI6gT4MW5GYgRM7sv19M/8MunZHpK8uC/zDlu7k9kKkZ8E7IU
 nmgOjwxmQJgJZrm0OWAhg9wsDfaSEALBf3FiRimY/Atr/GL9BTvbpU/+PhalIBXYVv8Z
 38nNFczikKOm3L/BVb4AS5oY4ohXnwKhERPbRXtGkZDrPn7B74jX0Afr/ffEZrfir4ql
 5Ilg7hayjZNHnpBd0fNY3BAKRRQo5k1OQcCxWn8hIWT/OjlofNADIWQ3ldbOqIqNCWmk
 //VA==
X-Gm-Message-State: APjAAAXo1DPOiQMrbQLId0sY92cDnuMhci5zbZ8DCYgC5crHnHF6c6t7
 qaB0rJEOrBwTC/7M6Iw64IyCEnT9CHNHlgktYMuOwl42G9iKKI44Af7hDhxj9yUuHYSF83Ei7dB
 7o1SUhRY5fNzSKpI=
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr4504805wmd.101.1582204006819; 
 Thu, 20 Feb 2020 05:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzyX5Y7gdzaTOQjQ/rcWnepNEp6tk5YfOUODjdV1i7lhwV6s1r0NC2sbtsj+sn6/vQEc+xMg==
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr4504765wmd.101.1582204006470; 
 Thu, 20 Feb 2020 05:06:46 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 14/20] hw/virtio: Let vhost_memory_map() use a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:42 +0100
Message-Id: <20200220130548.29974-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: jhGHXd59N96uovvU4eJdBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/virtio/vhost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9edfadc81d..0d226dae10 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -294,7 +294,7 @@ static int vhost_dev_has_iommu(struct vhost_dev *dev)
 }
=20
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
-                              hwaddr *plen, int is_write)
+                              hwaddr *plen, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
         return cpu_physical_memory_map(addr, plen, is_write);
@@ -1012,21 +1012,21 @@ static int vhost_virtqueue_start(struct vhost_dev *=
dev,
=20
     vq->desc_size =3D s =3D l =3D virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys =3D a;
-    vq->desc =3D vhost_memory_map(dev, a, &l, 0);
+    vq->desc =3D vhost_memory_map(dev, a, &l, false);
     if (!vq->desc || l !=3D s) {
         r =3D -ENOMEM;
         goto fail_alloc_desc;
     }
     vq->avail_size =3D s =3D l =3D virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys =3D a =3D virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail =3D vhost_memory_map(dev, a, &l, 0);
+    vq->avail =3D vhost_memory_map(dev, a, &l, false);
     if (!vq->avail || l !=3D s) {
         r =3D -ENOMEM;
         goto fail_alloc_avail;
     }
     vq->used_size =3D s =3D l =3D virtio_queue_get_used_size(vdev, idx);
     vq->used_phys =3D a =3D virtio_queue_get_used_addr(vdev, idx);
-    vq->used =3D vhost_memory_map(dev, a, &l, 1);
+    vq->used =3D vhost_memory_map(dev, a, &l, true);
     if (!vq->used || l !=3D s) {
         r =3D -ENOMEM;
         goto fail_alloc_used;
--=20
2.21.1


