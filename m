Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB224C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B624B206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHpF57UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B624B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxr8o-0008F3-VN
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxr7u-0007oj-Ok
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:12:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxr7s-0001AS-TP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595333523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6iByElys1hnOssVEoafolq61ljU766cMaeFLi4BzJdQ=;
 b=HHpF57UEz+bFIVTrCWvDifU7HpJlDgpaPeQ4qwVqhcUztBr27plbzCBZQtZFZ5DefZtvuj
 0pKC+/FPXxzNrscoy8Zr0BGGa1y8Rm3Uf/kutvJempaIJfwcuWyc5DaM0mK4a5JfDDOfkl
 nDbXvC8ijgt7WoARtdR6f9jagAH8xVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-fXhOffu-NzCrgxJziB2jwA-1; Tue, 21 Jul 2020 08:11:59 -0400
X-MC-Unique: fXhOffu-NzCrgxJziB2jwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF32F1083FAB;
 Tue, 21 Jul 2020 12:11:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE44372688;
 Tue, 21 Jul 2020 12:11:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57630111CA27; Tue, 21 Jul 2020 14:11:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: Drop broken and superfluous object_property_set_link()
Date: Tue, 21 Jul 2020 14:11:53 +0200
Message-Id: <20200721121153.1128844-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, mst@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, frederic.konrad@adacore.com, arei.gonglei@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio_crypto_pci_realize() and copies the value of vcrypto->vdev's
property "cryptodev" to vcrypto's property:

    object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf.rng),
                             NULL);

Since it does so only after realize, this always fails, but the error
is ignored.

It's actually superfluous: vcrypto's property is an alias of
vcrypto->vdev's property, created by virtio_instance_init_common().

Drop the call.

Same for virtio_ccw_crypto_realize(), virtio_rng_pci_realize(),
virtio_ccw_rng_realize().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/s390x/virtio-ccw-crypto.c  | 3 ---
 hw/s390x/virtio-ccw-rng.c     | 3 ---
 hw/virtio/virtio-crypto-pci.c | 2 --
 hw/virtio/virtio-rng-pci.c    | 3 ---
 4 files changed, 11 deletions(-)

diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 570c0333fc..358c74fb4b 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -23,9 +23,6 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
         return;
     }
-
-    object_property_set_link(OBJECT(vdev), "cryptodev",
-                             OBJECT(dev->vdev.conf.cryptodev), NULL);
 }
 
 static void virtio_ccw_crypto_instance_init(Object *obj)
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 4bb8c16d79..2e3a9da5e8 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -24,9 +24,6 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
         return;
     }
-
-    object_property_set_link(OBJECT(dev), "rng", OBJECT(dev->vdev.conf.rng),
-                             NULL);
 }
 
 static void virtio_ccw_rng_instance_init(Object *obj)
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index f1cc979d33..198f86e08c 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -57,8 +57,6 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
-    object_property_set_link(OBJECT(vcrypto), "cryptodev",
-                             OBJECT(vcrypto->vdev.conf.cryptodev), NULL);
 }
 
 static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 2f0b529b62..8afbb4c209 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -38,9 +38,6 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
-
-    object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf.rng),
-                             NULL);
 }
 
 static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
-- 
2.26.2


