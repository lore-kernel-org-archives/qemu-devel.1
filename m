Received: from eggs.gnu.org ([2001:4830:134:3::10]:48311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxG-0000Za-Mn
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxB-00082P-Pe
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxB-00081d-IA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 944BE7B2B2
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:08 +0200
Message-Id: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 00/22] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

First the things I didn'~t touch:
- CONFIG_FOO in source files (scsi mainly)
  Paolo said that there are people working on that
- usb: it is a mess how things are entangled there
- acpi options (like hotplug etc); another entanglement

So, what is there?
- the bits that didn't got reviewed on previous iteration
- virtio-pci: As Thomas did something for s390, I did the bits for virtio-pci.

I am able now to disable all virtio-pci devices, and run make tests.
This is my current virtio bits:


CONFIG_VIRTIO=y
CONFIG_VIRTIO_CRYPTO=y
CONFIG_VIRTIO_GPU=y
CONFIG_SCSI=y
CONFIG_VIRTIO_SCSI=y

VIRTIO_SCSI is used in cdrom-test.c.  The only way to be able to
disable it is to test for its existence insed that test.  Notice that
this are the same bits that make it impssible to disable megasas, lsi
and esp.

Please, comment.

Juan.



[v1]
Notice that this is an RFC because they don't work.  As said on my
previous submmision, we need <foo>-softmmu/config-devices.h to make
this work.  This series just allow us to disable the devices, but not
to enable it back O:-)

Notice:

- scsi stuff: we are testing they in cdrom-test.c, so we need to be
  able to config them out.  Notice also that #ifdefs only go in tests/<...>

- virtio stuff: see how we need to also change hw/virtio/virtio-pci.c
  to disable it.  The problem appears in the device-instropect-test.c.
  As they are defined in the binary, but not complied in.  We can
  change for a registration appreach, but that is more work that what
  I intended for this series.

What do you think?

Later, Juan.

Based-on: 


Juan Quintela (22):
  configure: We don't want to clean configuration files
  config:  CONFIG_SERIAL* is already in pci.mak
  check: Use land/lor when possible
  check: Only test isa-testdev when it is compiled in
  check: Only test usb-xhci-nec when it is compiled in
  i386-softmmu: Configuration is identical to x86_64-softmmu
  check: Only test ivshm when it is compiled in
  check: Only test tpm devices when they are compiled in
  virtio: Remove unneeded includes
  virtio: split vsock bits from virtio-pci
  virtio: split host bits from virtio-pci
  virtio: split input bits from virtio-pci
  virtio: split rng bits from virtio-pci
  virtio: split balloon bits from virtio-pci
  virtio: split 9p bits from virtio-pci
  virtio: split vhost-user-blk bits from virtio-pci
  virtio: split vhost-user-scsi bits from virtio-pci
  virtio: split vhost-scsi bits from virtio-pci
  virtio: split virtio-scsi bits from virtio-pci
  virtio: split virtio-blk bits rom virtio-pci
  virtio: split virtio-net bits rom virtio-pci
  virtio: split virtio-serial bits rom virtio-pci

 Makefile                                |   3 +-
 default-configs/alpha-softmmu.mak       |   2 -
 default-configs/arm-softmmu.mak         |   2 -
 default-configs/hppa-softmmu.mak        |   3 -
 default-configs/i386-softmmu.mak        |  67 +-
 default-configs/mips-softmmu-common.mak |   2 -
 default-configs/ppc-softmmu.mak         |   1 -
 default-configs/ppcemb-softmmu.mak      |   2 -
 default-configs/sh4-softmmu.mak         |   2 -
 default-configs/sh4eb-softmmu.mak       |   2 -
 default-configs/sparc64-softmmu.mak     |   2 -
 default-configs/virtio.mak              |   3 +
 default-configs/x86_64-softmmu.mak      |   2 -
 hw/virtio/Makefile.objs                 |  14 +-
 hw/virtio/vhost-scsi-pci.c              |  94 +++
 hw/virtio/vhost-user-blk-pci.c          |  88 +++
 hw/virtio/vhost-user-scsi-pci.c         |  89 +++
 hw/virtio/vhost-vsock-pci.c             |  71 +++
 hw/virtio/virtio-9p-pci.c               |  74 +++
 hw/virtio/virtio-balloon-pci.c          |  82 +++
 hw/virtio/virtio-blk-pci.c              |  82 +++
 hw/virtio/virtio-input-host-pci.c       |  42 ++
 hw/virtio/virtio-input-pci.c            | 136 ++++
 hw/virtio/virtio-net-pci.c              |  81 +++
 hw/virtio/virtio-pci.c                  | 792 +-----------------------
 hw/virtio/virtio-rng-pci.c              |  77 +++
 hw/virtio/virtio-scsi-pci.c             |  93 +++
 hw/virtio/virtio-serial-pci.c           |  97 +++
 tests/Makefile.include                  |  89 ++-
 29 files changed, 1169 insertions(+), 925 deletions(-)
 create mode 100644 hw/virtio/vhost-scsi-pci.c
 create mode 100644 hw/virtio/vhost-user-blk-pci.c
 create mode 100644 hw/virtio/vhost-user-scsi-pci.c
 create mode 100644 hw/virtio/vhost-vsock-pci.c
 create mode 100644 hw/virtio/virtio-9p-pci.c
 create mode 100644 hw/virtio/virtio-balloon-pci.c
 create mode 100644 hw/virtio/virtio-blk-pci.c
 create mode 100644 hw/virtio/virtio-input-host-pci.c
 create mode 100644 hw/virtio/virtio-input-pci.c
 create mode 100644 hw/virtio/virtio-net-pci.c
 create mode 100644 hw/virtio/virtio-rng-pci.c
 create mode 100644 hw/virtio/virtio-scsi-pci.c
 create mode 100644 hw/virtio/virtio-serial-pci.c

-- 
2.17.1
