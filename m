Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F01CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E0E2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8c1aB1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E0E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNC5G-0005TO-Fp
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNBzo-00037b-Gf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNBzn-00065v-EV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27185
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNBzn-00065Y-Ak
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIilRMF3CC/CW5jbJi+pIxz32bjewuFi7+thsamBRu0=;
 b=S8c1aB1gyEDUeC6vO4smK6ACGlQSVRd7uX2+Owrp7pVYvkMKmWuFUq5Mz8QK3rH1d6FxA/
 I196jQiKNk2CIV1RSJ0p1U/eA9lq01GFJgzjAem3nv5TvnRe8s1FZ3gifejVGdsxNuWVqB
 s7h3veRnIDVxKVLOFWV9vV0nW/H/kcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-HUfEIWybOM-7SSgJFhSAMQ-1; Wed, 23 Oct 2019 04:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E84DA476;
 Wed, 23 Oct 2019 08:27:46 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA5B95DD78;
 Wed, 23 Oct 2019 08:27:39 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/11] pci: mark devices partially unplugged
Date: Wed, 23 Oct 2019 10:27:03 +0200
Message-Id: <20191023082711.16694-4-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-1-jfreimann@redhat.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HUfEIWybOM-7SSgJFhSAMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the guest unplug request was triggered. This is needed for
the failover feature. In case of a failed migration we need to
plug the device back to the guest.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/pci/pcie.c        | 3 +++
 include/hw/pci/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index a6beb567bd..19363ff8ce 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -456,6 +456,9 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *=
dev, void *opaque)
 {
     HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(dev))=
;
=20
+    if (dev->partially_hotplugged) {
+        return;
+    }
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
     object_unparent(OBJECT(dev));
 }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index def5435685..7b7eac845c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -265,6 +265,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
=20
 struct PCIDevice {
     DeviceState qdev;
+    bool partially_hotplugged;
=20
     /* PCI config space */
     uint8_t *config;
--=20
2.21.0


