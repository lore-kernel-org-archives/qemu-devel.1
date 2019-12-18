Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2831FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85A8218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4VOQ1P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85A8218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWfx-0006Wn-Rs
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihWc4-000237-D4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihWbx-0000fn-EQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:31:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihWbx-0000d1-5y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576665080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ndu/KcKhXnTzlsoRKFIBHEbeTtnMMbcyNBsJhcRgzB8=;
 b=c4VOQ1P07LYpV1DqAejEAKdm24hMg5CHG6LpOxBj/10VJjujUiexprih0kARKk3hNwVU3h
 eSFOnocTR5CVfHJYsgmryDuhYvswHWONZEi1Hy4dT1AtW/KCwTBiLr7A4Ldp/6XvnntUhW
 mVhBndlzDh+0Liwvq3coiOCC4OCzrVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-KQY-0lVMOVuAxB0-u3ypNQ-1; Wed, 18 Dec 2019 05:31:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A230B800D4C;
 Wed, 18 Dec 2019 10:31:13 +0000 (UTC)
Received: from thuth.com (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FFB85C28C;
 Wed, 18 Dec 2019 10:31:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 5/7] test: Move qtests to a separate directory
Date: Wed, 18 Dec 2019 11:30:57 +0100
Message-Id: <20191218103059.11729-6-thuth@redhat.com>
In-Reply-To: <20191218103059.11729-1-thuth@redhat.com>
References: <20191218103059.11729-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KQY-0lVMOVuAxB0-u3ypNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests directory itself is pretty overcrowded, and it's hard to
see which test belongs to which test subsystem (unit, qtest, ...).
Let's move the qtests to a separate folder for more clarity.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml                                |  11 +-
 MAINTAINERS                                   |  79 ++++---
 configure                                     |   4 +-
 tests/Makefile.include                        | 203 +++++++++---------
 tests/{ =3D> qtest}/ac97-test.c                 |   0
 tests/{ =3D> qtest}/acpi-utils.c                |   0
 tests/{ =3D> qtest}/acpi-utils.h                |   0
 tests/{ =3D> qtest}/ahci-test.c                 |   0
 tests/{ =3D> qtest}/arm-cpu-features.c          |   0
 .../bios-tables-test-allowed-diff.h           |   0
 tests/{ =3D> qtest}/bios-tables-test.c          |   0
 tests/{ =3D> qtest}/boot-order-test.c           |   0
 tests/{ =3D> qtest}/boot-sector.c               |   0
 tests/{ =3D> qtest}/boot-sector.h               |   0
 tests/{ =3D> qtest}/boot-serial-test.c          |   0
 tests/{ =3D> qtest}/cdrom-test.c                |   0
 tests/{ =3D> qtest}/cpu-plug-test.c             |   0
 tests/{ =3D> qtest}/device-introspect-test.c    |   0
 tests/{ =3D> qtest}/device-plug-test.c          |   0
 tests/{ =3D> qtest}/display-vga-test.c          |   0
 tests/{ =3D> qtest}/drive_del-test.c            |   0
 tests/{ =3D> qtest}/ds1338-test.c               |   0
 tests/{ =3D> qtest}/e1000-test.c                |   0
 tests/{ =3D> qtest}/e1000e-test.c               |   0
 tests/{ =3D> qtest}/eepro100-test.c             |   0
 tests/{ =3D> qtest}/endianness-test.c           |   0
 tests/{ =3D> qtest}/es1370-test.c               |   0
 tests/{ =3D> qtest}/fdc-test.c                  |   0
 tests/{ =3D> qtest}/fw_cfg-test.c               |   0
 tests/{ =3D> qtest}/hd-geo-test.c               |   0
 tests/{ =3D> qtest}/hexloader-test.c            |   0
 tests/{ =3D> qtest}/i440fx-test.c               |   0
 tests/{ =3D> qtest}/i82801b11-test.c            |   0
 tests/{ =3D> qtest}/ide-test.c                  |   0
 tests/{ =3D> qtest}/intel-hda-test.c            |   0
 tests/{ =3D> qtest}/ioh3420-test.c              |   0
 tests/{ =3D> qtest}/ipmi-bt-test.c              |   0
 tests/{ =3D> qtest}/ipmi-kcs-test.c             |   0
 tests/{ =3D> qtest}/ipoctal232-test.c           |   0
 tests/{ =3D> qtest}/ivshmem-test.c              |   0
 tests/{ =3D> qtest}/libqtest-single.h           |   0
 tests/{ =3D> qtest}/libqtest.c                  |   0
 tests/{ =3D> qtest}/libqtest.h                  |   0
 tests/{ =3D> qtest}/m25p80-test.c               |   0
 tests/{ =3D> qtest}/m48t59-test.c               |   0
 tests/{ =3D> qtest}/machine-none-test.c         |   0
 tests/{ =3D> qtest}/megasas-test.c              |   0
 tests/{ =3D> qtest}/microbit-test.c             |   0
 tests/{ =3D> qtest}/migration-test.c            |   0
 tests/{ =3D> qtest}/modules-test.c              |   0
 tests/{ =3D> qtest}/ne2000-test.c               |   0
 tests/{ =3D> qtest}/numa-test.c                 |   0
 tests/{ =3D> qtest}/nvme-test.c                 |   0
 tests/{ =3D> qtest}/pca9552-test.c              |   0
 tests/{ =3D> qtest}/pci-test.c                  |   0
 tests/{ =3D> qtest}/pcnet-test.c                |   0
 tests/{ =3D> qtest}/pflash-cfi02-test.c         |   0
 tests/{ =3D> qtest}/pnv-xscom-test.c            |   0
 tests/{ =3D> qtest}/prom-env-test.c             |   0
 tests/{ =3D> qtest}/pvpanic-test.c              |   0
 tests/{ =3D> qtest}/pxe-test.c                  |   0
 tests/{ =3D> qtest}/q35-test.c                  |   0
 tests/{ =3D> qtest}/qmp-cmd-test.c              |   0
 tests/{ =3D> qtest}/qmp-test.c                  |   0
 tests/{ =3D> qtest}/qom-test.c                  |   0
 tests/{ =3D> qtest}/qos-test.c                  |   0
 tests/{ =3D> qtest}/rtas-test.c                 |   0
 tests/{ =3D> qtest}/rtc-test.c                  |   0
 tests/{ =3D> qtest}/rtl8139-test.c              |   0
 tests/{ =3D> qtest}/sdhci-test.c                |   0
 tests/{ =3D> qtest}/spapr-phb-test.c            |   0
 tests/{ =3D> qtest}/tco-test.c                  |   0
 tests/{ =3D> qtest}/test-arm-mptimer.c          |   0
 tests/{ =3D> qtest}/test-filter-mirror.c        |   0
 tests/{ =3D> qtest}/test-filter-redirector.c    |   0
 tests/{ =3D> qtest}/test-hmp.c                  |   0
 tests/{ =3D> qtest}/test-netfilter.c            |   0
 tests/{ =3D> qtest}/test-x86-cpuid-compat.c     |   0
 tests/{ =3D> qtest}/tmp105-test.c               |   0
 tests/{ =3D> qtest}/tpm-crb-swtpm-test.c        |   0
 tests/{ =3D> qtest}/tpm-crb-test.c              |   0
 tests/{ =3D> qtest}/tpm-emu.c                   |   0
 tests/{ =3D> qtest}/tpm-emu.h                   |   0
 tests/{ =3D> qtest}/tpm-tests.c                 |   0
 tests/{ =3D> qtest}/tpm-tests.h                 |   0
 tests/{ =3D> qtest}/tpm-tis-swtpm-test.c        |   0
 tests/{ =3D> qtest}/tpm-tis-test.c              |   0
 tests/{ =3D> qtest}/tpm-util.c                  |   0
 tests/{ =3D> qtest}/tpm-util.h                  |   0
 tests/{ =3D> qtest}/usb-hcd-ehci-test.c         |   0
 tests/{ =3D> qtest}/usb-hcd-ohci-test.c         |   0
 tests/{ =3D> qtest}/usb-hcd-uhci-test.c         |   0
 tests/{ =3D> qtest}/usb-hcd-xhci-test.c         |   0
 tests/{ =3D> qtest}/vhost-user-test.c           |   0
 tests/{ =3D> qtest}/virtio-9p-test.c            |   0
 tests/{ =3D> qtest}/virtio-blk-test.c           |   0
 tests/{ =3D> qtest}/virtio-ccw-test.c           |   0
 tests/{ =3D> qtest}/virtio-net-test.c           |   0
 tests/{ =3D> qtest}/virtio-rng-test.c           |   0
 tests/{ =3D> qtest}/virtio-scsi-test.c          |   0
 tests/{ =3D> qtest}/virtio-serial-test.c        |   0
 tests/{ =3D> qtest}/virtio-test.c               |   0
 tests/{ =3D> qtest}/vmgenid-test.c              |   0
 tests/{ =3D> qtest}/vmxnet3-test.c              |   0
 tests/{ =3D> qtest}/wdt_ib700-test.c            |   0
 105 files changed, 148 insertions(+), 149 deletions(-)
 rename tests/{ =3D> qtest}/ac97-test.c (100%)
 rename tests/{ =3D> qtest}/acpi-utils.c (100%)
 rename tests/{ =3D> qtest}/acpi-utils.h (100%)
 rename tests/{ =3D> qtest}/ahci-test.c (100%)
 rename tests/{ =3D> qtest}/arm-cpu-features.c (100%)
 rename tests/{ =3D> qtest}/bios-tables-test-allowed-diff.h (100%)
 rename tests/{ =3D> qtest}/bios-tables-test.c (100%)
 rename tests/{ =3D> qtest}/boot-order-test.c (100%)
 rename tests/{ =3D> qtest}/boot-sector.c (100%)
 rename tests/{ =3D> qtest}/boot-sector.h (100%)
 rename tests/{ =3D> qtest}/boot-serial-test.c (100%)
 rename tests/{ =3D> qtest}/cdrom-test.c (100%)
 rename tests/{ =3D> qtest}/cpu-plug-test.c (100%)
 rename tests/{ =3D> qtest}/device-introspect-test.c (100%)
 rename tests/{ =3D> qtest}/device-plug-test.c (100%)
 rename tests/{ =3D> qtest}/display-vga-test.c (100%)
 rename tests/{ =3D> qtest}/drive_del-test.c (100%)
 rename tests/{ =3D> qtest}/ds1338-test.c (100%)
 rename tests/{ =3D> qtest}/e1000-test.c (100%)
 rename tests/{ =3D> qtest}/e1000e-test.c (100%)
 rename tests/{ =3D> qtest}/eepro100-test.c (100%)
 rename tests/{ =3D> qtest}/endianness-test.c (100%)
 rename tests/{ =3D> qtest}/es1370-test.c (100%)
 rename tests/{ =3D> qtest}/fdc-test.c (100%)
 rename tests/{ =3D> qtest}/fw_cfg-test.c (100%)
 rename tests/{ =3D> qtest}/hd-geo-test.c (100%)
 rename tests/{ =3D> qtest}/hexloader-test.c (100%)
 rename tests/{ =3D> qtest}/i440fx-test.c (100%)
 rename tests/{ =3D> qtest}/i82801b11-test.c (100%)
 rename tests/{ =3D> qtest}/ide-test.c (100%)
 rename tests/{ =3D> qtest}/intel-hda-test.c (100%)
 rename tests/{ =3D> qtest}/ioh3420-test.c (100%)
 rename tests/{ =3D> qtest}/ipmi-bt-test.c (100%)
 rename tests/{ =3D> qtest}/ipmi-kcs-test.c (100%)
 rename tests/{ =3D> qtest}/ipoctal232-test.c (100%)
 rename tests/{ =3D> qtest}/ivshmem-test.c (100%)
 rename tests/{ =3D> qtest}/libqtest-single.h (100%)
 rename tests/{ =3D> qtest}/libqtest.c (100%)
 rename tests/{ =3D> qtest}/libqtest.h (100%)
 rename tests/{ =3D> qtest}/m25p80-test.c (100%)
 rename tests/{ =3D> qtest}/m48t59-test.c (100%)
 rename tests/{ =3D> qtest}/machine-none-test.c (100%)
 rename tests/{ =3D> qtest}/megasas-test.c (100%)
 rename tests/{ =3D> qtest}/microbit-test.c (100%)
 rename tests/{ =3D> qtest}/migration-test.c (100%)
 rename tests/{ =3D> qtest}/modules-test.c (100%)
 rename tests/{ =3D> qtest}/ne2000-test.c (100%)
 rename tests/{ =3D> qtest}/numa-test.c (100%)
 rename tests/{ =3D> qtest}/nvme-test.c (100%)
 rename tests/{ =3D> qtest}/pca9552-test.c (100%)
 rename tests/{ =3D> qtest}/pci-test.c (100%)
 rename tests/{ =3D> qtest}/pcnet-test.c (100%)
 rename tests/{ =3D> qtest}/pflash-cfi02-test.c (100%)
 rename tests/{ =3D> qtest}/pnv-xscom-test.c (100%)
 rename tests/{ =3D> qtest}/prom-env-test.c (100%)
 rename tests/{ =3D> qtest}/pvpanic-test.c (100%)
 rename tests/{ =3D> qtest}/pxe-test.c (100%)
 rename tests/{ =3D> qtest}/q35-test.c (100%)
 rename tests/{ =3D> qtest}/qmp-cmd-test.c (100%)
 rename tests/{ =3D> qtest}/qmp-test.c (100%)
 rename tests/{ =3D> qtest}/qom-test.c (100%)
 rename tests/{ =3D> qtest}/qos-test.c (100%)
 rename tests/{ =3D> qtest}/rtas-test.c (100%)
 rename tests/{ =3D> qtest}/rtc-test.c (100%)
 rename tests/{ =3D> qtest}/rtl8139-test.c (100%)
 rename tests/{ =3D> qtest}/sdhci-test.c (100%)
 rename tests/{ =3D> qtest}/spapr-phb-test.c (100%)
 rename tests/{ =3D> qtest}/tco-test.c (100%)
 rename tests/{ =3D> qtest}/test-arm-mptimer.c (100%)
 rename tests/{ =3D> qtest}/test-filter-mirror.c (100%)
 rename tests/{ =3D> qtest}/test-filter-redirector.c (100%)
 rename tests/{ =3D> qtest}/test-hmp.c (100%)
 rename tests/{ =3D> qtest}/test-netfilter.c (100%)
 rename tests/{ =3D> qtest}/test-x86-cpuid-compat.c (100%)
 rename tests/{ =3D> qtest}/tmp105-test.c (100%)
 rename tests/{ =3D> qtest}/tpm-crb-swtpm-test.c (100%)
 rename tests/{ =3D> qtest}/tpm-crb-test.c (100%)
 rename tests/{ =3D> qtest}/tpm-emu.c (100%)
 rename tests/{ =3D> qtest}/tpm-emu.h (100%)
 rename tests/{ =3D> qtest}/tpm-tests.c (100%)
 rename tests/{ =3D> qtest}/tpm-tests.h (100%)
 rename tests/{ =3D> qtest}/tpm-tis-swtpm-test.c (100%)
 rename tests/{ =3D> qtest}/tpm-tis-test.c (100%)
 rename tests/{ =3D> qtest}/tpm-util.c (100%)
 rename tests/{ =3D> qtest}/tpm-util.h (100%)
 rename tests/{ =3D> qtest}/usb-hcd-ehci-test.c (100%)
 rename tests/{ =3D> qtest}/usb-hcd-ohci-test.c (100%)
 rename tests/{ =3D> qtest}/usb-hcd-uhci-test.c (100%)
 rename tests/{ =3D> qtest}/usb-hcd-xhci-test.c (100%)
 rename tests/{ =3D> qtest}/vhost-user-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-9p-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-blk-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-ccw-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-net-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-rng-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-scsi-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-serial-test.c (100%)
 rename tests/{ =3D> qtest}/virtio-test.c (100%)
 rename tests/{ =3D> qtest}/vmgenid-test.c (100%)
 rename tests/{ =3D> qtest}/vmxnet3-test.c (100%)
 rename tests/{ =3D> qtest}/wdt_ib700-test.c (100%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e3db1b847c..9af4fb548a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -73,11 +73,12 @@ build-tci:
  - ./configure --enable-tcg-interpreter
       --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; =
done)"
  - make -j2
- - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
+ - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/px=
e-test
  - for tg in $TARGETS ; do
      export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
-     ./tests/boot-serial-test || exit 1 ;
-     ./tests/cdrom-test || exit 1 ;
+     ./tests/qtest/boot-serial-test || exit 1 ;
+     ./tests/qtest/cdrom-test || exit 1 ;
    done
- - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/pxe-tes=
t
- - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe-test =
-m slow
+ - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/p=
xe-test
+ - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
+   ./tests/qtest/pxe-test -m slow
diff --git a/MAINTAINERS b/MAINTAINERS
index 740401bcbb..d571e16cc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -532,7 +532,7 @@ F: include/hw/misc/arm11scu.h
 F: include/hw/timer/a9gtimer.h
 F: include/hw/timer/arm_mptimer.h
 F: include/hw/timer/armv7m_systick.h
-F: tests/test-arm-mptimer.c
+F: tests/qtest/test-arm-mptimer.c
=20
 Exynos
 M: Igor Mitsyanko <i.mitsyanko@gmail.com>
@@ -863,7 +863,7 @@ F: hw/*/nrf51*.c
 F: hw/*/microbit*.c
 F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
-F: tests/microbit-test.c
+F: tests/qtest/microbit-test.c
=20
 CRIS Machines
 -------------
