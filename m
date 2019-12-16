Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E06C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4072467B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvChM8hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4072467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igeAG-0007p4-DO
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 19:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ige95-0006M9-O4
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ige94-0006LB-NO
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ige94-0006KV-K7
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576455714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zyx5Q0etKOjeoIcognRvut9GjEcnClAltc5bpgSqMuo=;
 b=JvChM8hE9JU0+JcesF+Z8U8cO4Q8qHhHzHL1qMXwAhPDTvwy6Q4HCV3ix2VMdMaFAW62wl
 EkIMMIbUzNhft/1OOxf7gtqkUfxAPsowoJLETYqBphm7BbXiFY9tkZ/2k7zbtS70ZaFmx/
 5RfZKE0ilR8/igExTV/VTVlF7GpeFGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-NVWiawfaPkmx3dNd-7lVyQ-1; Sun, 15 Dec 2019 19:21:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3D38017DF;
 Mon, 16 Dec 2019 00:21:49 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0221F1001B00;
 Mon, 16 Dec 2019 00:21:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/pci/pci_host: Let pci_data_[read/write] use unsigned
 'size' argument
Date: Mon, 16 Dec 2019 01:21:34 +0100
Message-Id: <20191216002134.18279-3-philmd@redhat.com>
In-Reply-To: <20191216002134.18279-1-philmd@redhat.com>
References: <20191216002134.18279-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NVWiawfaPkmx3dNd-7lVyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both functions are called by MemoryRegionOps.[read/write] handlers
with unsigned 'size' argument. Both functions call
pci_host_config_[read/write]_common() which expect a uint32_t 'len'
parameter (also unsigned).
Since it is pointless (and confuse) to use a signed value, use a
unsigned type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/pci/pci_host.h | 4 ++--
 hw/pci/pci_host.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595fc7..9ce088bd13 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -62,8 +62,8 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uin=
t32_t addr,
 uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
                                      uint32_t limit, uint32_t len);
=20
-void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, int len);
-uint32_t pci_data_read(PCIBus *s, uint32_t addr, int len);
+void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, unsigned len);
+uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
=20
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 0958d157de..ce7bcdb1d5 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -106,7 +106,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev=
, uint32_t addr,
     return ret;
 }
=20
-void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, int len)
+void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, unsigned len)
 {
     PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
     uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
@@ -119,7 +119,7 @@ void pci_data_write(PCIBus *s, uint32_t addr, uint32_t =
val, int len)
                                  val, len);
 }
=20
-uint32_t pci_data_read(PCIBus *s, uint32_t addr, int len)
+uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len)
 {
     PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
     uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
--=20
2.21.0


