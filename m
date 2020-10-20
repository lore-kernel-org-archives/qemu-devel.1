Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406742224F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYe+pavI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406742224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmPt-0006Rc-0I
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUmOJ-00058X-Th
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUmOE-0001qT-C9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603180140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=73OhakPiEo4H0NBEo1NTdVVL6u+6Ni6vkp6gJPsouUs=;
 b=RYe+pavIbzrafwlZFL08KqlMicWhxvSKCFVAsxwXqvQ0WMRtiDUW8WtYamICmAcy8zxQ0F
 QZ/kLHlN/V7h6NnPwJbbGgCGAenxJnLCtvJ+r8DYughYKnhxIWGJVRlE6Nq8nYRxma+ou/
 4RTY/WuNAt7jKnj9wz5P8PZMPOZBD7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-fNO_m0MuNJ2IJejBt9bpcQ-1; Tue, 20 Oct 2020 03:48:58 -0400
X-MC-Unique: fNO_m0MuNJ2IJejBt9bpcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E531006C90;
 Tue, 20 Oct 2020 07:48:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E547C60C13;
 Tue, 20 Oct 2020 07:48:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E7E3411AB5; Tue, 20 Oct 2020 09:48:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/10] microvm: add usb support
Date: Tue, 20 Oct 2020 09:48:34 +0200
Message-Id: <20201020074844.5304-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
v3:=0D
 - fix Kconfig deps for XHCI=0D
=0D
Gerd Hoffmann (10):=0D
  acpi: add aml builder stubs=0D
  usb/xhci: add include/hw/usb/xhci.h header file=0D
  usb/xhci: add xhci_sysbus_build_aml() helper=0D
  usb/xhci: fixup xhci kconfig deps=0D
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
 hw/i386/Kconfig                  |   1 +=0D
 hw/usb/Kconfig                   |   6 ++----=0D
 tests/data/acpi/microvm/DSDT.rtc | Bin 0 -> 404 bytes=0D
 tests/data/acpi/microvm/DSDT.usb | Bin 0 -> 414 bytes=0D
 16 files changed, 131 insertions(+), 46 deletions(-)=0D
 create mode 100644 include/hw/usb/xhci.h=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.rtc=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.usb=0D
=0D
--=20=0D
2.27.0=0D
=0D