@@ -1100,9 +1100,9 @@ F: include/hw/*/xics*
 F: pc-bios/slof.bin
 F: docs/specs/ppc-spapr-hcalls.txt
 F: docs/specs/ppc-spapr-hotplug.txt
-F: tests/spapr*
+F: tests/qtest/spapr*
 F: tests/libqos/*spapr*
-F: tests/rtas*
+F: tests/qtest/rtas*
 F: tests/libqos/rtas*
=20
 PowerNV (Non-Virtualized)
@@ -1115,7 +1115,7 @@ F: hw/intc/pnv*
 F: hw/intc/xics_pnv.c
 F: include/hw/ppc/pnv*
 F: pc-bios/skiboot.lid
-F: tests/pnv*
+F: tests/qtest/pnv*
=20
 virtex_ml507
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
@@ -1263,7 +1263,7 @@ F: hw/misc/sga.c
 F: hw/isa/apm.c
 F: include/hw/isa/apm.h
 F: tests/test-x86-cpuid.c
-F: tests/test-x86-cpuid-compat.c
+F: tests/qtest/test-x86-cpuid-compat.c
=20
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -1359,9 +1359,9 @@ F: hw/ide/
 F: hw/block/block.c
 F: hw/block/cdrom.c
 F: hw/block/hd-geometry.c
-F: tests/ide-test.c
-F: tests/ahci-test.c
-F: tests/cdrom-test.c
+F: tests/qtest/ide-test.c
+F: tests/qtest/ahci-test.c
+F: tests/qtest/cdrom-test.c
 F: tests/libqos/ahci*
 T: git https://github.com/jnsnow/qemu.git ide
=20
@@ -1371,7 +1371,7 @@ S: Maintained
 F: include/hw/ipmi/*
 F: hw/ipmi/*
 F: hw/smbios/smbios_type_38.c
-F: tests/ipmi*
+F: tests/qtest/ipmi*
 T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
=20
 Floppy
@@ -1380,7 +1380,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/fdc.c
 F: include/hw/block/fdc.h
-F: tests/fdc-test.c
+F: tests/qtest/fdc-test.c
 T: git https://github.com/jnsnow/qemu.git ide
=20
 OMAP
@@ -1418,8 +1418,8 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
-F: tests/bios-tables-test.c
-F: tests/acpi-utils.[hc]
+F: tests/qtest/bios-tables-test.c
+F: tests/qtest/acpi-utils.[hc]
 F: tests/data/acpi/
=20
 ppc4xx
@@ -1442,7 +1442,7 @@ M: Jason Wang <jasowang@redhat.com>
 S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
-F: tests/virtio-net-test.c
+F: tests/qtest/virtio-net-test.c
 F: docs/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
=20
@@ -1459,7 +1459,7 @@ R: Fam Zheng <fam@euphon.net>
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
-F: tests/virtio-scsi-test.c
+F: tests/qtest/virtio-scsi-test.c
 T: git https://github.com/bonzini/qemu.git scsi-next
=20
 SSI
@@ -1469,7 +1469,7 @@ F: hw/ssi/*
 F: hw/block/m25p80.c
 F: include/hw/ssi/ssi.h
 X: hw/ssi/xilinx_*
-F: tests/m25p80-test.c
+F: tests/qtest/m25p80-test.c
=20
 Xilinx SPI
 M: Alistair Francis <alistair@alistair23.me>
@@ -1482,13 +1482,13 @@ S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
-F: tests/sd*
+F: tests/qtest/sd*
=20
 USB
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: hw/usb/*
-F: tests/usb-*-test.c
+F: tests/qtest/usb-*-test.c
 F: docs/usb2.txt
 F: docs/usb-storage.txt
 F: include/hw/usb.h
@@ -1550,7 +1550,6 @@ F: hw/virtio/Makefile.objs
 F: hw/virtio/trace-events
 F: net/vhost-user.c
 F: include/hw/virtio/
-F: tests/virtio-balloon-test.c
=20
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
@@ -1558,7 +1557,7 @@ S: Odd Fixes
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
 F: fsdev/
-F: tests/virtio-9p-test.c
+F: tests/qtest/virtio-9p-test.c
 T: git https://github.com/gkurz/qemu.git 9p-next
=20
 virtio-blk
@@ -1567,7 +1566,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/virtio-blk.c
 F: hw/block/dataplane/*
-F: tests/virtio-blk-test.c
+F: tests/qtest/virtio-blk-test.c
 T: git https://github.com/stefanha/qemu.git block
=20
 virtio-ccw
@@ -1595,8 +1594,7 @@ S: Supported
 F: hw/char/virtio-serial-bus.c
 F: hw/char/virtio-console.c
 F: include/hw/virtio/virtio-serial.h
-F: tests/virtio-console-test.c
-F: tests/virtio-serial-test.c
+F: tests/qtest/virtio-serial-test.c
=20
 virtio-rng
 M: Laurent Vivier <lvivier@redhat.com>
@@ -1606,7 +1604,7 @@ F: hw/virtio/virtio-rng.c
 F: include/hw/virtio/virtio-rng.h
 F: include/sysemu/rng*.h
 F: backends/rng*.c
-F: tests/virtio-rng-test.c
+F: tests/qtest/virtio-rng-test.c
=20
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
@@ -1620,7 +1618,7 @@ M: Keith Busch <keith.busch@intel.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
-F: tests/nvme-test.c
+F: tests/qtest/nvme-test.c
=20
 megasas
 M: Hannes Reinecke <hare@suse.com>
@@ -1628,7 +1626,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/scsi/megasas.c
 F: hw/scsi/mfi.h
-F: tests/megasas-test.c
+F: tests/qtest/megasas-test.c
=20
 Network packet abstractions
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
@@ -1643,7 +1641,7 @@ M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
-F: tests/vmxnet3-test.c
+F: tests/qtest/vmxnet3-test.c
=20
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
@@ -1691,7 +1689,7 @@ F: docs/generic-loader.txt
 Intel Hexadecimal Object File Loader
 M: Su Hang <suhang16@mails.ucas.ac.cn>
 S: Maintained
-F: tests/hexloader-test.c
+F: tests/qtest/hexloader-test.c
 F: tests/data/hex-loader/test.hex
=20
 CHRP NVRAM
@@ -1699,7 +1697,7 @@ M: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
-F: tests/prom-env-test.c
+F: tests/qtest/prom-env-test.c
=20
 VM Generation ID
 M: Ben Warren <ben@skyportsystems.com>
@@ -1707,7 +1705,7 @@ S: Maintained
 F: hw/acpi/vmgenid.c
 F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.txt
-F: tests/vmgenid-test.c
+F: tests/qtest/vmgenid-test.c
 F: stubs/vmgenid.c
=20
 Unimplemented device
@@ -1777,7 +1775,7 @@ F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
 F: tests/libqos/fw_cfg.c
-F: tests/fw_cfg-test.c
+F: tests/qtest/fw_cfg-test.c
 T: git https://github.com/philmd/qemu.git fw_cfg-next
=20
 XIVE
@@ -1797,9 +1795,9 @@ S: Maintained
 F: audio/
 F: hw/audio/
 F: include/hw/audio/
-F: tests/ac97-test.c
-F: tests/es1370-test.c
-F: tests/intel-hda-test.c
+F: tests/qtest/ac97-test.c
+F: tests/qtest/es1370-test.c
+F: tests/qtest/intel-hda-test.c
=20
 Block layer core
 M: Kevin Wolf <kwolf@redhat.com>
@@ -2000,7 +1998,7 @@ F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp-target.h
-F: tests/test-hmp.c
+F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
=20
@@ -2126,8 +2124,8 @@ F: qapi/error.json
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
 F: scripts/qmp/
-F: tests/qmp-test.c
-F: tests/qmp-cmd-test.c
+F: tests/qtest/qmp-test.c
+F: tests/qtest/qmp-cmd-test.c
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 qtest
@@ -2137,9 +2135,8 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: qtest.c
 F: accel/qtest.c
-F: tests/libqtest*
 F: tests/libqos/
-F: tests/*-test.c
+F: tests/qtest/
=20
 Register API
 M: Alistair Francis <alistair@alistair23.me>
@@ -2183,7 +2180,7 @@ F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
 F: backends/tpm.c
-F: tests/*tpm*
+F: tests/qtest/*tpm*
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
=20
 Checkpatch
@@ -2198,7 +2195,7 @@ F: include/migration/
 F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
-F: tests/migration-test.c
+F: tests/qtest/migration-test.c
 F: docs/devel/migration.rst
 F: qapi/migration.json
=20
diff --git a/configure b/configure
index 84b413dbfc..121f1317e2 100755
--- a/configure
+++ b/configure
@@ -7952,8 +7952,8 @@ fi
 # so the build tree will be missing the link back to the new file, and
 # tests might fail. Prefer to keep the relevant files in their own
 # directory and symlink the directory instead.
-DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema test=
s/qemu-iotests tests/vm"
-DIRS=3D"$DIRS tests/fp tests/qgraph"
+DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema test=
s/qtest"
+DIRS=3D"$DIRS tests/qemu-iotests tests/vm tests/fp tests/qgraph"
 DIRS=3D"$DIRS docs docs/interop fsdev scsi"
 DIRS=3D"$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e3b199cf09..76154aece8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -508,7 +508,7 @@ generated-files-y +=3D tests/include/test-qapi-events-s=
ub-module.h
 generated-files-y +=3D tests/test-qapi-events-sub-sub-module.h
 generated-files-y +=3D tests/test-qapi-introspect.h
=20
-QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
+QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
=20
=20
 # Deps that are common to various different sets of tests below
@@ -687,12 +687,12 @@ tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o=
 $(test-authz-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
-tests/tpm-crb-swtpm-test$(EXESUF): tests/tpm-crb-swtpm-test.o tests/tpm-em=
u.o \
-=09tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
-tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test-i=
o-obj-y)
-tests/tpm-tis-swtpm-test$(EXESUF): tests/tpm-tis-swtpm-test.o tests/tpm-em=
u.o \
-=09tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
-tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test-i=
o-obj-y)
+tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-test.o =
tests/qtest/tpm-emu.o \
+=09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
+tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o =
tests/qtest/tpm-emu.o \
+=09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
@@ -722,7 +722,7 @@ libqos-pc-obj-y +=3D tests/libqos/ahci.o
 libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos=
/usb.o
=20
 # Devices
-qos-test-obj-y =3D tests/qos-test.o $(libqgraph-obj-y)
+qos-test-obj-y =3D tests/qtest/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y +=3D tests/libqos/e1000e.o
 qos-test-obj-y +=3D tests/libqos/i2c.o
@@ -755,97 +755,97 @@ qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machin=
e.o
 qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
=20
 # Tests
-qos-test-obj-y +=3D tests/ac97-test.o
-qos-test-obj-y +=3D tests/ds1338-test.o
-qos-test-obj-y +=3D tests/e1000-test.o
-qos-test-obj-y +=3D tests/e1000e-test.o
-qos-test-obj-y +=3D tests/eepro100-test.o
-qos-test-obj-y +=3D tests/es1370-test.o
-qos-test-obj-y +=3D tests/ipoctal232-test.o
-qos-test-obj-y +=3D tests/megasas-test.o
-qos-test-obj-y +=3D tests/ne2000-test.o
-qos-test-obj-y +=3D tests/nvme-test.o
-qos-test-obj-y +=3D tests/pca9552-test.o
-qos-test-obj-y +=3D tests/pci-test.o
-qos-test-obj-y +=3D tests/pcnet-test.o
-qos-test-obj-y +=3D tests/sdhci-test.o
-qos-test-obj-y +=3D tests/spapr-phb-test.o
-qos-test-obj-y +=3D tests/tmp105-test.o
-qos-test-obj-y +=3D tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
-qos-test-obj-$(CONFIG_VHOST_NET_USER) +=3D tests/vhost-user-test.o $(chard=
ev-obj-y) $(test-io-obj-y)
-qos-test-obj-y +=3D tests/virtio-test.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/virtio-9p-test.o
-qos-test-obj-y +=3D tests/virtio-blk-test.o
-qos-test-obj-y +=3D tests/virtio-net-test.o
-qos-test-obj-y +=3D tests/virtio-rng-test.o
-qos-test-obj-y +=3D tests/virtio-scsi-test.o
-qos-test-obj-y +=3D tests/virtio-serial-test.o
-qos-test-obj-y +=3D tests/vmxnet3-test.o
+qos-test-obj-y +=3D tests/qtest/ac97-test.o
+qos-test-obj-y +=3D tests/qtest/ds1338-test.o
+qos-test-obj-y +=3D tests/qtest/e1000-test.o
+qos-test-obj-y +=3D tests/qtest/e1000e-test.o
+qos-test-obj-y +=3D tests/qtest/eepro100-test.o
+qos-test-obj-y +=3D tests/qtest/es1370-test.o
+qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o
+qos-test-obj-y +=3D tests/qtest/megasas-test.o
+qos-test-obj-y +=3D tests/qtest/ne2000-test.o
+qos-test-obj-y +=3D tests/qtest/nvme-test.o
+qos-test-obj-y +=3D tests/qtest/pca9552-test.o
+qos-test-obj-y +=3D tests/qtest/pci-test.o
+qos-test-obj-y +=3D tests/qtest/pcnet-test.o
+qos-test-obj-y +=3D tests/qtest/sdhci-test.o
+qos-test-obj-y +=3D tests/qtest/spapr-phb-test.o
+qos-test-obj-y +=3D tests/qtest/tmp105-test.o
+qos-test-obj-y +=3D tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
+qos-test-obj-$(CONFIG_VHOST_NET_USER) +=3D tests/qtest/vhost-user-test.o $=
(chardev-obj-y) $(test-io-obj-y)
+qos-test-obj-y +=3D tests/qtest/virtio-test.o
+qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/virtio-9p-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-blk-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-net-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-rng-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-scsi-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-serial-test.o
+qos-test-obj-y +=3D tests/qtest/vmxnet3-test.o
=20
 check-unit-y +=3D tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
=20
 check-qtest-generic-y +=3D qos-test
-tests/qos-test$(EXESUF): $(qos-test-obj-y)
-
-tests/qmp-test$(EXESUF): tests/qmp-test.o
-tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
-tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
-tests/rtc-test$(EXESUF): tests/rtc-test.o
-tests/m48t59-test$(EXESUF): tests/m48t59-test.o
-tests/hexloader-test$(EXESUF): tests/hexloader-test.o
-tests/pflash-cfi02$(EXESUF): tests/pflash-cfi02-test.o
-tests/endianness-test$(EXESUF): tests/endianness-test.o
-tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
-tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
-tests/fdc-test$(EXESUF): tests/fdc-test.o
-tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
-tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(E=
XESUF)
-tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
-tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
-tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o $(libqos-obj-y)
-tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
-tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
-tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
-=09tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
-tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj=
-y)
-tests/microbit-test$(EXESUF): tests/microbit-test.o
-tests/m25p80-test$(EXESUF): tests/m25p80-test.o
-tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
-tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
-tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
-tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
-tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
-tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
-tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
-tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
-tests/display-vga-test$(EXESUF): tests/display-vga-test.o
-tests/qom-test$(EXESUF): tests/qom-test.o
-tests/test-hmp$(EXESUF): tests/test-hmp.o
-tests/machine-none-test$(EXESUF): tests/machine-none-test.o
-tests/device-plug-test$(EXESUF): tests/device-plug-test.o
-tests/drive_del-test$(EXESUF): tests/drive_del-test.o
-tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
-tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
-tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
-tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
-tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-o=
bj-y)
-tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-o=
bj-y)
-tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-o=
bj-y)
-tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
-tests/migration-test$(EXESUF): tests/migration-test.o
-tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_s=
cm_helper.o
-tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
-tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-=
y)
-tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qt=
est-obj-y)
-tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtes=
t-obj-y)
-tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/i=
vshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
-tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
-tests/numa-test$(EXESUF): tests/numa-test.o
-tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o test=
s/acpi-utils.o
-tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos=
-obj-y)
-tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
+tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y)
+
+tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
+tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
+tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-introspect=
-test.o
+tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
+tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
+tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
+tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
+tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
+tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-o=
bj-y)
+tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj=
-y)
+tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
+tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
+tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y)=
 qemu-img$(EXESUF)
+tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
+tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
+tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y=
)
+tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libq=
os-obj-y)
+tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(li=
bqos-obj-y)
+tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
+=09tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
+tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sec=
tor.o $(libqos-obj-y)
+tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
+tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
+tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-ob=
j-y)
+tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
+tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-ob=
j-y)
+tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-=
obj-y)
+tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
+tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
+tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
+tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
+tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
+tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
+tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
+tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
+tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
+tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
+tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
+tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
+tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
+tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
+tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o $(=
libqos-usb-obj-y)
+tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o $(=
libqos-usb-obj-y)
+tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(=
libqos-usb-obj-y)
+tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
+tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o
+tests/qtest/qemu-iotests/qtest/socket_scm_helper$(EXESUF): tests/qtest/qem=
u-iotests/qtest/socket_scm_helper.o
+tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-=
obj-y)
+tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o =
$(qtest-obj-y)
+tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redir=
ector.o $(qtest-obj-y)
+tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-com=
pat.o $(qtest-obj-y)
+tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivsh=
mem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(=
test-util-obj-y) libvhost-user.a
+tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
+tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
+tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/=
boot-sector.o tests/qtest/acpi-utils.o
+tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest/boot=
-sector.o $(libqos-obj-y)
+tests/qtest/arm-cpu-features$(EXESUF): tests/qtest/arm-cpu-features.o
=20
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 =09$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,=
"LINK","$(TARGET_DIR)$@")
@@ -864,13 +864,13 @@ tests/migration/initrd-stress.img: tests/migration/st=
ress$(EXESUF)
 TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS =3D $(TARGETS)
-check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=
=3Dtests/%$(EXESUF)))
-check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/%$(EXESUF))
+check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=
=3Dtests/qtest/%$(EXESUF)))
+check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF))
 else
 QTEST_TARGETS =3D
 endif
=20
-qtest-obj-y =3D tests/libqtest.o $(test-util-obj-y)
+qtest-obj-y =3D tests/qtest/libqtest.o $(test-util-obj-y)
 $(check-qtest-y): $(qtest-obj-y)
=20
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
@@ -915,7 +915,7 @@ endef
=20
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/a=
ll $(check-qtest-y)
-=09$(call do_test_human,$(check-qtest-$*-y:%=3Dtests/%$(EXESUF)) $(check-q=
test-generic-y:%=3Dtests/%$(EXESUF)), \
+=09$(call do_test_human,$(check-qtest-$*-y:%=3Dtests/qtest/%$(EXESUF)) $(c=
heck-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF)), \
 =09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 =09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
=20
@@ -928,7 +928,7 @@ check-speed: $(check-speed-y)
 # gtester tests with TAP output
=20
 $(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qt=
est-%.tap: %-softmmu/all $(check-qtest-y)
-=09$(call do_test_tap, $(check-qtest-$*-y:%=3Dtests/%$(EXESUF)) $(check-qt=
est-generic-y:%=3Dtests/%$(EXESUF)), \
+=09$(call do_test_tap, $(check-qtest-$*-y:%=3Dtests/qtest/%$(EXESUF)) $(ch=
eck-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF)), \
 =09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 =09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
=20
@@ -1196,8 +1196,8 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARG=
ETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-block check-qapi-schema check-unit check-softfloat check-qtes=
t check-decodetree
 check-clean:
-=09rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
-=09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y:%=3Dtests/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests/%$(EXESUF=
)))
+=09rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
+=09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y:%=3Dtests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests/qte=
st/%$(EXESUF)))
 =09rm -f tests/test-qapi-gen-timestamp
 =09rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
=20
@@ -1208,6 +1208,7 @@ clean: check-clean
 all: $(QEMU_IOTESTS_HELPERS-y)
=20
 -include $(wildcard tests/*.d)
+-include $(wildcard tests/qtest/*.d)
 -include $(wildcard tests/libqos/*.d)
=20
 endif
diff --git a/tests/ac97-test.c b/tests/qtest/ac97-test.c
similarity index 100%
rename from tests/ac97-test.c
rename to tests/qtest/ac97-test.c
diff --git a/tests/acpi-utils.c b/tests/qtest/acpi-utils.c
similarity index 100%
rename from tests/acpi-utils.c
rename to tests/qtest/acpi-utils.c
diff --git a/tests/acpi-utils.h b/tests/qtest/acpi-utils.h
similarity index 100%
rename from tests/acpi-utils.h
rename to tests/qtest/acpi-utils.h
diff --git a/tests/ahci-test.c b/tests/qtest/ahci-test.c
similarity index 100%
rename from tests/ahci-test.c
rename to tests/qtest/ahci-test.c
diff --git a/tests/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
similarity index 100%
rename from tests/arm-cpu-features.c
rename to tests/qtest/arm-cpu-features.c
diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/qtest/bios-table=
s-test-allowed-diff.h
similarity index 100%
rename from tests/bios-tables-test-allowed-diff.h
rename to tests/qtest/bios-tables-test-allowed-diff.h
diff --git a/tests/bios-tables-test.c b/tests/qtest/bios-tables-test.c
similarity index 100%
rename from tests/bios-tables-test.c
rename to tests/qtest/bios-tables-test.c
diff --git a/tests/boot-order-test.c b/tests/qtest/boot-order-test.c
similarity index 100%
rename from tests/boot-order-test.c
rename to tests/qtest/boot-order-test.c
diff --git a/tests/boot-sector.c b/tests/qtest/boot-sector.c
similarity index 100%
rename from tests/boot-sector.c
rename to tests/qtest/boot-sector.c
diff --git a/tests/boot-sector.h b/tests/qtest/boot-sector.h
similarity index 100%
rename from tests/boot-sector.h
rename to tests/qtest/boot-sector.h
diff --git a/tests/boot-serial-test.c b/tests/qtest/boot-serial-test.c
similarity index 100%
rename from tests/boot-serial-test.c
rename to tests/qtest/boot-serial-test.c
diff --git a/tests/cdrom-test.c b/tests/qtest/cdrom-test.c
similarity index 100%
rename from tests/cdrom-test.c
rename to tests/qtest/cdrom-test.c
diff --git a/tests/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
similarity index 100%
rename from tests/cpu-plug-test.c
rename to tests/qtest/cpu-plug-test.c
diff --git a/tests/device-introspect-test.c b/tests/qtest/device-introspect=
-test.c
similarity index 100%
rename from tests/device-introspect-test.c
rename to tests/qtest/device-introspect-test.c
diff --git a/tests/device-plug-test.c b/tests/qtest/device-plug-test.c
similarity index 100%
rename from tests/device-plug-test.c
rename to tests/qtest/device-plug-test.c
diff --git a/tests/display-vga-test.c b/tests/qtest/display-vga-test.c
similarity index 100%
rename from tests/display-vga-test.c
rename to tests/qtest/display-vga-test.c
diff --git a/tests/drive_del-test.c b/tests/qtest/drive_del-test.c
similarity index 100%
rename from tests/drive_del-test.c
rename to tests/qtest/drive_del-test.c
diff --git a/tests/ds1338-test.c b/tests/qtest/ds1338-test.c
similarity index 100%
rename from tests/ds1338-test.c
rename to tests/qtest/ds1338-test.c
diff --git a/tests/e1000-test.c b/tests/qtest/e1000-test.c
similarity index 100%
rename from tests/e1000-test.c
rename to tests/qtest/e1000-test.c
diff --git a/tests/e1000e-test.c b/tests/qtest/e1000e-test.c
similarity index 100%
rename from tests/e1000e-test.c
rename to tests/qtest/e1000e-test.c
diff --git a/tests/eepro100-test.c b/tests/qtest/eepro100-test.c
similarity index 100%
rename from tests/eepro100-test.c
rename to tests/qtest/eepro100-test.c
diff --git a/tests/endianness-test.c b/tests/qtest/endianness-test.c
similarity index 100%
rename from tests/endianness-test.c
rename to tests/qtest/endianness-test.c
diff --git a/tests/es1370-test.c b/tests/qtest/es1370-test.c
similarity index 100%
rename from tests/es1370-test.c
rename to tests/qtest/es1370-test.c
diff --git a/tests/fdc-test.c b/tests/qtest/fdc-test.c
similarity index 100%
rename from tests/fdc-test.c
rename to tests/qtest/fdc-test.c
diff --git a/tests/fw_cfg-test.c b/tests/qtest/fw_cfg-test.c
similarity index 100%
rename from tests/fw_cfg-test.c
rename to tests/qtest/fw_cfg-test.c
diff --git a/tests/hd-geo-test.c b/tests/qtest/hd-geo-test.c
similarity index 100%
rename from tests/hd-geo-test.c
rename to tests/qtest/hd-geo-test.c
diff --git a/tests/hexloader-test.c b/tests/qtest/hexloader-test.c
similarity index 100%
rename from tests/hexloader-test.c
rename to tests/qtest/hexloader-test.c
diff --git a/tests/i440fx-test.c b/tests/qtest/i440fx-test.c
similarity index 100%
rename from tests/i440fx-test.c
rename to tests/qtest/i440fx-test.c
diff --git a/tests/i82801b11-test.c b/tests/qtest/i82801b11-test.c
similarity index 100%
rename from tests/i82801b11-test.c
rename to tests/qtest/i82801b11-test.c
diff --git a/tests/ide-test.c b/tests/qtest/ide-test.c
similarity index 100%
rename from tests/ide-test.c
rename to tests/qtest/ide-test.c
diff --git a/tests/intel-hda-test.c b/tests/qtest/intel-hda-test.c
similarity index 100%
rename from tests/intel-hda-test.c
rename to tests/qtest/intel-hda-test.c
diff --git a/tests/ioh3420-test.c b/tests/qtest/ioh3420-test.c
similarity index 100%
rename from tests/ioh3420-test.c
rename to tests/qtest/ioh3420-test.c
diff --git a/tests/ipmi-bt-test.c b/tests/qtest/ipmi-bt-test.c
similarity index 100%
rename from tests/ipmi-bt-test.c
rename to tests/qtest/ipmi-bt-test.c
diff --git a/tests/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
similarity index 100%
rename from tests/ipmi-kcs-test.c
rename to tests/qtest/ipmi-kcs-test.c
diff --git a/tests/ipoctal232-test.c b/tests/qtest/ipoctal232-test.c
similarity index 100%
rename from tests/ipoctal232-test.c
rename to tests/qtest/ipoctal232-test.c
diff --git a/tests/ivshmem-test.c b/tests/qtest/ivshmem-test.c
similarity index 100%
rename from tests/ivshmem-test.c
rename to tests/qtest/ivshmem-test.c
diff --git a/tests/libqtest-single.h b/tests/qtest/libqtest-single.h
similarity index 100%
rename from tests/libqtest-single.h
rename to tests/qtest/libqtest-single.h
diff --git a/tests/libqtest.c b/tests/qtest/libqtest.c
similarity index 100%
rename from tests/libqtest.c
rename to tests/qtest/libqtest.c
diff --git a/tests/libqtest.h b/tests/qtest/libqtest.h
similarity index 100%
rename from tests/libqtest.h
rename to tests/qtest/libqtest.h
diff --git a/tests/m25p80-test.c b/tests/qtest/m25p80-test.c
similarity index 100%
rename from tests/m25p80-test.c
rename to tests/qtest/m25p80-test.c
diff --git a/tests/m48t59-test.c b/tests/qtest/m48t59-test.c
similarity index 100%
rename from tests/m48t59-test.c
rename to tests/qtest/m48t59-test.c
diff --git a/tests/machine-none-test.c b/tests/qtest/machine-none-test.c
similarity index 100%
rename from tests/machine-none-test.c
rename to tests/qtest/machine-none-test.c
diff --git a/tests/megasas-test.c b/tests/qtest/megasas-test.c
similarity index 100%
rename from tests/megasas-test.c
rename to tests/qtest/megasas-test.c
diff --git a/tests/microbit-test.c b/tests/qtest/microbit-test.c
similarity index 100%
rename from tests/microbit-test.c
rename to tests/qtest/microbit-test.c
diff --git a/tests/migration-test.c b/tests/qtest/migration-test.c
similarity index 100%
rename from tests/migration-test.c
rename to tests/qtest/migration-test.c
diff --git a/tests/modules-test.c b/tests/qtest/modules-test.c
similarity index 100%
rename from tests/modules-test.c
rename to tests/qtest/modules-test.c
diff --git a/tests/ne2000-test.c b/tests/qtest/ne2000-test.c
similarity index 100%
rename from tests/ne2000-test.c
rename to tests/qtest/ne2000-test.c
diff --git a/tests/numa-test.c b/tests/qtest/numa-test.c
similarity index 100%
rename from tests/numa-test.c
rename to tests/qtest/numa-test.c
diff --git a/tests/nvme-test.c b/tests/qtest/nvme-test.c
similarity index 100%
rename from tests/nvme-test.c
rename to tests/qtest/nvme-test.c
diff --git a/tests/pca9552-test.c b/tests/qtest/pca9552-test.c
similarity index 100%
rename from tests/pca9552-test.c
rename to tests/qtest/pca9552-test.c
diff --git a/tests/pci-test.c b/tests/qtest/pci-test.c
similarity index 100%
rename from tests/pci-test.c
rename to tests/qtest/pci-test.c
diff --git a/tests/pcnet-test.c b/tests/qtest/pcnet-test.c
similarity index 100%
rename from tests/pcnet-test.c
rename to tests/qtest/pcnet-test.c
diff --git a/tests/pflash-cfi02-test.c b/tests/qtest/pflash-cfi02-test.c
similarity index 100%
rename from tests/pflash-cfi02-test.c
rename to tests/qtest/pflash-cfi02-test.c
diff --git a/tests/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
similarity index 100%
rename from tests/pnv-xscom-test.c
rename to tests/qtest/pnv-xscom-test.c
diff --git a/tests/prom-env-test.c b/tests/qtest/prom-env-test.c
similarity index 100%
rename from tests/prom-env-test.c
rename to tests/qtest/prom-env-test.c
diff --git a/tests/pvpanic-test.c b/tests/qtest/pvpanic-test.c
similarity index 100%
rename from tests/pvpanic-test.c
rename to tests/qtest/pvpanic-test.c
diff --git a/tests/pxe-test.c b/tests/qtest/pxe-test.c
similarity index 100%
rename from tests/pxe-test.c
rename to tests/qtest/pxe-test.c
diff --git a/tests/q35-test.c b/tests/qtest/q35-test.c
similarity index 100%
rename from tests/q35-test.c
rename to tests/qtest/q35-test.c
diff --git a/tests/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
similarity index 100%
rename from tests/qmp-cmd-test.c
rename to tests/qtest/qmp-cmd-test.c
diff --git a/tests/qmp-test.c b/tests/qtest/qmp-test.c
similarity index 100%
rename from tests/qmp-test.c
rename to tests/qtest/qmp-test.c
diff --git a/tests/qom-test.c b/tests/qtest/qom-test.c
similarity index 100%
rename from tests/qom-test.c
rename to tests/qtest/qom-test.c
diff --git a/tests/qos-test.c b/tests/qtest/qos-test.c
similarity index 100%
rename from tests/qos-test.c
rename to tests/qtest/qos-test.c
diff --git a/tests/rtas-test.c b/tests/qtest/rtas-test.c
similarity index 100%
rename from tests/rtas-test.c
rename to tests/qtest/rtas-test.c
diff --git a/tests/rtc-test.c b/tests/qtest/rtc-test.c
similarity index 100%
rename from tests/rtc-test.c
rename to tests/qtest/rtc-test.c
diff --git a/tests/rtl8139-test.c b/tests/qtest/rtl8139-test.c
similarity index 100%
rename from tests/rtl8139-test.c
rename to tests/qtest/rtl8139-test.c
diff --git a/tests/sdhci-test.c b/tests/qtest/sdhci-test.c
similarity index 100%
rename from tests/sdhci-test.c
rename to tests/qtest/sdhci-test.c
diff --git a/tests/spapr-phb-test.c b/tests/qtest/spapr-phb-test.c
similarity index 100%
rename from tests/spapr-phb-test.c
rename to tests/qtest/spapr-phb-test.c
diff --git a/tests/tco-test.c b/tests/qtest/tco-test.c
similarity index 100%
rename from tests/tco-test.c
rename to tests/qtest/tco-test.c
diff --git a/tests/test-arm-mptimer.c b/tests/qtest/test-arm-mptimer.c
similarity index 100%
rename from tests/test-arm-mptimer.c
rename to tests/qtest/test-arm-mptimer.c
diff --git a/tests/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
similarity index 100%
rename from tests/test-filter-mirror.c
rename to tests/qtest/test-filter-mirror.c
diff --git a/tests/test-filter-redirector.c b/tests/qtest/test-filter-redir=
ector.c
similarity index 100%
rename from tests/test-filter-redirector.c
rename to tests/qtest/test-filter-redirector.c
diff --git a/tests/test-hmp.c b/tests/qtest/test-hmp.c
similarity index 100%
rename from tests/test-hmp.c
rename to tests/qtest/test-hmp.c
diff --git a/tests/test-netfilter.c b/tests/qtest/test-netfilter.c
similarity index 100%
rename from tests/test-netfilter.c
rename to tests/qtest/test-netfilter.c
diff --git a/tests/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-com=
pat.c
similarity index 100%
rename from tests/test-x86-cpuid-compat.c
rename to tests/qtest/test-x86-cpuid-compat.c
diff --git a/tests/tmp105-test.c b/tests/qtest/tmp105-test.c
similarity index 100%
rename from tests/tmp105-test.c
rename to tests/qtest/tmp105-test.c
diff --git a/tests/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
similarity index 100%
rename from tests/tpm-crb-swtpm-test.c
rename to tests/qtest/tpm-crb-swtpm-test.c
diff --git a/tests/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
similarity index 100%
rename from tests/tpm-crb-test.c
rename to tests/qtest/tpm-crb-test.c
diff --git a/tests/tpm-emu.c b/tests/qtest/tpm-emu.c
similarity index 100%
rename from tests/tpm-emu.c
rename to tests/qtest/tpm-emu.c
diff --git a/tests/tpm-emu.h b/tests/qtest/tpm-emu.h
similarity index 100%
rename from tests/tpm-emu.h
rename to tests/qtest/tpm-emu.h
diff --git a/tests/tpm-tests.c b/tests/qtest/tpm-tests.c
similarity index 100%
rename from tests/tpm-tests.c
rename to tests/qtest/tpm-tests.c
diff --git a/tests/tpm-tests.h b/tests/qtest/tpm-tests.h
similarity index 100%
rename from tests/tpm-tests.h
rename to tests/qtest/tpm-tests.h
diff --git a/tests/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
similarity index 100%
rename from tests/tpm-tis-swtpm-test.c
rename to tests/qtest/tpm-tis-swtpm-test.c
diff --git a/tests/tpm-tis-test.c b/tests/qtest/tpm-tis-test.c
similarity index 100%
rename from tests/tpm-tis-test.c
rename to tests/qtest/tpm-tis-test.c
diff --git a/tests/tpm-util.c b/tests/qtest/tpm-util.c
similarity index 100%
rename from tests/tpm-util.c
rename to tests/qtest/tpm-util.c
diff --git a/tests/tpm-util.h b/tests/qtest/tpm-util.h
similarity index 100%
rename from tests/tpm-util.h
rename to tests/qtest/tpm-util.h
diff --git a/tests/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
similarity index 100%
rename from tests/usb-hcd-ehci-test.c
rename to tests/qtest/usb-hcd-ehci-test.c
diff --git a/tests/usb-hcd-ohci-test.c b/tests/qtest/usb-hcd-ohci-test.c
similarity index 100%
rename from tests/usb-hcd-ohci-test.c
rename to tests/qtest/usb-hcd-ohci-test.c
diff --git a/tests/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
similarity index 100%
rename from tests/usb-hcd-uhci-test.c
rename to tests/qtest/usb-hcd-uhci-test.c
diff --git a/tests/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
similarity index 100%
rename from tests/usb-hcd-xhci-test.c
rename to tests/qtest/usb-hcd-xhci-test.c
diff --git a/tests/vhost-user-test.c b/tests/qtest/vhost-user-test.c
similarity index 100%
rename from tests/vhost-user-test.c
rename to tests/qtest/vhost-user-test.c
diff --git a/tests/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
similarity index 100%
rename from tests/virtio-9p-test.c
rename to tests/qtest/virtio-9p-test.c
diff --git a/tests/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
similarity index 100%
rename from tests/virtio-blk-test.c
rename to tests/qtest/virtio-blk-test.c
diff --git a/tests/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
similarity index 100%
rename from tests/virtio-ccw-test.c
rename to tests/qtest/virtio-ccw-test.c
diff --git a/tests/virtio-net-test.c b/tests/qtest/virtio-net-test.c
similarity index 100%
rename from tests/virtio-net-test.c
rename to tests/qtest/virtio-net-test.c
diff --git a/tests/virtio-rng-test.c b/tests/qtest/virtio-rng-test.c
similarity index 100%
rename from tests/virtio-rng-test.c
rename to tests/qtest/virtio-rng-test.c
diff --git a/tests/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
similarity index 100%
rename from tests/virtio-scsi-test.c
rename to tests/qtest/virtio-scsi-test.c
diff --git a/tests/virtio-serial-test.c b/tests/qtest/virtio-serial-test.c
similarity index 100%
rename from tests/virtio-serial-test.c
rename to tests/qtest/virtio-serial-test.c
diff --git a/tests/virtio-test.c b/tests/qtest/virtio-test.c
similarity index 100%
rename from tests/virtio-test.c
rename to tests/qtest/virtio-test.c
diff --git a/tests/vmgenid-test.c b/tests/qtest/vmgenid-test.c
similarity index 100%
rename from tests/vmgenid-test.c
rename to tests/qtest/vmgenid-test.c
diff --git a/tests/vmxnet3-test.c b/tests/qtest/vmxnet3-test.c
similarity index 100%
rename from tests/vmxnet3-test.c
rename to tests/qtest/vmxnet3-test.c
diff --git a/tests/wdt_ib700-test.c b/tests/qtest/wdt_ib700-test.c
similarity index 100%
rename from tests/wdt_ib700-test.c
rename to tests/qtest/wdt_ib700-test.c
--=20
2.18.1


