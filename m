Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA80C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F9720656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yut060G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F9720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iol8V-0006EH-VT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojSA-0002nG-Pt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojS9-0001Qz-HL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:39:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojS9-0001QZ-D8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mD5CnKaHCqEnDtYsfaWuvKKdqaTymxgk4zlUTmpGAA8=;
 b=Yut060G6jXelUx3LdePcJ0YFgFmea9lpPIYSNM7O9+a/MZsGrlMSCvMYJAxfFweWZxFDVr
 MecLqxUhaf8PxE3no1X6mGjtcYICk59+vadDtQVraure5eyNppNwRtRwzdhT0wYRiDf57z
 PqxSELK7KWzqJ94Xbguk30pCfrSfWgQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-L6Bu27xiPbiWuIfgyjvcGA-1; Tue, 07 Jan 2020 02:37:09 -0500
Received: by mail-qv1-f71.google.com with SMTP id n11so36111338qvp.15
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zrcV6NduOW424RfDjQAFC57USpEMc62nbflawLr92Qk=;
 b=spLasPldmFO/Fz2Cb8udsSJyNalydJOH+JX+BCdTXi8jsT6GK0XsoRGxY2Q4fXAt2m
 b5HVCpHOdFgaXZ9RCpQgLvpejZAoeZwjjQnm1tRBffM9sc9pPHxI9IekBScmEiXmdLfo
 CyY3FelbfRFYQORTRvb+aaojYJqLEC9FJM5zLvrtQ7KgCNOaWDL/Q9T2O2E96vALra+a
 F2+Vy5qpvWwYlJDsf3NFDHDJNUYqTZjLZ0R1epV6QHtVKpKz85Wqyj0L4DzGoljl9Rat
 d7mxXRB+GvNuO/JKwPVTpKkBB+ZwO1dGurlRY9jQVHQ6TTzCpiyGe+6AbgEMaW+5Fk8p
 up5w==
X-Gm-Message-State: APjAAAU5FC70K05O757ZTvpUTvwkFg0/NTJdzDvQ89LgXa6RJd2wZOhM
 M9F2w7utdIEpyHY8YVuW9i3huOPkKRqJWjKap73kD6Q9CWbmJ/sv6JVA0nkoZvsPxfzgFAkY/bx
 aRBvkxBJ+hghF4aQ=
X-Received: by 2002:a37:e312:: with SMTP id y18mr88627004qki.250.1578382626005; 
 Mon, 06 Jan 2020 23:37:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLRgD5T2iwhQwjVEw5plXhkS2IFiChVBYXgc7TQD1LlCFQnhXxmd2PCgVlnIFZZXOeyl1FYg==
X-Received: by 2002:a37:e312:: with SMTP id y18mr88626992qki.250.1578382625785; 
 Mon, 06 Jan 2020 23:37:05 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id j194sm22072669qke.83.2020.01.06.23.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:05 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 22/32] hw/pci/pci_host: Let pci_data_[read/write] use
 unsigned 'size' argument
Message-ID: <20200107073451.298261-23-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: L6Bu27xiPbiWuIfgyjvcGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Both functions are called by MemoryRegionOps.[read/write] handlers
with unsigned 'size' argument. Both functions call
pci_host_config_[read/write]_common() which expect a uint32_t 'len'
parameter (also unsigned).
Since it is pointless (and confuse) to use a signed value, use a
unsigned type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191216002134.18279-3-philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


