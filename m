Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1CC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1E120658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhJfjzvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1E120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c0F-0002EL-N0
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bte-0007Ez-Fb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6btc-00013W-DX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6btc-00012g-99
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3B3Sa4xWvVmS4vX2SpY1eVnYbHxN4jErdc7je0hAjzI=;
 b=fhJfjzvDzF9Smni5k6NoH9cdG5FlQ4ocD9unss2GHJappiB9uoA+sWaqPqsA13HEVrWvzn
 mQbMxAjg9gTW60Ji06goqOdvZEbDc5S6YyHyKo1x3gyiqPhX1HP1QPZEX11pnbDTcvGRbY
 RZihhwsD+cscv1Uy4DMa6neBOEBvzZo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-_bzD1zwwN-GWkLWUg8aN-g-1; Tue, 25 Feb 2020 10:13:09 -0500
X-MC-Unique: _bzD1zwwN-GWkLWUg8aN-g-1
Received: by mail-qt1-f197.google.com with SMTP id t4so15215721qtd.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K82kJSX7CFx0xCCgPULemf4x4nZ22grma2KzCsjRDMY=;
 b=IgcjFHh2apxHjcvlx7lbVi86YQqeoFYIoL1nHx0qrOkyK2x86MuOH4Fvt1s0DdLSHL
 sQnDx+83qu1W3c9Ss3S8cM+QPfCfr0f1AoFjQoNNO9/CR8+A+GgKmOyttHqj6/e4sLy2
 LjYHN/cDnYowTFyTZm+ZwtvyOuBdFC+xfLbQy/wnXB1N41ANkWuAgY2yVlbp1dDSiDVN
 CDvrK8g9FmF1jAh3O6rbzy9rNLOWMpqyifc5cUHcjkE0tjKSRtJnJ0v+Pcspnf0Rsqmm
 OxErDVsn7AC2raCk7R5EQcxG92xJL2f/ct5rhsOTvcWolPQ74EZEHtPX461Pv5ma1S7X
 2ODw==
X-Gm-Message-State: APjAAAV5raZYEnp55hwCUY1hrw932jjpsyn2I7AkhmVi+C7R8+Ik2hRs
 Zs9gO9HPkTZuUba1beqRimzVWVK9mY/zT2pn57TiHmYysJPw5q3YmfMEAAGX3FWeeT3g8BktbQE
 qt2cYLouVc0+evWM=
X-Received: by 2002:a37:7a04:: with SMTP id v4mr21353237qkc.246.1582643588423; 
 Tue, 25 Feb 2020 07:13:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBOZdAVNP7MItD9+3/9V40PAsTgI8S/+t/hoSwJZ/n9aMxynoidNV8f/WQV2LsfeEmU2rIsA==
X-Received: by 2002:a37:7a04:: with SMTP id v4mr21353211qkc.246.1582643588207; 
 Tue, 25 Feb 2020 07:13:08 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g2sm6361781qka.42.2020.02.25.07.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:13:07 -0800 (PST)
Date: Tue, 25 Feb 2020 10:13:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] virtio-crypto: do delete ctrl_vq in
 virtio_crypto_device_unrealize
Message-ID: <20200225151210.647797-9-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


