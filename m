Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8875C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82618207FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6LKUFXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82618207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5di-00052B-Sy
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5V0-0002x9-Ci
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Uz-0004vb-6J
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Uz-0004vN-2d
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMQapAZoKHuzNu9Pp7IYAg1kGSgMFQ0zkXvOLbEXi5E=;
 b=a6LKUFXil7qctonNy/5ckdrx8Sewp5aB2Q77jtKSmqHYtzhRhFiuNq6EsSL/70fR9tbJz/
 VfyBm8DLQzB3zU182K++FYoL57knzngWh7GQyKlRz9Mwe+nA//q54IqjrEhQ54+eNuryUq
 Gxyjn+LW1YHhSOtyM2R9WrCiLM4tvDc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-lmckzrOGOF-dLzInhdXWRQ-1; Sun, 05 Jan 2020 07:59:13 -0500
Received: by mail-qt1-f200.google.com with SMTP id x8so8877291qtq.14
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kOPqzhUAAr1F9DHkT+R7bzvkT8C45cWHnUcu3/B6bq0=;
 b=fNNwFmOLEUqdcN2Eln/ratQihuiiHXMw9TNUjs0yB1SZEcOY5aQkFWWDppedCc1RNb
 Zhfb0Eh9h5R5IpZa0t+PAR4E3twqEwJ/NsfGI0IMaJVHc7id3Lpn8mBwuj1Er9ikDXaZ
 JIvOQr0XgTHGuMwU+4iXd9A4148zrjq+Lgbb2MfuxM0oosulNlf/EuYtEDkUPhTSmUyn
 72epi+D7M3A4coqwM1IYd+Kuwl2kpM+S48y7hlNRRKC9In9hRJcaDi9n/iHqW/AlcdEa
 WBvUqx/pRRojjqhyHLbnJSzQzwbNb7FRkMerLFKUCGi8gdqKU7KcOnZmIC0qs8Crk1pF
 2kSw==
X-Gm-Message-State: APjAAAWNhxknfimk6nGCVGTYEzNlbbbMRSs7KjchtpERn2hDn5TsPUds
 EnOsACbGmY2OwrZPMh/k7U3NOTbBgw+1KFIXzkLPeLK05qzrDzBdHu0eCM6J9Kski5IG44GBCk7
 c8R++AKo8C0YENh4=
X-Received: by 2002:ac8:410f:: with SMTP id q15mr71046061qtl.192.1578229152727; 
 Sun, 05 Jan 2020 04:59:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqytPrZ3BXHjaiZtYcG36Pw+7AzrXNsb0T0z5iNf8O9aAHxyA0vEXx5CnlbC2xhDeGifiK+fvg==
X-Received: by 2002:ac8:410f:: with SMTP id q15mr71046051qtl.192.1578229152544; 
 Sun, 05 Jan 2020 04:59:12 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id j185sm19255290qkc.96.2020.01.05.04.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:11 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 21/32] hw/pci/pci_host: Remove redundant PCI_DPRINTF()
Message-ID: <20200105125622.27231-22-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: lmckzrOGOF-dLzInhdXWRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

In commit 3bf4dfdd111 we introduced the pci_cfg_[read/write]
trace events in pci_host_config_[read/write]_common().
We have the following call trace:

  pci_host_data_[read/write]()
    - PCI_DPRINTF()
    - pci_data_[read/write]()
        - PCI_DPRINTF()
        - pci_host_config_[read/write]_common()
            trace_pci_cfg_[read/write]()

Since the PCI_DPRINTF() calls are redundant with the trace
events, remove them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191216002134.18279-2-philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci_host.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index c5f9244934..0958d157de 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -115,8 +115,6 @@ void pci_data_write(PCIBus *s, uint32_t addr, uint32_t =
val, int len)
         return;
     }
=20
-    PCI_DPRINTF("%s: %s: addr=3D%02" PRIx32 " val=3D%08" PRIx32 " len=3D%d=
\n",
-                __func__, pci_dev->name, config_addr, val, len);
     pci_host_config_write_common(pci_dev, config_addr, PCI_CONFIG_SPACE_SI=
ZE,
                                  val, len);
 }
@@ -125,18 +123,13 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, int =
len)
 {
     PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
     uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
-    uint32_t val;
=20
     if (!pci_dev) {
         return ~0x0;
     }
=20
-    val =3D pci_host_config_read_common(pci_dev, config_addr,
-                                      PCI_CONFIG_SPACE_SIZE, len);
-    PCI_DPRINTF("%s: %s: addr=3D%02"PRIx32" val=3D%08"PRIx32" len=3D%d\n",
-                __func__, pci_dev->name, config_addr, val, len);
-
-    return val;
+    return pci_host_config_read_common(pci_dev, config_addr,
+                                       PCI_CONFIG_SPACE_SIZE, len);
 }
=20
 static void pci_host_config_write(void *opaque, hwaddr addr,
@@ -167,8 +160,7 @@ static void pci_host_data_write(void *opaque, hwaddr ad=
dr,
                                 uint64_t val, unsigned len)
 {
     PCIHostState *s =3D opaque;
-    PCI_DPRINTF("write addr " TARGET_FMT_plx " len %d val %x\n",
-                addr, len, (unsigned)val);
+
     if (s->config_reg & (1u << 31))
         pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
 }
@@ -177,14 +169,11 @@ static uint64_t pci_host_data_read(void *opaque,
                                    hwaddr addr, unsigned len)
 {
     PCIHostState *s =3D opaque;
-    uint32_t val;
+
     if (!(s->config_reg & (1U << 31))) {
         return 0xffffffff;
     }
-    val =3D pci_data_read(s->bus, s->config_reg | (addr & 3), len);
-    PCI_DPRINTF("read addr " TARGET_FMT_plx " len %d val %x\n",
-                addr, len, val);
-    return val;
+    return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
 }
=20
 const MemoryRegionOps pci_host_conf_le_ops =3D {
--=20
MST


