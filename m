Received: from eggs.gnu.org ([2001:4830:134:3::10]:37147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiA-0004YP-Pn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAi7-0003nx-Kl
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:50 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:51117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAi7-0003jv-AY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:47 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b195so5727649wmb.5
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:45 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	u186sm2596278wmd.19.2017.09.21.16.16.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Sep 2017 16:16:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:08 +0200
Message-Id: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/32] Misc changes for 2017-09-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98dae6:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-09-20 20:33:48 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 165d4d2a77f470b6f095ec665b1d274c8ceede0a:

  chardev: remove context in chr_update_read_handler (2017-09-22 01:13:58 +0200)

----------------------------------------------------------------
* Speed up AddressSpaceDispatch creation (Alexey)
* Fix kvm.c assert (David)
* Memory fixes and further speedup (me)
* Persistent reservation manager infrastructure (me)
* virtio-serial: add enable_backend callback (Pavel)
* chardev GMainContext fixes (Peter)

----------------------------------------------------------------
Alexey Kardashevskiy (17):
      exec: Explicitly export target AS from address_space_translate_internal
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
 memory.c                          |  378 ++++++++++----
 monitor.c                         |    3 +-
 qapi/block-core.json              |    4 +
 scsi/Makefile.objs                |    2 +
 scsi/pr-helper.h                  |   41 ++
 scsi/pr-manager-helper.c          |  302 +++++++++++
 scsi/pr-manager.c                 |  109 ++++
 scsi/qemu-pr-helper.c             | 1038 +++++++++++++++++++++++++++++++++++++
 scsi/trace-events                 |    3 +
 scsi/utils.c                      |   10 +
 target/arm/cpu.c                  |   16 +-
 target/i386/cpu.c                 |    5 +-
 trace-events                      |    3 +
 vl.c                              |    3 +-
 44 files changed, 2513 insertions(+), 310 deletions(-)
 create mode 100644 docs/interop/pr-helper.rst
 create mode 100644 docs/pr-manager.rst
 create mode 100644 include/scsi/pr-manager.h
 create mode 100644 scsi/pr-helper.h
 create mode 100644 scsi/pr-manager-helper.c
 create mode 100644 scsi/pr-manager.c
 create mode 100644 scsi/qemu-pr-helper.c
 create mode 100644 scsi/trace-events
-- 
1.8.3.1
