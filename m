Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D06C204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcOrpgIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D06C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WNP-0001FR-7c
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnA-0006Pu-KI
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vn3-0002zH-8A
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nYUXmTWSKexbdkMEaYAcEMsa4wE3TNWF800U2epZ9s=;
 b=NcOrpgIvlVXVi4Kkah4qYdKYtw7Q7KsHOnwOd0u96a3yJNnAVQpza6G5GJhBao+xorfwWu
 7GL+KuhInPDtae9apOajVXLnxDEsvIS5r5+QVGYm6+gAXCC+Y8BW85j+G/Ulads8Q33Xxh
 aoaYiYNwb0Mga7Z/r/6PUBuqlpg3f5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-3gpquYnhN6Kl7QxLSwnNCQ-1; Fri, 14 Aug 2020 05:14:18 -0400
X-MC-Unique: 3gpquYnhN6Kl7QxLSwnNCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3755E1DDE1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD4065D9D2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 069/150] meson: convert tests/qtest to meson
Date: Fri, 14 Aug 2020 05:12:05 -0400
Message-Id: <20200814091326.16173-70-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                                   |   3 +
 tests/Makefile.include                        |  47 +--
 tests/meson.build                             |   1 +
 tests/qtest/Makefile.include                  | 332 ------------------
 tests/qtest/ac97-test.c                       |   2 +-
 tests/qtest/acpi-utils.h                      |   2 +-
 tests/qtest/ahci-test.c                       |   2 +-
 tests/qtest/arm-cpu-features.c                |   2 +-
 tests/qtest/boot-order-test.c                 |   2 +-
 tests/qtest/boot-sector.c                     |   2 +-
 tests/qtest/boot-sector.h                     |   2 +-
 tests/qtest/boot-serial-test.c                |   2 +-
 tests/qtest/cdrom-test.c                      |   2 +-
 tests/qtest/dbus-vmstate-test.c               |   2 +-
 tests/qtest/device-introspect-test.c          |   2 +-
 tests/qtest/device-plug-test.c                |   2 +-
 tests/qtest/drive_del-test.c                  |   2 +-
 tests/qtest/ds1338-test.c                     |   2 +-
 tests/qtest/e1000-test.c                      |   2 +-
 tests/qtest/eepro100-test.c                   |   2 +-
 tests/qtest/endianness-test.c                 |   2 +-
 tests/qtest/es1370-test.c                     |   2 +-
 tests/qtest/fuzz/fuzz.c                       |   2 +-
 tests/qtest/fuzz/fuzz.h                       |   2 +-
 tests/qtest/fuzz/i440fx_fuzz.c                |   2 +-
 tests/qtest/fuzz/qos_fuzz.c                   |   2 +-
 tests/qtest/fuzz/virtio_net_fuzz.c            |   2 +-
 tests/qtest/fw_cfg-test.c                     |   2 +-
 tests/qtest/hd-geo-test.c                     |   2 +-
 tests/qtest/hexloader-test.c                  |   2 +-
 tests/qtest/ide-test.c                        |   2 +-
 tests/qtest/ipoctal232-test.c                 |   2 +-
 tests/qtest/ivshmem-test.c                    |   2 +-
 .../libqos/aarch64-xlnx-zcu102-machine.c      |   4 +-
 tests/qtest/libqos/ahci.c                     |   6 +-
 tests/qtest/libqos/ahci.h                     |   6 +-
 tests/qtest/libqos/arm-imx25-pdk-machine.c    |   6 +-
 tests/qtest/libqos/arm-n800-machine.c         |   6 +-
 tests/qtest/libqos/arm-raspi2-machine.c       |   4 +-
 tests/qtest/libqos/arm-sabrelite-machine.c    |   4 +-
 tests/qtest/libqos/arm-smdkc210-machine.c     |   4 +-
 tests/qtest/libqos/arm-virt-machine.c         |   6 +-
 .../qtest/libqos/arm-xilinx-zynq-a9-machine.c |   4 +-
 tests/qtest/libqos/e1000e.c                   |   6 +-
 tests/qtest/libqos/e1000e.h                   |   2 +-
 tests/qtest/libqos/fw_cfg.c                   |   2 +-
 tests/qtest/libqos/i2c-imx.c                  |   2 +-
 tests/qtest/libqos/i2c-omap.c                 |   2 +-
 tests/qtest/libqos/i2c.c                      |   2 +-
 tests/qtest/libqos/i2c.h                      |   2 +-
 tests/qtest/libqos/libqos-pc.c                |   6 +-
 tests/qtest/libqos/libqos-pc.h                |   2 +-
 tests/qtest/libqos/libqos-spapr.c             |   6 +-
 tests/qtest/libqos/libqos-spapr.h             |   2 +-
 tests/qtest/libqos/libqos.c                   |   4 +-
 tests/qtest/libqos/libqos.h                   |   4 +-
 tests/qtest/{ => libqos}/libqtest.h           |   0
 tests/qtest/libqos/malloc-pc.c                |   4 +-
 tests/qtest/libqos/malloc-pc.h                |   2 +-
 tests/qtest/libqos/malloc-spapr.c             |   2 +-
 tests/qtest/libqos/malloc-spapr.h             |   2 +-
 tests/qtest/libqos/malloc.c                   |   2 +-
 tests/qtest/libqos/meson.build                |  57 +++
 tests/qtest/libqos/pci-pc.c                   |   2 +-
 tests/qtest/libqos/pci-pc.h                   |   6 +-
 tests/qtest/libqos/pci-spapr.c                |   6 +-
 tests/qtest/libqos/pci-spapr.h                |   6 +-
 tests/qtest/libqos/pci.c                      |   4 +-
 tests/qtest/libqos/pci.h                      |   2 +-
 tests/qtest/libqos/ppc64_pseries-machine.c    |   4 +-
 tests/qtest/libqos/qgraph.c                   |   4 +-
 tests/qtest/libqos/qgraph.h                   |   6 +-
 tests/qtest/libqos/qgraph_internal.h          |   4 +-
 tests/qtest/libqos/qos_external.c             |   8 +-
 tests/qtest/libqos/qos_external.h             |   4 +-
 tests/qtest/libqos/rtas.c                     |   2 +-
 tests/qtest/libqos/rtas.h                     |   2 +-
 tests/qtest/libqos/sdhci.c                    |   2 +-
 tests/qtest/libqos/sdhci.h                    |   2 +-
 tests/qtest/libqos/tpci200.c                  |   4 +-
 tests/qtest/libqos/usb.c                      |   2 +-
 tests/qtest/libqos/usb.h                      |   2 +-
 tests/qtest/libqos/virtio-9p.c                |   4 +-
 tests/qtest/libqos/virtio-9p.h                |   6 +-
 tests/qtest/libqos/virtio-balloon.c           |   4 +-
 tests/qtest/libqos/virtio-balloon.h           |   6 +-
 tests/qtest/libqos/virtio-blk.c               |   4 +-
 tests/qtest/libqos/virtio-blk.h               |   6 +-
 tests/qtest/libqos/virtio-mmio.c              |   8 +-
 tests/qtest/libqos/virtio-mmio.h              |   4 +-
 tests/qtest/libqos/virtio-net.c               |   4 +-
 tests/qtest/libqos/virtio-net.h               |   6 +-
 tests/qtest/libqos/virtio-pci.c               |  14 +-
 tests/qtest/libqos/virtio-pci.h               |   6 +-
 tests/qtest/libqos/virtio-rng.c               |   4 +-
 tests/qtest/libqos/virtio-rng.h               |   6 +-
 tests/qtest/libqos/virtio-scsi.c              |   4 +-
 tests/qtest/libqos/virtio-scsi.h              |   6 +-
 tests/qtest/libqos/virtio-serial.c            |   4 +-
 tests/qtest/libqos/virtio-serial.h            |   6 +-
 tests/qtest/libqos/virtio.c                   |   2 +-
 tests/qtest/libqos/virtio.h                   |   2 +-
 tests/qtest/libqos/x86_64_pc-machine.c        |   2 +-
 tests/qtest/libqtest-single.h                 |   2 +-
 tests/qtest/libqtest.c                        |   2 +-
 tests/qtest/m48t59-test.c                     |   2 +-
 tests/qtest/machine-none-test.c               |   2 +-
 tests/qtest/megasas-test.c                    |   2 +-
 tests/qtest/meson.build                       | 257 ++++++++++++++
 tests/qtest/microbit-test.c                   |   2 +-
 tests/qtest/migration-helpers.h               |   2 +-
 tests/qtest/migration-test.c                  |   4 +-
 tests/qtest/modules-test.c                    |   2 +-
 tests/qtest/ne2000-test.c                     |   2 +-
 tests/qtest/numa-test.c                       |   2 +-
 tests/qtest/nvme-test.c                       |   2 +-
 tests/qtest/pca9552-test.c                    |   2 +-
 tests/qtest/pci-test.c                        |   2 +-
 tests/qtest/pcnet-test.c                      |   2 +-
 tests/qtest/pflash-cfi02-test.c               |   2 +-
 tests/qtest/pnv-xscom-test.c                  |   2 +-
 tests/qtest/prom-env-test.c                   |   2 +-
 tests/qtest/pvpanic-test.c                    |   2 +-
 tests/qtest/pxe-test.c                        |   2 +-
 tests/qtest/q35-test.c                        |   2 +-
 tests/qtest/qmp-cmd-test.c                    |   2 +-
 tests/qtest/qmp-test.c                        |   2 +-
 tests/qtest/qom-test.c                        |   2 +-
 tests/qtest/rtas-test.c                       |   2 +-
 tests/qtest/sdhci-test.c                      |   2 +-
 tests/qtest/spapr-phb-test.c                  |   2 +-
 tests/qtest/tco-test.c                        |   2 +-
 tests/qtest/test-filter-mirror.c              |   2 +-
 tests/qtest/test-filter-redirector.c          |   2 +-
 tests/qtest/test-hmp.c                        |   2 +-
 tests/qtest/tpm-crb-swtpm-test.c              |   2 +-
 tests/qtest/tpm-tis-device-swtpm-test.c       |   2 +-
 tests/qtest/tpm-tis-swtpm-test.c              |   2 +-
 tests/qtest/tpm-util.c                        |   2 +-
 tests/qtest/tulip-test.c                      |   2 +-
 tests/qtest/virtio-rng-test.c                 |   2 +-
 tests/qtest/virtio-test.c                     |   2 +-
 tests/qtest/vmgenid-test.c                    |   2 +-
 tests/qtest/vmxnet3-test.c                    |   2 +-
 tests/qtest/wdt_ib700-test.c                  |   2 +-
 tests/test-qga.c                              |   2 +-
 tests/test-qgraph.c                           |   5 +-
 147 files changed, 541 insertions(+), 589 deletions(-)
 delete mode 100644 tests/qtest/Makefile.include
 rename tests/qtest/{ => libqos}/libqtest.h (100%)
 create mode 100644 tests/qtest/libqos/meson.build
 create mode 100644 tests/qtest/meson.build

