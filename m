Received: from eggs.gnu.org ([2001:4830:134:3::10]:59282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEuN-0004NQ-CM
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEuH-0008La-Oq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehEuH-0008KZ-Iy
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A44B6C0587F0
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 13:28:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 14:27:50 +0100
Message-Id: <20180201132757.23063-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 0/7] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series adds a new memory backend, similar to hostmem-file, except
that it doesn't need to create files. It also enforces memory sealing.

This backend is mainly useful for sharing the memory with other
processes.

Note that Linux supports transparent huge-pages of shmem/memfd memory
since 4.8. It is relatively easier to set up THP than a dedicate
hugepage mount point by using "madvise" in
/sys/kernel/mm/transparent_hugepage/shmem_enabled.

Since 4.14, memfd allows to set hugetlb requirement explicitly.

Pending for merge in 4.16 is memfd sealing support for hugetlb backed
memory.

Usage:
-object memory-backend-memfd,id=3Dmem1,size=3D1G

v7:
- fix a small memory leak
- update documentation and commit messages
- rebased

v6:
- add hugetlbsize option
- run vhost-user read-guest-mem test with memfile & memfd backend

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

v2:
- make it linux-specific
- minor changes and commit message tweaks

Marc-Andr=C3=A9 Lureau (7):
  memfd: add error argument, instead of perror()
  memfd: add hugetlb support
  memfd: add hugetlbsize argument
  Add memfd based hostmem
  tests: keep compiling failing vhost-user tests
  vhost-user-test: make read-guest-mem setup its own qemu
  tests: use memfd in vhost-user-test

 include/qemu/memfd.h     |   5 +-
 backends/hostmem-memfd.c | 170 +++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/virtio/vhost.c        |   8 ++-
 tests/vhost-user-test.c  | 128 +++++++++++++++++++++++------------
 util/memfd.c             |  78 ++++++++++++++--------
 backends/Makefile.objs   |   2 +
 qemu-options.hx          |  22 ++++++
 7 files changed, 340 insertions(+), 73 deletions(-)
 create mode 100644 backends/hostmem-memfd.c

--=20
2.16.0.rc1.1.gef27df75a1
