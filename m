Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkmop-0003pv-9F
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkmoo-0007J7-1e
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkmon-0007Iw-RO
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFDB13683C
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 07:44:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Aug 2017 08:21:59 +0100
Message-Id: <20170824072202.26818-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] iotests: clean up resources using context
 managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This series introduces context managers for the two most commonly used
resources: files and VMs.  Context managers eliminate the need to call a
cleanup function explicitly.

Tests should declare resources upfront in a with statement.  Resources are
automatically cleaned up whether the test passes or fails:

  with FilePath('test.img') as img_path,
       VM() as vm:
      ...test...
  # img_path is deleted and vm is shut down automatically

The final patch converts 194 to use context managers instead of
atexit.register().  This makes the code shorter and easier to read.

Stefan Hajnoczi (3):
  qemu.py: make VM() a context manager
  iotests.py: add FilePath context manager
  qemu-iotests: use context managers for resource cleanup in 194

 scripts/qemu.py               | 16 ++++++++-
 tests/qemu-iotests/194        | 83 +++++++++++++++++++++----------------------
 tests/qemu-iotests/iotests.py | 26 ++++++++++++++
 3 files changed, 82 insertions(+), 43 deletions(-)

-- 
2.13.5
