Received: from eggs.gnu.org ([2001:4830:134:3::10]:41800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d9No5-0007ur-N3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 23:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d9No2-0005CA-Hg
	for qemu-devel@nongnu.org; Fri, 12 May 2017 23:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d9No2-00059E-8Z
	for qemu-devel@nongnu.org; Fri, 12 May 2017 23:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6E048553F
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 03:33:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 13 May 2017 00:33:13 -0300
Message-Id: <20170513033316.22395-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] script for crash-testing -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Changes v1 -> v2:
* Use a simpler method to query QEMU exit code in qemu.py
* Use only qemu.py module, instead of qtest.py
* New whitelist entries:
  * "could not find stage1 bootloader"
  * Segfaults when using devices: a15mpcore_priv, sb16, cs4231a, arm-gicv3
* Format "success" line using formatTestCase(), and using DEBUG
  loglevel
* Reword "test case:" line with "running test case:", for clarity
* Fix "pc-.*" whitelist to include "q35" too
* Add --devtype option to test only a specific device type
* Send all log messages to stdout instead of stderr
* Avoid printing "obsolete whitelist entry?" messages if we know
  we are not testing every single accel/machine/device
  combination
* --quick mode, to skip cases where failures are always expected,
  and to print a warning in case we don't get an expected failure
* Use qemu.QEMUMachine instead of qtest.QEMUQtestMachine, as we don't
  use any of the QEMUQtestMachine features
* Fix handling of multiple '-t' options
* Simplify code that generate random sample of test cases

This series adds scripts/device-crashtest.py, that can be used to
crash-test -device with multiple machine/accel/device
combinations.

The script found a few crashes on some machines/devices. A dump
of existing cases can be seen here:
  https://gist.github.com/ehabkost/503b0af0375f0d98d3e84017e8ca54eb

The script contains a whitelist that can also be useful as
documentation of existing ways -device can fail or crash.

Note that the script takes a few hours to run on the default mode
(testing all accel/machine/device combinations), but the "-r N"
option can be used to make it only test N random samples.

Example script output:

  $ ../scripts/device-crash-test.py -v --shuffle
  INFO: test case: machine=verdex binary=./aarch64-softmmu/qemu-system-aarch64 device=exynos4210-ehci-usb accel=tcg
  INFO: test case: machine=none binary=./aarch64-softmmu/qemu-system-aarch64 device=onenand accel=tcg
  INFO: test case: machine=pc-i440fx-2.2 binary=./x86_64-softmmu/qemu-system-x86_64 device=ide-cd accel=kvm
  INFO: success: ./x86_64-softmmu/qemu-system-x86_64 -S -machine pc-i440fx-2.2,accel=kvm -device ide-cd
  INFO: test case: machine=SPARCClassic binary=./sparc-softmmu/qemu-system-sparc device=memory accel=tcg
  qemu received signal 6: -S -machine SPARCClassic,accel=tcg -device memory
  ERROR: failed: machine=SPARCClassic binary=./sparc-softmmu/qemu-system-sparc device=memory accel=tcg
  ERROR: cmdline: ./sparc-softmmu/qemu-system-sparc -S -machine SPARCClassic,accel=tcg -device memory
  ERROR: log: qemu-system-sparc: /root/qemu-build/exec.c:1500: find_ram_offset: Assertion `size != 0' failed.
  ERROR: exit code: -6
  INFO: test case: machine=romulus-bmc binary=./arm-softmmu/qemu-system-arm device=ich9-usb-uhci6 accel=tcg
  INFO: test case: machine=ref405ep binary=./ppc-softmmu/qemu-system-ppc device=ivshmem-doorbell accel=tcg
  INFO: test case: machine=romulus-bmc binary=./aarch64-softmmu/qemu-system-aarch64 device=l2x0 accel=tcg
  INFO: test case: machine=pc-i440fx-1.7 binary=./x86_64-softmmu/qemu-system-x86_64 device=virtio-input-host-pci accel=tcg
  INFO: test case: machine=none binary=./ppc-softmmu/qemu-system-ppc device=virtio-tablet-pci accel=tcg
  INFO: test case: machine=terrier binary=./aarch64-softmmu/qemu-system-aarch64 device=sst25vf016b accel=tcg
  INFO: success: ./aarch64-softmmu/qemu-system-aarch64 -S -machine terrier,accel=tcg -device sst25vf016b
  INFO: test case: machine=none binary=./i386-softmmu/qemu-system-i386 device=intel-iommu accel=kvm
  qemu received signal 6: -S -machine none,accel=kvm -device intel-iommu
  ERROR: failed: machine=none binary=./i386-softmmu/qemu-system-i386 device=intel-iommu accel=kvm
  ERROR: cmdline: ./i386-softmmu/qemu-system-i386 -S -machine none,accel=kvm -device intel-iommu
  ERROR: log: /root/qemu-build/hw/i386/intel_iommu.c:2565:vtd_realize: Object 0x7fe117fabfb0 is not an instance of type generic-pc-machine
  ERROR: exit code: -6
  INFO: test case: machine=tosa binary=./aarch64-softmmu/qemu-system-aarch64 device=integrator_core accel=tcg
  INFO: test case: machine=isapc binary=./i386-softmmu/qemu-system-i386 device=i82550 accel=kvm
  INFO: test case: machine=xlnx-ep108 binary=./aarch64-softmmu/qemu-system-aarch64 device=digic accel=tcg
  qemu received signal 6: -S -machine xlnx-ep108,accel=tcg -device digic
  ERROR: failed: machine=xlnx-ep108 binary=./aarch64-softmmu/qemu-system-aarch64 device=digic accel=tcg
  ERROR: cmdline: ./aarch64-softmmu/qemu-system-aarch64 -S -machine xlnx-ep108,accel=tcg -device digic
  ERROR: log: audio: Could not init `oss' audio driver
  ERROR: log: Unexpected error in qemu_chr_fe_init() at /root/qemu-build/chardev/char.c:512:
  ERROR: log: qemu-system-aarch64: -device digic: Device 'serial0' is in use
  ERROR: exit code: -6
  INFO: test case: machine=raspi2 binary=./arm-softmmu/qemu-system-arm device=sd-card accel=tcg
  INFO: success: ./arm-softmmu/qemu-system-arm -S -machine raspi2,accel=tcg -device sd-card
  [...]

Eduardo Habkost (3):
  qemu.py: Don't set _popen=None on error/shutdown
  qemu.py: Add QEMUMachine.exitcode() method
  scripts: Test script to look for -device crashes

 scripts/device-crash-test.py | 520 +++++++++++++++++++++++++++++++++++++++++++
 scripts/qemu.py              |  16 +-
 2 files changed, 531 insertions(+), 5 deletions(-)
 create mode 100755 scripts/device-crash-test.py

-- 
2.11.0.259.g40922b1
