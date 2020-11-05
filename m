Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51FC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8421E206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6g0p0/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8421E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafd4-000516-Bu
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUK-0001PT-ME
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUI-0003Wz-Sc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZhBsWtKEEzyMXyBVK47xYEmrwZmbu8ZyE5H5qe6Slng=;
 b=I6g0p0/fftE4aD2DnEoJXIOJm7Eg4UNGT8jZs8S1wOmFBwsPTQQ2IrqWoG9zcSP2fKEJHX
 uGhhk4olkF+g0cluBiftmdNa6JDJsNou5p8OdAwZFXNdT4pHmcQMxccVI9w5dhp2dCees+
 twAs++mbtGfy18grtg5HXroVMQrH+9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-s3mfQ8n9PDagl_T_ItpsPg-1; Thu, 05 Nov 2020 08:39:35 -0500
X-MC-Unique: s3mfQ8n9PDagl_T_ItpsPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CD03805F18;
 Thu,  5 Nov 2020 13:39:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58CE21002C10;
 Thu,  5 Nov 2020 13:39:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7C1F69D0F; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] microvm: add second ioapic
Date: Thu,  5 Nov 2020 14:39:11 +0100
Message-Id: <20201105133923.23821-1-kraxel@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a second ioapic to microvm.  Gives us more IRQ lines we can=0D
use for virtio-mmio devices.  Bump number of possible virtio-mmio=0D
devices from 8 to 24.=0D
=0D
v2:=0D
 - reorganize code a bit.=0D
 - add ioapic2=3D option to microvm.=0D
=0D
Gerd Hoffmann (12):=0D
  [testing] disable xhci msix=0D
  x86: rewrite gsi_handler()=0D
  x86: add support for second ioapic=0D
  microvm: make number of virtio transports runtime configurable=0D
  microvm: make pcie irq base runtime configurable=0D
  microvm: drop microvm_gsi_handler()=0D
  microvm: add second ioapic=0D
  tests/acpi: allow updates for expected data files=0D
  tests/acpi: add empty data files=0D
  tests/acpi: add ioapic2=3Don test for microvm=0D
  tests/acpi: update expected data files=0D
  tests/acpi: disallow updates for expected data files=0D
=0D
 include/hw/i386/ioapic.h             |   1 +=0D
 include/hw/i386/ioapic_internal.h    |   2 +-=0D
 include/hw/i386/microvm.h            |   6 +-=0D
 include/hw/i386/x86.h                |   3 +=0D
 hw/i386/acpi-common.c                |  10 ++++=0D
 hw/i386/microvm.c                    |  81 ++++++++++++++++++++-------=0D
 hw/i386/x86.c                        |  34 +++++++++--=0D
 hw/usb/hcd-xhci-pci.c                |   2 +-=0D
 tests/qtest/bios-tables-test.c       |  20 +++++--=0D
 tests/data/acpi/microvm/APIC.ioapic2 | Bin 0 -> 82 bytes=0D
 tests/data/acpi/microvm/DSDT.ioapic2 | Bin 0 -> 365 bytes=0D
 11 files changed, 126 insertions(+), 33 deletions(-)=0D
 create mode 100644 tests/data/acpi/microvm/APIC.ioapic2=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.ioapic2=0D
=0D
--=20=0D
2.27.0=0D
=0D


