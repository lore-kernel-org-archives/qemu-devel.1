Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C6A20724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZf1LX7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C6A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMTU-0002CS-P1
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMCy-0002jk-6v
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:10:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMCS-0003HJ-1p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594023002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvBDMmtYvVkY3jVOUFPXEZPVFsdhSQqoZM3UWCNt/ok=;
 b=WZf1LX7he0uEcU5uOIDpAlT+XzajLlNX05YsPE83l/B0I1b2VJkU80rowYusigXeiWdgc0
 AepFOYv5yPzgkcSnH+40hQVy3KQ8ZRsEUL77wdxzxhld79sNCsaF4lGciy+yc/XkSdq0AL
 V4s9PC6+F92sDQ91olfauV//jE4xtTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-nqD9eO03O9CeIgG73shkPg-1; Mon, 06 Jul 2020 04:09:58 -0400
X-MC-Unique: nqD9eO03O9CeIgG73shkPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 143C5800407;
 Mon,  6 Jul 2020 08:09:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B29910013C2;
 Mon,  6 Jul 2020 08:09:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFB6311385FC; Mon,  6 Jul 2020 10:09:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/44] virtio-crypto-pci: Tidy up
 virtio_crypto_pci_realize()
Date: Mon,  6 Jul 2020 10:09:11 +0200
Message-Id: <20200706080950.403087-6-armbru@redhat.com>
In-Reply-To: <20200706080950.403087-1-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, groug@kaod.org,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio_crypto_pci_realize() continues after realization of its
"virtio-crypto-device" fails.  Only an object_property_set_link()
follows; looks harmless to me.  Tidy up anyway: return after failure,
just like virtio_rng_pci_realize() does.

Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Gonglei < arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 72be531c95..0755722288 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -54,7 +54,9 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 
     virtio_pci_force_virtio_1(vpci_dev);
-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
+        return;
+    }
     object_property_set_link(OBJECT(vcrypto),
                  OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
                  NULL);
-- 
2.26.2


