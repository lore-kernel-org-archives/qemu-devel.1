Received: from eggs.gnu.org ([2001:4830:134:3::10]:51297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhF-0000ey-QM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhC-0001mU-LP
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:51 -0300
Message-Id: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/6] QTests: use Python to run complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi,

With this series we can now write tests using Python rather than C.
For complex tests this can reduce the test development time, we can focus on
the test purposes instead of his implementation details.

- 1,2: we already have Python classes to run Block tests, move all the
  non Block-related methods to qtest.py,
- 3: default TEST_DIR to TMPDIR,
- 4: add a method to restrict tests to a list of supported machines,
- 5: since the Block tests are output sensitive, do not mess with their
  current tuned iotests::main(unittest), add a more generic one in qtest.py,
- 6: finally modify the tests Makefile to run C/Python tests with the same
  rule.

to have a better idea, here is a snippet from the next series:

    class TestSdCardSpecV2(qtest.QMPTestCase):
        [...]
        def test_power_on_spec_v2(self):
            self.bus.do_cmd(GO_IDLE_STATE)
            [...]
            # verify Card ID
            data = self.bus.do_cmd(ALL_SEND_CID)
            oid, pnm, psn = struct.unpack(">x2s5sxLxxx", data)
            self.assertEqual(oid, "XY") # QEMU default
            self.assertEqual(pnm, "QEMU!") # QEMU default
            self.assertEqual(psn, 0xdeadbeef) # QEMU default

The test suite is ran the same way:

$ make check-qtest-aarch64 
  GTESTER check-qtest-aarch64
  PYTEST  check-qtest-aarch64

Adding the verbose flag we see the SD bus commands:

$ make check-qtest-aarch64 V=1
TEST: tests/test-hmp... (pid=16074)
...
  /aarch64/hmp/xlnx-zcu102:                                            OK
  /aarch64/hmp/lm3s811evb:                                             OK
  /aarch64/hmp/none+2MB:                                               OK
PASS: tests/test-hmp
PYTHONPATH=/source/qemu/scripts QEMU_PROG=aarch64-softmmu/qemu-system-aarch64 TEST_DIR=/tmp python -B /source/qemu/tests/sdcard_tests.py -v
INFO:root:CMD#00 -> (none)
INFO:root:CMD#08 -> 00000100
INFO:root:CMD#08 -> 00000200
INFO:root:CMD#08 -> 00000400
INFO:root:CMD#08 -> 00000800
INFO:root:CMD#08 -> 00001000
INFO:root:CMD#08 -> 00002000
INFO:root:CMD#55 -> 00000120
INFO:root:CMD#41 -> 00ffff00
INFO:root:CMD#55 -> 00000120
INFO:root:CMD#41 -> 80ffff00
INFO:root:CMD#02 -> aa585951454d552101deadbeef006219
INFO:root:CMD#03 -> 45670500
INFO:root:CMD#03 -> 8ace0700
.
----------------------------------------------------------------------
Ran 1 test in 0.070s

OK

Regards,

Phil.

Based-on: 20171213204436.5379-12-f4bug@amsat.org
          (QOM'ify SDBus, housekeeping)

Philippe Mathieu-Daudé (6):
  iotests.py: split BlockQMPTestCase class of QMPTestCase
  iotests.py: move the generic QMPTestCase to qtest.py
  qtest.py: use TMPDIR/TEMP if the TEST_DIR env var is missing
  qtest.py: add verify_machine(supported_machines)
  qtest.py: add a simple main() which calls unittest.main()
  tests: add a Makefile rule to run Python qtests

 scripts/qtest.py              | 152 ++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include        |  11 ++-
 tests/qemu-iotests/030        |  14 ++--
 tests/qemu-iotests/040        |   2 +-
 tests/qemu-iotests/041        |  20 +++---
 tests/qemu-iotests/044        |   2 +-
 tests/qemu-iotests/045        |   4 +-
 tests/qemu-iotests/055        |   8 +--
 tests/qemu-iotests/056        |   4 +-
 tests/qemu-iotests/057        |   2 +-
 tests/qemu-iotests/065        |   2 +-
 tests/qemu-iotests/093        |   6 +-
 tests/qemu-iotests/096        |   2 +-
 tests/qemu-iotests/118        |   2 +-
 tests/qemu-iotests/124        |   2 +-
 tests/qemu-iotests/129        |   2 +-
 tests/qemu-iotests/132        |   2 +-
 tests/qemu-iotests/136        |   2 +-
 tests/qemu-iotests/139        |   2 +-
 tests/qemu-iotests/147        |   2 +-
 tests/qemu-iotests/148        |   2 +-
 tests/qemu-iotests/152        |   2 +-
 tests/qemu-iotests/155        |   2 +-
 tests/qemu-iotests/163        |   2 +-
 tests/qemu-iotests/165        |   2 +-
 tests/qemu-iotests/196        |   2 +-
 tests/qemu-iotests/iotests.py |  84 ++---------------------
 27 files changed, 212 insertions(+), 127 deletions(-)

-- 
2.15.1
