Received: from eggs.gnu.org ([2001:4830:134:3::10]:33081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Ci2-0003Ct-Jv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Chy-0007JQ-ME
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:46:58 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Chy-0007Ih-Eu
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:46:54 -0400
Received: by mail-qk0-x241.google.com with SMTP id d74so5975622qkg.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:46:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:35 -0300
Message-Id: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/7] avocado: Add acceptance tests parsing
 the Linux boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>

Hi,

While previously working on a Super I/O refactor, I encountered some problems
at runtime, after building the codebase successfully and running qtests.
I had to manually start to boot different guests and check the bootlog.

I wanted to give a try at Avocado which seems designed to simplify that kind
of functional tests.

I applied Amador Pahim work following Cleber Rosa documentation from
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03891.html,
however I had to modify few things to parse the boot console.
Since his work is not merged, I included it in this series.

The tests simply expect to find a string reported by Linux printk when a
device is detected/initialized, such "ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A"
and "i8042 KBD port at 0x60,0x64 irq 1" for the Super I/O chip, or such
"registered as PCnet/PCI II 79C970A" to confirms the PCI subsystem and network
device are correctly detected:


    self.assertIn(u'ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A', bootlog)
    self.assertIn(u'ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A', bootlog)
    self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
    self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)

Example of the tests output:

    $ avocado run test_linux-boot-console.py -m test_linux-boot-console.py.data/parameters.yaml 
    JOB ID     : 695094c9bbe8f6011226da7c2031c2c53e949910
    JOB LOG    : /home/phil/avocado/job-results/job-2018-04-19T13.36-695094c/job.log
     (1/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boot_console;alpha-2582: PASS (4.76 s)
     (2/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boot_console;mips-4a72: PASS (0.00 s)
     (3/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boot_console;alpha-2582: PASS (0.00 s)
     (4/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boot_console;mips-4a72: PASS (3.92 s)
     (5/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boot_console;alpha-2582: PASS (0.00 s)
     (6/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boot_console;mips-4a72: PASS (4.08 s)
    RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
    JOB TIME   : 13.31 s

Please apologize my ugly Python, this series is just a proof-of-concept :)
I couldn't figure out how to use the @skipUnless(correct arch) decorator.

Regards,

Phil.

Amador Pahim (1):
  AVOCADO_QEMU: Snapshot commit

Philippe Mathieu-Daudé (6):
  avocado: Update python scripts to upstream codebase
  qemu.py: Check console arch is supported before calling mktemp()
  qemu.py: Avoid deprecated tempfile.mktemp()
  avocado: Add an optional flag 'login' to get_console()
  avocado: Add a test parsing Linux kernel booting console
  avocado: Add tests booting the Malta machine

 scripts/qemu.py                               |  50 ++-
 tests/avocado/README.rst                      | 132 ++++++
 tests/avocado/avocado_qemu/__init__.py        |   0
 tests/avocado/avocado_qemu/test.py            | 419 ++++++++++++++++++
 tests/avocado/parameters.yaml                 |  19 +
 tests/avocado/test_info_memdev_host_nodes.py  |  66 +++
 tests/avocado/test_linux-boot-console.py      | 180 ++++++++
 .../parameters.yaml                           |   5 +
 tests/avocado/test_nec-usb-xhci.py            |  63 +++
 .../test_nec-usb-xhci.py.data/parameters.yaml |   4 +
 tests/avocado/test_numa_hotplug.py            | 120 +++++
 tests/avocado/test_ovmf_with_240_vcpus.py     |  70 +++
 .../parameters.yaml                           |   2 +
 tests/avocado/variants.yaml                   |  62 +++
 14 files changed, 1187 insertions(+), 5 deletions(-)
 create mode 100644 tests/avocado/README.rst
 create mode 100644 tests/avocado/avocado_qemu/__init__.py
 create mode 100644 tests/avocado/avocado_qemu/test.py
 create mode 100644 tests/avocado/parameters.yaml
 create mode 100644 tests/avocado/test_info_memdev_host_nodes.py
 create mode 100644 tests/avocado/test_linux-boot-console.py
 create mode 100644 tests/avocado/test_linux-boot-console.py.data/parameters.yaml
 create mode 100644 tests/avocado/test_nec-usb-xhci.py
 create mode 100644 tests/avocado/test_nec-usb-xhci.py.data/parameters.yaml
 create mode 100644 tests/avocado/test_numa_hotplug.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py.data/parameters.yaml
 create mode 100644 tests/avocado/variants.yaml

-- 
2.17.0
