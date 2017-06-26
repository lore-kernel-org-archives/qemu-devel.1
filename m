Received: from eggs.gnu.org ([2001:4830:134:3::10]:39989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPTEl-0007Lt-5Z
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPTEk-0001Va-95
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:35:27 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 26 Jun 2017 13:35:05 +0100
Message-Id: <20170626123510.20134-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/5] Improve I/O tests coverage of LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The main goal of this series is to get the I/O tests passing
100% with LUKS when run with './check -luks'. It also adds a
few more combinations to the LUKS/dmcrypt interoperability
test.

To make LUKS testing not quite as slow, we drop the PBKDF
iteration count down to a very small value. This doesn't
remove all overhead, as formatting the volume will always
measure PBKDF timing over a 1 second interval.

Changed in v6:

 - Fix quoting of $TEST_IMG (Eric/Max)
 - Remove accidental use of tabs (Max)
 - Drop unused SYSEMU_EXTRA_ARGS (Max)
 - Remove accidental import of 'time' module (Max)

Changed in v5:

 - Rebase to kevin/block  git tree instead of master
 - Fix LUKS compat in new test 181

Changed in v4:

 - Fix misc mistakes in syntax conversion (Max)
 - Drop changes to 120 & mark it unsupported (Max)
 - Use _unsupported_fmt (Max)

Changed in v3:

 - Fix some typos in commit message(s) (Eric)

Changed in v2:

 - Split off patch that change check.time recording since
   it was not a direct dependancy
 - Skip new 159 & 170 tests which don't work due to qemu-img
   dd limitations

Daniel P. Berrange (5):
  iotests: skip 159 & 170 with luks format
  iotests: fix remainining tests to work with LUKS
  iotests: reduce PBKDF iterations when testing LUKS
  iotests: add more LUKS hash combination tests
  iotests: chown LUKS device before qemu-io launches

 tests/qemu-iotests/033           |   12 +-
 tests/qemu-iotests/120           |    1 +
 tests/qemu-iotests/140           |    9 +-
 tests/qemu-iotests/145           |   19 +-
 tests/qemu-iotests/149           |   25 +-
 tests/qemu-iotests/149.out       | 1002 ++++++++++++++++++++++++++++----------
 tests/qemu-iotests/157           |   17 +-
 tests/qemu-iotests/157.out       |   16 +-
 tests/qemu-iotests/159           |    1 +
 tests/qemu-iotests/170           |    1 +
 tests/qemu-iotests/174           |    2 +-
 tests/qemu-iotests/181           |   21 +-
 tests/qemu-iotests/common.filter |    3 +-
 tests/qemu-iotests/common.qemu   |    9 +-
 tests/qemu-iotests/common.rc     |    3 +
 15 files changed, 841 insertions(+), 300 deletions(-)

-- 
2.9.3
