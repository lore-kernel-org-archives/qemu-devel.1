Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9903C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48FF20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOEPxuLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48FF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw5f-0005SU-VE
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvrQ-0003MP-JD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvrP-0001vY-Ec
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvrP-0001re-8q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mD5CnKaHCqEnDtYsfaWuvKKdqaTymxgk4zlUTmpGAA8=;
 b=iOEPxuLlV5jiPOnwL+Z0x7/uuBgyf30X+rInhZ0zV4k7itj4JDOEE6NrME1VYASerccoue
 G/M2gzDLMKxJdBnlDwYqwOIBjdPElAnM4jwvAd+rApfhLpLKUq+8B4VsHfi1rHkfhaB3/S
 q7kpzhStHVqVnnZ+gzguv+tjkJUrcMw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-N1FOdMFOPAaNa09OTiTAhQ-1; Thu, 19 Dec 2019 08:28:56 -0500
Received: by mail-qk1-f199.google.com with SMTP id a73so3630337qkg.5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zrcV6NduOW424RfDjQAFC57USpEMc62nbflawLr92Qk=;
 b=VSW/PB7V1GL0OfM6DYGdPKJkCl9MQKTCp5FwZZTYPf2veATwobZa741996LqVc5geI
 /lTyObd4N2eQMxgdiKTeU1SYMrFjGt8NUjv29bKRv9vpnG4Q+1WhWnTr5O+ypT5/ITYv
 0FivkEE3bOUXUQO76VXzmcx2+XYHtJceX8su3t8xlJGN+CrvKkpjwnX1ft2cySeevaPW
 1gPdjjrGKpzkMdN0XpEzq2BkR3jUtN5av0IBqSiqq0J2MjKQLnmz9DdBCy4zdoXStM1C
 FYlfv2R+sjUYJmIHSSxxV1NgJxpyjPF9XYkNGXMvUQrI1YJNMJPt4QBfZ6/p48rCkVAP
 xOZw==
X-Gm-Message-State: APjAAAVJSnjVBIhFdMO8b84lD+mNTs9yAJn5bS52Ntbua1yqB+5NakEZ
 P2eGEd8el4pSjGuI4wrOXD+fC4nwfgjgjrEruY35l9d3H19acwh+fjHX3DuJgmSzz1VcllVbxuX
 wBy/Wrz9rvI7ymJw=
X-Received: by 2002:ac8:3094:: with SMTP id v20mr7108658qta.306.1576762136248; 
 Thu, 19 Dec 2019 05:28:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwvR7qD69zLue8XYugyddN465V20M+iYrINBFMFADZE1KA8X3uD1kfn5tyjSg0CqnDgzKIxg==
X-Received: by 2002:ac8:3094:: with SMTP id v20mr7108641qta.306.1576762136078; 
 Thu, 19 Dec 2019 05:28:56 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id c37sm1884177qta.56.2019.12.19.05.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:28:55 -0800 (PST)
Date: Thu, 19 Dec 2019 08:28:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/24] hw/pci/pci_host: Let pci_data_[read/write] use unsigned
 'size' argument
Message-ID: <20191219132621.16595-23-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: N1FOdMFOPAaNa09OTiTAhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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


