Received: from eggs.gnu.org ([2001:4830:134:3::10]:53272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA9-0001rx-1d
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA5-0001M5-UH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHA5-0001Lq-Oh
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F5328123A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:38 +0100
Message-Id: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/9] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new Linux-specific memory backend, similar to hostmem-file,
except that it doesn't need file path. It also try to enforce memory
sealing if available. It is thus slightly easier and secure, and is
compatible with transparent huge-pages since Linux 4.8.

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
 tests/vhost-user-test.c  |  14 +++---
 util/memfd.c             |  42 ++++++++++-------
 backends/Makefile.objs   |   2 +
 qemu-options.hx          |  11 +++++
 11 files changed, 229 insertions(+), 99 deletions(-)
 create mode 100644 backends/hostmem-memfd.c

--=20
2.11.0
