Received: from eggs.gnu.org ([209.51.188.92]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nKr-0001SO-6l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nKp-00048U-HK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:20:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nKp-00046a-72
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:20:55 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:20:25 -0800
Message-Id: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 00/37] Initial support of
 multi-process qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Initial support of multi-process qemu

CCing people who were discussing this functionality with Jag
during KVM forum last (2018) year to continue the conversation.

Started with the presentation in October 2017 made by
Marc-Andre (Red Hat) and Konrad Wilk (Oracle)
(http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf,
https://www.youtube.com/watch?v=Kq1-coHh7lg) and
continued in the BoF session at the KVM forum in 2018 with Jag leading
the discussion, the multi-process project is now in the prototype version
and presented by this patchset.

The proof of the concept patches were posted on the qemu-devel mailing
list before the BoF session at the KVM forum and can be found here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html

This series presents the initial support for QEMU that can
launch some of the devices in the remote processes.

We would like to present set of RFC patches with some extention to the previous
patches and hoping that we can continue working on the patches with the community
feedback. Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>

Great QEMU code is the result of the efforts of many excellent
contributors and Coverity (static-analyzer) shows defect density
lower than in Linux kernel!
>From a security perspective, this is fantastic.
But as we all know new features and sometimes even bug-fixes
can bring in security bugs. We want to squash
them as soon as possible. Also, some of the older code may still
have security bugs lurking in it that haven't yet been explored.
Hence this patch set aims at minimizing the attack vectors
by splitting and minimizing the size of the text _without_
losing the wealth of features.
Being able to launch separate processes for emulation of
certain subsystems allow for providing for each remote process
only the privileges it needs to provide its service,
e.g., a disk service could be given access only the the
disk images it provides, and not be allowed to access other
files, or any network devices.
An attacker who compromised this service would not be able
to use this exploit to access files or devices beyond what
the disk service was given access to.

For full concept writeup about QEMU disaggregation refer to
docs/devel/qemu-multiprocess.txt.

This series has a limited scope and allows QEMU to launch
LSI SCSI controller emulation in the separate process and
execute HMP commands to manipulate the devices.

Please refer to the docs/qemu-multiprocess.txt for usage
information.

This series is based on qemu upstream (on top of the commit
commit 32694e98b8d7a246345448a8f707d2e11d6c65e2).

In the future we hope to work on:
  - live migration;
  - performance improvements;
  - support for more devices;
  - support for CPU disaggregated emulation;

We would like to welcome all your ideas, concerns and questions
for this patchset.

Thank you!

Elena Ufimtseva (15):
  multi-process: add a command line option for debug file
  multi-process: introduce proxy object
  multi-process: store info about the remote process
  multi-process: add command line options rdrive and rdevice
  multi-process: pass proxy link socket fd to remote process
  multi-process: configure remote side devices
  multi-process: add qdev_proxy_add to create proxy devices
  multi-process: remote: add setup_devices and setup_drive msg
    processing
  multi-process: remote: use fd for socket from parent process
  multi-process: remote: add create_done condition
  multi-process: add processing of rdrive and rdevice command line
  multi-process: add heartbeat timer and signal handler
  multi-process: handle heartbit messages in remote process
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess
  multi-process: add configure and usage information

Jagannathan Raman (22):
  multi-process: memory: alloc RAM from file at offset
  multi-process: util: Add qemu_thread_cancel() to cancel running thread
  multi-process: Add stub functions to facilate build of multi-process
  multi-process: Add config option for multi-process QEMU
  multi-process: build system for remote device process
  multi-process: define proxy-link object
  multi-process: add functions to synchronize proxy and remote endpoints
  multi-process: setup PCI host bridge for remote device
  multi-process: setup a machine object for remote device process
  multi-process: setup memory manager for remote device
  multi-process: remote process initialization
  multi-process: PCI BAR write handling for proxy & remote endpoints
  multi-process: PCI BAR read handling for proxy & remote endpoints
  multi-process: Add LSI device proxy object
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Add QMP & HMP commands to list remote processes
  multi-process: QMP/HMP commands to add a device to the remote process
  multi-process: QMP/HMP commands to remove device from the remote
    process
  multi-process: HMP command to add drive to the remote device
  multi-process: HMP command to delete drive from remote device
  multi-process: QMP/HMP commands to resize block device on remote
    process

 Makefile                            |    5 +-
 Makefile.objs                       |   22 +
 Makefile.target                     |   53 +-
 accel/stubs/kvm-stub.c              |    5 +
 accel/stubs/tcg-stub.c              |   85 +++
 backends/Makefile.objs              |    2 +
 block/Makefile.objs                 |    2 +
 blockdev.c                          |   12 +
 configure                           |   11 +
 docs/devel/qemu-multiprocess.txt    | 1109 +++++++++++++++++++++++++++++++++++
 docs/qemu-multiprocess.txt          |  104 ++++
 exec.c                              |   12 +-
 hmp-commands.hx                     |   88 +++
 hmp.h                               |    4 +
 hw/Makefile.objs                    |    9 +
 hw/block/Makefile.objs              |    2 +
 hw/core/Makefile.objs               |   14 +
 hw/i386/pc.c                        |    1 +
 hw/nvram/Makefile.objs              |    2 +
 hw/pci/Makefile.objs                |    4 +
 hw/proxy/Makefile.objs              |    3 +
 hw/proxy/memory-sync.c              |  214 +++++++
 hw/proxy/monitor.c                  |  338 +++++++++++
 hw/proxy/proxy-lsi53c895a.c         |  162 +++++
 hw/proxy/qemu-proxy.c               |  461 +++++++++++++++
 hw/scsi/Makefile.objs               |    2 +
 include/exec/address-spaces.h       |    2 +
 include/exec/ram_addr.h             |    2 +-
 include/glib-compat.h               |    4 +
 include/hw/i386/pc.h                |    3 +
 include/hw/pci/pci_ids.h            |    3 +
 include/hw/proxy/memory-sync.h      |   51 ++
 include/hw/proxy/proxy-lsi53c895a.h |   42 ++
 include/hw/proxy/qemu-proxy.h       |   90 +++
 include/hw/qdev-core.h              |    1 +
 include/io/proxy-link.h             |  189 ++++++
 include/monitor/qdev.h              |    9 +
 include/qemu/log.h                  |    1 +
 include/qemu/mmap-alloc.h           |    2 +-
 include/qemu/thread.h               |    1 +
 include/remote/iohub.h              |   63 ++
 include/remote/machine.h            |   48 ++
 include/remote/memory.h             |   34 ++
 include/remote/pcihost.h            |   58 ++
 include/sysemu/blockdev.h           |    1 +
 include/sysemu/sysemu.h             |    3 +
 io/Makefile.objs                    |    2 +
 io/proxy-link.c                     |  301 ++++++++++
 memory.c                            |    2 +-
 migration/Makefile.objs             |    2 +
 monitor.c                           |    7 +
 qapi/block-core.json                |   54 ++
 qapi/misc.json                      |   49 ++
 qdev-monitor.c                      |  170 +++++-
 qemu-options.hx                     |   26 +
 qom/Makefile.objs                   |    4 +
 remote/Makefile.objs                |    4 +
 remote/iohub.c                      |  159 +++++
 remote/machine.c                    |  141 +++++
 remote/memory.c                     |   98 ++++
 remote/pcihost.c                    |   84 +++
 remote/remote-main.c                |  585 ++++++++++++++++++
 stubs/machine-init-done.c           |    4 +
 stubs/monitor.c                     |   25 +
 stubs/net-stub.c                    |   31 +
 stubs/replay.c                      |   14 +
 stubs/vl-stub.c                     |   75 +++
 stubs/vmstate.c                     |   20 +
 stubs/xen-mapcache.c                |   22 +
 util/log.c                          |    2 +
 util/mmap-alloc.c                   |    5 +-
 util/oslib-posix.c                  |    2 +-
 util/qemu-thread-posix.c            |   10 +
 vl.c                                |   76 +++
 74 files changed, 5291 insertions(+), 16 deletions(-)
 create mode 100644 docs/devel/qemu-multiprocess.txt
 create mode 100644 docs/qemu-multiprocess.txt
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 hw/proxy/monitor.c
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/memory-sync.h
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h
 create mode 100644 include/hw/proxy/qemu-proxy.h
 create mode 100644 include/io/proxy-link.h
 create mode 100644 include/remote/iohub.h
 create mode 100644 include/remote/machine.h
 create mode 100644 include/remote/memory.h
 create mode 100644 include/remote/pcihost.h
 create mode 100644 io/proxy-link.c
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/iohub.c
 create mode 100644 remote/machine.c
 create mode 100644 remote/memory.c
 create mode 100644 remote/pcihost.c
 create mode 100644 remote/remote-main.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/vl-stub.c
 create mode 100644 stubs/xen-mapcache.c

-- 
1.8.3.1
