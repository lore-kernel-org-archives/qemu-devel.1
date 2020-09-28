Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FEAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457672074F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7My8h25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457672074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqpH-000654-8i
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqcn-0007kp-Gg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqci-0006HM-OI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UDNSv99blgCXgYKAJW9DywzNbpAo3HN/zviB89rGwi0=;
 b=K7My8h25eCpPj3MMXMxXW25AIm2efDZoBB6GEVI0jiQzGrxmP2HCEE/JV9kHnBkDMhAm1P
 IlFjGtgNvJ04Na5q+ITRUsiUWDG9mjRR/q+Mb7RxZz6nH8PY8FUK+FEu+zGVZ1nsqPUr0Q
 wZSxL9en5yy+gcR+rZ+bPrB76DzoKy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-utlhAF7EMd6n-v3CKHbecw-1; Mon, 28 Sep 2020 06:43:08 -0400
X-MC-Unique: utlhAF7EMd6n-v3CKHbecw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC9661DDF9;
 Mon, 28 Sep 2020 10:43:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 217911002C08;
 Mon, 28 Sep 2020 10:42:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 51B689CAE; Mon, 28 Sep 2020 12:42:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] microvm: add pcie support
Date: Mon, 28 Sep 2020 12:42:44 +0200
Message-Id: <20200928104256.9241-1-kraxel@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:=0D
 - move aml generator to gpex and have arm virt + microvm share it.=0D
 - add 64bit window.=0D
 - add testcase.=0D
v3:=0D
 - fix testcase: force tcg, disable on i386.=0D
=0D
Gerd Hoffmann (12):=0D
  move MemMapEntry=0D
  acpi: add acpi_dsdt_add_gpex=0D
  arm: use acpi_dsdt_add_gpex=0D
  microvm: add irq table=0D
  microvm: add pcie support=0D
  microvm/pcie: add 64bit mmio window=0D
  tests/acpi: allow updates for expected data files=0D
  tests/acpi: add empty tests/data/acpi/microvm/DSDT.pcie file=0D
  tests/acpi: factor out common microvm test setup=0D
  tests/acpi: add microvm pcie test=0D
  acpi/gpex: no reason to use a method for _CRS=0D
  tests/acpi: update expected data files=0D
=0D
 include/exec/hwaddr.h             |   5 +=0D
 include/hw/arm/virt.h             |   5 -=0D
 include/hw/i386/microvm.h         |  32 ++++++=0D
 include/hw/pci-host/gpex.h        |  11 ++=0D
 hw/arm/sbsa-ref.c                 |   5 -=0D
 hw/arm/virt-acpi-build.c          | 175 ++---------------------------=0D
 hw/i386/acpi-microvm.c            |  12 ++=0D
 hw/i386/microvm.c                 |  93 ++++++++++++++++=0D
 hw/pci-host/gpex-acpi.c           | 177 ++++++++++++++++++++++++++++++=0D
 tests/qtest/bios-tables-test.c    |  30 ++++-=0D
 hw/i386/Kconfig                   |   1 +=0D
 hw/pci-host/meson.build           |   1 +=0D
 tests/data/acpi/microvm/DSDT.pcie | Bin 0 -> 3023 bytes=0D
 tests/data/acpi/virt/DSDT         | Bin 5200 -> 5196 bytes=0D
 tests/data/acpi/virt/DSDT.memhp   | Bin 6561 -> 6557 bytes=0D
 tests/data/acpi/virt/DSDT.numamem | Bin 5200 -> 5196 bytes=0D
 16 files changed, 366 insertions(+), 181 deletions(-)=0D
 create mode 100644 hw/pci-host/gpex-acpi.c=0D
 create mode 100644 tests/data/acpi/microvm/DSDT.pcie=0D
=0D
--=20=0D
2.27.0=0D
=0D


