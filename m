Received: from eggs.gnu.org ([2001:4830:134:3::10]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5aY6-0007Fu-3h
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5aY5-00011a-AA
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:25:46 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:42491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5aY5-00011E-4g
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:25:45 -0400
Received: by mail-ot0-x232.google.com with SMTP id h55-v6so9516827ote.9
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 10:25:45 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 18:25:23 +0100
Message-ID: <CAFEAcA9=mNacWgm_7uWPSpaiNbM5zWmHj+YKrVmZoL9YUgRdJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] tests/Makefile.include gtester rules defeat attempts
 to parallelize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I noticed that the rules for gtester in tests/Makefile.include
work against attempts to parallelize "make check" with make's
-j argument, because from Make's point of view we run a
single command which looks like

gtester tests/endianness-test tests/fdc-test tests/ide-test
tests/ahci-test tests/hd-geo-test tests/boot-order-test
tests/bios-tables-test tests/boot-serial-test tests/pxe-test
tests/rtc-test tests/ipmi-kcs-test tests/ipmi-bt-test
tests/i440fx-test tests/fw_cfg-test tests/drive_del-test
tests/wdt_ib700-test tests/tco-test tests/e1000-test tests/e1000e-test
tests/rtl8139-test tests/pcnet-test tests/eepro100-test
tests/ne2000-test tests/nvme-test tests/ac97-test tests/es1370-test
tests/virtio-net-test tests/virtio-balloon-test tests/virtio-blk-test
tests/virtio-rng-test tests/virtio-scsi-test tests/virtio-serial-test
tests/virtio-console-test tests/tpci200-test tests/ipoctal232-test
tests/display-vga-test tests/intel-hda-test tests/megasas-test
tests/vmxnet3-test tests/pvpanic-test tests/i82801b11-test
tests/ioh3420-test tests/usb-hcd-ohci-test tests/usb-hcd-uhci-test
tests/usb-hcd-ehci-test tests/usb-hcd-xhci-test tests/cpu-plug-test
tests/q35-test tests/vmgenid-test tests/tpm-crb-test
tests/tpm-tis-test tests/test-netfilter tests/test-filter-mirror
tests/test-filter-redirector tests/migration-test
tests/test-x86-cpuid-compat tests/numa-test tests/qmp-test
tests/device-introspect-test tests/machine-none-test tests/qom-test
tests/test-hmp

and then all of those individual tests/foo-test get run in series
by gtester, rather than being possibly parallelized by make.

Does anybody feel like playing around with the makefile
rules to see if they can make that a bit less serialized?

thanks
-- PMM
