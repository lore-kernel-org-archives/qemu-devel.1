Received: from eggs.gnu.org ([2001:4830:134:3::10]:46426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKtL-0003Q4-PO
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKtK-0002V2-Ow
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:17:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyKtK-0002Ua-Kp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:17:42 -0400
Date: Tue, 20 Mar 2018 19:17:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521566230-111929-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2 0/3] migration: usefaultfd cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>

We normally do not need to bother with ifdefs around
specific system-calls. userfaultfd turns out to be
different because our unistd import into linux-headers
is incomplete: it's missing asm-generic bits,
some arm and mips headers.

Fix it up, and drop ifdefs for usefaultfd.

Tested on x86 only.

Pls consider merging this through the migration tree.

Michael S. Tsirkin (3):
  update-linux-headers.sh: add unistd.h
  linux-headers: add asm-generic/unistd.h
  postcopy: drop unnecessary conditions

 linux-headers/asm-arm/bitsperlong.h     |   1 +
 linux-headers/asm-arm64/bitsperlong.h   |  24 +
 linux-headers/asm-generic/bitsperlong.h |  16 +
 linux-headers/asm-generic/unistd.h      | 944 ++++++++++++++++++++++++++++++++
 linux-headers/asm-mips/bitsperlong.h    |   9 +
 linux-headers/asm-mips/unistd.h         |  44 +-
 linux-headers/asm-powerpc/bitsperlong.h |  13 +
 linux-headers/asm-s390/bitsperlong.h    |  14 +
 linux-headers/asm-x86/bitsperlong.h     |  14 +
 migration/postcopy-ram.c                |   4 +-
 tests/migration-test.c                  |   2 +-
 scripts/update-linux-headers.sh         |  17 +-
 12 files changed, 1085 insertions(+), 17 deletions(-)
 create mode 100644 linux-headers/asm-arm/bitsperlong.h
 create mode 100644 linux-headers/asm-arm64/bitsperlong.h
 create mode 100644 linux-headers/asm-generic/bitsperlong.h
 create mode 100644 linux-headers/asm-generic/unistd.h
 create mode 100644 linux-headers/asm-mips/bitsperlong.h
 create mode 100644 linux-headers/asm-powerpc/bitsperlong.h
 create mode 100644 linux-headers/asm-s390/bitsperlong.h
 create mode 100644 linux-headers/asm-x86/bitsperlong.h

-- 
MST
