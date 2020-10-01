Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04369C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC3920759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UISSAGEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC3920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtyx-0007ao-Eo
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNtxV-0005uC-5z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNtxT-0002L8-GO
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:29:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601540938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0gZoZGgkQ6L5XWoeAyBLs2hpirn2eZB2bNqhHYKOYEU=;
 b=UISSAGEuE9IROZ6NGAoeIpG2hCsvOPkQBWZ6Qtc5JxpoETfP+KBPsyW5JrP+SXrNWg9+jl
 oOYi0j+IlE4enKi8l4WniD3PSupODmMO6ZC/GToFvFB7aLMZ2gt5nCwpuCBCVhkkZ04LhN
 mQfu1hbnbA11ML9L3RrXI4wZLJ+iEbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-_E8fxs2JPGyf9aGy5kEqSg-1; Thu, 01 Oct 2020 04:28:56 -0400
X-MC-Unique: _E8fxs2JPGyf9aGy5kEqSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59B61015EDC;
 Thu,  1 Oct 2020 08:28:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95BCC5D9E2;
 Thu,  1 Oct 2020 08:28:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C92FD43BFA2; Thu,  1 Oct 2020 10:28:34 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] microvm: add usb support
Date: Thu,  1 Oct 2020 10:28:25 +0200
Message-Id: <20201001082834.15821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This depends on the pending microvm pull request.=0D
=0D
v2:=0D
 - add some xhci cleanups.=0D
 - move aml builder to sysbus-xhci.=0D
 - add acpi testcase for usb=3Don (and while being at it rtc=3Don too).=0D
=0D
Gerd Hoffmann (9):=0D
  acpi: add aml builder stubs=0D
  usb/xhci: add include/hw/usb/xhci.h header file=0D
  usb/xhci: add xhci_sysbus_build_aml() helper=0D
  microvm: add usb support=0D
  tests/acpi: allow updates for expected data files=0D
  tests/acpi: add empty tests/data/acpi/microvm/DSDT.{usb,rtc} files=0D
  tests/acpi: add microvm usb test=0D
  tests/acpi: add microvm rtc test=0D
  tests/acpi: update expected data files=0D
=0D
 hw/usb/hcd-xhci-sysbus.h         |   1 -=0D
 hw/usb/hcd-xhci.h                |  22 ++++++--------------=0D
 include/hw/i386/microvm.h        |   5 ++++-=0D
 include/hw/usb/xhci.h            |  21 +++++++++++++++++++=0D
 hw/acpi/aml-build-stub.c         |  14 +++++++++++++=0D
 hw/i386/acpi-microvm.c           |   9 ++++++++=0D
 hw/i386/microvm.c                |  13 ++++++++++++=0D
 hw/usb/hcd-xhci-nec.c            |   4 ++--=0D
 hw/usb/hcd-xhci-pci.c            |   4 ++--=0D
 hw/usb/hcd-xhci-sysbus.c         |  19 +++++++++++++++--=0D
 hw/usb/hcd-xhci.c                |  34 +++++++++++++++----------------=0D
 tests/qtest/bios-tables-test.c   |  24 ++++++++++++++++++++++=0D
 tests/data/acpi/microvm/DSDT.rtc | Bin 0 -> 404 bytes=0D
 tests/data/acpi/microvm/DSDT.usb | Bin 0 -> 414 bytes=0D
 14 files changed, 128 insertions(+), 42 deletions(-)=0D
 create mode 100644 include/hw/usb/xhci.h=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.rtc=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.usb=0D
=0D
--=20=0D
2.27.0=0D
=0D


