Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35DC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EED20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOi7aE30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EED20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDaC-0007De-FM
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYl-0005RS-Rn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYk-0006ZN-6A
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ge/NPs5maQ977E98YNqRK3OYZ1LGaZWTbEL2f1Ol8j0=;
 b=HOi7aE30E4UMJat3Rv30kAtCKY79T9B4ssNFLMnLrcGRpF3XQiFQNM5qt5SgZYA0/6N9wn
 8T3PxrmPSGIkQNsqoNSgJXNZVxlR94a9oGxvKvk6rQTSvjUyA2ENoPwrDD7xLjbZHzeaKD
 38bFeL57HN7Yy7yDzel2JW6pgGCnDX4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-d22p-4qbOAyr2rw4qsrhdQ-1; Wed, 22 Jul 2020 08:09:15 -0400
X-MC-Unique: d22p-4qbOAyr2rw4qsrhdQ-1
Received: by mail-wm1-f72.google.com with SMTP id a5so1022440wmj.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ge/NPs5maQ977E98YNqRK3OYZ1LGaZWTbEL2f1Ol8j0=;
 b=UTaUAZOkY/QEjQSi2iJjrT9bLJBwwhCzK0CZ2KJCn9fRu3ckFCLrXOV/+z04wyChfl
 wErHdYNtXZfawKU9XK0vPazd5qf2I7HwPn7ltUNZ+P6QhTympABOTBacnpRAY0LMhjWb
 9wJAWYV39ENxzPBXWLqN4kgmbCv+r4DOMJol+TJ58ptrSBYc6OzVihxkJaoHusyHeUyf
 XtGNgHSKnrmIYlPBomSfyQr0fU5UkXv/qyurMcKG1jsH4bP1XzWsHKZygJMupWNdlwUR
 hwonP7+qDzUCwSYM9yA0x/mLkxX7Jsx/EPvX9zJtLNddwx4SWj8F3W8N6vkjWwNihRF4
 3P2w==
X-Gm-Message-State: AOAM532Q9Wut4gc1y6dXzu9h1pjVAzz6pHIVZEGAvWezOlknB6l1mFjn
 7Tu8+ShQ4Q30tJD9jW0xgggonWu8PZfvMQ45KzwA61mrUoW49HHeUI4/569JBbKrEpYtsbQ825b
 Kij+RJlodRQPOTbI=
X-Received: by 2002:adf:df06:: with SMTP id y6mr720630wrl.89.1595419753843;
 Wed, 22 Jul 2020 05:09:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRgydDziEav8BWoQhl0kLNhM4wH0dqxINccHL8yd8WIbYEkEXBXDRN+03csXZoJUgyMA4szg==
X-Received: by 2002:adf:df06:: with SMTP id y6mr720614wrl.89.1595419753608;
 Wed, 22 Jul 2020 05:09:13 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 i14sm12093235wrc.19.2020.07.22.05.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:13 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] virtio: Drop broken and superfluous
 object_property_set_link()
Message-ID: <20200722120853.9144-3-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

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
Message-Id: <20200721121153.1128844-1-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


