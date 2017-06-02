Received: from eggs.gnu.org ([2001:4830:134:3::10]:50712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnJf-000789-V7
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnJc-00030X-NW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:12:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGnJc-00030N-HO
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:12:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5ED5419CF96
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:12:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 18:12:20 +0400
Message-Id: <20170602141229.15326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/9] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new Linux-specific memory backend, similar to hostmem-file,
except that it doesn't need file path. It also try to enforce memory
sealing if available. It is thus slightly easier and secure, and is
compatible with transparent huge-pages since Linux 4.8.

The first 6 patches are mostly cleanups and could be considered
regardless of memfd hostmem acceptability.

v3:
- make vhost-user-test use memfd only if possible
- rebased

v1->v2:
- make it linux-specific
- minor changes and commit message tweaks

Marc-Andr=C3=A9 Lureau (9):
  exec: check kvm mmu notifiers earlier
  exec: split file_ram_alloc()
  exec: split qemu_ram_alloc_from_file()
  Add memory_region_init_ram_from_fd()
  ivshmem: use ram_from_fd()
  memory: remove memory_region_set_fd
  memfd: split qemu_memfd_alloc()
  Add memfd based hostmem
  tests: use memfd in vhost-user-test

 include/exec/memory.h    |  31 ++++++++-----
 include/exec/ram_addr.h  |   3 ++
 include/qemu/memfd.h     |   2 +
 backends/hostmem-memfd.c |  67 +++++++++++++++++++++++++++
 exec.c                   | 116 ++++++++++++++++++++++++++++-------------=
------
 hw/misc/ivshmem.c        |  14 +++---
 memory.c                 |  26 +++++++----
 tests/vhost-user-test.c  |  68 +++++++++++++++++----------
 util/memfd.c             |  42 ++++++++++-------
 backends/Makefile.objs   |   2 +
 qemu-options.hx          |  11 +++++
 11 files changed, 266 insertions(+), 116 deletions(-)
 create mode 100644 backends/hostmem-memfd.c

--=20
2.13.0.91.g00982b8dd