diff --git a/meson.build b/meson.build
index 3dd1443fa8..f79fc116d1 100644
--- a/meson.build
+++ b/meson.build
@@ -531,6 +531,9 @@ subdir('nbd')
 subdir('scsi')
 subdir('block')
 
+# needed for fuzzing binaries
+subdir('tests/qtest/libqos')
+
 mods = []
 block_mods = []
 softmmu_mods = []
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 676d099631..66acf9cdb3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -109,6 +109,7 @@ check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
+check-unit-y += tests/test-qgraph$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 check-unit-y += tests/test-qemu-opts$(EXESUF)
@@ -306,19 +307,6 @@ tests/test-qapi-gen-timestamp: \
 	@rm -f tests/test-qapi-doc.texi
 	@>$@
 
-tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c: tests/qtest/dbus-vmstate1-gen-timestamp ;
-tests/qtest/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/qtest/dbus-vmstate1.xml
-	$(call quiet-command,$(GDBUS_CODEGEN) $< \
-		--interface-prefix org.qemu --generate-c-code tests/qtest/dbus-vmstate1, \
-		"GEN","$(@:%-timestamp=%)")
-	@>$@
-
-tests/qtest/dbus-vmstate-test.o-cflags := -DSRCDIR="$(SRC_PATH)"
-tests/qtest/dbus-vmstate1.o-cflags := $(GIO_CFLAGS)
-tests/qtest/dbus-vmstate1.o-libs := $(GIO_LIBS)
-
-tests/qtest/dbus-vmstate-test.o: tests/qtest/dbus-vmstate1.h
-
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visitor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.o $(test-qapi-obj-y)
 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y) tests/test-qapi-emit-events.o tests/test-qapi-events.o
@@ -333,6 +321,7 @@ tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
 tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
+tests/test-qgraph$(EXESUF): tests/test-qgraph.o tests/qtest/libqos/qgraph.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
 tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test-crypto-obj-y)
 tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
@@ -396,10 +385,8 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rm $(INITRD_WORK_DIR)/init
 	rmdir $(INITRD_WORK_DIR)
 
-include $(SRC_PATH)/tests/qtest/Makefile.include
-
 tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)
-tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
+tests/test-qga$(EXESUF): tests/test-qga.o tests/qtest/libqtest.o $(test-util-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 
@@ -440,14 +427,6 @@ define do_test_tap
 	  "TAP","$@")
 endef
 
-.PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
-$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(check-qtest-y)
-	$(call do_test_human,$(check-qtest-$*-y:%=tests/qtest/%$(EXESUF)) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)), \
-	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
-	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
-
-build-qtest: $(patsubst %, %-softmmu/all, $(QTEST_TARGETS)) $(check-qtest-y)
-
 build-unit: $(check-unit-y)
 
 check-unit: $(check-unit-y)
@@ -458,18 +437,9 @@ check-speed: $(check-speed-y)
 
 # gtester tests with TAP output
 
-$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: %-softmmu/all $(check-qtest-y)
-	$(call do_test_tap, $(check-qtest-$*-y:%=tests/qtest/%$(EXESUF)) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)), \
-	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
-	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
-
 check-report-unit.tap: $(check-unit-y)
 	$(call do_test_tap,$^)
 
-# Reports and overall runs
-
-check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
-
 # Plugins
 ifeq ($(CONFIG_PLUGIN),y)
 .PHONY: plugins
@@ -580,19 +550,16 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 
 # Consolidated targets
 
-.PHONY: check-block check-qtest check-unit check check-clean get-vm-images
-check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
+.PHONY: check-block check-unit check check-clean get-vm-images
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
 endif
-check-build: build-unit build-qtest
+check-build: build-unit
 
-check: check-block check-unit check-qtest
+check: check-block check-unit
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
-	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
 	rm -f tests/test-qapi-gen-timestamp
-	rm -f tests/qtest/dbus-vmstate1-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
 check: check-block check-qapi-schema check-unit check-qtest check-decodetree
