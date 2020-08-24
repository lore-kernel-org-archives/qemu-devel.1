Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB21B20838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRoPaR2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB21B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kABTs-0004I7-6g
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kABTG-0003Qn-TP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:21:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kABTF-0000g3-CY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598271664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e6CSmopPnAarkZ54RHFSqAtjYslrD2Y+5OpEZ0zScXc=;
 b=XRoPaR2oSBtRRSd0Qpt3URqYrg15dvwVU1MLzTmhNu5czMhagrci1UZD+8wWUfK+2FGi4D
 U2o7TC7hNBO7Z5EALcrq2ETcrvOqjR2qNqE/MnwUbjg/+xQofGGGRGDNf/+rZ/UJKXLCNI
 4aWyx6G/LpRxWeK+AGZCqfcbz+qXBGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-FIWPEg8cPTOPEa5uBOTnGQ-1; Mon, 24 Aug 2020 08:21:00 -0400
X-MC-Unique: FIWPEg8cPTOPEa5uBOTnGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D0918A2245;
 Mon, 24 Aug 2020 12:20:59 +0000 (UTC)
Received: from localhost (ovpn-113-235.ams2.redhat.com [10.36.113.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 218DB5D9EF;
 Mon, 24 Aug 2020 12:20:54 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH] virtio: add Virtio*BusClass sizes
Date: Mon, 24 Aug 2020 14:20:51 +0200
Message-Id: <20200824122051.99432-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 08:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both VirtioPCIBusClass and VirtioCcwBusClass are typedefs of
VirtioBusClass, but set .class_size in the TypeInfo anyway
to be safe if that changes in the future.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c  | 1 +
 hw/virtio/virtio-pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 0e602702971b..8feb3451a098 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1237,6 +1237,7 @@ static const TypeInfo virtio_ccw_bus_info = {
     .name = TYPE_VIRTIO_CCW_BUS,
     .parent = TYPE_VIRTIO_BUS,
     .instance_size = sizeof(VirtioCcwBusState),
+    .class_size = sizeof(VirtioCcwBusClass),
     .class_init = virtio_ccw_bus_class_init,
 };
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ccdf54e81c78..45e7b65a8d24 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2101,6 +2101,7 @@ static const TypeInfo virtio_pci_bus_info = {
     .name          = TYPE_VIRTIO_PCI_BUS,
     .parent        = TYPE_VIRTIO_BUS,
     .instance_size = sizeof(VirtioPCIBusState),
+    .class_size    = sizeof(VirtioPCIBusClass),
     .class_init    = virtio_pci_bus_class_init,
 };
 
-- 
2.25.4


