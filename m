Received: from eggs.gnu.org ([2001:4830:134:3::10]:34351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKS-0004TS-RR
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKK-0003CJ-Da
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwxKK-0003BJ-3D
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFF9B804B9F1
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 22:28:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  4 Sep 2018 00:27:55 +0200
Message-Id: <20180903222758.13267-3-quintela@redhat.com>
In-Reply-To: <20180903222758.13267-1-quintela@redhat.com>
References: <20180903222758.13267-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] tests/migration: Enable the migration test
 on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We can re-use the s390-ccw bios code to implement a small firmware
for a s390x guest which prints out the "A" and "B" characters and
modifies the memory, as required for the migration test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1535027120-26187-1-git-send-email-thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include               |    1 +
 tests/Makefile.include.orig          | 1025 ++++++++++++++++++++++++++
 tests/migration-test.c               |   23 +
 tests/migration-test.c.orig          |  780 ++++++++++++++++++++
 tests/migration/s390x-a-b-rebuild.sh |   42 ++
 tests/migration/s390x-a-b.c          |   35 +
 tests/migration/s390x-a-b.h          |  427 +++++++++++
 7 files changed, 2333 insertions(+)
 create mode 100644 tests/Makefile.include.orig
 create mode 100644 tests/migration-test.c.orig
 create mode 100755 tests/migration/s390x-a-b-rebuild.sh
 create mode 100644 tests/migration/s390x-a-b.c
 create mode 100644 tests/migration/s390x-a-b.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 87c81d1dcc..f1bdf96561 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -403,6 +403,7 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
