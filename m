Received: from eggs.gnu.org ([2001:4830:134:3::10]:37337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74Kw-000582-K3
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74Kt-0001oG-9c
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:18 -0400
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 13 Apr 2018 22:26:02 +0300
Message-Id: <20180413192605.2145-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] qemu-nbd: Disallow listing exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

oVirt uses random URLs to expose images temporarily via HTTPS. We would
like to integrated qemu-nbd in the same system, proving a user an easy
and uniform way to access an image - either using HTTPS:

    https://server:54322/images/dc72d3cc-b933-45e8-89a2-e028e1c2ef3d

Or using NBD over TLS:

    nbd://server:10809/dc72d3cc-b933-45e8-89a2-e028e1c2ef3d

Unfortunatly, qemu-nbd allows listing exports by default. Allowing
anyone to find the secret export using easy to guess port number.

These patches:
- add --nolist option to qemu-nbd, disabling NBD_OPT_LIST command.
- add some infrastructure ot iotests.py
- and use the new infrastructure to add test the new option using
  nbd-client.

Adding dependency on nbd-client may be probelematic, but I think
qemu-nbd should have tests ensuring compatibility with other tools.

Nir Soffer (3):
  nbd: Add option to disallow listing exports
  iotests.py: Add helper for running commands
  qemu-iotests: Test new qemu-nbd --nolist option

 blockdev-nbd.c                |  2 +-
 include/block/nbd.h           |  1 +
 nbd/server.c                  |  7 +++++++
 qemu-nbd.c                    |  9 ++++++++-
 qemu-nbd.texi                 |  2 ++
 tests/qemu-iotests/214        | 46 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out    |  2 ++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 18 +++++++++++++++++
 9 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out

-- 
2.14.3
