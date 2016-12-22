Received: from eggs.gnu.org ([2001:4830:134:3::10]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5m5-00077U-Az
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5m2-0003XS-9z
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5m2-0003X2-29
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05A7D7AEB3
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:59:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:59:04 +0100
Message-Id: <20161222155915.7232-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

This moves out of libqemustub.a those functions which can be handled
simply by $(call lnot), like we already do for pci-stub.c or kvm-stub.c.
libqemustub.a keep the more complex cases where a small part of the
executables we build needs an implementation of a small subset of an API.

Paolo

Paolo Bonzini (11):
  stubs: merge all monitor stubs in one file, remove monitor_cur_is_qmp stub
  stubs: move smbios stubs to hw/smbios
  stubs: move acpi stubs to hw/acpi
  stubs: remove unused stub for serial_hd
  hw: move reset handlers from vl.c to hw/core
  stubs: group stubs for user-mode emulation
  stubs: group all monitor_fdset_* functions in a single file
  stubs: move vhost stubs to stubs/vhost.o
  event_notifier: cleanups around event_notifier_set_handler
  build: remove --enable-colo/--disable-colo
  stubs: remove stubs/kvm.c

 MAINTAINERS                                        |  1 +
 Makefile.target                                    |  4 +-
 configure                                          | 11 ----
 hw/Makefile.objs                                   |  2 +-
 hw/acpi/Makefile.objs                              | 12 ++--
 stubs/ipmi.c => hw/acpi/ipmi-stub.c                |  0
 hw/core/Makefile.objs                              |  2 +-
 hw/core/reset.c                                    | 72 ++++++++++++++++++++++
 hw/smbios/Makefile.objs                            | 11 +++-
 .../smbios/smbios_type_38-stub.c                   |  0
 hw/usb/ccid-card-emulated.c                        |  2 +-
 hw/virtio/Makefile.objs                            |  6 +-
 stubs/vhost.c => hw/virtio/vhost-stub.c            |  0
 hw/virtio/virtio.c                                 | 10 +--
 include/hw/hw.h                                    |  6 +-
 include/qemu/event_notifier.h                      |  3 -
 include/qemu/main-loop.h                           | 15 +++++
 include/sysemu/reset.h                             | 10 +++
 include/sysemu/sysemu.h                            |  1 -
 iohandler.c                                        |  7 +++
 migration/Makefile.objs                            |  3 +-
 stubs/Makefile.objs                                | 19 +-----
 stubs/cpus.c                                       | 11 ----
 stubs/fdset-add-fd.c                               |  8 ---
 stubs/fdset-find-fd.c                              |  8 ---
 stubs/fdset-get-fd.c                               |  8 ---
 stubs/fdset-remove-fd.c                            |  7 ---
 stubs/fdset.c                                      | 22 +++++++
 stubs/get-next-serial.c                            |  4 --
 stubs/iohandler.c                                  |  8 ---
 stubs/kvm.c                                        |  8 ---
 stubs/migration-colo.c                             | 46 --------------
 stubs/mon-is-qmp.c                                 | 10 ---
 stubs/monitor-init.c                               |  7 ---
 stubs/{get-fd.c => monitor.c}                      |  6 ++
 stubs/replay-user.c                                | 33 ----------
 stubs/reset.c                                      | 14 -----
 target/i386/hyperv.c                               |  7 ++-
 target/mips/kvm.c                                  |  5 ++
 target/ppc/kvm.c                                   |  5 ++
 target/s390x/kvm.c                                 |  5 ++
 tests/Makefile.include                             |  1 +
 user-exec-stub.c                                   | 34 ++++++++++
 util/event_notifier-posix.c                        |  9 ---
 util/event_notifier-win32.c                        | 12 ----
 vl.c                                               | 42 -------------
 46 files changed, 222 insertions(+), 295 deletions(-)
 rename stubs/ipmi.c => hw/acpi/ipmi-stub.c (100%)
 create mode 100644 hw/core/reset.c
 rename stubs/smbios_type_38.c => hw/smbios/smbios_type_38-stub.c (100%)
 rename stubs/vhost.c => hw/virtio/vhost-stub.c (100%)
 create mode 100644 include/sysemu/reset.h
 delete mode 100644 stubs/cpus.c
 delete mode 100644 stubs/fdset-add-fd.c
 delete mode 100644 stubs/fdset-find-fd.c
 delete mode 100644 stubs/fdset-get-fd.c
 delete mode 100644 stubs/fdset-remove-fd.c
 create mode 100644 stubs/fdset.c
 delete mode 100644 stubs/get-next-serial.c
 delete mode 100644 stubs/iohandler.c
 delete mode 100644 stubs/kvm.c
 delete mode 100644 stubs/migration-colo.c
 delete mode 100644 stubs/mon-is-qmp.c
 delete mode 100644 stubs/monitor-init.c
 rename stubs/{get-fd.c => monitor.c} (75%)
 delete mode 100644 stubs/replay-user.c
 delete mode 100644 stubs/reset.c
 create mode 100644 user-exec-stub.c

-- 
2.9.3
