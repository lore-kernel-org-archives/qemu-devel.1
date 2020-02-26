Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8E8C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AA52084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeRVwQnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AA52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sgn-0000QI-5J
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sdx-0003Nb-TA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sdw-0006zM-Lv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sdw-0006z5-Hq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3B3Sa4xWvVmS4vX2SpY1eVnYbHxN4jErdc7je0hAjzI=;
 b=MeRVwQnL4oIhliNP+NTutC2cbYUZYuIGYXy9fbm2Wb8clfhROpxRTLYWCwFbaKlY1NfDdP
 NbQhqneyHC0bk3Z+gguGkuQ12QOU66S1CZ9DgG6iRL1dtshGql4pMkW/ZFAPZF7GrlVGoO
 0Skr3PoHZX26wQLjTshb97tj5pKGMno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-LkIy-8VsPm2rKYu_3OebdQ-1; Wed, 26 Feb 2020 04:06:10 -0500
X-MC-Unique: LkIy-8VsPm2rKYu_3OebdQ-1
Received: by mail-wm1-f70.google.com with SMTP id b8so1053683wmj.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K82kJSX7CFx0xCCgPULemf4x4nZ22grma2KzCsjRDMY=;
 b=lDh8vkJp1BSLrIZaxy6LYEuVQfa+vMM0zQrcgW/7jAd8rVN8c0isAyrZxddu85BxqD
 c52YB6d6kI/3y6OmCmpdSKFCLGAR4gLy4CtmDPTdDiTLkP+iehO3q+CXyMIkE/BId3+Q
 mUEXZ/lMkeChcyN3y5QPjNnzx38tVvaSEp6AWZxr++0QU0A9WhcivqHJK+wpGVs1rwdC
 9/oc2s8o9XP02xizJcxb9Pyj0lCuiHR+7EpPKUaxzvEtqguYYQ8PUlZtMrzgd4jQdsPe
 HfmH+YG3/QDqlJjl8cXfWRxk3gW+DMORrNodawBCC1JRLbQ/AIp5oRymlvjKWP5Iu6Nr
 7fKw==
X-Gm-Message-State: APjAAAXrCSeIME80Nwdd+zQ6ETSJhuLg0d4S/BK7B6gAGn3+gKaCGg8Q
 V9lHmLys6WqI5JV1Q8+MWc0Q/HdT5npMP9JoKaa89pfFpAjhrn5WJikTFvEsnLfoxlDMnc9KYX/
 BY4ikFCB28/m5b/4=
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr4504998wrs.166.1582707968045; 
 Wed, 26 Feb 2020 01:06:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPDPuO9Yzk6NYo1a7LBapWyXISAr/J6Tc9b5VN4MvGtNLqodb5Nn890JzlTygdo7N1HGqmbA==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr4504974wrs.166.1582707967831; 
 Wed, 26 Feb 2020 01:06:07 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 q3sm2257355wrs.1.2020.02.26.01.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:06:07 -0800 (PST)
Date: Wed, 26 Feb 2020 04:06:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/30] virtio-crypto: do delete ctrl_vq in
 virtio_crypto_device_unrealize
Message-ID: <20200226090010.708934-9-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Similar to other virtio-deivces, ctrl_vq forgot to delete in virtio_crypto_=
device_unrealize, this patch fix it.
This device has aleardy maintained vq pointers. Thus, we use the new virtio=
_delete_queue function directly to do the cleanup.

The leak stack:
Direct leak of 10752 byte(s) in 3 object(s) allocated from:
    #0 0x7f4c024b1970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f4c018be49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55a2f8017279 in virtio_add_queue /mnt/sdb/qemu-new/qemu_test/qemu/=
hw/virtio/virtio.c:2333
    #3 0x55a2f8057035 in virtio_crypto_device_realize /mnt/sdb/qemu-new/qem=
u_test/qemu/hw/virtio/virtio-crypto.c:814
    #4 0x55a2f8005d80 in virtio_device_realize /mnt/sdb/qemu-new/qemu_test/=
qemu/hw/virtio/virtio.c:3531
    #5 0x55a2f8497d1b in device_set_realized /mnt/sdb/qemu-new/qemu_test/qe=
mu/hw/core/qdev.c:891
    #6 0x55a2f8b48595 in property_set_bool /mnt/sdb/qemu-new/qemu_test/qemu=
/qom/object.c:2238
    #7 0x55a2f8b54fad in object_property_set_qobject /mnt/sdb/qemu-new/qemu=
_test/qemu/qom/qom-qobject.c:26
    #8 0x55a2f8b4de2c in object_property_set_bool /mnt/sdb/qemu-new/qemu_te=
st/qemu/qom/object.c:1390
    #9 0x55a2f80609c9 in virtio_crypto_pci_realize /mnt/sdb/qemu-new/qemu_t=
est/qemu/hw/virtio/virtio-crypto-pci.c:58

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Message-Id: <20200225075554.10835-5-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 7351ab0a19..4c65114de5 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -831,12 +831,13 @@ static void virtio_crypto_device_unrealize(DeviceStat=
e *dev, Error **errp)
=20
     max_queues =3D vcrypto->multiqueue ? vcrypto->max_queues : 1;
     for (i =3D 0; i < max_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(vcrypto->vqs[i].dataq);
         q =3D &vcrypto->vqs[i];
         qemu_bh_delete(q->dataq_bh);
     }
=20
     g_free(vcrypto->vqs);
+    virtio_delete_queue(vcrypto->ctrl_vq);
=20
     virtio_cleanup(vdev);
     cryptodev_backend_set_used(vcrypto->cryptodev, false);
--=20
MST


