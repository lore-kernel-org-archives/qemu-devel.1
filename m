Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEBE2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWA7PRSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEBE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYG2s-0004ch-32
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG0V-0002rl-6t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG0S-0006Ww-1B
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604008970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gSTZBXXfd0+vevsX7mCftYv7eVyTOPno3SzqKexqQQk=;
 b=jWA7PRSwPkzfPpZA75477K64OibuLQY1FFArhlXHNBBjsGxVYyUtpMNDVUZ9WB/lT+DLv1
 Dc+3z3Jtwv05n1W/wz6n/OtK9NwglY65MZgkt34qlHM8xuK/i0PkVNj3/4Gxe6pPqX8HpK
 lXk61YjnTF7Gz2MwlmjR3H2eH3TEY+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-igCu02gqMLCE4bCO83YVoQ-1; Thu, 29 Oct 2020 18:02:48 -0400
X-MC-Unique: igCu02gqMLCE4bCO83YVoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA92805F07
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:02:47 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 491B45C1C4;
 Thu, 29 Oct 2020 22:02:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/36] Make qdev static property API usable by any QOM type
Date: Thu, 29 Oct 2020 18:02:10 -0400
Message-Id: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series refactor the qdev property code so the static=0D
property system can be used by any QOM type.  As an example, at=0D
the end of the series some properties in TYPE_MACHINE are=0D
converted to static properties.=0D
=0D
Eduardo Habkost (36):=0D
  cs4231: Get rid of empty property array=0D
  cpu: Move cpu_common_props to hw/core/cpu.c=0D
  qdev: Move property code to qdev-properties.[ch]=0D
  qdev: Check dev->realized at set_size()=0D
  sparc: Check dev->realized at sparc_set_nwindows()=0D
  qdev: Don't use dev->id on set_size32() error message=0D
  qdev: Make PropertyInfo.print method get Object* argument=0D
  qdev: Make bit_prop_set() get Object* argument=0D
  qdev: Make qdev_get_prop_ptr() get Object* arg=0D
  qdev: Make qdev_find_global_prop() get Object* argument=0D
  qdev: Make check_prop_still_unset() get Object* argument=0D
  qdev: Make error_set_from_qdev_prop_error() get Object* argument=0D
  qdev: Wrap getters and setters in separate helpers=0D
  qdev: Move dev->realized check to qdev_property_set()=0D
  qdev: Make PropertyInfo.create return ObjectProperty*=0D
  qdev: Make qdev_class_add_property() more flexible=0D
  qdev: Separate generic and device-specific property registration=0D
  qdev: Avoid unnecessary DeviceState* variable at set_prop_arraylen()=0D
  qdev: Move array property creation/registration to separate functions=0D
  qdev: Reuse object_property_add_static() when adding array elements=0D
  qom: Add allow_set callback to ObjectProperty=0D
  qdev: Make qdev_prop_allow_set() a property allow_set callback=0D
  qdev: Make qdev_propinfo_get_uint16() static=0D
  qdev: Rename qdev_propinfo_* to object_propinfo_*=0D
  qdev: Rename qdev_get_prop_ptr() to object_static_prop_ptr()=0D
  qdev: Move softmmu properties to qdev-properties-system.h=0D
  qdev: Reuse DEFINE_PROP in all DEFINE_PROP_* macros=0D
  qdev: Move core static property code to QOM=0D
  qdev: Move qdev_prop_tpm declaration to tpm_prop.h=0D
  qdev: Rename qdev_prop_* to prop_info_*=0D
  qdev: Stop using error_set_from_qdev_prop_error() for UUID property=0D
  qdev: Move base property types to qom/property-types.c=0D
  tests: Use static properties at check-qom-proplist test case=0D
  machine: Use DEFINE_PROP_STRING for string properties=0D
  machine: Use DEFINE_PROP_BOOL for boolean properties=0D
  qom: Include static property API reference in documentation=0D
