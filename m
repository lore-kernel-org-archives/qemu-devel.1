Received: from eggs.gnu.org ([2001:4830:134:3::10]:44809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDI-0006T9-A2
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDD-0000y1-GD
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54864
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDD-0000xm-9t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCs6Bw131852
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj59q9s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:50 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:48 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:34 +0200
Message-Id: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 00/11] pending s390 patches part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

here is the first bunch on patches for s390:

- Some more PCI changes
- storage attribute migration (migration of CMMA state)
- cpu model cleanups and preparations

part 2 will follow shortly (sorry for the delay - process reasons ;-)).

In addition to that I plan to have the migration rework from Halil
and Thomas network boot.


Christian Borntraeger (1):
  linux-headers: update to 4.13-rc0

Claudio Imbrenda (2):
  s390x/migration: Storage attributes device
  s390x/migration: Monitor commands for storage attributes

Fei Li (3):
  s390x: add flags field for registering I/O adapter
  s390x/flic: introduce modify_ais_mode callback
  s390x/sic: realize SIC handling

Janosch Frank (1):
  s390x/kvm: Rework cmma management

Jason J. Herne (2):
  s390x/cpumodel: clean up spacing and comments
  s390x/cpumodel: provide compat handling for new cpu features

Yi Min Zhao (2):
  s390x/flic: introduce inject_airq callback
  s390x/css: update css_adapter_interrupt

 hmp-commands-info.hx                               |  16 +
 hmp-commands.hx                                    |  16 +
 hw/intc/s390_flic.c                                |  66 +++-
 hw/intc/s390_flic_kvm.c                            |  57 ++-
 hw/intc/trace-events                               |   4 +
 hw/s390x/Makefile.objs                             |   2 +
 hw/s390x/css-bridge.c                              |   2 +-
 hw/s390x/css.c                                     |  52 ++-
 hw/s390x/s390-pci-bus.c                            |   5 +-
 hw/s390x/s390-stattrib-kvm.c                       | 178 +++++++++
 hw/s390x/s390-stattrib.c                           | 410 +++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c                         |  10 +-
 hw/s390x/trace-events                              |   1 +
 hw/s390x/virtio-ccw.c                              |   2 +-
 include/hw/s390x/css.h                             |  12 +-
 include/hw/s390x/s390_flic.h                       |  13 +-
 include/hw/s390x/storage-attributes.h              |  72 ++++
 include/standard-headers/asm-x86/hyperv.h          |  21 +-
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/pci_regs.h          |   1 +
 linux-headers/asm-arm/kvm.h                        |   8 +
 linux-headers/asm-arm64/kvm.h                      |   3 +
 linux-headers/asm-powerpc/kvm.h                    |   6 +
 linux-headers/asm-s390/kvm.h                       |  12 +
 linux-headers/linux/kvm.h                          |  35 ++
 monitor.c                                          |   1 +
 target/s390x/cpu.h                                 |   1 +
 target/s390x/cpu_features.c                        |   3 +
 target/s390x/cpu_features_def.h                    |  35 ++
 target/s390x/cpu_models.c                          |  26 ++
 target/s390x/cpu_models.h                          |   2 +
 target/s390x/gen-features.c                        |  58 ++-
 target/s390x/kvm.c                                 |  42 ++-
 33 files changed, 1135 insertions(+), 38 deletions(-)
 create mode 100644 hw/s390x/s390-stattrib-kvm.c
 create mode 100644 hw/s390x/s390-stattrib.c
 create mode 100644 include/hw/s390x/storage-attributes.h

-- 
2.7.4