+check-qtest-s390x-y += tests/migration-test$(EXESUF)
 
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
diff --git a/tests/Makefile.include.orig b/tests/Makefile.include.orig
new file mode 100644
index 0000000000..87c81d1dcc
--- /dev/null
+++ b/tests/Makefile.include.orig
@@ -0,0 +1,1025 @@
+
+.PHONY: check-help
+check-help:
+	@echo "Regression testing targets:"
+	@echo
+	@echo " $(MAKE) check                Run all tests"
+	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
+	@echo " $(MAKE) check-qtest          Run qtest tests"
+	@echo " $(MAKE) check-unit           Run qobject tests"
+	@echo " $(MAKE) check-speed          Run qobject speed tests"
+	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
+	@echo " $(MAKE) check-block          Run block tests"
+	@echo " $(MAKE) check-tcg            Run TCG tests"
+	@echo " $(MAKE) check-report.html    Generates an HTML test report"
+	@echo " $(MAKE) check-clean          Clean the tests"
+	@echo
+	@echo "Please note that HTML reports do not regenerate if the unit tests"
+	@echo "has not changed."
+	@echo
+	@echo "The variable SPEED can be set to control the gtester speed setting."
+	@echo "Default options are -k and (for $(MAKE) V=1) --verbose; they can be"
+	@echo "changed with variable GTESTER_OPTIONS."
+
+ifneq ($(wildcard config-host.mak),)
+export SRC_PATH
+
+# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
+qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/types.py \
+$(SRC_PATH)/scripts/qapi/visit.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/qapi-gen.py
+
+# Get the list of all supported sysemu targets
+SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
+   $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
+
+check-unit-y = tests/check-qdict$(EXESUF)
+gcov-files-check-qdict-y = qobject/qdict.c
+check-unit-y = tests/check-block-qdict$(EXESUF)
+gcov-files-check-block-qdict-y = qobject/block-qdict.c
+check-unit-y += tests/test-char$(EXESUF)
+gcov-files-check-qdict-y = chardev/char.c
+check-unit-y += tests/check-qnum$(EXESUF)
+gcov-files-check-qnum-y = qobject/qnum.c
+check-unit-y += tests/check-qstring$(EXESUF)
+gcov-files-check-qstring-y = qobject/qstring.c
+check-unit-y += tests/check-qlist$(EXESUF)
+gcov-files-check-qlist-y = qobject/qlist.c
+check-unit-y += tests/check-qnull$(EXESUF)
+gcov-files-check-qnull-y = qobject/qnull.c
+check-unit-y += tests/check-qobject$(EXESUF)
+check-unit-y += tests/check-qjson$(EXESUF)
+gcov-files-check-qjson-y = qobject/qjson.c
+check-unit-y += tests/check-qlit$(EXESUF)
+gcov-files-check-qlit-y = qobject/qlit.c
+check-unit-y += tests/test-qobject-output-visitor$(EXESUF)
+gcov-files-test-qobject-output-visitor-y = qapi/qobject-output-visitor.c
+check-unit-y += tests/test-clone-visitor$(EXESUF)
+gcov-files-test-clone-visitor-y = qapi/qapi-clone-visitor.c
+check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
+gcov-files-test-qobject-input-visitor-y = qapi/qobject-input-visitor.c
+check-unit-y += tests/test-qmp-cmds$(EXESUF)
+gcov-files-test-qmp-cmds-y = qapi/qmp-dispatch.c
+check-unit-y += tests/test-string-input-visitor$(EXESUF)
+gcov-files-test-string-input-visitor-y = qapi/string-input-visitor.c
+check-unit-y += tests/test-string-output-visitor$(EXESUF)
+gcov-files-test-string-output-visitor-y = qapi/string-output-visitor.c
+check-unit-y += tests/test-qmp-event$(EXESUF)
+gcov-files-test-qmp-event-y += qapi/qmp-event.c
+check-unit-y += tests/test-opts-visitor$(EXESUF)
+gcov-files-test-opts-visitor-y = qapi/opts-visitor.c
+check-unit-y += tests/test-coroutine$(EXESUF)
+gcov-files-test-coroutine-y = coroutine-$(CONFIG_COROUTINE_BACKEND).c
+check-unit-y += tests/test-visitor-serialization$(EXESUF)
+check-unit-y += tests/test-iov$(EXESUF)
+gcov-files-test-iov-y = util/iov.c
+check-unit-y += tests/test-aio$(EXESUF)
+gcov-files-test-aio-y = util/async.c util/qemu-timer.o
+gcov-files-test-aio-$(CONFIG_WIN32) += util/aio-win32.c
+gcov-files-test-aio-$(CONFIG_POSIX) += util/aio-posix.c
+check-unit-y += tests/test-aio-multithread$(EXESUF)
+gcov-files-test-aio-multithread-y = $(gcov-files-test-aio-y)
+gcov-files-test-aio-multithread-y += util/qemu-coroutine.c tests/iothread.c
+check-unit-y += tests/test-throttle$(EXESUF)
+check-unit-y += tests/test-thread-pool$(EXESUF)
+gcov-files-test-thread-pool-y = thread-pool.c
+gcov-files-test-hbitmap-y = util/hbitmap.c
+check-unit-y += tests/test-hbitmap$(EXESUF)
+gcov-files-test-hbitmap-y = blockjob.c
+check-unit-y += tests/test-bdrv-drain$(EXESUF)
+check-unit-y += tests/test-blockjob$(EXESUF)
+check-unit-y += tests/test-blockjob-txn$(EXESUF)
+check-unit-y += tests/test-block-backend$(EXESUF)
+check-unit-y += tests/test-x86-cpuid$(EXESUF)
+# all code tested by test-x86-cpuid is inside topology.h
+gcov-files-test-x86-cpuid-y =
+ifeq ($(CONFIG_SOFTMMU),y)
+check-unit-y += tests/test-xbzrle$(EXESUF)
+gcov-files-test-xbzrle-y = migration/xbzrle.c
+check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
+endif
+check-unit-y += tests/test-cutils$(EXESUF)
+gcov-files-test-cutils-y += util/cutils.c
+check-unit-y += tests/test-shift128$(EXESUF)
+gcov-files-test-shift128-y = util/host-utils.c
+check-unit-y += tests/test-mul64$(EXESUF)
+gcov-files-test-mul64-y = util/host-utils.c
+check-unit-y += tests/test-int128$(EXESUF)
+# all code tested by test-int128 is inside int128.h
+gcov-files-test-int128-y =
+check-unit-y += tests/rcutorture$(EXESUF)
+gcov-files-rcutorture-y = util/rcu.c
+check-unit-y += tests/test-rcu-list$(EXESUF)
+gcov-files-test-rcu-list-y = util/rcu.c
+check-unit-y += tests/test-rcu-simpleq$(EXESUF)
+gcov-files-test-rcu-simpleq-y = util/rcu.c
+check-unit-y += tests/test-rcu-tailq$(EXESUF)
+gcov-files-test-rcu-tailq-y = util/rcu.c
+check-unit-y += tests/test-qdist$(EXESUF)
+gcov-files-test-qdist-y = util/qdist.c
+check-unit-y += tests/test-qht$(EXESUF)
+gcov-files-test-qht-y = util/qht.c
+check-unit-y += tests/test-qht-par$(EXESUF)
+gcov-files-test-qht-par-y = util/qht.c
+check-unit-y += tests/test-bitops$(EXESUF)
+check-unit-y += tests/test-bitcnt$(EXESUF)
+check-unit-y += tests/test-qdev-global-props$(EXESUF)
+check-unit-y += tests/check-qom-interface$(EXESUF)
+gcov-files-check-qom-interface-y = qom/object.c
+check-unit-y += tests/check-qom-proplist$(EXESUF)
+gcov-files-check-qom-proplist-y = qom/object.c
+check-unit-y += tests/test-qemu-opts$(EXESUF)
+gcov-files-test-qemu-opts-y = util/qemu-option.c
+check-unit-y += tests/test-keyval$(EXESUF)
+gcov-files-test-keyval-y = util/keyval.c
+check-unit-y += tests/test-write-threshold$(EXESUF)
+gcov-files-test-write-threshold-y = block/write-threshold.c
+check-unit-y += tests/test-crypto-hash$(EXESUF)
+check-speed-y += tests/benchmark-crypto-hash$(EXESUF)
+check-unit-y += tests/test-crypto-hmac$(EXESUF)
+check-speed-y += tests/benchmark-crypto-hmac$(EXESUF)
+check-unit-y += tests/test-crypto-cipher$(EXESUF)
+check-speed-y += tests/benchmark-crypto-cipher$(EXESUF)
+check-unit-y += tests/test-crypto-secret$(EXESUF)
+check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
+check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlssession$(EXESUF)
+ifneq (,$(findstring qemu-ga,$(TOOLS)))
+check-unit-$(CONFIG_LINUX) += tests/test-qga$(EXESUF)
+endif
+check-unit-y += tests/test-timed-average$(EXESUF)
+check-unit-y += tests/test-util-sockets$(EXESUF)
+check-unit-y += tests/test-io-task$(EXESUF)
+check-unit-y += tests/test-io-channel-socket$(EXESUF)
+check-unit-y += tests/test-io-channel-file$(EXESUF)
+check-unit-$(CONFIG_GNUTLS) += tests/test-io-channel-tls$(EXESUF)
+check-unit-y += tests/test-io-channel-command$(EXESUF)
+check-unit-y += tests/test-io-channel-buffer$(EXESUF)
+check-unit-y += tests/test-base64$(EXESUF)
+check-unit-$(if $(CONFIG_NETTLE_KDF),y,$(CONFIG_GCRYPT_KDF)) += tests/test-crypto-pbkdf$(EXESUF)
+check-unit-y += tests/test-crypto-ivgen$(EXESUF)
+check-unit-y += tests/test-crypto-afsplit$(EXESUF)
+check-unit-y += tests/test-crypto-xts$(EXESUF)
+check-unit-y += tests/test-crypto-block$(EXESUF)
+check-unit-y += tests/test-logging$(EXESUF)
+gcov-files-test-logging-y = util/log.c
+check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
+check-unit-y += tests/test-bufferiszero$(EXESUF)
+gcov-files-check-bufferiszero-y = util/bufferiszero.c
+check-unit-y += tests/test-uuid$(EXESUF)
+check-unit-y += tests/ptimer-test$(EXESUF)
+gcov-files-ptimer-test-y = hw/core/ptimer.c
+check-unit-y += tests/test-qapi-util$(EXESUF)
+gcov-files-test-qapi-util-y = qapi/qapi-util.c
+
+check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
+
+# All QTests for now are POSIX-only, but the dependencies are
+# really in libqtest, not in the testcases themselves.
+
+check-qtest-generic-y = tests/qmp-test$(EXESUF)
+gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
+check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
+
+check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
+gcov-files-generic-y = qdev-monitor.c qmp.c
+check-qtest-generic-y += tests/cdrom-test$(EXESUF)
+
+gcov-files-ipack-y += hw/ipack/ipack.c
+check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
+gcov-files-ipack-y += hw/char/ipoctal232.c
+
+check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
+gcov-files-virtioserial-y += hw/char/virtio-console.c
+
+gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
+check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
+gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
+check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
+gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
+check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
+gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
+check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
+gcov-files-virtio-y += hw/virtio/virtio-rng.c
+check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
+gcov-files-virtio-y += i386-softmmu/hw/scsi/virtio-scsi.c
+ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
+check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
+gcov-files-virtio-y += hw/9pfs/virtio-9p.c
+gcov-files-virtio-y += i386-softmmu/hw/9pfs/virtio-9p-device.c
+endif
+check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
+gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
+check-qtest-virtio-y += $(check-qtest-virtioserial-y)
+gcov-files-virtio-y += $(gcov-files-virtioserial-y)
+
+check-qtest-pci-y += tests/e1000-test$(EXESUF)
+gcov-files-pci-y += hw/net/e1000.c
+check-qtest-pci-y += tests/e1000e-test$(EXESUF)
+gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
+check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
+gcov-files-pci-$(CONFIG_RTL8139_PCI) += hw/net/rtl8139.c
+check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
+gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet.c
+gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet-pci.c
+check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
+gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
+check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
+gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
+check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
+gcov-files-pci-$(CONFIG_NVME_PCI) += hw/block/nvme.c
+check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
+gcov-files-pci-$(CONFIG_AC97) += hw/audio/ac97.c
+check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
+gcov-files-pci-$(CONFIG_ES1370) += hw/audio/es1370.c
+check-qtest-pci-y += $(check-qtest-virtio-y)
+gcov-files-pci-y += $(gcov-files-virtio-y) hw/virtio/virtio-pci.c
+check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
+gcov-files-pci-$(CONFIG_IPACK) += hw/ipack/tpci200.c
+check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
+gcov-files-pci-$(CONFIG_IPACK) += $(gcov-files-ipack-y)
+check-qtest-pci-y += tests/display-vga-test$(EXESUF)
+gcov-files-pci-y += hw/display/vga.c
+gcov-files-pci-y += hw/display/cirrus_vga.c
+gcov-files-pci-y += hw/display/vga-pci.c
+gcov-files-pci-y += hw/display/virtio-gpu.c
+gcov-files-pci-y += hw/display/virtio-gpu-pci.c
+gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
+check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
+gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
+check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
+gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
+check-qtest-pci-y += tests/megasas-test$(EXESUF)
+gcov-files-pci-y += hw/scsi/megasas.c
+check-qtest-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
+gcov-files-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
+check-qtest-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
+check-qtest-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
+gcov-files-$(CONFIG_WDT_IB700) += hw/watchdog/watchdog.c hw/watchdog/wdt_ib700.c
+
+check-qtest-i386-y += tests/fdc-test$(EXESUF)
+gcov-files-i386-y = hw/block/fdc.c
+check-qtest-i386-y += tests/ide-test$(EXESUF)
+check-qtest-i386-y += tests/ahci-test$(EXESUF)
+check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
+gcov-files-i386-y += hw/block/hd-geometry.c
+check-qtest-i386-y += tests/boot-order-test$(EXESUF)
+check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
+check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
+check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
+check-qtest-i386-y += tests/rtc-test$(EXESUF)
+check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
+check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
+check-qtest-i386-y += tests/i440fx-test$(EXESUF)
+check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
+check-qtest-i386-y += tests/drive_del-test$(EXESUF)
+check-qtest-i386-y += tests/tco-test$(EXESUF)
+check-qtest-i386-y += $(check-qtest-pci-y)
+gcov-files-i386-y += $(gcov-files-pci-y)
+gcov-files-i386-y += hw/net/net_rx_pkt.c
+gcov-files-i386-y += hw/net/net_tx_pkt.c
+check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
+gcov-files-i386-$(CONFIG_PVPANIC) += i386-softmmu/hw/misc/pvpanic.c
+check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
+gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
+check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
+gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
+check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
+gcov-files-i386-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
+check-qtest-i386-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
+gcov-files-i386-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
+ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
+check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
+endif
+gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
+gcov-files-i386-y += hw/usb/dev-hid.c
+gcov-files-i386-y += hw/usb/dev-storage.c
+check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
+gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
+gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
+check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
+check-qtest-i386-y += tests/q35-test$(EXESUF)
+check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
+gcov-files-i386-y += hw/pci-host/q35.c
+check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
+ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
+check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
+endif
+check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-test$(EXESUF)
+check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
+check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-i386-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
+check-qtest-i386-y += tests/migration-test$(EXESUF)
+check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
+check-qtest-i386-y += tests/numa-test$(EXESUF)
+check-qtest-x86_64-y += $(check-qtest-i386-y)
+check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
+gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
+gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
+
+check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
+
+check-qtest-hppa-y = tests/boot-serial-test$(EXESUF)
+
+check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
+
+check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
+
+check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
+
+check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
+check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
+check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
+check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
+check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
+gcov-files-ppc-y += hw/timer/m48t59.c
+
+check-qtest-ppc64-y = $(check-qtest-ppc-y)
+gcov-files-ppc64-y = $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-ppc-y))
+check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
+gcov-files-ppc64-y += ppc64-softmmu/hw/ppc/spapr_pci.c
+check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
+check-qtest-ppc64-y += tests/migration-test$(EXESUF)
+check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
+check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
+check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
+gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
+check-qtest-ppc64-y += $(check-qtest-virtio-y)
+check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
+check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
+check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
+check-qtest-ppc64-y += tests/numa-test$(EXESUF)
+check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
+gcov-files-ppc64-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
+check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
+
+check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
+check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
+gcov-files-sparc-y = hw/timer/m48t59.c
+check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
+
+check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
+check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
+
+check-qtest-arm-y = tests/tmp105-test$(EXESUF)
+check-qtest-arm-y += tests/pca9552-test$(EXESUF)
+check-qtest-arm-y += tests/ds1338-test$(EXESUF)
+check-qtest-arm-y += tests/m25p80-test$(EXESUF)
+gcov-files-arm-y += hw/misc/tmp105.c
+check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
+gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
+check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
+gcov-files-arm-y += hw/timer/arm_mptimer.c
+check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
+check-qtest-arm-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
+check-qtest-arm-y += tests/hexloader-test$(EXESUF)
+
+check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
+check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
+
+check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
+
+check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
+
+check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
+check-qtest-s390x-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
+check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
+check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
+check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
+check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
+check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
+
+check-qtest-generic-y += tests/machine-none-test$(EXESUF)
+check-qtest-generic-y += tests/qom-test$(EXESUF)
+check-qtest-generic-y += tests/test-hmp$(EXESUF)
+
+qapi-schema += alternate-any.json
+qapi-schema += alternate-array.json
+qapi-schema += alternate-base.json
+qapi-schema += alternate-clash.json
+qapi-schema += alternate-conflict-dict.json
+qapi-schema += alternate-conflict-enum-bool.json
+qapi-schema += alternate-conflict-enum-int.json
+qapi-schema += alternate-conflict-string.json
+qapi-schema += alternate-conflict-bool-string.json
+qapi-schema += alternate-conflict-num-string.json
+qapi-schema += alternate-empty.json
+qapi-schema += alternate-nested.json
+qapi-schema += alternate-unknown.json
+qapi-schema += args-alternate.json
+qapi-schema += args-any.json
+qapi-schema += args-array-empty.json
+qapi-schema += args-array-unknown.json
+qapi-schema += args-bad-boxed.json
+qapi-schema += args-boxed-anon.json
+qapi-schema += args-boxed-empty.json
+qapi-schema += args-boxed-string.json
+qapi-schema += args-int.json
+qapi-schema += args-invalid.json
+qapi-schema += args-member-array-bad.json
+qapi-schema += args-member-case.json
+qapi-schema += args-member-unknown.json
+qapi-schema += args-name-clash.json
+qapi-schema += args-union.json
+qapi-schema += args-unknown.json
+qapi-schema += bad-base.json
+qapi-schema += bad-data.json
+qapi-schema += bad-ident.json
+qapi-schema += bad-if.json
+qapi-schema += bad-if-empty.json
+qapi-schema += bad-if-empty-list.json
+qapi-schema += bad-if-list.json
+qapi-schema += bad-type-bool.json
+qapi-schema += bad-type-dict.json
+qapi-schema += bad-type-int.json
+qapi-schema += base-cycle-direct.json
+qapi-schema += base-cycle-indirect.json
+qapi-schema += command-int.json
+qapi-schema += comments.json
+qapi-schema += doc-bad-alternate-member.json
+qapi-schema += doc-bad-command-arg.json
+qapi-schema += doc-bad-section.json
+qapi-schema += doc-bad-symbol.json
+qapi-schema += doc-bad-union-member.json
+qapi-schema += doc-before-include.json
+qapi-schema += doc-before-pragma.json
+qapi-schema += doc-duplicated-arg.json
+qapi-schema += doc-duplicated-return.json
+qapi-schema += doc-duplicated-since.json
+qapi-schema += doc-empty-arg.json
+qapi-schema += doc-empty-section.json
+qapi-schema += doc-empty-symbol.json
+qapi-schema += doc-good.json
+qapi-schema += doc-interleaved-section.json
+qapi-schema += doc-invalid-end.json
+qapi-schema += doc-invalid-end2.json
+qapi-schema += doc-invalid-return.json
+qapi-schema += doc-invalid-section.json
+qapi-schema += doc-invalid-start.json
+qapi-schema += doc-missing-colon.json
+qapi-schema += doc-missing-expr.json
+qapi-schema += doc-missing-space.json
+qapi-schema += doc-missing.json
+qapi-schema += doc-no-symbol.json
+qapi-schema += double-data.json
+qapi-schema += double-type.json
+qapi-schema += duplicate-key.json
+qapi-schema += empty.json
+qapi-schema += enum-bad-name.json
+qapi-schema += enum-bad-prefix.json
+qapi-schema += enum-clash-member.json
+qapi-schema += enum-dict-member.json
+qapi-schema += enum-int-member.json
+qapi-schema += enum-member-case.json
+qapi-schema += enum-missing-data.json
+qapi-schema += enum-wrong-data.json
+qapi-schema += escape-outside-string.json
+qapi-schema += escape-too-big.json
+qapi-schema += escape-too-short.json
+qapi-schema += event-boxed-empty.json
+qapi-schema += event-case.json
+qapi-schema += event-nest-struct.json
+qapi-schema += flat-union-array-branch.json
+qapi-schema += flat-union-bad-base.json
+qapi-schema += flat-union-bad-discriminator.json
+qapi-schema += flat-union-base-any.json
+qapi-schema += flat-union-base-union.json
+qapi-schema += flat-union-clash-member.json
+qapi-schema += flat-union-empty.json
+qapi-schema += flat-union-inline.json
+qapi-schema += flat-union-int-branch.json
+qapi-schema += flat-union-invalid-branch-key.json
+qapi-schema += flat-union-invalid-discriminator.json
+qapi-schema += flat-union-no-base.json
+qapi-schema += flat-union-optional-discriminator.json
+qapi-schema += flat-union-string-discriminator.json
+qapi-schema += funny-char.json
+qapi-schema += ident-with-escape.json
+qapi-schema += include-before-err.json
+qapi-schema += include-cycle.json
+qapi-schema += include-extra-junk.json
+qapi-schema += include-format-err.json
+qapi-schema += include-nested-err.json
+qapi-schema += include-no-file.json
+qapi-schema += include-non-file.json
+qapi-schema += include-relpath.json
+qapi-schema += include-repetition.json
+qapi-schema += include-self-cycle.json
+qapi-schema += include-simple.json
+qapi-schema += indented-expr.json
+qapi-schema += leading-comma-list.json
+qapi-schema += leading-comma-object.json
+qapi-schema += missing-colon.json
+qapi-schema += missing-comma-list.json
+qapi-schema += missing-comma-object.json
+qapi-schema += missing-type.json
+qapi-schema += nested-struct-data.json
+qapi-schema += non-objects.json
+qapi-schema += oob-test.json
+qapi-schema += allow-preconfig-test.json
+qapi-schema += pragma-doc-required-crap.json
+qapi-schema += pragma-extra-junk.json
+qapi-schema += pragma-name-case-whitelist-crap.json
+qapi-schema += pragma-non-dict.json
+qapi-schema += pragma-returns-whitelist-crap.json
+qapi-schema += qapi-schema-test.json
+qapi-schema += quoted-structural-chars.json
+qapi-schema += redefined-builtin.json
+qapi-schema += redefined-command.json
+qapi-schema += redefined-event.json
+qapi-schema += redefined-type.json
+qapi-schema += reserved-command-q.json
+qapi-schema += reserved-enum-q.json
+qapi-schema += reserved-member-has.json
+qapi-schema += reserved-member-q.json
+qapi-schema += reserved-member-u.json
+qapi-schema += reserved-member-underscore.json
+qapi-schema += reserved-type-kind.json
+qapi-schema += reserved-type-list.json
+qapi-schema += returns-alternate.json
+qapi-schema += returns-array-bad.json
+qapi-schema += returns-dict.json
+qapi-schema += returns-unknown.json
+qapi-schema += returns-whitelist.json
+qapi-schema += struct-base-clash-deep.json
+qapi-schema += struct-base-clash.json
+qapi-schema += struct-data-invalid.json
+qapi-schema += struct-member-invalid.json
+qapi-schema += trailing-comma-list.json
+qapi-schema += trailing-comma-object.json
+qapi-schema += type-bypass-bad-gen.json
+qapi-schema += unclosed-list.json
+qapi-schema += unclosed-object.json
+qapi-schema += unclosed-string.json
+qapi-schema += unicode-str.json
+qapi-schema += union-base-empty.json
+qapi-schema += union-base-no-discriminator.json
+qapi-schema += union-branch-case.json
+qapi-schema += union-clash-branches.json
+qapi-schema += union-empty.json
+qapi-schema += union-invalid-base.json
+qapi-schema += union-optional-branch.json
+qapi-schema += union-unknown.json
+qapi-schema += unknown-escape.json
+qapi-schema += unknown-expr-key.json
+
+
+check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
+
+GENERATED_FILES += tests/test-qapi-types.h tests/test-qapi-visit.h \
+	tests/test-qapi-commands.h tests/test-qapi-events.h \
+	tests/test-qapi-introspect.h
+
+test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
+	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
+	tests/check-qjson.o tests/check-qlit.o \
+	tests/check-block-qtest.o \
+	tests/test-coroutine.o tests/test-string-output-visitor.o \
+	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
+	tests/test-clone-visitor.o \
+	tests/test-qobject-input-visitor.o \
+	tests/test-qmp-cmds.o tests/test-visitor-serialization.o \
+	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
+	tests/test-opts-visitor.o tests/test-qmp-event.o \
+	tests/rcutorture.o tests/test-rcu-list.o \
+	tests/test-rcu-simpleq.o \
+	tests/test-rcu-tailq.o \
+	tests/test-qdist.o tests/test-shift128.o \
+	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
+	tests/atomic_add-bench.o
+
+$(test-obj-y): QEMU_INCLUDES += -Itests
+QEMU_CFLAGS += -I$(SRC_PATH)/tests
+
+
+# Deps that are common to various different sets of tests below
+test-util-obj-y = libqemuutil.a
+test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
+test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
+	tests/test-qapi-events.o tests/test-qapi-introspect.o \
+	$(test-qom-obj-y)
+benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
+test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
+test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
+test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
+
+tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
+tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
+tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
+tests/check-block-qdict$(EXESUF): tests/check-block-qdict.o $(test-util-obj-y)
+tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
+tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
+tests/check-qobject$(EXESUF): tests/check-qobject.o $(test-util-obj-y)
+tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
+tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
+tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
+tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
+
+tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(chardev-obj-y)
+tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
+tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
+tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-obj-y)
+tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
+tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-block-obj-y) $(test-util-obj-y)
+tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
+tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
+tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
+tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
+tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
+tests/test-int128$(EXESUF): tests/test-int128.o
+tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
+tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
+tests/test-rcu-simpleq$(EXESUF): tests/test-rcu-simpleq.o $(test-util-obj-y)
+tests/test-rcu-tailq$(EXESUF): tests/test-rcu-tailq.o $(test-util-obj-y)
+tests/test-qdist$(EXESUF): tests/test-qdist.o $(test-util-obj-y)
+tests/test-qht$(EXESUF): tests/test-qht.o $(test-util-obj-y)
+tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(test-util-obj-y)
+tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
+tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
+tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+
+tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
+	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
+	hw/core/bus.o \
+	hw/core/irq.o \
+	hw/core/fw-path-provider.o \
+	hw/core/reset.o \
+	$(test-qapi-obj-y)
+tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
+	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
+        migration/qemu-file-channel.o migration/qjson.o \
+	$(test-io-obj-y)
+tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
+tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
+
+tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
+
+tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-obj-y) \
+	$(test-block-obj-y)
+
+tests/test-qapi-types.c tests/test-qapi-types.h \
+tests/test-qapi-visit.c tests/test-qapi-visit.h \
+tests/test-qapi-commands.h tests/test-qapi-commands.c \
+tests/test-qapi-events.c tests/test-qapi-events.h \
+tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
+tests/test-qapi-gen-timestamp ;
+tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+		-o tests -p "test-" $<, \
+		"GEN","$(@:%-timestamp=%)")
+	@>$@
+
+tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+		-o tests/qapi-schema -p "doc-good-" $<, \
+		"GEN","$@")
+	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
+	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-good-qmp-*.[ch]
+
+tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visitor.o $(test-qapi-obj-y)
+tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.o $(test-qapi-obj-y)
+tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
+tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visitor.o $(test-qapi-obj-y)
+tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-obj-y)
+tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visitor.o $(test-qapi-obj-y)
+tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-commands.o $(test-qapi-obj-y)
+tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
+tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
+
+tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
+tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
+tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
+tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
+tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
+tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test-crypto-obj-y)
+tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
+tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test-crypto-obj-y)
+tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
+tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-crypto-obj-y)
+tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
+tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
+
+tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
+tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
+tests/pkix_asn1_tab.o-cflags := $(TASN1_CFLAGS)
+
+tests/test-crypto-tlscredsx509.o-cflags := $(TASN1_CFLAGS)
+tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o \
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
+
+tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS)
+tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
+	tests/crypto-tls-psk-helpers.o \
+        $(test-crypto-obj-y)
+tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
+	tests/socket-helpers.o $(test-util-obj-y)
+tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
+tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
+        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
+tests/tpm-crb-swtpm-test$(EXESUF): tests/tpm-crb-swtpm-test.o tests/tpm-emu.o \
+	tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
+tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test-io-obj-y)
+tests/tpm-tis-swtpm-test$(EXESUF): tests/tpm-tis-swtpm-test.o tests/tpm-emu.o \
+	tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
+tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test-io-obj-y)
+tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
+        tests/io-channel-helpers.o $(test-io-obj-y)
+tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
+	tests/io-channel-helpers.o $(test-io-obj-y)
+tests/test-io-channel-command$(EXESUF): tests/test-io-channel-command.o \
+        tests/io-channel-helpers.o $(test-io-obj-y)
+tests/test-io-channel-buffer$(EXESUF): tests/test-io-channel-buffer.o \
+        tests/io-channel-helpers.o $(test-io-obj-y)
+tests/test-crypto-pbkdf$(EXESUF): tests/test-crypto-pbkdf.o $(test-crypto-obj-y)
+tests/test-crypto-ivgen$(EXESUF): tests/test-crypto-ivgen.o $(test-crypto-obj-y)
+tests/test-crypto-afsplit$(EXESUF): tests/test-crypto-afsplit.o $(test-crypto-obj-y)
+tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
+
+libqos-obj-y = tests/libqos/pci.o tests/libqos/fw_cfg.o tests/libqos/malloc.o
+libqos-obj-y += tests/libqos/i2c.o tests/libqos/libqos.o
+libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
+libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
+libqos-spapr-obj-y += tests/libqos/rtas.o
+libqos-spapr-obj-y += tests/libqos/pci-spapr.o
+libqos-pc-obj-y = $(libqos-obj-y) tests/libqos/pci-pc.o
+libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
+libqos-pc-obj-y += tests/libqos/ahci.o
+libqos-omap-obj-y = $(libqos-obj-y) tests/libqos/i2c-omap.o
+libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
+libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
+libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
+
+tests/qmp-test$(EXESUF): tests/qmp-test.o
+tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
+tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
+tests/rtc-test$(EXESUF): tests/rtc-test.o
+tests/m48t59-test$(EXESUF): tests/m48t59-test.o
+tests/hexloader-test$(EXESUF): tests/hexloader-test.o
+tests/endianness-test$(EXESUF): tests/endianness-test.o
+tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
+tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
+tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
+tests/fdc-test$(EXESUF): tests/fdc-test.o
+tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
+tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
+tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
+tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
+tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
+tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
+tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
+tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
+	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
+tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
+tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
+tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
+tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
+tests/m25p80-test$(EXESUF): tests/m25p80-test.o
+tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
+tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
+tests/fw_cfg-test$(EXESUF): tests/fw_cfg-test.o $(libqos-pc-obj-y)
+tests/e1000-test$(EXESUF): tests/e1000-test.o
+tests/e1000e-test$(EXESUF): tests/e1000e-test.o $(libqos-pc-obj-y)
+tests/rtl8139-test$(EXESUF): tests/rtl8139-test.o $(libqos-pc-obj-y)
+tests/pcnet-test$(EXESUF): tests/pcnet-test.o
+tests/pnv-xscom-test$(EXESUF): tests/pnv-xscom-test.o
+tests/eepro100-test$(EXESUF): tests/eepro100-test.o
+tests/vmxnet3-test$(EXESUF): tests/vmxnet3-test.o
+tests/ne2000-test$(EXESUF): tests/ne2000-test.o
+tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
+tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
+tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o $(libqos-virtio-obj-y)
+tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
+tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
+tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
+tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
+tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
+tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
+tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o $(libqos-virtio-obj-y)
+tests/virtio-console-test$(EXESUF): tests/virtio-console-test.o $(libqos-virtio-obj-y)
+tests/tpci200-test$(EXESUF): tests/tpci200-test.o
+tests/display-vga-test$(EXESUF): tests/display-vga-test.o
+tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
+tests/qom-test$(EXESUF): tests/qom-test.o
+tests/test-hmp$(EXESUF): tests/test-hmp.o
+tests/machine-none-test$(EXESUF): tests/machine-none-test.o
+tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
+tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
+tests/nvme-test$(EXESUF): tests/nvme-test.o
+tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
+tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
+tests/ac97-test$(EXESUF): tests/ac97-test.o
+tests/es1370-test$(EXESUF): tests/es1370-test.o
+tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
+tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
+tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
+tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
+tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
+tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
+tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
+tests/migration-test$(EXESUF): tests/migration-test.o
+tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
+	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
+	$(chardev-obj-y)
+tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
+tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
+tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
+tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
+tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
+tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
+tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qtest-obj-y)
+tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtest-obj-y)
+tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/megasas-test$(EXESUF): tests/megasas-test.o $(libqos-spapr-obj-y) $(libqos-pc-obj-y)
+tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
+tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
+tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
+tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
+tests/numa-test$(EXESUF): tests/numa-test.o
+tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
+tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
+tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
+
+tests/migration/stress$(EXESUF): tests/migration/stress.o
+	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
+
+INITRD_WORK_DIR=tests/migration/initrd
+
+tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
+	mkdir -p $(INITRD_WORK_DIR)
+	cp $< $(INITRD_WORK_DIR)/init
+	(cd $(INITRD_WORK_DIR) && (find | cpio --quiet -o -H newc | gzip -9)) > $@
+	rm $(INITRD_WORK_DIR)/init
+	rmdir $(INITRD_WORK_DIR)
+
+ifeq ($(CONFIG_POSIX),y)
+LIBS += -lutil
+endif
+
+# QTest rules
+
+TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+ifeq ($(CONFIG_POSIX),y)
+QTEST_TARGETS = $(TARGETS)
+check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
+check-qtest-y += $(check-qtest-generic-y)
+else
+QTEST_TARGETS =
+endif
+
+qtest-obj-y = tests/libqtest.o $(test-util-obj-y)
+$(check-qtest-y): $(qtest-obj-y)
+
+tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
+tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
+
+SPEED = quick
+GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
+GCOV_OPTIONS = -n $(if $(V),-f,)
+
+# gtester tests, possibly with verbose output
+
+.PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
+$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu $(check-qtest-y)
+	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
+		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
+		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
+		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
+
+.PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
+$(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
+	$(call quiet-command, \
+		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
+		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
+
+# gtester tests with XML output
+
+$(patsubst %, check-report-qtest-%.xml, $(QTEST_TARGETS)): check-report-qtest-%.xml: $(check-qtest-y)
+	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
+		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
+	  gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
+
+check-report-unit.xml: $(check-unit-y)
+	$(call quiet-command,gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $^,"GTESTER","$@")
+
+# Reports and overall runs
+
+check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check-report-unit.xml
+	$(call quiet-command,$(SRC_PATH)/scripts/gtester-cat $^ > $@,"GEN","$@")
+
+check-report.html: check-report.xml
+	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
+
+# Per guest TCG tests
+
+LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_DIRS))
+BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
+CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
+RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
+
+ifeq ($(HAVE_USER_DOCKER),y)
+# Probe for the Docker Builds needed for each build
+$(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
+	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
+	$(if $(DOCKER_PREREQ), 					\
+		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
+endif
+
+build-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
+		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
+		"BUILD", "TCG tests for $*")
+
+run-tcg-tests-%: % build-tcg-tests-%
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
+		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" run-guest-tests, \
+		"RUN", "TCG tests for $*")
+
+clean-tcg-tests-%:
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
+
+.PHONY: build-tcg
+build-tcg: $(BUILD_TCG_TARGET_RULES)
+
+.PHONY: check-tcg
+check-tcg: $(RUN_TCG_TARGET_RULES)
+
+.PHONY: clean-tcg
+clean-tcg: $(CLEAN_TCG_TARGET_RULES)
+
+# Other tests
+
+QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
+
+.PHONY: check-tests/qemu-iotests-quick.sh
+check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+	$<
+
+.PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
+$(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
+	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
+		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
+		$^ >$*.test.out 2>$*.test.err; \
+		echo $$? >$*.test.exit, \
+		"TEST","$*.out")
+	@# Sanitize error messages (make them independent of build directory)
+	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$*.err -
+	@diff -u $(SRC_PATH)/$*.out $*.test.out
+	@diff -u $(SRC_PATH)/$*.exit $*.test.exit
+
+.PHONY: check-tests/qapi-schema/doc-good.texi
+check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
+	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
+
+.PHONY: check-decodetree
+check-decodetree:
+	$(call quiet-command, \
+	  cd $(SRC_PATH)/tests/decode && \
+          ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
+          TEST, decodetree.py)
+
+# Consolidated targets
+
+.PHONY: check-qapi-schema check-qtest check-unit check check-clean
+check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
+check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
+check-unit: $(patsubst %,check-%, $(check-unit-y))
+check-speed: $(patsubst %,check-%, $(check-speed-y))
+check-block: $(patsubst %,check-%, $(check-block-y))
+check: check-qapi-schema check-unit check-qtest check-decodetree
+check-clean:
+	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
+	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
+	rm -f tests/test-qapi-gen-timestamp
+
+clean: check-clean
+
+# Build the help program automatically
+
+all: $(QEMU_IOTESTS_HELPERS-y)
+
+-include $(wildcard tests/*.d)
+-include $(wildcard tests/libqos/*.d)
+
+endif
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 0e687b7512..756aa15e94 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -93,6 +93,18 @@ static void init_bootfile_x86(const char *bootpath)
     fclose(bootfile);
 }
 
+#include "tests/migration/s390x-a-b.h"
+
+static void init_bootfile_s390x(const char *bootpath)
+{
+    FILE *bootfile = fopen(bootpath, "wb");
+    size_t len = sizeof(s390x_a_b_elf);
+
+    g_assert_cmpint(fwrite(s390x_a_b_elf, len, 1, bootfile), ==, 1);
+    fclose(bootfile);
+}
+
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -451,6 +463,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s",
                                   accel, tmpfs, uri);
+    } else if (g_str_equal(arch, "s390x")) {
+        init_bootfile_s390x(bootpath);
+        cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
+                                  " -name source,debug-threads=on"
+                                  " -serial file:%s/src_serial -bios %s",
+                                  accel, tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 128M"
+                                  " -name target,debug-threads=on"
+                                  " -serial file:%s/dest_serial -bios %s"
+                                  " -incoming %s",
+                                  accel, tmpfs, bootpath, uri);
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/migration-test.c.orig b/tests/migration-test.c.orig
new file mode 100644
index 0000000000..0e687b7512
--- /dev/null
+++ b/tests/migration-test.c.orig
@@ -0,0 +1,780 @@
+/*
+ * QTest testcase for migration
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+#include "qemu/option.h"
+#include "qemu/range.h"
+#include "qemu/sockets.h"
+#include "chardev/char.h"
+#include "sysemu/sysemu.h"
+
+/* TODO actually test the results and get rid of this */
+#define qtest_qmp_discard_response(...) qobject_unref(qtest_qmp(__VA_ARGS__))
+
+const unsigned start_address = 1024 * 1024;
+const unsigned end_address = 100 * 1024 * 1024;
+bool got_stop;
+static bool uffd_feature_thread_id;
+
+#if defined(__linux__)
+#include <sys/syscall.h>
+#include <sys/vfs.h>
+#endif
+
+#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+
+static bool ufd_version_check(void)
+{
+    struct uffdio_api api_struct;
+    uint64_t ioctl_mask;
+
+    int ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
+
+    if (ufd == -1) {
+        g_test_message("Skipping test: userfaultfd not available");
+        return false;
+    }
+
+    api_struct.api = UFFD_API;
+    api_struct.features = 0;
+    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+        g_test_message("Skipping test: UFFDIO_API failed");
+        return false;
+    }
+    uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
+
+    ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
+                 (__u64)1 << _UFFDIO_UNREGISTER;
+    if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
+        g_test_message("Skipping test: Missing userfault feature");
+        return false;
+    }
+
+    return true;
+}
+
+#else
+static bool ufd_version_check(void)
+{
+    g_test_message("Skipping test: Userfault not available (builtdtime)");
+    return false;
+}
+
+#endif
+
+static const char *tmpfs;
+
+/* A simple PC boot sector that modifies memory (1-100MB) quickly
+ * outputting a 'B' every so often if it's still running.
+ */
+#include "tests/migration/x86-a-b-bootblock.h"
+
+static void init_bootfile_x86(const char *bootpath)
+{
+    FILE *bootfile = fopen(bootpath, "wb");
+
+    g_assert_cmpint(fwrite(x86_bootsect, 512, 1, bootfile), ==, 1);
+    fclose(bootfile);
+}
+
+/*
+ * Wait for some output in the serial output file,
+ * we get an 'A' followed by an endless string of 'B's
+ * but on the destination we won't have the A.
+ */
+static void wait_for_serial(const char *side)
+{
+    char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
+    FILE *serialfile = fopen(serialpath, "r");
+    const char *arch = qtest_get_arch();
+    int started = (strcmp(side, "src_serial") == 0 &&
+                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
+
+    g_free(serialpath);
+    do {
+        int readvalue = fgetc(serialfile);
+
+        if (!started) {
+            /* SLOF prints its banner before starting test,
+             * to ignore it, mark the start of the test with '_',
+             * ignore all characters until this marker
+             */
+            switch (readvalue) {
+            case '_':
+                started = 1;
+                break;
+            case EOF:
+                fseek(serialfile, 0, SEEK_SET);
+                usleep(1000);
+                break;
+            }
+            continue;
+        }
+        switch (readvalue) {
+        case 'A':
+            /* Fine */
+            break;
+
+        case 'B':
+            /* It's alive! */
+            fclose(serialfile);
+            return;
+
+        case EOF:
+            started = (strcmp(side, "src_serial") == 0 &&
+                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
+            fseek(serialfile, 0, SEEK_SET);
+            usleep(1000);
+            break;
+
+        default:
+            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            g_assert_not_reached();
+        }
+    } while (true);
+}
+
+static void stop_cb(void *opaque, const char *name, QDict *data)
+{
+    if (!strcmp(name, "STOP")) {
+        got_stop = true;
+    }
+}
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+GCC_FMT_ATTR(2, 3)
+static QDict *wait_command(QTestState *who, const char *command, ...)
+{
+    va_list ap;
+
+    va_start(ap, command);
+    qtest_qmp_vsend(who, command, ap);
+    va_end(ap);
+
+    return qtest_qmp_receive_success(who, stop_cb, NULL);
+}
+
+/*
+ * Note: caller is responsible to free the returned object via
+ * qobject_unref() after use
+ */
+static QDict *migrate_query(QTestState *who)
+{
+    return wait_command(who, "{ 'execute': 'query-migrate' }");
+}
+
+/*
+ * Note: caller is responsible to free the returned object via
+ * g_free() after use
+ */
+static gchar *migrate_query_status(QTestState *who)
+{
+    QDict *rsp_return = migrate_query(who);
+    gchar *status = g_strdup(qdict_get_str(rsp_return, "status"));
+
+    g_assert(status);
+    qobject_unref(rsp_return);
+
+    return status;
+}
+
+/*
+ * It's tricky to use qemu's migration event capability with qtest,
+ * events suddenly appearing confuse the qmp()/hmp() responses.
+ */
+
+static uint64_t get_migration_pass(QTestState *who)
+{
+    QDict *rsp_return, *rsp_ram;
+    uint64_t result;
+
+    rsp_return = migrate_query(who);
+    if (!qdict_haskey(rsp_return, "ram")) {
+        /* Still in setup */
+        result = 0;
+    } else {
+        rsp_ram = qdict_get_qdict(rsp_return, "ram");
+        result = qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
+    }
+    qobject_unref(rsp_return);
+    return result;
+}
+
+static void read_blocktime(QTestState *who)
+{
+    QDict *rsp_return;
+
+    rsp_return = migrate_query(who);
+    g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
+    qobject_unref(rsp_return);
+}
+
+static void wait_for_migration_status(QTestState *who,
+                                      const char *goal)
+{
+    while (true) {
+        bool completed;
+        char *status;
+
+        status = migrate_query_status(who);
+        completed = strcmp(status, goal) == 0;
+        g_assert_cmpstr(status, !=,  "failed");
+        g_free(status);
+        if (completed) {
+            return;
+        }
+        usleep(1000);
+    }
+}
+
+static void wait_for_migration_complete(QTestState *who)
+{
+    wait_for_migration_status(who, "completed");
+}
+
+static void wait_for_migration_pass(QTestState *who)
+{
+    uint64_t initial_pass = get_migration_pass(who);
+    uint64_t pass;
+
+    /* Wait for the 1st sync */
+    while (!got_stop && !initial_pass) {
+        usleep(1000);
+        initial_pass = get_migration_pass(who);
+    }
+
+    do {
+        usleep(1000);
+        pass = get_migration_pass(who);
+    } while (pass == initial_pass && !got_stop);
+}
+
+static void check_guests_ram(QTestState *who)
+{
+    /* Our ASM test will have been incrementing one byte from each page from
+     * 1MB to <100MB in order.
+     * This gives us a constraint that any page's byte should be equal or less
+     * than the previous pages byte (mod 256); and they should all be equal
+     * except for one transition at the point where we meet the incrementer.
+     * (We're running this with the guest stopped).
+     */
+    unsigned address;
+    uint8_t first_byte;
+    uint8_t last_byte;
+    bool hit_edge = false;
+    bool bad = false;
+
+    qtest_memread(who, start_address, &first_byte, 1);
+    last_byte = first_byte;
+
+    for (address = start_address + 4096; address < end_address; address += 4096)
+    {
+        uint8_t b;
+        qtest_memread(who, address, &b, 1);
+        if (b != last_byte) {
+            if (((b + 1) % 256) == last_byte && !hit_edge) {
+                /* This is OK, the guest stopped at the point of
+                 * incrementing the previous page but didn't get
+                 * to us yet.
+                 */
+                hit_edge = true;
+                last_byte = b;
+            } else {
+                fprintf(stderr, "Memory content inconsistency at %x"
+                                " first_byte = %x last_byte = %x current = %x"
+                                " hit_edge = %x\n",
+                                address, first_byte, last_byte, b, hit_edge);
+                bad = true;
+            }
+        }
+    }
+    g_assert_false(bad);
+}
+
+static void cleanup(const char *filename)
+{
+    char *path = g_strdup_printf("%s/%s", tmpfs, filename);
+
+    unlink(path);
+    g_free(path);
+}
+
+static void migrate_check_parameter(QTestState *who, const char *parameter,
+                                    long long value)
+{
+    QDict *rsp_return;
+
+    rsp_return = wait_command(who,
+                              "{ 'execute': 'query-migrate-parameters' }");
+    g_assert_cmpint(qdict_get_int(rsp_return, parameter), ==, value);
+    qobject_unref(rsp_return);
+}
+
+static void migrate_set_parameter(QTestState *who, const char *parameter,
+                                  long long value)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who,
+                    "{ 'execute': 'migrate-set-parameters',"
+                    "'arguments': { %s: %lld } }",
+                    parameter, value);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    migrate_check_parameter(who, parameter, value);
+}
+
+static void migrate_pause(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp = wait_command(who, "{ 'execute': 'migrate-pause' }");
+    qobject_unref(rsp);
+}
+
+static void migrate_recover(QTestState *who, const char *uri)
+{
+    QDict *rsp;
+
+    rsp = wait_command(who,
+                       "{ 'execute': 'migrate-recover', "
+                       "  'id': 'recover-cmd', "
+                       "  'arguments': { 'uri': %s } }",
+                       uri);
+    qobject_unref(rsp);
+}
+
+static void migrate_set_capability(QTestState *who, const char *capability,
+                                   bool value)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who,
+                    "{ 'execute': 'migrate-set-capabilities',"
+                    "'arguments': { "
+                    "'capabilities': [ { "
+                    "'capability': %s, 'state': %i } ] } }",
+                    capability, value);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+}
+
+/*
+ * Send QMP command "migrate".
+ * Arguments are built from @fmt... (formatted like
+ * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
+ */
+GCC_FMT_ATTR(3, 4)
+static void migrate(QTestState *who, const char *uri, const char *fmt, ...)
+{
+    va_list ap;
+    QDict *args, *rsp;
+
+    va_start(ap, fmt);
+    args = qdict_from_vjsonf_nofail(fmt, ap);
+    va_end(ap);
+
+    g_assert(!qdict_haskey(args, "uri"));
+    qdict_put_str(args, "uri", uri);
+
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': %p}", args);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+}
+
+static void migrate_postcopy_start(QTestState *from, QTestState *to)
+{
+    QDict *rsp;
+
+    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
+    qobject_unref(rsp);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
+}
+
+static int test_migrate_start(QTestState **from, QTestState **to,
+                               const char *uri, bool hide_stderr)
+{
+    gchar *cmd_src, *cmd_dst;
+    char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
+    const char *arch = qtest_get_arch();
+    const char *accel = "kvm:tcg";
+
+    got_stop = false;
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        init_bootfile_x86(bootpath);
+        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
+                                  " -name source,debug-threads=on"
+                                  " -serial file:%s/src_serial"
+                                  " -drive file=%s,format=raw",
+                                  accel, tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
+                                  " -name target,debug-threads=on"
+                                  " -serial file:%s/dest_serial"
+                                  " -drive file=%s,format=raw"
+                                  " -incoming %s",
+                                  accel, tmpfs, bootpath, uri);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -name source,debug-threads=on"
+                                  " -serial file:%s/src_serial"
+                                  " -prom-env '"
+                                  "boot-command=hex .\" _\" begin %x %x "
+                                  "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
+                                  "until'",  accel, tmpfs, end_address,
+                                  start_address);
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -name target,debug-threads=on"
+                                  " -serial file:%s/dest_serial"
+                                  " -incoming %s",
+                                  accel, tmpfs, uri);
+    } else {
+        g_assert_not_reached();
+    }
+
+    g_free(bootpath);
+
+    if (hide_stderr) {
+        gchar *tmp;
+        tmp = g_strdup_printf("%s 2>/dev/null", cmd_src);
+        g_free(cmd_src);
+        cmd_src = tmp;
+
+        tmp = g_strdup_printf("%s 2>/dev/null", cmd_dst);
+        g_free(cmd_dst);
+        cmd_dst = tmp;
+    }
+
+    *from = qtest_start(cmd_src);
+    g_free(cmd_src);
+
+    *to = qtest_init(cmd_dst);
+    g_free(cmd_dst);
+    return 0;
+}
+
+static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
+{
+    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
+
+    qtest_quit(from);
+
+    if (test_dest) {
+        qtest_memread(to, start_address, &dest_byte_a, 1);
+
+        /* Destination still running, wait for a byte to change */
+        do {
+            qtest_memread(to, start_address, &dest_byte_b, 1);
+            usleep(1000 * 10);
+        } while (dest_byte_a == dest_byte_b);
+
+        qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
+
+        /* With it stopped, check nothing changes */
+        qtest_memread(to, start_address, &dest_byte_c, 1);
+        usleep(1000 * 200);
+        qtest_memread(to, start_address, &dest_byte_d, 1);
+        g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+
+        check_guests_ram(to);
+    }
+
+    qtest_quit(to);
+
+    cleanup("bootsect");
+    cleanup("migsocket");
+    cleanup("src_serial");
+    cleanup("dest_serial");
+}
+
+static void deprecated_set_downtime(QTestState *who, const double value)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who,
+                    "{ 'execute': 'migrate_set_downtime',"
+                    " 'arguments': { 'value': %f } }", value);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    migrate_check_parameter(who, "downtime-limit", value * 1000);
+}
+
+static void deprecated_set_speed(QTestState *who, long long value)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who, "{ 'execute': 'migrate_set_speed',"
+                          "'arguments': { 'value': %lld } }", value);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    migrate_check_parameter(who, "max-bandwidth", value);
+}
+
+static void test_deprecated(void)
+{
+    QTestState *from;
+
+    from = qtest_start("");
+
+    deprecated_set_downtime(from, 0.12345);
+    deprecated_set_speed(from, 12345);
+
+    qtest_quit(from);
+}
+
+static int migrate_postcopy_prepare(QTestState **from_ptr,
+                                     QTestState **to_ptr,
+                                     bool hide_error)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, hide_error)) {
+        return -1;
+    }
+
+    migrate_set_capability(from, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-blocktime", true);
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    migrate_set_parameter(from, "max-bandwidth", 100000000);
+    migrate_set_parameter(from, "downtime-limit", 1);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+    g_free(uri);
+
+    wait_for_migration_pass(from);
+
+    *from_ptr = from;
+    *to_ptr = to;
+
+    return 0;
+}
+
+static void migrate_postcopy_complete(QTestState *from, QTestState *to)
+{
+    wait_for_migration_complete(from);
+
+    /* Make sure we get at least one "B" on destination */
+    wait_for_serial("dest_serial");
+
+    if (uffd_feature_thread_id) {
+        read_blocktime(to);
+    }
+
+    test_migrate_end(from, to, true);
+}
+
+static void test_postcopy(void)
+{
+    QTestState *from, *to;
+
+    if (migrate_postcopy_prepare(&from, &to, false)) {
+        return;
+    }
+    migrate_postcopy_start(from, to);
+    migrate_postcopy_complete(from, to);
+}
+
+static void test_postcopy_recovery(void)
+{
+    QTestState *from, *to;
+    char *uri;
+
+    if (migrate_postcopy_prepare(&from, &to, true)) {
+        return;
+    }
+
+    /* Turn postcopy speed down, 4K/s is slow enough on any machines */
+    migrate_set_parameter(from, "max-postcopy-bandwidth", 4096);
+
+    /* Now we start the postcopy */
+    migrate_postcopy_start(from, to);
+
+    /*
+     * Wait until postcopy is really started; we can only run the
+     * migrate-pause command during a postcopy
+     */
+    wait_for_migration_status(from, "postcopy-active");
+
+    /*
+     * Manually stop the postcopy migration. This emulates a network
+     * failure with the migration socket
+     */
+    migrate_pause(from);
+
+    /*
+     * Wait for destination side to reach postcopy-paused state.  The
+     * migrate-recover command can only succeed if destination machine
+     * is in the paused state
+     */
+    wait_for_migration_status(to, "postcopy-paused");
+
+    /*
+     * Create a new socket to emulate a new channel that is different
+     * from the broken migration channel; tell the destination to
+     * listen to the new port
+     */
+    uri = g_strdup_printf("unix:%s/migsocket-recover", tmpfs);
+    migrate_recover(to, uri);
+
+    /*
+     * Try to rebuild the migration channel using the resume flag and
+     * the newly created channel
+     */
+    wait_for_migration_status(from, "postcopy-paused");
+    migrate(from, uri, "{'resume': true}");
+    g_free(uri);
+
+    /* Restore the postcopy bandwidth to unlimited */
+    migrate_set_parameter(from, "max-postcopy-bandwidth", 0);
+
+    migrate_postcopy_complete(from, to);
+}
+
+static void test_baddest(void)
+{
+    QTestState *from, *to;
+    QDict *rsp_return;
+    char *status;
+    bool failed;
+
+    if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
+        return;
+    }
+    migrate(from, "tcp:0:0", "{}");
+    do {
+        status = migrate_query_status(from);
+        g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed")));
+        failed = !strcmp(status, "failed");
+        g_free(status);
+    } while (!failed);
+
+    /* Is the machine currently running? */
+    rsp_return = wait_command(from, "{ 'execute': 'query-status' }");
+    g_assert(qdict_haskey(rsp_return, "running"));
+    g_assert(qdict_get_bool(rsp_return, "running"));
+    qobject_unref(rsp_return);
+
+    test_migrate_end(from, to, false);
+}
+
+static void test_precopy_unix(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, false)) {
+        return;
+    }
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300 ms should converge */
+    migrate_set_parameter(from, "downtime-limit", 300);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to, true);
+    g_free(uri);
+}
+
+int main(int argc, char **argv)
+{
+    char template[] = "/tmp/migration-test-XXXXXX";
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (!ufd_version_check()) {
+        return 0;
+    }
+
+    /*
+     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
+     * is touchy due to race conditions on dirty bits (especially on PPC for
+     * some reason)
+     */
+    if (g_str_equal(qtest_get_arch(), "ppc64") &&
+        access("/sys/module/kvm_hv", F_OK)) {
+        g_test_message("Skipping test: kvm_hv not available");
+        return 0;
+    }
+
+    tmpfs = mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
+    }
+    g_assert(tmpfs);
+
+    module_call_init(MODULE_INIT_QOM);
+
+    qtest_add_func("/migration/postcopy/unix", test_postcopy);
+    qtest_add_func("/migration/postcopy/recovery", test_postcopy_recovery);
+    qtest_add_func("/migration/deprecated", test_deprecated);
+    qtest_add_func("/migration/bad_dest", test_baddest);
+    qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+
+    ret = g_test_run();
+
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = rmdir(tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s\n",
+                       tmpfs, strerror(errno));
+    }
+
+    return ret;
+}
diff --git a/tests/migration/s390x-a-b-rebuild.sh b/tests/migration/s390x-a-b-rebuild.sh
new file mode 100755
index 0000000000..b508befeea
--- /dev/null
+++ b/tests/migration/s390x-a-b-rebuild.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+srcdir=$(dirname $0)
+fwdir="$srcdir"/../../pc-bios/s390-ccw
+SRCFILE=$srcdir/s390x-a-b.c
+HEADER=$srcdir/s390x-a-b.h
+
+if [ ! -e "$SRCFILE" ]; then
+    echo "Couldn't find $SRCFILE" >&2
+    exit 1
+fi
+
+if [ $(uname -m) = "s390x" ]; then
+    cc=gcc
+    strip=strip
+else
+    cc=s390x-linux-gnu-gcc
+    strip=s390x-linux-gnu-strip
+fi
+
+tmpdir=$(mktemp -d --tmpdir X86BB.XXXXXX)
+$cc -ffreestanding -fno-delete-null-pointer-checks -fPIE -Os \
+    -msoft-float -march=z900 -fno-asynchronous-unwind-tables -Wl,-pie \
+    -Wl,--build-id=none -nostdlib -I"$fwdir" "$fwdir"/start.S \
+    "$fwdir"/sclp.c "$srcdir"/s390x-a-b.c -o "$tmpdir"/s390x-a-b.elf &&
+$strip --strip-unneeded "$tmpdir"/s390x-a-b.elf &&
+cd "$tmpdir" &&
+xxd -i s390x-a-b.elf | sed -e 's/.*int.*//' > "$tmpdir"/s390x-a-b.hex &&
+cd "$OLDPWD" &&
+cat - "$tmpdir"/s390x-a-b.hex <<HERE > "$HEADER"
+/*
+ * This file is automatically generated from tests/migration/s390x-a-b.c, edit
+ * that and then run tests/migration/s390x-a-b-rebuild.sh to update, and then
+ * remember to send both in your patch submission.
+ */
+HERE
+
+rm "$tmpdir"/s390x-a-b.hex "$tmpdir"/s390x-a-b.elf
+cd .. && rmdir "$tmpdir"
diff --git a/tests/migration/s390x-a-b.c b/tests/migration/s390x-a-b.c
new file mode 100644
index 0000000000..1ae720bb69
--- /dev/null
+++ b/tests/migration/s390x-a-b.c
@@ -0,0 +1,35 @@
+/*
+ * S390 guest code used in migration tests
+ *
+ * Copyright 2018 Thomas Huth, Red Hat Inc.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#define LOADPARM_LEN 8  /* Needed for sclp.h */
+
+#include <libc.h>
+#include <sclp.h>
+
+char stack[0x8000] __attribute__((aligned(4096)));
+
+#define START_ADDRESS  (1024 * 1024)
+#define END_ADDRESS    (100 * 1024 * 1024)
+
+void main(void)
+{
+    unsigned long addr;
+
+    sclp_setup();
+    sclp_print("A");
+
+    while (1) {
+        for (addr = START_ADDRESS; addr < END_ADDRESS; addr += 4096) {
+            *(volatile char *)addr += 1;  /* Change pages */
+        }
+        sclp_print("B");
+    }
+}
diff --git a/tests/migration/s390x-a-b.h b/tests/migration/s390x-a-b.h
new file mode 100644
index 0000000000..eb1bab4ae6
--- /dev/null
+++ b/tests/migration/s390x-a-b.h
@@ -0,0 +1,427 @@
+/*
+ * This file is automatically generated from tests/migration/s390x-a-b.c, edit
+ * that and then run tests/migration/s390x-a-b-rebuild.sh to update, and then
+ * remember to send both in your patch submission.
+ */
+unsigned char s390x_a_b_elf[] = {
+  0x7f, 0x45, 0x4c, 0x46, 0x02, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x16, 0x00, 0x00, 0x00, 0x01,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x90, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0xa0,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x38, 0x00, 0x07, 0x00, 0x40,
+  0x00, 0x0c, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x05,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x88, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x01, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
+  0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x01, 0xc8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc8,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc8, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
+  0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0x30, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x06,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f, 0x30, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x1f, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe8, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0xa0, 0xd0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+  0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x0f, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x30, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0xd0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xd0,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x64, 0x74, 0xe5, 0x51,
+  0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x10, 0x64, 0x74, 0xe5, 0x52, 0x00, 0x00, 0x00, 0x04,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f, 0x30, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x1f, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xd0, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0xd0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+  0x2f, 0x6c, 0x69, 0x62, 0x2f, 0x6c, 0x64, 0x36, 0x34, 0x2e, 0x73, 0x6f,
+  0x2e, 0x31, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
+  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x02, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xeb, 0xdf, 0xf0, 0x68,
+  0x00, 0x24, 0xc0, 0xd0, 0x00, 0x00, 0x02, 0x79, 0xa7, 0xfb, 0xff, 0x60,
+  0xc0, 0xe5, 0x00, 0x00, 0x00, 0xd0, 0xc0, 0x20, 0x00, 0x00, 0x02, 0x6d,
+  0xc0, 0xe5, 0x00, 0x00, 0x01, 0x32, 0xa5, 0x1e, 0x00, 0x10, 0xe3, 0x10,
+  0xd0, 0x00, 0x00, 0x21, 0xa7, 0x24, 0x00, 0x0d, 0xe3, 0x20, 0x10, 0x00,
+  0x00, 0x90, 0xa7, 0x2a, 0x00, 0x01, 0x42, 0x20, 0x10, 0x00, 0xa7, 0x1b,
+  0x10, 0x00, 0xa7, 0xf4, 0xff, 0xf2, 0xc0, 0x20, 0x00, 0x00, 0x02, 0x56,
+  0xc0, 0xe5, 0x00, 0x00, 0x01, 0x1a, 0xa5, 0x1e, 0x00, 0x10, 0xa7, 0xf4,
+  0xff, 0xed, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0xc0, 0xf0, 0x00, 0x00,
+  0x5e, 0xb8, 0xc0, 0x20, 0x00, 0x00, 0x0e, 0xc1, 0xc0, 0x30, 0x00, 0x00,
+  0x5e, 0xb2, 0xb9, 0x0b, 0x00, 0x32, 0xb9, 0x02, 0x00, 0x33, 0xa7, 0x84,
+  0x00, 0x19, 0xa7, 0x3b, 0xff, 0xff, 0xeb, 0x43, 0x00, 0x08, 0x00, 0x0c,
+  0xb9, 0x02, 0x00, 0x44, 0xb9, 0x04, 0x00, 0x12, 0xa7, 0x84, 0x00, 0x09,
+  0xd7, 0xff, 0x10, 0x00, 0x10, 0x00, 0x41, 0x10, 0x11, 0x00, 0xa7, 0x47,
+  0xff, 0xfb, 0xc0, 0x20, 0x00, 0x00, 0x00, 0x07, 0x44, 0x30, 0x20, 0x00,
+  0xa7, 0xf4, 0xff, 0xaa, 0xd7, 0x00, 0x10, 0x00, 0x10, 0x00, 0xc0, 0x10,
+  0x00, 0x00, 0x00, 0x29, 0xb2, 0xb2, 0x10, 0x00, 0xeb, 0x00, 0xf0, 0x00,
+  0x00, 0x25, 0x96, 0x02, 0xf0, 0x06, 0xeb, 0x00, 0xf0, 0x00, 0x00, 0x2f,
+  0xc0, 0x10, 0x00, 0x00, 0x00, 0x11, 0xe3, 0x10, 0x01, 0xb8, 0x00, 0x24,
+  0xc0, 0x10, 0x00, 0x00, 0x00, 0x26, 0xd2, 0x07, 0x01, 0xb0, 0x10, 0x00,
+  0xc0, 0x10, 0x00, 0x00, 0x00, 0x18, 0xb2, 0xb2, 0x10, 0x00, 0xeb, 0x00,
+  0xf0, 0x00, 0x00, 0x25, 0x94, 0xfd, 0xf0, 0x06, 0xeb, 0x00, 0xf0, 0x00,
+  0x00, 0x2f, 0x07, 0xfe, 0x07, 0x07, 0x07, 0x07, 0x00, 0x02, 0x00, 0x01,
+  0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x03, 0x02, 0x00, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x80, 0x00, 0x00, 0x00,
+  0xeb, 0xdf, 0xf0, 0x68, 0x00, 0x24, 0xc0, 0x10, 0x00, 0x00, 0x16, 0x4d,
+  0xa7, 0xfb, 0xff, 0x60, 0xb2, 0x20, 0x00, 0x21, 0xb2, 0x22, 0x00, 0xd0,
+  0x88, 0xd0, 0x00, 0x1c, 0xc0, 0xe5, 0xff, 0xff, 0xff, 0xba, 0xa7, 0xde,
+  0x00, 0x03, 0xa7, 0x84, 0x00, 0x0c, 0xa7, 0xde, 0x00, 0x02, 0xa7, 0x28,
+  0x00, 0x00, 0xa7, 0x74, 0x00, 0x08, 0xa7, 0x28, 0xff, 0xfe, 0xa7, 0xf4,
+  0x00, 0x04, 0xa7, 0x28, 0xff, 0xff, 0xeb, 0xdf, 0xf1, 0x08, 0x00, 0x04,
+  0xb9, 0x14, 0x00, 0x22, 0x07, 0xfe, 0x07, 0x07, 0xc0, 0x50, 0x00, 0x00,
+  0x01, 0x1c, 0xc0, 0x10, 0x00, 0x00, 0x16, 0x25, 0xa7, 0x48, 0x00, 0x1c,
+  0x50, 0x20, 0x10, 0x0c, 0x40, 0x40, 0x10, 0x00, 0xe3, 0x20, 0x50, 0x00,
+  0x00, 0x04, 0xa7, 0x48, 0x00, 0x04, 0x50, 0x30, 0x10, 0x10, 0x40, 0x40,
+  0x10, 0x0a, 0xc0, 0xf4, 0xff, 0xff, 0xff, 0xc3, 0xa7, 0x29, 0x00, 0x00,
+  0xa7, 0x39, 0x00, 0x40, 0xc0, 0xf4, 0xff, 0xff, 0xff, 0xe4, 0x07, 0x07,
+  0xeb, 0xaf, 0xf0, 0x50, 0x00, 0x24, 0xc0, 0xd0, 0x00, 0x00, 0x00, 0xfd,
+  0xa7, 0x2a, 0xff, 0xff, 0xa7, 0xfb, 0xff, 0x60, 0x55, 0x20, 0xd0, 0x10,
+  0xa7, 0x24, 0x00, 0x4a, 0xa7, 0xa9, 0x00, 0x00, 0xa7, 0x19, 0x00, 0x00,
+  0xc0, 0x20, 0x00, 0x00, 0x15, 0xf6, 0xa7, 0x4b, 0x00, 0x01, 0xa7, 0x47,
+  0x00, 0x04, 0xa7, 0xf4, 0x00, 0x21, 0xa7, 0x59, 0x00, 0x01, 0xb9, 0x08,
+  0x00, 0x51, 0xe3, 0x50, 0xd0, 0x08, 0x00, 0x21, 0xa7, 0x24, 0x00, 0x18,
+  0x41, 0xba, 0x30, 0x00, 0x95, 0x0a, 0xb0, 0x00, 0xa7, 0x74, 0x00, 0x08,
+  0xa7, 0x08, 0x00, 0x0d, 0x42, 0x01, 0x20, 0x0e, 0xb9, 0x04, 0x00, 0x15,
+  0x43, 0x5a, 0x30, 0x00, 0xa7, 0xab, 0x00, 0x01, 0x42, 0x51, 0x20, 0x0e,
+  0x41, 0x10, 0x10, 0x01, 0xa7, 0xf4, 0xff, 0xdf, 0xc0, 0x20, 0x00, 0x00,
+  0x15, 0xce, 0xa7, 0x38, 0x00, 0x0e, 0x1a, 0x31, 0xa7, 0x1a, 0x00, 0x06,
+  0x40, 0x30, 0x20, 0x00, 0x92, 0x00, 0x20, 0x02, 0x40, 0x10, 0x20, 0x08,
+  0x92, 0x1a, 0x20, 0x0a, 0x92, 0x00, 0x20, 0x0b, 0xe3, 0x20, 0xd0, 0x00,
+  0x00, 0x04, 0xc0, 0xe5, 0xff, 0xff, 0xff, 0x69, 0xb9, 0x04, 0x00, 0x2a,
+  0xa7, 0xf4, 0x00, 0x04, 0xa7, 0x29, 0xff, 0xff, 0xe3, 0x40, 0xf1, 0x10,
+  0x00, 0x04, 0xeb, 0xaf, 0xf0, 0xf0, 0x00, 0x04, 0x07, 0xf4, 0x07, 0x07,
+  0xb9, 0x04, 0x00, 0x32, 0xa7, 0x49, 0x00, 0x00, 0x43, 0x14, 0x30, 0x00,
+  0xa7, 0x11, 0x00, 0xff, 0xa7, 0x84, 0x00, 0x06, 0xa7, 0x4b, 0x00, 0x01,
+  0xa7, 0xf4, 0xff, 0xf8, 0xa7, 0x29, 0x00, 0x01, 0xc0, 0xf4, 0xff, 0xff,
+  0xff, 0x90, 0x07, 0x07, 0xeb, 0xbf, 0xf0, 0x58, 0x00, 0x24, 0xc0, 0xd0,
+  0x00, 0x00, 0x00, 0x95, 0xc0, 0x30, 0x00, 0x00, 0x15, 0x8e, 0xa7, 0x19,
+  0x00, 0x20, 0xa7, 0xfb, 0xff, 0x60, 0xb9, 0x04, 0x00, 0xb2, 0x92, 0x00,
+  0x30, 0x00, 0xa7, 0x3b, 0x00, 0x01, 0xa7, 0x17, 0xff, 0xfc, 0xc0, 0x10,
+  0x00, 0x00, 0x15, 0x7f, 0xa7, 0x28, 0x00, 0x20, 0x40, 0x20, 0x10, 0x00,
+  0xe3, 0x20, 0xd0, 0x00, 0x00, 0x04, 0xc0, 0xe5, 0xff, 0xff, 0xff, 0x25,
+  0x12, 0x22, 0xa7, 0x74, 0x00, 0x17, 0xa7, 0x19, 0x00, 0x00, 0xc0, 0x40,
+  0x00, 0x00, 0x00, 0x7d, 0xc0, 0x50, 0x00, 0x00, 0x15, 0x76, 0xa7, 0x39,
+  0x00, 0x08, 0xe3, 0x21, 0x50, 0x00, 0x00, 0x90, 0x43, 0x22, 0x40, 0x00,
+  0x42, 0x21, 0xb0, 0x00, 0xa7, 0x1b, 0x00, 0x01, 0xa7, 0x37, 0xff, 0xf7,
+  0xe3, 0x40, 0xf1, 0x10, 0x00, 0x04, 0xeb, 0xbf, 0xf0, 0xf8, 0x00, 0x04,
+  0x07, 0xf4, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0xeb, 0xaf, 0xf0, 0x50,
+  0x00, 0x24, 0xc0, 0xd0, 0x00, 0x00, 0x00, 0x55, 0xa7, 0xfb, 0xff, 0x60,
+  0xb9, 0x04, 0x00, 0xb2, 0xe3, 0x30, 0xd0, 0x08, 0x00, 0x21, 0xb9, 0x04,
+  0x00, 0xa3, 0xa7, 0xc4, 0x00, 0x04, 0xa7, 0xa9, 0x0f, 0xf8, 0xc0, 0x10,
+  0x00, 0x00, 0x15, 0x3d, 0xa7, 0x28, 0x10, 0x00, 0xa7, 0xab, 0x00, 0x01,
+  0x40, 0x20, 0x10, 0x00, 0x92, 0x00, 0x10, 0x02, 0xe3, 0x20, 0xd0, 0x00,
+  0x00, 0x04, 0xc0, 0xe5, 0xff, 0xff, 0xfe, 0xdf, 0xa7, 0x19, 0x00, 0x00,
+  0xc0, 0x20, 0x00, 0x00, 0x15, 0x2a, 0xa7, 0xa7, 0x00, 0x13, 0xc0, 0x10,
+  0x00, 0x00, 0x15, 0x25, 0xe3, 0x40, 0xf1, 0x10, 0x00, 0x04, 0xeb, 0xaf,
+  0xf0, 0xf0, 0x00, 0x04, 0xe3, 0x20, 0x10, 0x08, 0x00, 0x91, 0xa7, 0x2a,
+  0xff, 0xf9, 0xb9, 0x14, 0x00, 0x22, 0x07, 0xf4, 0x43, 0x31, 0x20, 0x0f,
+  0x42, 0x31, 0xb0, 0x00, 0xa7, 0x1b, 0x00, 0x01, 0xa7, 0xf4, 0xff, 0xe7,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x78, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x76, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f, 0xf7,
+  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x77, 0x00, 0x05,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f, 0xf8, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x20, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x3c, 0x28, 0x2b, 0x7c, 0x26, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x21, 0x24, 0x2a, 0x29, 0x3b, 0x2e, 0x2d, 0x2f, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2c, 0x25, 0x5f, 0x3e, 0x3f,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x60, 0x3a, 0x23,
+  0x40, 0x27, 0x3d, 0x22, 0x2e, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+  0x68, 0x69, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x6a, 0x6b, 0x6c,
+  0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x41, 0x42, 0x43,
+  0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x2e, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51, 0x52, 0x2e, 0x2e,
+  0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
+  0x59, 0x5a, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x30, 0x31, 0x32, 0x33,
+  0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
+  0x41, 0x00, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x06, 0x3f, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x6f, 0xff, 0xfe, 0xf5, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x01, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x28, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xf8,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0b,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x6f, 0xff, 0xff, 0xfb, 0x00, 0x00, 0x00, 0x00,
+  0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x47, 0x43, 0x43, 0x3a, 0x20, 0x28, 0x47, 0x4e,
+  0x55, 0x29, 0x20, 0x34, 0x2e, 0x38, 0x2e, 0x35, 0x20, 0x32, 0x30, 0x31,
+  0x35, 0x30, 0x36, 0x32, 0x33, 0x20, 0x28, 0x52, 0x65, 0x64, 0x20, 0x48,
+  0x61, 0x74, 0x20, 0x34, 0x2e, 0x38, 0x2e, 0x35, 0x2d, 0x31, 0x36, 0x29,
+  0x00, 0x00, 0x2e, 0x73, 0x68, 0x73, 0x74, 0x72, 0x74, 0x61, 0x62, 0x00,
+  0x2e, 0x69, 0x6e, 0x74, 0x65, 0x72, 0x70, 0x00, 0x2e, 0x67, 0x6e, 0x75,
+  0x2e, 0x68, 0x61, 0x73, 0x68, 0x00, 0x2e, 0x64, 0x79, 0x6e, 0x73, 0x79,
+  0x6d, 0x00, 0x2e, 0x64, 0x79, 0x6e, 0x73, 0x74, 0x72, 0x00, 0x2e, 0x74,
+  0x65, 0x78, 0x74, 0x00, 0x2e, 0x72, 0x6f, 0x64, 0x61, 0x74, 0x61, 0x00,
+  0x2e, 0x64, 0x79, 0x6e, 0x61, 0x6d, 0x69, 0x63, 0x00, 0x2e, 0x67, 0x6f,
+  0x74, 0x00, 0x2e, 0x62, 0x73, 0x73, 0x00, 0x2e, 0x63, 0x6f, 0x6d, 0x6d,
+  0x65, 0x6e, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc8,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc8, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0x6f, 0xff, 0xff, 0xf6,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x01, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xd8,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x00, 0x00, 0x03,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1d,
+  0x00, 0x00, 0x00, 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xf8, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x01, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30,
+  0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18,
+  0x00, 0x00, 0x00, 0x25, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x28,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x28, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2d, 0x00, 0x00, 0x00, 0x01,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x02, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xb8, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x33,
+  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0xe8, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x05, 0xe8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x48,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x3b, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x30,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f, 0x30, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0xd0, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x01,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x49,
+  0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x10, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x4e, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x18, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x2d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x03,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x45,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x57, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
-- 
2.17.1