=0D
 docs/devel/qom.rst                     |   6 +=0D
 audio/audio.h                          |   1 +=0D
 hw/core/qdev-prop-internal.h           |  30 -=0D
 hw/tpm/tpm_prop.h                      |   2 +=0D
 include/hw/block/block.h               |   1 +=0D
 include/hw/core/cpu.h                  |   1 -=0D
 include/hw/qdev-core.h                 |  47 +-=0D
 include/hw/qdev-properties-system.h    |  68 +++=0D
 include/hw/qdev-properties.h           | 241 +-------=0D
 include/net/net.h                      |   1 +=0D
 include/qom/object.h                   |  16 +=0D
 include/qom/static-property-internal.h |  41 ++=0D
 include/qom/static-property.h          | 343 +++++++++++=0D
 backends/tpm/tpm_util.c                |  14 +-=0D
 cpu.c                                  |  15 -=0D
 hw/arm/pxa2xx.c                        |   1 +=0D
 hw/arm/strongarm.c                     |   1 +=0D
 hw/audio/cs4231.c                      |   5 -=0D
 hw/block/fdc.c                         |   1 +=0D
 hw/block/m25p80.c                      |   1 +=0D
 hw/block/nand.c                        |   1 +=0D
 hw/block/onenand.c                     |   1 +=0D
 hw/block/pflash_cfi01.c                |   1 +=0D
 hw/block/pflash_cfi02.c                |   1 +=0D
 hw/block/vhost-user-blk.c              |   1 +=0D
 hw/block/xen-block.c                   |  11 +-=0D
 hw/char/avr_usart.c                    |   1 +=0D
 hw/char/bcm2835_aux.c                  |   1 +=0D
 hw/char/cadence_uart.c                 |   1 +=0D
 hw/char/cmsdk-apb-uart.c               |   1 +=0D
 hw/char/debugcon.c                     |   1 +=0D
 hw/char/digic-uart.c                   |   1 +=0D
 hw/char/escc.c                         |   1 +=0D
 hw/char/etraxfs_ser.c                  |   1 +=0D
 hw/char/exynos4210_uart.c              |   1 +=0D
 hw/char/grlib_apbuart.c                |   1 +=0D
 hw/char/ibex_uart.c                    |   1 +=0D
 hw/char/imx_serial.c                   |   1 +=0D
 hw/char/ipoctal232.c                   |   1 +=0D
 hw/char/lm32_juart.c                   |   1 +=0D
 hw/char/lm32_uart.c                    |   1 +=0D
 hw/char/mcf_uart.c                     |   1 +=0D
 hw/char/milkymist-uart.c               |   1 +=0D
 hw/char/nrf51_uart.c                   |   1 +=0D
 hw/char/parallel.c                     |   1 +=0D
 hw/char/pl011.c                        |   1 +=0D
 hw/char/renesas_sci.c                  |   1 +=0D
 hw/char/sclpconsole-lm.c               |   1 +=0D
 hw/char/sclpconsole.c                  |   1 +=0D
 hw/char/serial-pci-multi.c             |   1 +=0D
 hw/char/serial.c                       |   1 +=0D
 hw/char/spapr_vty.c                    |   1 +=0D
 hw/char/stm32f2xx_usart.c              |   1 +=0D
 hw/char/terminal3270.c                 |   1 +=0D
 hw/char/virtio-console.c               |   1 +=0D
 hw/char/xilinx_uartlite.c              |   1 +=0D
 hw/core/cpu.c                          |  15 +=0D
 hw/core/machine.c                      | 241 +-------=0D
 hw/core/qdev-properties-system.c       | 193 ++----=0D
 hw/core/qdev-properties.c              | 801 +++----------------------=0D
 hw/core/qdev.c                         | 120 ----=0D
 hw/i386/kvm/i8254.c                    |   1 +=0D
 hw/ide/qdev.c                          |   1 +=0D
 hw/intc/arm_gicv3_common.c             |   2 +-=0D
 hw/intc/rx_icu.c                       |   4 +-=0D
 hw/ipmi/ipmi_bmc_extern.c              |   1 +=0D
 hw/misc/arm_sysctl.c                   |   4 +-=0D
 hw/misc/ivshmem.c                      |   1 +=0D
 hw/misc/mac_via.c                      |   1 +=0D
 hw/misc/sifive_u_otp.c                 |   1 +=0D
 hw/net/e1000e.c                        |   6 +-=0D
 hw/net/rocker/rocker.c                 |   1 +=0D
 hw/nvram/eeprom_at24c.c                |   1 +=0D
 hw/nvram/spapr_nvram.c                 |   1 +=0D
 hw/pci-bridge/gen_pcie_root_port.c     |   1 +=0D
 hw/pci/pci.c                           |   1 +=0D
 hw/ppc/pnv_pnor.c                      |   1 +=0D
 hw/rdma/vmw/pvrdma_main.c              |   1 +=0D
 hw/rtc/mc146818rtc.c                   |   1 +=0D
 hw/s390x/css.c                         |  13 +-=0D
 hw/s390x/s390-pci-bus.c                |  10 +-=0D
 hw/scsi/scsi-disk.c                    |   1 +=0D
 hw/scsi/scsi-generic.c                 |   1 +=0D
 hw/scsi/vhost-user-scsi.c              |   1 +=0D
 hw/sd/sd.c                             |   1 +=0D
 hw/usb/ccid-card-passthru.c            |   1 +=0D
 hw/usb/dev-serial.c                    |   1 +=0D
 hw/usb/redirect.c                      |   1 +=0D
 hw/vfio/pci-quirks.c                   |  11 +-=0D
 hw/vfio/pci.c                          |   1 +=0D
 hw/virtio/vhost-user-fs.c              |   1 +=0D
 hw/virtio/vhost-user-vsock.c           |   1 +=0D
 hw/virtio/virtio-iommu-pci.c           |   1 +=0D
 hw/xen/xen_pt.c                        |   1 +=0D
 migration/migration.c                  |   1 +=0D
 qom/object.c                           |   4 +=0D
 qom/property-types.c                   | 649 ++++++++++++++++++++=0D
 qom/static-property.c                  | 114 ++++=0D
 softmmu/qdev-monitor.c                 |   1 +=0D
 target/arm/cpu.c                       |   2 +-=0D
 target/sparc/cpu.c                     |   2 +-=0D
 tests/check-qom-proplist.c             |  61 +-=0D
 qom/meson.build                        |   2 +=0D
 103 files changed, 1544 insertions(+), 1620 deletions(-)=0D
 delete mode 100644 hw/core/qdev-prop-internal.h=0D
 create mode 100644 include/hw/qdev-properties-system.h=0D
 create mode 100644 include/qom/static-property-internal.h=0D
 create mode 100644 include/qom/static-property.h=0D
 create mode 100644 qom/property-types.c=0D
 create mode 100644 qom/static-property.c=0D
=0D
--=20=0D
2.28.0=0D
=0D


