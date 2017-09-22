Received: from eggs.gnu.org ([2001:4830:134:3::10]:42244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvTJt-0001D2-0b
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvTJo-0005XF-I4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dvTJo-0005Wt-8y
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68E2B4A6F4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 19:08:55 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-77.ams2.redhat.com
	[10.36.117.77])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C471A5D9CB
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 19:08:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 21:08:53 +0200
Message-Id: <20170922190853.1911-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/32] Misc patches for 2017-09-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98da=
e6:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2017-09-20 20:33:48 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to bb86d05f4afab3ebfee2e897e295d61dbd8cc28e:

  chardev: remove context in chr_update_read_handler (2017-09-22 21:07:27=
 +0200)

----------------------------------------------------------------
* Speed up AddressSpaceDispatch creation (Alexey)
* Fix kvm.c assert (David)
* Memory fixes and further speedup (me)
* Persistent reservation manager infrastructure (me)
* virtio-serial: add enable_backend callback (Pavel)
* chardev GMainContext fixes (Peter)

----------------------------------------------------------------
Alexey Kardashevskiy (17):
      exec: Explicitly export target AS from address_space_translate_inte=
rnal
      memory: Open code FlatView rendering
      memory: Move FlatView allocation to a helper
      memory: Move AddressSpaceDispatch from AddressSpace to FlatView
      memory: Remove AddressSpace pointer from AddressSpaceDispatch
      memory: Switch memory from using AddressSpace to FlatView
      memory: Cleanup after switching to FlatView
      memory: Rename mem_begin/mem_commit/mem_add helpers
      memory: Store physical root MR in FlatView
      memory: Alloc dispatch tree where topology is generared
      memory: Move address_space_update_ioeventfds
      memory: Share FlatView's and dispatch trees between address spaces
      memory: Do not allocate FlatView in address_space_init
      memory: Rework "info mtree" to print flat views and dispatch trees
      memory: Get rid of address_space_init_shareable
      memory: Create FlatView directly
      memory: Share special empty FlatView

David Hildenbrand (1):
      kvm: drop wrong assertion creating problems with pflash

KONRAD Frederic (1):
      memory: avoid a name clash with access macro

Paolo Bonzini (8):
      atomic: update documentation
      memory: avoid "resurrection" of dead FlatViews
      memory: trace FlatView creation and destruction
      memory: seek FlatView sharing candidates among children subregions
      scsi, file-posix: add support for persistent reservation management
      scsi: build qemu-pr-helper
      scsi: add multipath support to qemu-pr-helper
      scsi: add persistent reservation manager using qemu-pr-helper

Pavel Butsykin (1):
      virtio-serial: add enable_backend callback

Peter Xu (4):
      chardev: new qemu_chr_be_update_read_handlers()
      chardev: add Chardev.gcontext field
      chardev: use per-dev context for io_add_watch_poll
      chardev: remove context in chr_update_read_handler

 Makefile                          |    7 +-
 Makefile.objs                     |    1 +
 accel/kvm/kvm-all.c               |    1 -
 block/file-posix.c                |   30 ++
 chardev/char-fd.c                 |    5 +-
 chardev/char-fe.c                 |    7 +-
 chardev/char-pty.c                |    5 +-
 chardev/char-socket.c             |    7 +-
 chardev/char-udp.c                |    5 +-
 chardev/char.c                    |   11 +
 configure                         |   60 ++-
 cpus.c                            |    5 +-
 docs/devel/atomics.txt            |   14 +-
 docs/interop/pr-helper.rst        |   83 +++
 docs/pr-manager.rst               |  111 ++++
 exec.c                            |  330 +++++++-----
 hmp-commands-info.hx              |    7 +-
 hw/arm/armv7m.c                   |    9 +-
 hw/char/virtio-console.c          |   21 +
 hw/char/virtio-serial-bus.c       |    7 +
 hw/intc/openpic_kvm.c             |    2 +-
 include/chardev/char.h            |   13 +-
 include/exec/memory-internal.h    |   16 +-
 include/exec/memory.h             |   75 ++-
 include/hw/arm/armv7m.h           |    2 +-
 include/hw/virtio/virtio-serial.h |    3 +
 include/qemu/atomic.h             |    8 +
 include/qemu/typedefs.h           |    1 +
 include/scsi/pr-manager.h         |   56 ++
 include/scsi/utils.h              |    4 +
 memory.c                          |  378 ++++++++++---
 monitor.c                         |    3 +-
 qapi/block-core.json              |    4 +
 scsi/Makefile.objs                |    2 +
 scsi/pr-helper.h                  |   41 ++
 scsi/pr-manager-helper.c          |  302 +++++++++++
 scsi/pr-manager.c                 |  109 ++++
 scsi/qemu-pr-helper.c             | 1075 +++++++++++++++++++++++++++++++=
++++++
 scsi/trace-events                 |    3 +
 scsi/utils.c                      |   10 +
 target/arm/cpu.c                  |   16 +-
 target/i386/cpu.c                 |    5 +-
 trace-events                      |    3 +
 vl.c                              |    3 +-
 44 files changed, 2550 insertions(+), 310 deletions(-)
 create mode 100644 docs/interop/pr-helper.rst
 create mode 100644 docs/pr-manager.rst
 create mode 100644 include/scsi/pr-manager.h
 create mode 100644 scsi/pr-helper.h
 create mode 100644 scsi/pr-manager-helper.c
 create mode 100644 scsi/pr-manager.c
 create mode 100644 scsi/qemu-pr-helper.c
 create mode 100644 scsi/trace-events
--=20
2.13.5
