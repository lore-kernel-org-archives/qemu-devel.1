Received: from eggs.gnu.org ([2001:4830:134:3::10]:44889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6ZVw-0005Kn-CU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6ZVt-0002uM-BM
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6ZVt-0002u6-5g
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:59:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C9DAC050043
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:59:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 10:59:04 +0100
Message-Id: <20171023095910.23202-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/6] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new Linux-specific memory backend, similar to hostmem-file,
except that it doesn't need file path. It also try to enforce memory
sealing if available. It is thus slightly easier and secure, and is
compatible with transparent huge-pages since Linux 4.8.

Since Linux 4.14, memfd supports explicit hugetlb, however without
sealing.

v5:
- add memfd hugetlb support
- add seal and hugeltb options to memfd memory backend
- update qemu-option to explain sharing works with vhost-user for now
- rebased, misc code changes

v4:
- rebased, now that preliminary patches are merged

v3:
- make vhost-user-test use memfd only if possible
- rebased

v1->v2:
- make it linux-specific
- minor changes and commit message tweaks

Marc-Andr=C3=A9 Lureau (6):
  memfd: split qemu_memfd_alloc()
  memfd: remove needless include
  memfd: add error argument, instead of perror()
  memfd: add hugetlb support
  Add memfd based hostmem
  tests: use memfd in vhost-user-test

 include/qemu/memfd.h     |   4 +-
 backends/hostmem-memfd.c | 124 +++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/virtio/vhost.c        |   8 ++-
 tests/vhost-user-test.c  |  70 ++++++++++++++++----------
 util/memfd.c             | 101 ++++++++++++++++++++++----------------
 backends/Makefile.objs   |   2 +
 qemu-options.hx          |  15 ++++++
 7 files changed, 256 insertions(+), 68 deletions(-)
 create mode 100644 backends/hostmem-memfd.c

--=20
2.15.0.rc0.40.gaefcc5f6f
