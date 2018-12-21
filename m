Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gaUWN-00059N-4q
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 18:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gaUWM-0004pk-IS
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 18:47:59 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 22 Dec 2018 00:47:47 +0100
Message-Id: <20181221234750.23577-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] iotests: Allow 147 to be run concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

147 currently cannot be run concurrently for two reasons:

(1) It creates TCP/IP NBD servers on a fixed port.

(2) It uses a mix of "0.0.0.0", "localhost", and "::1" as host addresses
    to bind to.  As explained in the commit messages of patches 2 and 3,
    this results in it potentially actually being able to set up two
    servers on the same port at the same time -- but connecting to one
    will always lead to the IPv6 server (regardless of whether you use
    "localhost" or "::1").  Therefore, even if you get two servers
    running concurrently, one of the tests will still break because it
    connects to the wrong one.

This series fixes these issues.


Note that even if you do not care about concurrency, it still is a good
idea to make 147 not use a fixed port to create NBD servers on, as it
may always be already in use by a totally different application.


Max Reitz (3):
  iotests.py: Add qemu_nbd_pipe()
  iotests: Bind qemu-nbd to localhost in 147
  iotests: Allow 147 to be run concurrently

 tests/qemu-iotests/147        | 98 ++++++++++++++++++++++++-----------
 tests/qemu-iotests/iotests.py | 14 +++++
 2 files changed, 82 insertions(+), 30 deletions(-)

--=20
2.19.2