@@ -604,7 +571,5 @@ clean: check-clean
 all: $(QEMU_IOTESTS_HELPERS-y)
 
 -include $(wildcard tests/*.d)
--include $(wildcard tests/qtest/*.d)
--include $(wildcard tests/qtest/libqos/*.d)
 
 endif
diff --git a/tests/meson.build b/tests/meson.build
index 8be9c2233c..d724402cf4 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -8,3 +8,4 @@ if 'CONFIG_TCG' in config_host
 endif
 
 subdir('qapi-schema')
+subdir('qtest')
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
deleted file mode 100644
index b0204e44f2..0000000000
--- a/tests/qtest/Makefile.include
+++ /dev/null
@@ -1,332 +0,0 @@
-# All QTests for now are POSIX-only, but the dependencies are
-# really in libqtest, not in the testcases themselves.
-
-check-qtest-generic-y += cdrom-test
-check-qtest-generic-y += device-introspect-test
-check-qtest-generic-y += machine-none-test
-check-qtest-generic-y += qmp-test
-check-qtest-generic-y += qmp-cmd-test
-check-qtest-generic-y += qom-test
-check-qtest-generic-$(CONFIG_MODULES) += modules-test
-check-qtest-generic-y += test-hmp
-
-check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
-check-qtest-pci-$(CONFIG_VGA) += display-vga-test
-check-qtest-pci-$(CONFIG_HDA) += intel-hda-test
-check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
-
-DBUS_DAEMON := $(shell which dbus-daemon 2>/dev/null)
-ifneq ($(GDBUS_CODEGEN),)
-ifneq ($(DBUS_DAEMON),)
-# Temporarily disabled due to Patchew failures:
-#check-qtest-pci-$(CONFIG_GIO) += dbus-vmstate-test
-endif
-endif
-
-check-qtest-i386-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-i386-y += fdc-test
-check-qtest-i386-y += ide-test
-check-qtest-i386-$(CONFIG_TOOLS) += ahci-test
-check-qtest-i386-y += hd-geo-test
-check-qtest-i386-y += boot-order-test
-check-qtest-i386-y += bios-tables-test
-check-qtest-i386-$(CONFIG_SGA) += boot-serial-test
-check-qtest-i386-$(CONFIG_SLIRP) += pxe-test
-check-qtest-i386-y += rtc-test
-check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += ipmi-kcs-test
-ifdef CONFIG_LINUX
-check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += ipmi-bt-test
-endif
-check-qtest-i386-y += i440fx-test
-check-qtest-i386-y += fw_cfg-test
-check-qtest-i386-y += device-plug-test
-check-qtest-i386-y += drive_del-test
-check-qtest-i386-$(CONFIG_WDT_IB700) += wdt_ib700-test
-check-qtest-i386-y += tco-test
-check-qtest-i386-y += $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_PVPANIC) += pvpanic-test
-check-qtest-i386-$(CONFIG_I82801B11) += i82801b11-test
-check-qtest-i386-$(CONFIG_IOH3420) += ioh3420-test
-check-qtest-i386-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
-check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) += usb-hcd-ehci-test
-check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
-check-qtest-i386-y += cpu-plug-test
-check-qtest-i386-y += q35-test
-check-qtest-i386-y += vmgenid-test
-check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-swtpm-test
-check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-test
-check-qtest-i386-$(CONFIG_TPM_TIS_ISA) += tpm-tis-swtpm-test
-check-qtest-i386-$(CONFIG_TPM_TIS_ISA) += tpm-tis-test
-check-qtest-i386-$(CONFIG_SLIRP) += test-netfilter
-check-qtest-i386-$(CONFIG_POSIX) += test-filter-mirror
-check-qtest-i386-$(CONFIG_RTL8139_PCI) += test-filter-redirector
-check-qtest-i386-y += migration-test
-check-qtest-i386-y += test-x86-cpuid-compat
-check-qtest-i386-y += numa-test
-
-check-qtest-x86_64-y += $(check-qtest-i386-y)
-
-check-qtest-avr-y += boot-serial-test
-
-check-qtest-alpha-y += boot-serial-test
-check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-hppa-y += boot-serial-test
-check-qtest-hppa-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-m68k-y = boot-serial-test
-
-check-qtest-microblaze-y += boot-serial-test
-
-check-qtest-mips-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-mips-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-mips64-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-mips64el-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-moxie-y += boot-serial-test
-
-check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-ppc-y += boot-order-test
-check-qtest-ppc-y += prom-env-test
-check-qtest-ppc-y += drive_del-test
-check-qtest-ppc-y += boot-serial-test
-check-qtest-ppc-$(CONFIG_M48T59) += m48t59-test
-
-check-qtest-ppc64-y += $(check-qtest-ppc-y)
-check-qtest-ppc64-$(CONFIG_PSERIES) += device-plug-test
-check-qtest-ppc64-$(CONFIG_POWERNV) += pnv-xscom-test
-check-qtest-ppc64-y += migration-test
-check-qtest-ppc64-$(CONFIG_PSERIES) += rtas-test
-check-qtest-ppc64-$(CONFIG_SLIRP) += pxe-test
-check-qtest-ppc64-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
-check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
-check-qtest-ppc64-$(CONFIG_SLIRP) += test-netfilter
-check-qtest-ppc64-$(CONFIG_POSIX) += test-filter-mirror
-check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += test-filter-redirector
-check-qtest-ppc64-$(CONFIG_VGA) += display-vga-test
-check-qtest-ppc64-y += numa-test
-check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
-check-qtest-ppc64-y += cpu-plug-test
-
-check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = endianness-test
-
-check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = endianness-test
-
-check-qtest-sparc-y += prom-env-test
-check-qtest-sparc-y += m48t59-test
-check-qtest-sparc-y += boot-serial-test
-
-check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-sparc64-y += prom-env-test
-check-qtest-sparc64-y += boot-serial-test
-
-check-qtest-arm-y += arm-cpu-features
-check-qtest-arm-y += microbit-test
-check-qtest-arm-y += m25p80-test
-check-qtest-arm-y += test-arm-mptimer
-check-qtest-arm-y += boot-serial-test
-check-qtest-arm-y += hexloader-test
-check-qtest-arm-$(CONFIG_PFLASH_CFI02) += pflash-cfi02-test
-
-check-qtest-aarch64-y += arm-cpu-features
-check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) += tpm-tis-device-test
-check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) += tpm-tis-device-swtpm-test
-check-qtest-aarch64-y += numa-test
-check-qtest-aarch64-y += boot-serial-test
-check-qtest-aarch64-y += migration-test
-
-# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
-ifneq ($(ARCH),arm)
-check-qtest-aarch64-y += bios-tables-test
-endif
-
-check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
-
-check-qtest-xtensaeb-y += $(check-qtest-xtensa-y)
-
-check-qtest-s390x-y = boot-serial-test
-check-qtest-s390x-$(CONFIG_SLIRP) += pxe-test
-check-qtest-s390x-$(CONFIG_SLIRP) += test-netfilter
-check-qtest-s390x-$(CONFIG_POSIX) += test-filter-mirror
-check-qtest-s390x-$(CONFIG_POSIX) += test-filter-redirector
-check-qtest-s390x-y += drive_del-test
-check-qtest-s390x-y += device-plug-test
-check-qtest-s390x-y += virtio-ccw-test
-check-qtest-s390x-y += cpu-plug-test
-check-qtest-s390x-y += migration-test
-
-# libqos / qgraph :
-libqgraph-obj-y = tests/qtest/libqos/qgraph.o
-
-libqos-core-obj-y = $(libqgraph-obj-y) tests/qtest/libqos/pci.o tests/qtest/libqos/fw_cfg.o
-libqos-core-obj-y += tests/qtest/libqos/malloc.o
-libqos-core-obj-y += tests/qtest/libqos/libqos.o
-libqos-spapr-obj-y = $(libqos-core-obj-y) tests/qtest/libqos/malloc-spapr.o
-libqos-spapr-obj-y += tests/qtest/libqos/libqos-spapr.o
-libqos-spapr-obj-y += tests/qtest/libqos/rtas.o
-libqos-spapr-obj-y += tests/qtest/libqos/pci-spapr.o
-libqos-pc-obj-y = $(libqos-core-obj-y) tests/qtest/libqos/pci-pc.o
-libqos-pc-obj-y += tests/qtest/libqos/malloc-pc.o tests/qtest/libqos/libqos-pc.o
-libqos-pc-obj-y += tests/qtest/libqos/ahci.o
-libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/qtest/libqos/usb.o
-
-# qos devices:
-libqos-obj-y =  $(libqgraph-obj-y)
-libqos-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-libqos-obj-y += tests/qtest/libqos/qos_external.o
-libqos-obj-y += tests/qtest/libqos/e1000e.o
-libqos-obj-y += tests/qtest/libqos/i2c.o
-libqos-obj-y += tests/qtest/libqos/i2c-imx.o
-libqos-obj-y += tests/qtest/libqos/i2c-omap.o
-libqos-obj-y += tests/qtest/libqos/sdhci.o
-libqos-obj-y += tests/qtest/libqos/tpci200.o
-libqos-obj-y += tests/qtest/libqos/virtio.o
-libqos-obj-$(CONFIG_VIRTFS) += tests/qtest/libqos/virtio-9p.o
-libqos-obj-y += tests/qtest/libqos/virtio-balloon.o
-libqos-obj-y += tests/qtest/libqos/virtio-blk.o
-libqos-obj-y += tests/qtest/libqos/virtio-mmio.o
-libqos-obj-y += tests/qtest/libqos/virtio-net.o
-libqos-obj-y += tests/qtest/libqos/virtio-pci.o
-libqos-obj-y += tests/qtest/libqos/virtio-pci-modern.o
-libqos-obj-y += tests/qtest/libqos/virtio-rng.o
-libqos-obj-y += tests/qtest/libqos/virtio-scsi.o
-libqos-obj-y += tests/qtest/libqos/virtio-serial.o
-
-# qos machines:
-libqos-obj-y += tests/qtest/libqos/aarch64-xlnx-zcu102-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-imx25-pdk-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-n800-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-raspi2-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-sabrelite-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-smdkc210-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-virt-machine.o
-libqos-obj-y += tests/qtest/libqos/arm-xilinx-zynq-a9-machine.o
-libqos-obj-y += tests/qtest/libqos/ppc64_pseries-machine.o
-libqos-obj-y += tests/qtest/libqos/x86_64_pc-machine.o
-
-# qos tests:
-qos-test-obj-y += tests/qtest/qos-test.o
-qos-test-obj-y += tests/qtest/ac97-test.o
-qos-test-obj-y += tests/qtest/ds1338-test.o
-qos-test-obj-y += tests/qtest/e1000-test.o
-qos-test-obj-y += tests/qtest/e1000e-test.o
-qos-test-obj-y += tests/qtest/eepro100-test.o
-qos-test-obj-y += tests/qtest/es1370-test.o
-qos-test-obj-y += tests/qtest/ipoctal232-test.o
-qos-test-obj-y += tests/qtest/megasas-test.o
-qos-test-obj-y += tests/qtest/ne2000-test.o
-qos-test-obj-y += tests/qtest/tulip-test.o
-qos-test-obj-y += tests/qtest/nvme-test.o
-qos-test-obj-y += tests/qtest/pca9552-test.o
-qos-test-obj-y += tests/qtest/pci-test.o
-qos-test-obj-y += tests/qtest/pcnet-test.o
-qos-test-obj-y += tests/qtest/sdhci-test.o
-qos-test-obj-y += tests/qtest/spapr-phb-test.o
-qos-test-obj-y += tests/qtest/tmp105-test.o
-qos-test-obj-y += tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
-qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/qtest/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
-qos-test-obj-y += tests/qtest/virtio-test.o
-qos-test-obj-$(CONFIG_VIRTFS) += tests/qtest/virtio-9p-test.o
-qos-test-obj-y += tests/qtest/virtio-blk-test.o
-qos-test-obj-y += tests/qtest/virtio-net-test.o
-qos-test-obj-y += tests/qtest/virtio-rng-test.o
-qos-test-obj-y += tests/qtest/virtio-scsi-test.o
-qos-test-obj-y += tests/qtest/virtio-serial-test.o
-qos-test-obj-y += tests/qtest/vmxnet3-test.o
-
-check-unit-y += tests/test-qgraph$(EXESUF)
-tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
-
-check-qtest-generic-y += qos-test
-tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
-
-# QTest dependencies:
-tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
-tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
-tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-introspect-test.o
-tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
-tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
-tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
-tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
-tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
-tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-obj-y)
-tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj-y)
-tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
-tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
-tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
-tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
-tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
-tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y)
-tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libqos-obj-y)
-tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(libqos-obj-y)
-tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
-        tests/qtest/tpm-emu.o $(test-io-obj-y) \
-	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
-tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
-tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
-tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
-tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-obj-y)
-tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
-tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-obj-y)
-tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-obj-y)
-tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
-tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
-tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
-tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
-tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
-tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
-tests/qtest/modules-test$(EXESUF): tests/qtest/modules-test.o
-tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
-tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
-tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
-tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
-tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
-tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
-tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
-tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
-tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
-tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
-tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
-tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
-tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o tests/qtest/migration-helpers.o
-tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-obj-y)
-tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o $(qtest-obj-y)
-tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redirector.o $(qtest-obj-y)
-tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-compat.o $(qtest-obj-y)
-tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test.o tests/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
-tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
-tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/boot-sector.o tests/qtest/acpi-utils.o
-tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
-tests/qtest/arm-cpu-features$(EXESUF): tests/qtest/arm-cpu-features.o
-tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-test.o tests/qtest/tpm-emu.o \
-	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtest/tpm-emu.o $(test-io-obj-y)
-tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o tests/qtest/tpm-emu.o \
-	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-tis-device-swtpm-test$(EXESUF): tests/qtest/tpm-tis-device-swtpm-test.o tests/qtest/tpm-emu.o \
-	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
-tests/qtest/tpm-tis-device-test$(EXESUF): tests/qtest/tpm-tis-device-test.o tests/qtest/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
-
-# QTest rules
-
-TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
-QTEST_TARGETS =
-# The qtests are not runnable (yet) under TSan due to a known issue.
-# https://github.com/google/sanitizers/issues/1116
-ifndef CONFIG_TSAN
-ifeq ($(CONFIG_POSIX),y)
-QTEST_TARGETS = $(TARGETS)
-check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=tests/qtest/%$(EXESUF)))
-check-qtest-y += $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF))
-endif
-endif
-
-qtest-obj-y = tests/qtest/libqtest.o $(test-util-obj-y)
-$(check-qtest-y): $(qtest-obj-y)
diff --git a/tests/qtest/ac97-test.c b/tests/qtest/ac97-test.c
index b084e31bff..e09f2495d2 100644
--- a/tests/qtest/ac97-test.c
+++ b/tests/qtest/ac97-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/acpi-utils.h b/tests/qtest/acpi-utils.h
index 0c86780689..261784d251 100644
--- a/tests/qtest/acpi-utils.h
+++ b/tests/qtest/acpi-utils.h
@@ -13,7 +13,7 @@
 #ifndef TEST_ACPI_UTILS_H
 #define TEST_ACPI_UTILS_H
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 /* DSDT and SSDTs format */
 typedef struct {
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index c8d42ceea0..ca4294f44f 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/libqos-pc.h"
 #include "libqos/ahci.h"
 #include "libqos/pci-pc.h"
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index f7e062c189..77b5e30a9c 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -10,7 +10,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 
diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
index 2f1c07221c..fac580d6c4 100644
--- a/tests/qtest/boot-order-test.c
+++ b/tests/qtest/boot-order-test.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "libqos/fw_cfg.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 
diff --git a/tests/qtest/boot-sector.c b/tests/qtest/boot-sector.c
index 9e66c6d013..24df5c4734 100644
--- a/tests/qtest/boot-sector.c
+++ b/tests/qtest/boot-sector.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "boot-sector.h"
 #include "qemu-common.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 #define LOW(x) ((x) & 0xff)
 #define HIGH(x) ((x) >> 8)
diff --git a/tests/qtest/boot-sector.h b/tests/qtest/boot-sector.h
index 6ee6bb4d97..b339fdee4c 100644
--- a/tests/qtest/boot-sector.h
+++ b/tests/qtest/boot-sector.h
@@ -14,7 +14,7 @@
 #ifndef TEST_BOOT_SECTOR_H
 #define TEST_BOOT_SECTOR_H
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 /* Create boot disk file. fname must be a suitable string for mkstemp() */
 int boot_sector_init(char *fname);
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index bfe7624dc6..b6b1c23cd0 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/libqos-spapr.h"
 
 static const uint8_t bios_avr[] = {
diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 833a0508a1..e9afab693c 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "boot-sector.h"
 #include "qapi/qmp/qdict.h"
 
diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 2e5e47dec2..aca9b98b7a 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include <gio/gio.h>
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu-common.h"
 #include "dbus-vmstate1.h"
 #include "migration-helpers.h"
diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index d68b7856a7..9f22340ee5 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -22,7 +22,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index 318e422d51..9214892741 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 5f8839b232..2ab11ad225 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/virtio.h"
 #include "qapi/qmp/qdict.h"
 
diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index f6ade9a050..c5d46bcc64 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/i2c.h"
 
 #define DS1338_ADDR 0x68
diff --git a/tests/qtest/e1000-test.c b/tests/qtest/e1000-test.c
index c387984ef6..ea286d1793 100644
--- a/tests/qtest/e1000-test.c
+++ b/tests/qtest/e1000-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/eepro100-test.c b/tests/qtest/eepro100-test.c
index 8dbffff0b8..d72ad099f1 100644
--- a/tests/qtest/eepro100-test.c
+++ b/tests/qtest/eepro100-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
index cc088ac01a..4e79e22c28 100644
--- a/tests/qtest/endianness-test.c
+++ b/tests/qtest/endianness-test.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/bswap.h"
 
 typedef struct TestCase TestCase;
diff --git a/tests/qtest/es1370-test.c b/tests/qtest/es1370-test.c
index adccdac1be..2fd7fd2d3d 100644
--- a/tests/qtest/es1370-test.c
+++ b/tests/qtest/es1370-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 031594a686..1ceea84702 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -20,7 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
-#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/libqtest.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "fuzz.h"
 
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 9ca3d107c5..8eb765edc8 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -18,7 +18,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 
-#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/libqtest.h"
 
 /**
  * A libfuzzer fuzzing target
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index bf966d478b..f45373f5d3 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/main-loop.h"
-#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/libqtest.h"
 #include "tests/qtest/libqos/pci.h"
 #include "tests/qtest/libqos/pci-pc.h"
 #include "fuzz.h"
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index d52f3ebd83..b943577b8c 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -25,7 +25,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
 
-#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/libqtest.h"
 #include "tests/qtest/libqos/malloc.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "tests/qtest/libqos/qgraph_internal.h"
diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index a33bd73067..277a9e2b64 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 
 #include "standard-headers/linux/virtio_config.h"
-#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/libqtest.h"
 #include "tests/qtest/libqos/virtio-net.h"
 #include "fuzz.h"
 #include "fork_fuzz.h"
diff --git a/tests/qtest/fw_cfg-test.c b/tests/qtest/fw_cfg-test.c
index 5dc807ba23..95b3907c18 100644
--- a/tests/qtest/fw_cfg-test.c
+++ b/tests/qtest/fw_cfg-test.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "libqos/fw_cfg.h"
 #include "qemu/bswap.h"
diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index 48e8e02d6e..f7b7cfbc2d 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -19,7 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "qapi/qmp/qlist.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/fw_cfg.h"
 #include "libqos/libqos.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
diff --git a/tests/qtest/hexloader-test.c b/tests/qtest/hexloader-test.c
index 8b7aa2d72d..561502052a 100644
--- a/tests/qtest/hexloader-test.c
+++ b/tests/qtest/hexloader-test.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 /* Load 'test.hex' and verify that the in-memory contents are as expected.
  * 'test.hex' is a memory test pattern stored in Hexadecimal Object
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 5cfd97f915..3f8081e77d 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/malloc-pc.h"
diff --git a/tests/qtest/ipoctal232-test.c b/tests/qtest/ipoctal232-test.c
index 53a8c9b13c..65ce10b81b 100644
--- a/tests/qtest/ipoctal232-test.c
+++ b/tests/qtest/ipoctal232-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 
diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
index ecda256472..d5c8b9f128 100644
--- a/tests/qtest/ivshmem-test.c
+++ b/tests/qtest/ivshmem-test.c
@@ -13,7 +13,7 @@
 #include "contrib/ivshmem-server/ivshmem-server.h"
 #include "libqos/libqos-pc.h"
 #include "libqos/libqos-spapr.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu-common.h"
 
 #define TMPSHMSIZE (1 << 20)
diff --git a/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c b/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
index 8f827aeb52..79631cc7a9 100644
--- a/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
+++ b/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "sdhci.h"
 
 typedef struct QXlnxZCU102Machine QXlnxZCU102Machine;
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index cc1b08eabe..2946abc15a 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -25,8 +25,8 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
-#include "libqos/ahci.h"
-#include "libqos/pci-pc.h"
+#include "ahci.h"
+#include "pci-pc.h"
 
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
@@ -579,7 +579,7 @@ void ahci_write_fis(AHCIQState *ahci, AHCICommand *cmd)
     /* NCQ commands use exclusively 8 bit fields and needs no adjustment.
      * Only the count field needs to be adjusted for non-NCQ commands.
      * The auxiliary FIS fields are defined per-command and are not currently
-     * implemented in libqos/ahci.o, but may or may not need to be flipped. */
+     * implemented in ahci.o, but may or may not need to be flipped. */
     if (!cmd->props->ncq) {
         tmp.count = cpu_to_le16(tmp.count);
     }
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 44ab1104b5..88835b6228 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -25,9 +25,9 @@
  * THE SOFTWARE.
  */
 
-#include "libqos/libqos.h"
-#include "libqos/pci.h"
-#include "libqos/malloc-pc.h"
+#include "libqos.h"
+#include "pci.h"
+#include "malloc-pc.h"
 
 /*** Supplementary PCI Config Space IDs & Masks ***/
 #define PCI_DEVICE_ID_INTEL_Q35_AHCI   (0x2922)
diff --git a/tests/qtest/libqos/arm-imx25-pdk-machine.c b/tests/qtest/libqos/arm-imx25-pdk-machine.c
index 0da3f19c0e..6692adfa4f 100644
--- a/tests/qtest/libqos/arm-imx25-pdk-machine.c
+++ b/tests/qtest/libqos/arm-imx25-pdk-machine.c
@@ -20,9 +20,9 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
-#include "libqos/i2c.h"
+#include "malloc.h"
+#include "qgraph.h"
+#include "i2c.h"
 
 #define ARM_PAGE_SIZE            4096
 #define IMX25_PDK_RAM_START      0x80000000
diff --git a/tests/qtest/libqos/arm-n800-machine.c b/tests/qtest/libqos/arm-n800-machine.c
index 35f82070fa..ff2049c3a7 100644
--- a/tests/qtest/libqos/arm-n800-machine.c
+++ b/tests/qtest/libqos/arm-n800-machine.c
@@ -20,9 +20,9 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
-#include "libqos/i2c.h"
+#include "malloc.h"
+#include "qgraph.h"
+#include "i2c.h"
 
 #define ARM_PAGE_SIZE            4096
 #define N800_RAM_START      0x80000000
diff --git a/tests/qtest/libqos/arm-raspi2-machine.c b/tests/qtest/libqos/arm-raspi2-machine.c
index 8480d80669..35bb4709a4 100644
--- a/tests/qtest/libqos/arm-raspi2-machine.c
+++ b/tests/qtest/libqos/arm-raspi2-machine.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "sdhci.h"
 
 #define ARM_PAGE_SIZE             4096
diff --git a/tests/qtest/libqos/arm-sabrelite-machine.c b/tests/qtest/libqos/arm-sabrelite-machine.c
index f6e403b538..72425f0ad4 100644
--- a/tests/qtest/libqos/arm-sabrelite-machine.c
+++ b/tests/qtest/libqos/arm-sabrelite-machine.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "sdhci.h"
 
 #define ARM_PAGE_SIZE            4096
diff --git a/tests/qtest/libqos/arm-smdkc210-machine.c b/tests/qtest/libqos/arm-smdkc210-machine.c
index eebac7feeb..321b8826d4 100644
--- a/tests/qtest/libqos/arm-smdkc210-machine.c
+++ b/tests/qtest/libqos/arm-smdkc210-machine.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "sdhci.h"
 
 #define ARM_PAGE_SIZE             4096
diff --git a/tests/qtest/libqos/arm-virt-machine.c b/tests/qtest/libqos/arm-virt-machine.c
index 9316598f9e..e0f5932284 100644
--- a/tests/qtest/libqos/arm-virt-machine.c
+++ b/tests/qtest/libqos/arm-virt-machine.c
@@ -19,9 +19,9 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-mmio.h"
+#include "malloc.h"
+#include "qgraph.h"
+#include "virtio-mmio.h"
 
 #define ARM_PAGE_SIZE               4096
 #define VIRTIO_MMIO_BASE_ADDR       0x0A003E00
diff --git a/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c b/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
index 473acce993..56e53c745b 100644
--- a/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
+++ b/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "sdhci.h"
 
 typedef struct QXilinxZynqA9Machine QXilinxZynqA9Machine;
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
index e2927ed2da..a451f6168f 100644
--- a/tests/qtest/libqos/e1000e.c
+++ b/tests/qtest/libqos/e1000e.c
@@ -18,13 +18,13 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/pci-pc.h"
+#include "pci-pc.h"
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "e1000e.h"
 
 #define E1000E_IMS      (0x00d0)
diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
index 35183b2875..a22f5fdbad 100644
--- a/tests/qtest/libqos/e1000e.h
+++ b/tests/qtest/libqos/e1000e.h
@@ -19,7 +19,7 @@
 #ifndef QGRAPH_E1000E_H
 #define QGRAPH_E1000E_H
 
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 #include "pci.h"
 
 #define E1000E_RX0_MSG_ID           (0)
diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 1f46258f96..6b8e1babe5 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqos/fw_cfg.h"
+#include "fw_cfg.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/tests/qtest/libqos/i2c-imx.c b/tests/qtest/libqos/i2c-imx.c
index f33ece55a3..8f9a7e3831 100644
--- a/tests/qtest/libqos/i2c-imx.c
+++ b/tests/qtest/libqos/i2c-imx.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqos/i2c.h"
+#include "i2c.h"
 
 
 #include "libqtest.h"
diff --git a/tests/qtest/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-omap.c
index 9ae8214fa8..eb4e453485 100644
--- a/tests/qtest/libqos/i2c-omap.c
+++ b/tests/qtest/libqos/i2c-omap.c
@@ -7,7 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "libqos/i2c.h"
+#include "i2c.h"
 
 
 #include "qemu/bswap.h"
diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c
index 38f800dbab..ade1bdb40e 100644
--- a/tests/qtest/libqos/i2c.c
+++ b/tests/qtest/libqos/i2c.c
@@ -7,7 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "libqos/i2c.h"
+#include "i2c.h"
 #include "libqtest.h"
 
 void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h
index c65f087834..1341bac1c5 100644
--- a/tests/qtest/libqos/i2c.h
+++ b/tests/qtest/libqos/i2c.h
@@ -10,7 +10,7 @@
 #define LIBQOS_I2C_H
 
 #include "libqtest.h"
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 
 typedef struct I2CAdapter I2CAdapter;
 struct I2CAdapter {
diff --git a/tests/qtest/libqos/libqos-pc.c b/tests/qtest/libqos/libqos-pc.c
index d04abc548b..db420a596e 100644
--- a/tests/qtest/libqos/libqos-pc.c
+++ b/tests/qtest/libqos/libqos-pc.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
-#include "libqos/libqos-pc.h"
-#include "libqos/malloc-pc.h"
-#include "libqos/pci-pc.h"
+#include "libqos-pc.h"
+#include "malloc-pc.h"
+#include "pci-pc.h"
 
 static QOSOps qos_ops = {
     .alloc_init = pc_alloc_init,
diff --git a/tests/qtest/libqos/libqos-pc.h b/tests/qtest/libqos/libqos-pc.h
index a0e4c45516..1a9923ead4 100644
--- a/tests/qtest/libqos/libqos-pc.h
+++ b/tests/qtest/libqos/libqos-pc.h
@@ -1,7 +1,7 @@
 #ifndef LIBQOS_PC_H
 #define LIBQOS_PC_H
 
-#include "libqos/libqos.h"
+#include "libqos.h"
 
 QOSState *qtest_pc_vboot(const char *cmdline_fmt, va_list ap);
 QOSState *qtest_pc_boot(const char *cmdline_fmt, ...);
diff --git a/tests/qtest/libqos/libqos-spapr.c b/tests/qtest/libqos/libqos-spapr.c
index 8766d543ce..db0e87ba5c 100644
--- a/tests/qtest/libqos/libqos-spapr.c
+++ b/tests/qtest/libqos/libqos-spapr.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
-#include "libqos/libqos-spapr.h"
-#include "libqos/malloc-spapr.h"
-#include "libqos/pci-spapr.h"
+#include "libqos-spapr.h"
+#include "malloc-spapr.h"
+#include "pci-spapr.h"
 
 static QOSOps qos_ops = {
     .alloc_init = spapr_alloc_init,
diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
index 49bd72d20b..c61338917a 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -1,7 +1,7 @@
 #ifndef LIBQOS_SPAPR_H
 #define LIBQOS_SPAPR_H
 
-#include "libqos/libqos.h"
+#include "libqos.h"
 
 QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_list ap);
 QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index f229eb2cb8..2251e864ef 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -2,8 +2,8 @@
 #include <sys/wait.h>
 
 #include "libqtest.h"
-#include "libqos/libqos.h"
-#include "libqos/pci.h"
+#include "libqos.h"
+#include "pci.h"
 #include "qapi/qmp/qdict.h"
 
 /*** Test Setup & Teardown ***/
diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h
index 8e971c25a3..e0b2bfe7ca 100644
--- a/tests/qtest/libqos/libqos.h
+++ b/tests/qtest/libqos/libqos.h
@@ -2,8 +2,8 @@
 #define LIBQOS_H
 
 #include "libqtest.h"
-#include "libqos/pci.h"
-#include "libqos/malloc.h"
+#include "pci.h"
+#include "malloc.h"
 
 typedef struct QOSState QOSState;
 
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqos/libqtest.h
similarity index 100%
rename from tests/qtest/libqtest.h
rename to tests/qtest/libqos/libqtest.h
diff --git a/tests/qtest/libqos/malloc-pc.c b/tests/qtest/libqos/malloc-pc.c
index 6f92ce4135..16ff9609cc 100644
--- a/tests/qtest/libqos/malloc-pc.c
+++ b/tests/qtest/libqos/malloc-pc.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqos/malloc-pc.h"
-#include "libqos/fw_cfg.h"
+#include "malloc-pc.h"
+#include "fw_cfg.h"
 
 #include "standard-headers/linux/qemu_fw_cfg.h"
 
diff --git a/tests/qtest/libqos/malloc-pc.h b/tests/qtest/libqos/malloc-pc.h
index 21e75ae004..d8d79853c8 100644
--- a/tests/qtest/libqos/malloc-pc.h
+++ b/tests/qtest/libqos/malloc-pc.h
@@ -13,7 +13,7 @@
 #ifndef LIBQOS_MALLOC_PC_H
 #define LIBQOS_MALLOC_PC_H
 
-#include "libqos/malloc.h"
+#include "malloc.h"
 
 void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts flags);
 
diff --git a/tests/qtest/libqos/malloc-spapr.c b/tests/qtest/libqos/malloc-spapr.c
index 2a6b7e3776..84862e4876 100644
--- a/tests/qtest/libqos/malloc-spapr.c
+++ b/tests/qtest/libqos/malloc-spapr.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqos/malloc-spapr.h"
+#include "malloc-spapr.h"
 
 #include "qemu-common.h"
 
diff --git a/tests/qtest/libqos/malloc-spapr.h b/tests/qtest/libqos/malloc-spapr.h
index e5fe9bfc4b..f99572fd71 100644
--- a/tests/qtest/libqos/malloc-spapr.h
+++ b/tests/qtest/libqos/malloc-spapr.h
@@ -8,7 +8,7 @@
 #ifndef LIBQOS_MALLOC_SPAPR_H
 #define LIBQOS_MALLOC_SPAPR_H
 
-#include "libqos/malloc.h"
+#include "malloc.h"
 
 void spapr_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts flags);
 
diff --git a/tests/qtest/libqos/malloc.c b/tests/qtest/libqos/malloc.c
index 615422a5c4..f708b01432 100644
--- a/tests/qtest/libqos/malloc.c
+++ b/tests/qtest/libqos/malloc.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqos/malloc.h"
+#include "malloc.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
 
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
new file mode 100644
index 0000000000..19931b9248
--- /dev/null
+++ b/tests/qtest/libqos/meson.build
@@ -0,0 +1,57 @@
+libqos = static_library('qos',
+  files('../libqtest.c',
+        'qgraph.c',
+        'qos_external.c',
+        'pci.c',
+        'fw_cfg.c',
+        'malloc.c',
+        'libqos.c',
+
+        # spapr
+        'malloc-spapr.c',
+        'libqos-spapr.c',
+        'rtas.c',
+        'pci-spapr.c',
+
+        # pc
+        'pci-pc.c',
+        'malloc-pc.c',
+        'libqos-pc.c',
+        'ahci.c',
+
+        # usb
+        'usb.c',
+
+        # qgraph devices:
+        'e1000e.c',
+        'i2c.c',
+        'i2c-imx.c',
+        'i2c-omap.c',
+        'sdhci.c',
+        'tpci200.c',
+        'virtio.c',
+        'virtio-9p.c',
+        'virtio-balloon.c',
+        'virtio-blk.c',
+        'virtio-mmio.c',
+        'virtio-net.c',
+        'virtio-pci.c',
+        'virtio-pci-modern.c',
+        'virtio-rng.c',
+        'virtio-scsi.c',
+        'virtio-serial.c',
+
+        # qgraph machines:
+        'aarch64-xlnx-zcu102-machine.c',
+        'arm-imx25-pdk-machine.c',
+        'arm-n800-machine.c',
+        'arm-raspi2-machine.c',
+        'arm-sabrelite-machine.c',
+        'arm-smdkc210-machine.c',
+        'arm-virt-machine.c',
+        'arm-xilinx-zynq-a9-machine.c',
+        'ppc64_pseries-machine.c',
+        'x86_64_pc-machine.c',
+), build_by_default: false)
+
+qos = declare_dependency(link_whole: libqos)
diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 3bb2eb3ba8..f97844289f 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/pci-pc.h"
+#include "pci-pc.h"
 #include "qapi/qmp/qdict.h"
 #include "hw/pci/pci_regs.h"
 
diff --git a/tests/qtest/libqos/pci-pc.h b/tests/qtest/libqos/pci-pc.h
index 4690005232..49ec9507f2 100644
--- a/tests/qtest/libqos/pci-pc.h
+++ b/tests/qtest/libqos/pci-pc.h
@@ -13,9 +13,9 @@
 #ifndef LIBQOS_PCI_PC_H
 #define LIBQOS_PCI_PC_H
 
-#include "libqos/pci.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "pci.h"
+#include "malloc.h"
+#include "qgraph.h"
 
 typedef struct QPCIBusPC {
     QOSGraphObject obj;
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index d6f8c01cb7..262226985f 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -7,9 +7,9 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/pci-spapr.h"
-#include "libqos/rtas.h"
-#include "libqos/qgraph.h"
+#include "pci-spapr.h"
+#include "rtas.h"
+#include "qgraph.h"
 
 #include "hw/pci/pci_regs.h"
 
diff --git a/tests/qtest/libqos/pci-spapr.h b/tests/qtest/libqos/pci-spapr.h
index d9e25631c6..20a43718b7 100644
--- a/tests/qtest/libqos/pci-spapr.h
+++ b/tests/qtest/libqos/pci-spapr.h
@@ -8,9 +8,9 @@
 #ifndef LIBQOS_PCI_SPAPR_H
 #define LIBQOS_PCI_SPAPR_H
 
-#include "libqos/malloc.h"
-#include "libqos/pci.h"
-#include "libqos/qgraph.h"
+#include "malloc.h"
+#include "pci.h"
+#include "qgraph.h"
 
 /* From include/hw/pci-host/spapr.h */
 
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 2309a724e4..e1e96189c8 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqos/pci.h"
+#include "pci.h"
 
 #include "hw/pci/pci_regs.h"
 #include "qemu/host-utils.h"
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 
 void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
                          void (*func)(QPCIDevice *dev, int devfn, void *data),
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 590c175190..ee64fdecbd 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -14,7 +14,7 @@
 #define LIBQOS_PCI_H
 
 #include "libqtest.h"
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 
 #define QPCI_PIO_LIMIT    0x10000
 
diff --git a/tests/qtest/libqos/ppc64_pseries-machine.c b/tests/qtest/libqos/ppc64_pseries-machine.c
index 5d7bd88f2f..24ca179976 100644
--- a/tests/qtest/libqos/ppc64_pseries-machine.c
+++ b/tests/qtest/libqos/ppc64_pseries-machine.c
@@ -18,10 +18,10 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 #include "pci-spapr.h"
 #include "qemu/module.h"
-#include "libqos/malloc-spapr.h"
+#include "malloc-spapr.h"
 
 typedef struct QSPAPR_pci_host QSPAPR_pci_host;
 typedef struct Qppc64_pseriesMachine Qppc64_pseriesMachine;
diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index eb0af8ab4a..fc49cfa879 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/queue.h"
-#include "libqos/qgraph_internal.h"
-#include "libqos/qgraph.h"
+#include "qgraph_internal.h"
+#include "qgraph.h"
 
 #define QGRAPH_PRINT_DEBUG 0
 #define QOS_ROOT ""
diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index db1244eb59..10543269ce 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -106,7 +106,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
  * <example>
  *   <title>Creating new driver an its interface</title>
  *   <programlisting>
- #include "libqos/qgraph.h"
+ #include "qgraph.h"
 
  struct My_driver {
      QOSGraphObject obj;
@@ -190,7 +190,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
  * <example>
  *   <title>Creating new test</title>
  *   <programlisting>
- * #include "libqos/qgraph.h"
+ * #include "qgraph.h"
  *
  * static void my_test_function(void *obj, void *data)
  * {
@@ -230,7 +230,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
  * a valid test path will be:
  * "/x86_64/pc/other_node/my_driver/my_interface/my_test".
  *
- * Additional examples are also in libqos/test-qgraph.c
+ * Additional examples are also in test-qgraph.c
  *
  * Command line:
  * Command line is built by using node names and optional arguments
diff --git a/tests/qtest/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_internal.h
index aa3123f0f2..968fa69450 100644
--- a/tests/qtest/libqos/qgraph_internal.h
+++ b/tests/qtest/libqos/qgraph_internal.h
@@ -20,11 +20,11 @@
 #define QGRAPH_INTERNAL_H
 
 /* This header is declaring additional helper functions defined in
- * libqos/qgraph.c
+ * qgraph.c
  * It should not be included in tests
  */
 
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 
 typedef struct QOSGraphMachine QOSGraphMachine;
 typedef enum QOSEdgeType QOSEdgeType;
diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_external.c
index 0dfc05cfb6..10ee0f75b2 100644
--- a/tests/qtest/libqos/qos_external.c
+++ b/tests/qtest/libqos/qos_external.c
@@ -24,10 +24,10 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/module.h"
 #include "qapi/qmp/qlist.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
-#include "libqos/qgraph_internal.h"
-#include "libqos/qos_external.h"
+#include "malloc.h"
+#include "qgraph.h"
+#include "qgraph_internal.h"
+#include "qos_external.h"
 
 static void machine_apply_to_node(const char *name)
 {
diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_external.h
index 56a2f37fde..8446e3df0b 100644
--- a/tests/qtest/libqos/qos_external.h
+++ b/tests/qtest/libqos/qos_external.h
@@ -19,7 +19,9 @@
 #ifndef QOS_EXTERNAL_H
 #define QOS_EXTERNAL_H
 
-#include "libqos/malloc.h"
+#include "qgraph.h"
+
+#include "malloc.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-qom.h"
 
diff --git a/tests/qtest/libqos/rtas.c b/tests/qtest/libqos/rtas.c
index d81ff4274d..db29d5554d 100644
--- a/tests/qtest/libqos/rtas.c
+++ b/tests/qtest/libqos/rtas.c
@@ -5,7 +5,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/rtas.h"
+#include "rtas.h"
 
 static void qrtas_copy_args(QTestState *qts, uint64_t target_args,
                             uint32_t nargs, uint32_t *args)
diff --git a/tests/qtest/libqos/rtas.h b/tests/qtest/libqos/rtas.h
index 459e23aaf4..f38f99dfab 100644
--- a/tests/qtest/libqos/rtas.h
+++ b/tests/qtest/libqos/rtas.h
@@ -5,7 +5,7 @@
 
 #ifndef LIBQOS_RTAS_H
 #define LIBQOS_RTAS_H
-#include "libqos/malloc.h"
+#include "malloc.h"
 
 int qrtas_get_time_of_day(QTestState *qts, QGuestAllocator *alloc,
                           struct tm *tm, uint32_t *ns);
diff --git a/tests/qtest/libqos/sdhci.c b/tests/qtest/libqos/sdhci.c
index fbf2e36aec..65f0d07fc5 100644
--- a/tests/qtest/libqos/sdhci.c
+++ b/tests/qtest/libqos/sdhci.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 #include "pci.h"
 #include "qemu/module.h"
 #include "sdhci.h"
diff --git a/tests/qtest/libqos/sdhci.h b/tests/qtest/libqos/sdhci.h
index 1acd3096e2..22d647b1fd 100644
--- a/tests/qtest/libqos/sdhci.h
+++ b/tests/qtest/libqos/sdhci.h
@@ -19,7 +19,7 @@
 #ifndef QGRAPH_QSDHCI_H
 #define QGRAPH_QSDHCI_H
 
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 #include "pci.h"
 
 typedef struct QSDHCI QSDHCI;
diff --git a/tests/qtest/libqos/tpci200.c b/tests/qtest/libqos/tpci200.c
index ae590a456e..1787b1f188 100644
--- a/tests/qtest/libqos/tpci200.c
+++ b/tests/qtest/libqos/tpci200.c
@@ -10,8 +10,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/qgraph.h"
-#include "libqos/pci.h"
+#include "qgraph.h"
+#include "pci.h"
 
 typedef struct QTpci200 QTpci200;
 typedef struct QIpack QIpack;
diff --git a/tests/qtest/libqos/usb.c b/tests/qtest/libqos/usb.c
index d7a9cb3c72..8b45b02984 100644
--- a/tests/qtest/libqos/usb.c
+++ b/tests/qtest/libqos/usb.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "hw/usb/uhci-regs.h"
-#include "libqos/usb.h"
+#include "usb.h"
 
 void qusb_pci_init_one(QPCIBus *pcibus, struct qhc *hc, uint32_t devfn, int bar)
 {
diff --git a/tests/qtest/libqos/usb.h b/tests/qtest/libqos/usb.h
index eeced39a2f..50030d7fb1 100644
--- a/tests/qtest/libqos/usb.h
+++ b/tests/qtest/libqos/usb.h
@@ -1,7 +1,7 @@
 #ifndef LIBQOS_USB_H
 #define LIBQOS_USB_H
 
-#include "libqos/pci-pc.h"
+#include "pci-pc.h"
 
 struct qhc {
     QPCIDevice *dev;
diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index c87b56132a..2e300063e3 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -20,8 +20,8 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "libqos/virtio-9p.h"
-#include "libqos/qgraph.h"
+#include "virtio-9p.h"
+#include "qgraph.h"
 
 static QGuestAllocator *alloc;
 
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index be9621a5e3..b1e6badc4a 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_9P_H
 #define TESTS_LIBQOS_VIRTIO_9P_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtio9P QVirtio9P;
 typedef struct QVirtio9PPCI QVirtio9PPCI;
diff --git a/tests/qtest/libqos/virtio-balloon.c b/tests/qtest/libqos/virtio-balloon.c
index 9745f4a83c..a3da5c234d 100644
--- a/tests/qtest/libqos/virtio-balloon.c
+++ b/tests/qtest/libqos/virtio-balloon.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-balloon.h"
+#include "qgraph.h"
+#include "virtio-balloon.h"
 
 /* virtio-balloon-device */
 static void *qvirtio_balloon_get_driver(QVirtioBalloon *v_balloon,
diff --git a/tests/qtest/libqos/virtio-balloon.h b/tests/qtest/libqos/virtio-balloon.h
index 5b919303a6..309894c338 100644
--- a/tests/qtest/libqos/virtio-balloon.h
+++ b/tests/qtest/libqos/virtio-balloon.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_BALLOON_H
 #define TESTS_LIBQOS_VIRTIO_BALLOON_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtioBalloon QVirtioBalloon;
 typedef struct QVirtioBalloonPCI QVirtioBalloonPCI;
diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
index 5fc69401be..5da02591bc 100644
--- a/tests/qtest/libqos/virtio-blk.c
+++ b/tests/qtest/libqos/virtio-blk.c
@@ -20,8 +20,8 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "standard-headers/linux/virtio_blk.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-blk.h"
+#include "qgraph.h"
+#include "virtio-blk.h"
 
 #define PCI_SLOT                0x04
 #define PCI_FN                  0x00
diff --git a/tests/qtest/libqos/virtio-blk.h b/tests/qtest/libqos/virtio-blk.h
index 5170f13cfe..dcef38851e 100644
--- a/tests/qtest/libqos/virtio-blk.h
+++ b/tests/qtest/libqos/virtio-blk.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_BLK_H
 #define TESTS_LIBQOS_VIRTIO_BLK_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtioBlk QVirtioBlk;
 typedef struct QVirtioBlkPCI QVirtioBlkPCI;
diff --git a/tests/qtest/libqos/virtio-mmio.c b/tests/qtest/libqos/virtio-mmio.c
index e0a2bd7bc6..75efda3029 100644
--- a/tests/qtest/libqos/virtio-mmio.c
+++ b/tests/qtest/libqos/virtio-mmio.c
@@ -10,10 +10,10 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-mmio.h"
-#include "libqos/malloc.h"
-#include "libqos/qgraph.h"
+#include "virtio.h"
+#include "virtio-mmio.h"
+#include "malloc.h"
+#include "qgraph.h"
 #include "standard-headers/linux/virtio_ring.h"
 
 static uint8_t qvirtio_mmio_config_readb(QVirtioDevice *d, uint64_t off)
diff --git a/tests/qtest/libqos/virtio-mmio.h b/tests/qtest/libqos/virtio-mmio.h
index 0e45778b07..30803bc91c 100644
--- a/tests/qtest/libqos/virtio-mmio.h
+++ b/tests/qtest/libqos/virtio-mmio.h
@@ -10,8 +10,8 @@
 #ifndef LIBQOS_VIRTIO_MMIO_H
 #define LIBQOS_VIRTIO_MMIO_H
 
-#include "libqos/virtio.h"
-#include "libqos/qgraph.h"
+#include "virtio.h"
+#include "qgraph.h"
 
 #define QVIRTIO_MMIO_MAGIC_VALUE        0x000
 #define QVIRTIO_MMIO_VERSION            0x004
diff --git a/tests/qtest/libqos/virtio-net.c b/tests/qtest/libqos/virtio-net.c
index a9e253afe4..1cae07f60d 100644
--- a/tests/qtest/libqos/virtio-net.c
+++ b/tests/qtest/libqos/virtio-net.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-net.h"
+#include "qgraph.h"
+#include "virtio-net.h"
 #include "hw/virtio/virtio-net.h"
 
 
diff --git a/tests/qtest/libqos/virtio-net.h b/tests/qtest/libqos/virtio-net.h
index b8cbec04af..5ba2161de2 100644
--- a/tests/qtest/libqos/virtio-net.h
+++ b/tests/qtest/libqos/virtio-net.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_NET_H
 #define TESTS_LIBQOS_VIRTIO_NET_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtioNet QVirtioNet;
 typedef struct QVirtioNetPCI QVirtioNetPCI;
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 62851c29bb..cd3c0f5bf3 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -9,13 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
-#include "libqos/pci.h"
-#include "libqos/pci-pc.h"
-#include "libqos/malloc.h"
-#include "libqos/malloc-pc.h"
-#include "libqos/qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
+#include "pci.h"
+#include "pci-pc.h"
+#include "malloc.h"
+#include "malloc-pc.h"
+#include "qgraph.h"
 #include "standard-headers/linux/virtio_ring.h"
 #include "standard-headers/linux/virtio_pci.h"
 
diff --git a/tests/qtest/libqos/virtio-pci.h b/tests/qtest/libqos/virtio-pci.h
index 294d5567ee..f5115cacba 100644
--- a/tests/qtest/libqos/virtio-pci.h
+++ b/tests/qtest/libqos/virtio-pci.h
@@ -10,9 +10,9 @@
 #ifndef LIBQOS_VIRTIO_PCI_H
 #define LIBQOS_VIRTIO_PCI_H
 
-#include "libqos/virtio.h"
-#include "libqos/pci.h"
-#include "libqos/qgraph.h"
+#include "virtio.h"
+#include "pci.h"
+#include "qgraph.h"
 
 typedef struct QVirtioPCIMSIXOps QVirtioPCIMSIXOps;
 
diff --git a/tests/qtest/libqos/virtio-rng.c b/tests/qtest/libqos/virtio-rng.c
index 46f8d95b1f..2e09dd7c48 100644
--- a/tests/qtest/libqos/virtio-rng.c
+++ b/tests/qtest/libqos/virtio-rng.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-rng.h"
+#include "qgraph.h"
+#include "virtio-rng.h"
 
 /* virtio-rng-device */
 static void *qvirtio_rng_get_driver(QVirtioRng *v_rng,
diff --git a/tests/qtest/libqos/virtio-rng.h b/tests/qtest/libqos/virtio-rng.h
index 9342372efa..9ca102b599 100644
--- a/tests/qtest/libqos/virtio-rng.h
+++ b/tests/qtest/libqos/virtio-rng.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_RNG_H
 #define TESTS_LIBQOS_VIRTIO_RNG_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtioRng QVirtioRng;
 typedef struct QVirtioRngPCI QVirtioRngPCI;
diff --git a/tests/qtest/libqos/virtio-scsi.c b/tests/qtest/libqos/virtio-scsi.c
index c8c3598428..5644e32fc3 100644
--- a/tests/qtest/libqos/virtio-scsi.c
+++ b/tests/qtest/libqos/virtio-scsi.c
@@ -20,8 +20,8 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-scsi.h"
+#include "qgraph.h"
+#include "virtio-scsi.h"
 
 /* virtio-scsi-device */
 static void *qvirtio_scsi_get_driver(QVirtioSCSI *v_scsi,
diff --git a/tests/qtest/libqos/virtio-scsi.h b/tests/qtest/libqos/virtio-scsi.h
index 9e3774d99a..531315e6ad 100644
--- a/tests/qtest/libqos/virtio-scsi.h
+++ b/tests/qtest/libqos/virtio-scsi.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_SCSI_H
 #define TESTS_LIBQOS_VIRTIO_SCSI_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtioSCSI QVirtioSCSI;
 typedef struct QVirtioSCSIPCI QVirtioSCSIPCI;
diff --git a/tests/qtest/libqos/virtio-serial.c b/tests/qtest/libqos/virtio-serial.c
index b95654085d..ee34afd95a 100644
--- a/tests/qtest/libqos/virtio-serial.c
+++ b/tests/qtest/libqos/virtio-serial.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/module.h"
-#include "libqos/qgraph.h"
-#include "libqos/virtio-serial.h"
+#include "qgraph.h"
+#include "virtio-serial.h"
 
 static void *qvirtio_serial_get_driver(QVirtioSerial *v_serial,
                                        const char *interface)
diff --git a/tests/qtest/libqos/virtio-serial.h b/tests/qtest/libqos/virtio-serial.h
index 3328c6cf19..3db43b2bb8 100644
--- a/tests/qtest/libqos/virtio-serial.h
+++ b/tests/qtest/libqos/virtio-serial.h
@@ -19,9 +19,9 @@
 #ifndef TESTS_LIBQOS_VIRTIO_SERIAL_H
 #define TESTS_LIBQOS_VIRTIO_SERIAL_H
 
-#include "libqos/qgraph.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "qgraph.h"
+#include "virtio.h"
+#include "virtio-pci.h"
 
 typedef struct QVirtioSerial QVirtioSerial;
 typedef struct QVirtioSerialPCI QVirtioSerialPCI;
diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 9aa360620c..6fe7bf9555 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "libqtest.h"
-#include "libqos/virtio.h"
+#include "virtio.h"
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
 
diff --git a/tests/qtest/libqos/virtio.h b/tests/qtest/libqos/virtio.h
index 529ef7555a..b8bd06e1b8 100644
--- a/tests/qtest/libqos/virtio.h
+++ b/tests/qtest/libqos/virtio.h
@@ -10,7 +10,7 @@
 #ifndef LIBQOS_VIRTIO_H
 #define LIBQOS_VIRTIO_H
 
-#include "libqos/malloc.h"
+#include "malloc.h"
 #include "standard-headers/linux/virtio_ring.h"
 
 #define QVIRTIO_F_BAD_FEATURE           0x40000000ull
diff --git a/tests/qtest/libqos/x86_64_pc-machine.c b/tests/qtest/libqos/x86_64_pc-machine.c
index 0edb1c9144..ad96742a92 100644
--- a/tests/qtest/libqos/x86_64_pc-machine.c
+++ b/tests/qtest/libqos/x86_64_pc-machine.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/qgraph.h"
+#include "qgraph.h"
 #include "pci-pc.h"
 #include "qemu/module.h"
 #include "malloc-pc.h"
diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index 6f1bb1331c..176979a2ce 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -11,7 +11,7 @@
 #ifndef LIBQTEST_SINGLE_H
 #define LIBQTEST_SINGLE_H
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 QTestState *global_qtest __attribute__((common, weak));
 
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index fd4680590d..26f1223642 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -20,7 +20,7 @@
 #include <sys/wait.h>
 #include <sys/un.h>
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu-common.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index b94a1230f7..6db3234100 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 #define RTC_SECONDS             0x9
 #define RTC_MINUTES             0xa
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 57107f1aec..aab06b9fc2 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -14,7 +14,7 @@
 
 #include "qemu-common.h"
 #include "qemu/cutils.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 
 
diff --git a/tests/qtest/megasas-test.c b/tests/qtest/megasas-test.c
index d6796b9bd7..eae70ff95f 100644
--- a/tests/qtest/megasas-test.c
+++ b/tests/qtest/megasas-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
new file mode 100644
index 0000000000..30cb88d919
--- /dev/null
+++ b/tests/qtest/meson.build
@@ -0,0 +1,257 @@
+# All QTests for now are POSIX-only, but the dependencies are
+# really in libqtest, not in the testcases themselves.
+if not config_host.has_key('CONFIG_POSIX')
+  subdir_done()
+endif
+
+qtests_generic = [
+  'cdrom-test',
+  'device-introspect-test',
+  'machine-none-test',
+  'qmp-test',
+  'qmp-cmd-test',
+  'qom-test',
+  'test-hmp',
+  'qos-test',
+]
+if config_host.has_key('CONFIG_MODULES')
+  qtests_generic += [ 'modules-test' ]
+endif
+
+qtests_pci = \
+  (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : []) +                  \
+  (config_all_devices.has_key('CONFIG_IVSHMEM_DEVICE') ? ['ivshmem-test'] : [])
+
+qtests_i386 = \
+  (config_host.has_key('CONFIG_SLIRP') ? ['pxe-test', 'test-netfilter'] : []) +             \
+  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                     \
+  (have_tools ? ['ahci-test'] : []) +                                                       \
+  (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
+  (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \
+  (config_all_devices.has_key('CONFIG_RTL8139_PCI') ? ['test-filter-redirector'] : []) +    \
+  (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
+  (config_host.has_key('CONFIG_LINUX') and                                                  \
+   config_all_devices.has_key('CONFIG_ISA_IPMI_BT') ? ['ipmi-bt-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_WDT_IB700') ? ['wdt_ib700-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_PVPANIC') ? ['pvpanic-test'] : []) +                  \
+  (config_all_devices.has_key('CONFIG_HDA') ? ['intel-hda-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +             \
+  (config_all_devices.has_key('CONFIG_IOH3420') ? ['ioh3420-test'] : []) +                  \
+  (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_USB_UHCI') and                                        \
+   config_all_devices.has_key('CONFIG_USB_EHCI') ? ['usb-hcd-ehci-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +        \
+  (config_all_devices.has_key('CONFIG_TPM_CRB') ? ['tpm-crb-test'] : []) +                  \
+  (config_all_devices.has_key('CONFIG_TPM_CRB') ? ['tpm-crb-swtpm-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-swtpm-test'] : []) +        \
+  (config_all_devices.has_key('CONFIG_RTL8139_PCI') ? ['rtl8139-test'] : []) +              \
+  qtests_pci +                                                                              \
+  ['fdc-test',
+   'ide-test',
+   'ahci-test',
+   'hd-geo-test',
+   'boot-order-test',
+   'bios-tables-test',
+   'rtc-test',
+   'i440fx-test',
+   'fw_cfg-test',
+   'device-plug-test',
+   'drive_del-test',
+   'tco-test',
+   'cpu-plug-test',
+   'q35-test',
+   'vmgenid-test',
+   'migration-test',
+   'test-x86-cpuid-compat',
+   'numa-test']
+
+dbus_daemon = find_program('dbus-daemon', required: false)
+if dbus_daemon.found() and config_host.has_key('GDBUS_CODEGEN')
+  # Temporarily disabled due to Patchew failures:
+  #qtests_i386 += ['dbus-vmstate-test']
+  dbus_vmstate1 = custom_target('dbus-vmstate description',
+                                output: ['dbus-vmstate1.h', 'dbus-vmstate1.c'],
+                                input: files('dbus-vmstate1.xml'),
+                                command: [config_host['GDBUS_CODEGEN'],
+                                          '@INPUT@',
+                                          '--interface-prefix', 'org.qemu',
+                                          '--generate-c-code', '@BASENAME@']).to_list()
+else
+  dbus_vmstate1 = []
+endif
+
+qtests_x86_64 = qtests_i386
+
+qtests_alpha = [ 'boot-serial-test' ] +                                                      \
+  (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
+
+qtests_avr = [ 'boot-serial-test' ]
+
+qtests_hppa = [ 'boot-serial-test' ] +                                                       \
+  (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
+
+qtests_m68k = [ 'boot-serial-test' ]
+qtests_microblaze = [ 'boot-serial-test' ]
+qtests_microblazeel = qtests_microblaze
+
+qtests_mips = \
+  (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
+
+qtests_mips64 = \
+  (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
+
+qtests_mips64el = \
+  (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
+
+qtests_moxie = [ 'boot-serial-test' ]
+
+qtests_ppc = \
+  (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
+  ['boot-order-test', 'prom-env-test', 'drive_del-test', 'boot-serial-test']                 \
+
+qtests_ppc64 = \
+  (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
+  (config_host.has_key('CONFIG_SLIRP') ? ['pxe-test', 'test-netfilter'] : []) +              \
+  (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
+  (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +         \
+  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                      \
+  qtests_pci + ['migration-test', 'numa-test', 'cpu-plug-test']
+
+qtests_sh4 = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
+qtests_sh4eb = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
+
+qtests_sparc = ['prom-env-test', 'm48t59-test', 'boot-serial-test']
+
+qtests_sparc64 = \
+  (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  ['prom-env-test', 'boot-serial-test']
+
+qtests_arm = \
+  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') ? ['pflash-cfi02-test'] : []) +         \
+  ['arm-cpu-features',
+   'microbit-test',
+   'm25p80-test',
+   'test-arm-mptimer',
+   'boot-serial-test',
+   'hexloader-test']
+
+# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
+qtests_aarch64 = \
+  (cpu != 'arm' ? ['bios-tables-test'] : []) +                                                  \
+  (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-test'] : []) +        \
+  (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-swtpm-test'] : []) +  \
+  ['numa-test',
+   'boot-serial-test',
+   'migration-test']
+
+qtests_s390x = \
+  (config_host.has_key('CONFIG_SLIRP') ? ['pxe-test', 'test-netfilter'] : []) +                 \
+  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                         \
+  (config_host.has_key('CONFIG_POSIX') ? ['test-filter-redirector'] : []) +                     \
+  ['boot-serial-test',
+   'drive_del-test',
+   'device-plug-test',
+   'virtio-ccw-test',
+   'cpu-plug-test',
+   'migration-test']
+
+qos_test_ss = ss.source_set()
+qos_test_ss.add(
+  'ac97-test.c',
+  'ds1338-test.c',
+  'e1000-test.c',
+  'e1000e-test.c',
+  'eepro100-test.c',
+  'es1370-test.c',
+  'ipoctal232-test.c',
+  'megasas-test.c',
+  'ne2000-test.c',
+  'tulip-test.c',
+  'nvme-test.c',
+  'pca9552-test.c',
+  'pci-test.c',
+  'pcnet-test.c',
+  'sdhci-test.c',
+  'spapr-phb-test.c',
+  'tmp105-test.c',
+  'usb-hcd-ohci-test.c',
+  'virtio-test.c',
+  'virtio-blk-test.c',
+  'virtio-net-test.c',
+  'virtio-rng-test.c',
+  'virtio-scsi-test.c',
+  'virtio-serial-test.c',
+  'vmxnet3-test.c',
+)
+qos_test_ss.add(when: 'CONFIG_VIRTFS', if_true: files('virtio-9p-test.c'))
+qos_test_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-test.c'))
+
+extra_qtest_deps = {
+  'bios-tables-test': [io],
+  'ivshmem-test': [rt],
+  'qos-test': [chardev, io],
+  'tpm-crb-swtpm-test': [io],
+  'tpm-crb-test': [io],
+  'tpm-tis-swtpm-test': [io],
+  'tpm-tis-test': [io],
+  'tpm-tis-device-swtpm-test': [io],
+  'tpm-tis-device-test': [io],
+}
+extra_qtest_srcs = {
+  'bios-tables-test': files('boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'),
+  'pxe-test': files('boot-sector.c'),
+  'cdrom-test': files('boot-sector.c'),
+  'migration-test': files('migration-helpers.c'),
+  'ivshmem-test': files('../../contrib/ivshmem-server/ivshmem-server.c'),
+  'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
+  'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
+  'tpm-crb-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tests.c'),
+  'tpm-crb-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tests.c'),
+  'tpm-tis-device-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
+  'tpm-tis-device-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
+  'tpm-tis-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
+  'tpm-tis-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
+  'qos-test': qos_test_ss.apply(config_host, strict: false).sources()
+}
+
+
+qtest_executables = {}
+foreach dir : target_dirs
+  if not dir.endswith('-softmmu')
+    continue
+  endif
+
+  target_base = dir.split('-')[0]
+  qtests = get_variable('qtests_' + target_base, []) + qtests_generic
+
+  qtest_env = environment()
+  qtest_env.set('QTEST_QEMU_IMG', './qemu-img')
+  qtest_env.set('G_TEST_DBUS_DAEMON', meson.source_root() / 'tests/dbus-vmstate-daemon.sh')
+  qtest_env.set('QTEST_QEMU_BINARY', '@0@-softmmu/qemu-system-@0@'.format(target_base))
+  
+  foreach test : qtests
+    # Executables are shared across targets, declare them only the first time we
+    # encounter them
+    if not qtest_executables.has_key(test)
+      qtest_executables += {
+        test: executable(test,
+                         files(test + '.c') + extra_qtest_srcs.get(test, []),
+                         dependencies: [qemuutil, qos] + extra_qtest_deps.get(test, []))
+      }
+    endif
+    # FIXME: missing dependency on the emulator binary and qemu-img
+    test('qtest-@0@: @1@'.format(target_base, test),
+         qtest_executables[test],
+         env: qtest_env,
+         args: ['--tap', '-k'],
+         protocol: 'tap',
+         suite: ['qtest', 'qtest-' + target_base])
+  endforeach
+endforeach
diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 04e199ec33..2b255579df 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/hwaddr.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 #include "hw/arm/nrf51.h"
 #include "hw/char/nrf51_uart.h"
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index a11808b3b7..d63bba9630 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -12,7 +12,7 @@
 #ifndef MIGRATION_HELPERS_H_
 #define MIGRATION_HELPERS_H_
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 extern bool got_stop;
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 21ea5ba1d2..00a233cd8c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/module.h"
@@ -25,7 +25,7 @@
 #include "qapi/qobject-output-visitor.h"
 
 #include "migration-helpers.h"
-#include "migration/migration-test.h"
+#include "tests/migration/migration-test.h"
 
 /* TODO actually test the results and get rid of this */
 #define qtest_qmp_discard_response(...) qobject_unref(qtest_qmp(__VA_ARGS__))
diff --git a/tests/qtest/modules-test.c b/tests/qtest/modules-test.c
index 88217686e1..c238b3f422 100644
--- a/tests/qtest/modules-test.c
+++ b/tests/qtest/modules-test.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
diff --git a/tests/qtest/ne2000-test.c b/tests/qtest/ne2000-test.c
index 3fc0e555d5..43cfc4535a 100644
--- a/tests/qtest/ne2000-test.c
+++ b/tests/qtest/ne2000-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index e1ed6d4322..b25ebf97d8 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index ff0442150c..d32c953a38 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index d80ed93cd3..42a1312665 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
 #include "hw/misc/pca9552_regs.h"
diff --git a/tests/qtest/pci-test.c b/tests/qtest/pci-test.c
index 4b2092b949..e15d4d94d1 100644
--- a/tests/qtest/pci-test.c
+++ b/tests/qtest/pci-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/pcnet-test.c b/tests/qtest/pcnet-test.c
index 900944fa7e..7583aeb3c3 100644
--- a/tests/qtest/pcnet-test.c
+++ b/tests/qtest/pcnet-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/pflash-cfi02-test.c b/tests/qtest/pflash-cfi02-test.c
index 17aa669b2e..afb702b565 100644
--- a/tests/qtest/pflash-cfi02-test.c
+++ b/tests/qtest/pflash-cfi02-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 /*
  * To test the pflash_cfi02 device, we run QEMU with the musicpal machine with
diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index 2c46d5cf6d..c8d4043362 100644
--- a/tests/qtest/pnv-xscom-test.c
+++ b/tests/qtest/pnv-xscom-test.c
@@ -8,7 +8,7 @@
  */
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 typedef enum PnvChipType {
     PNV_CHIP_POWER8E,     /* AKA Murano (default) */
diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
index 60e6ec3153..f41d80154a 100644
--- a/tests/qtest/prom-env-test.c
+++ b/tests/qtest/prom-env-test.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/libqos-spapr.h"
 
 #define MAGIC   0xcafec0de
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index ff9176adf3..e57639481e 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 
 static void test_panic(void)
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 1161a773a4..32bbae33c5 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "qemu-common.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "boot-sector.h"
 #include "libqos/libqos-spapr.h"
 
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index c922d81bc0..b7cf144990 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci-host/q35.h"
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index f7b1aa7fdc..f34e68858a 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-introspect.h"
 #include "qapi/qmp/qdict.h"
diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 1a8876b6ca..5950c3ebbb 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 1acf0d7369..eb34af843b 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -13,7 +13,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/cutils.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 static void test_properties(QTestState *qts, const char *path, bool recurse)
 {
diff --git a/tests/qtest/rtas-test.c b/tests/qtest/rtas-test.c
index 167b42db38..a7e83e7d40 100644
--- a/tests/qtest/rtas-test.c
+++ b/tests/qtest/rtas-test.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 #include "libqos/libqos-spapr.h"
 #include "libqos/rtas.h"
diff --git a/tests/qtest/sdhci-test.c b/tests/qtest/sdhci-test.c
index 6275e7626c..a110cfe321 100644
--- a/tests/qtest/sdhci-test.c
+++ b/tests/qtest/sdhci-test.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/registerfields.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci/pci.h"
diff --git a/tests/qtest/spapr-phb-test.c b/tests/qtest/spapr-phb-test.c
index 093dc22f2f..ea8d596507 100644
--- a/tests/qtest/spapr-phb-test.c
+++ b/tests/qtest/spapr-phb-test.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 
diff --git a/tests/qtest/tco-test.c b/tests/qtest/tco-test.c
index 254f735370..47bc7ad301 100644
--- a/tests/qtest/tco-test.c
+++ b/tests/qtest/tco-test.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
 #include "qapi/qmp/qdict.h"
diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index 1e3ced84a9..bc0dee64dd 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index e4d53220fd..829db8c2ea 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -52,7 +52,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index d5e7ebd176..aea1384bac 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -15,7 +15,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 
 static int verbose;
 
diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index 55fdb5657d..1d82a48c04 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
 #include "hw/acpi/tpm.h"
diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-tis-device-swtpm-test.c
index 7b20035142..f7126eff9e 100644
--- a/tests/qtest/tpm-tis-device-swtpm-test.c
+++ b/tests/qtest/tpm-tis-device-swtpm-test.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
 #include "hw/acpi/tpm.h"
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 90131cb3c4..fa590e68f1 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
 #include "hw/acpi/tpm.h"
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 58a9593745..e2b29ef0f8 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/acpi/tpm.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "tpm-util.h"
 #include "qapi/qmp/qdict.h"
 
diff --git a/tests/qtest/tulip-test.c b/tests/qtest/tulip-test.c
index 2fb6c4d5a7..da16cbfafc 100644
--- a/tests/qtest/tulip-test.c
+++ b/tests/qtest/tulip-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/virtio-rng-test.c b/tests/qtest/virtio-rng-test.c
index 092ba13068..e6b8cd8e0c 100644
--- a/tests/qtest/virtio-rng-test.c
+++ b/tests/qtest/virtio-rng-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-rng.h"
diff --git a/tests/qtest/virtio-test.c b/tests/qtest/virtio-test.c
index f7c6afdcf1..6313417630 100644
--- a/tests/qtest/virtio-test.c
+++ b/tests/qtest/virtio-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index efba76e716..6781a51447 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -14,7 +14,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "boot-sector.h"
 #include "acpi-utils.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 
 #define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
diff --git a/tests/qtest/vmxnet3-test.c b/tests/qtest/vmxnet3-test.c
index a81025252c..97c23fd3a8 100644
--- a/tests/qtest/vmxnet3-test.c
+++ b/tests/qtest/vmxnet3-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/qtest/wdt_ib700-test.c b/tests/qtest/wdt_ib700-test.c
index 797288d939..6c36e43fb8 100644
--- a/tests/qtest/wdt_ib700-test.c
+++ b/tests/qtest/wdt_ib700-test.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/timer.h"
 
diff --git a/tests/test-qga.c b/tests/test-qga.c
index d1b4c3e8ce..4ac4c22109 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -4,7 +4,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-#include "libqtest.h"
+#include "libqos/libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 
diff --git a/tests/test-qgraph.c b/tests/test-qgraph.c
index 5c7e457075..267291c6ed 100644
--- a/tests/test-qgraph.c
+++ b/tests/test-qgraph.c
@@ -17,9 +17,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest.h"
-#include "libqos/qgraph.h"
-#include "libqos/qgraph_internal.h"
+#include "qtest/libqos/qgraph.h"
+#include "qtest/libqos/qgraph_internal.h"
 
 #define MACHINE_PC "x86_64/pc"
 #define MACHINE_RASPI2 "arm/raspi2"
-- 
2.26.2



