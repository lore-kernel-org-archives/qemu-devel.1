Received: from eggs.gnu.org ([2001:4830:134:3::10]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5G-0005fa-MK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5B-0007Aw-Le
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:02 -0400
Received: from mail-eopbgr30133.outbound.protection.outlook.com
	([40.107.3.133]:4192
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5B-00075V-2N
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:19:57 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:25 +0300
Message-Id: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 00/23] hyperv fixes and enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This series applies miscellaneous fixes and enhancements to Hyper-V
emulation code in QEMU, and lays out the ground for VMBus devices.

To give you a heads up, we currently have an implementation of VMBus
SCSI storage controller that works with native drivers in Windows
2008sp2 to 2016 and Linux; when used with modified SeaBIOS it can also
install and boot with no extra drivers required.  We hope to submit it
within 2.10 merge window in a few reasonably-sized self-contained
patchsets; this is the first one.

Evgeny Yakovlev (1):
  hyperv: set partition-wide MSRs only on first vcpu

Roman Kagan (22):
  hyperv: add header with protocol definitions
  update-linux-headers: prepare for hyperv.h removal
  hyperv: ensure msrs are inited properly
  hyperv: ensure VP index equal to QEMU cpu_index
  hyperv: helper to find vcpu by VP index
  hyperv_testdev: refactor for readability
  hyperv: cosmetic: g_malloc -> g_new
  hyperv: synic: only setup ack notifier if there's a callback
  hyperv: allow passing arbitrary data to sint ack callback
  hyperv: address HvSintRoute by X86CPU pointer
  hyperv: make HvSintRoute reference-counted
  hyperv: qdev-ify SynIC
  kvm-all: make async_safe_run_on_cpu safe on kvm too
  hyperv: make overlay pages for SynIC
  hyperv: map overlay pages after updating msrs
  hyperv: add synic message delivery
  hyperv: add synic event flag signaling
  hyperv: process SIGNAL_EVENT hypercall
  hyperv: process POST_MESSAGE hypercall
  hyperv_testdev: add SynIC message and event testmodes
  MAINTAINERS: add myself and eyakovlev@ for hyperv*
  hyperv: update copyright notices

 target/i386/cpu.h               |  18 +-
 target/i386/hyperv.h            |  38 ++-
 target/i386/hyperv_proto.h      | 257 +++++++++++++++++
 hw/misc/hyperv_testdev.c        | 269 ++++++++++++++----
 kvm-all.c                       |   2 +
 target/i386/cpu.c               |   4 +-
 target/i386/hyperv.c            | 612 +++++++++++++++++++++++++++++++++++++---
 target/i386/kvm.c               | 126 ++++++---
 target/i386/machine.c           |  15 +-
 MAINTAINERS                     |   7 +
 scripts/update-linux-headers.sh |   4 +-
 11 files changed, 1189 insertions(+), 163 deletions(-)
 create mode 100644 target/i386/hyperv_proto.h

-- 
2.9.4
