Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE55C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEC02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUoRX60S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEC02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOAh-000416-5n
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO4U-00076B-Jx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO4Q-0001aE-TM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FVsSj7Ag3OxVi76o/QFtGIulL6ygVCFfEV9JkauuBKk=;
 b=GUoRX60SlqcGnPNl1AqA/zID2o85h3PLIl5W75x8F1XnIPU75c3rrlumSHIo1ORBpphAa6
 OjeHOgkh95hb0Xfs6GPRL3aXQnhdA328VxhXzYyGAM3DDIGfNi4jy3yJf6AHh2nxfnCHs5
 ClV3SfB5XXzlRAgyuLm0g+G5ej6SmDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-hmsCuBA0MRq8s_DnpetcCg-1; Fri, 16 Oct 2020 07:38:47 -0400
X-MC-Unique: hmsCuBA0MRq8s_DnpetcCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C6D18A0761;
 Fri, 16 Oct 2020 11:38:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A19B910013DB;
 Fri, 16 Oct 2020 11:38:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AD45A11AB5; Fri, 16 Oct 2020 13:38:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] microvm: fix PCIe IRQs in APIC table.
Date: Fri, 16 Oct 2020 13:38:28 +0200
Message-Id: <20201016113835.17465-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0D
=0D
Gerd Hoffmann (7):=0D
  tests/acpi: allow changes for microvm/APIC.pcie=0D
  tests/acpi: add empty microvm/APIC.pcie=0D
  x86: make pci irqs runtime configurable=0D
  microvm: set pci_irq_mask=0D
  apci: drop has_pci arg for acpi_build_madt=0D
  tests/acpi: update expected data files=0D
  tests/acpi: disallow changes for microvm/APIC.pcie=0D
=0D
 hw/i386/acpi-common.h             |   3 +--=0D
 include/hw/i386/x86.h             |   2 ++=0D
 hw/i386/acpi-build.c              |   2 +-=0D
 hw/i386/acpi-common.c             |  26 +++++++++++---------------=0D
 hw/i386/acpi-microvm.c            |   2 +-=0D
 hw/i386/microvm.c                 |   6 ++++++=0D
 hw/i386/x86.c                     |   1 +=0D
 tests/data/acpi/microvm/APIC.pcie | Bin 0 -> 110 bytes=0D
 8 files changed, 23 insertions(+), 19 deletions(-)=0D
 create mode 100644 tests/data/acpi/microvm/APIC.pcie=0D
=0D
--=20=0D
2.27.0=0D
=0D


