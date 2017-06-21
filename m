Received: from eggs.gnu.org ([2001:4830:134:3::10]:34930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiR6-0006B5-Dd
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiR3-0004Gy-R4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:24:56 -0400
Received: from mail-eopbgr30100.outbound.protection.outlook.com
	([40.107.3.100]:13074
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiR3-0004GL-50
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:24:53 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:01 +0300
Message-Id: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 00/23] hyperv fixes and enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

This series applies miscellaneous fixes and enhancements to Hyper-V
emulation code in QEMU, and lays out the ground for VMBus devices.

v1 -> v2:
 - drop the already merged patch
 - split and rework SINTx and SVERSION msrs init
 - factor out hyperv vcpu init to a function
 - rework vp_index management
 - distinguish kvm-only (== legacy) mode for SynIC
 - use new capabilities recently submitted to KVM
 - add compat logic for SynIC
 - drop workaround for KVM zeroing SynIC pages
 - minor fixes according to comments

Evgeny Yakovlev (1):
  hyperv: set partition-wide MSRs only on first vcpu

Roman Kagan (22):
  hyperv: add header with protocol definitions
  update-linux-headers: prepare for hyperv.h removal
  hyperv: ensure SINTx msrs are reset properly
  hyperv: make SynIC version msr constant
  [not to commit] add new hyperv-related caps
  hyperv: ensure VP index equal to QEMU cpu_index
  hyperv_testdev: refactor for readability
  hyperv: cosmetic: g_malloc -> g_new
  hyperv: synic: only setup ack notifier if there's a callback
  hyperv: allow passing arbitrary data to sint ack callback
  hyperv: address HvSintRoute by X86CPU pointer
  hyperv: make HvSintRoute reference-counted
  hyperv: qom-ify SynIC
  hyperv: block SynIC use in QEMU in incompatible configurations
  hyperv: make overlay pages for SynIC
  hyperv: add synic message delivery
  hyperv: add synic event flag signaling
  hyperv: process SIGNAL_EVENT hypercall
  hyperv: process POST_MESSAGE hypercall
  hyperv_testdev: add SynIC message and event testmodes
  MAINTAINERS: add myself and eyakovlev@ for hyperv*
  hyperv: update copyright notices

 include/hw/i386/pc.h            |   5 +
 linux-headers/linux/kvm.h       |   2 +
 target/i386/cpu.h               |  16 +-
 target/i386/hyperv.h            |  40 ++-
 target/i386/hyperv_proto.h      | 257 ++++++++++++++++
 hw/misc/hyperv_testdev.c        | 267 +++++++++++++----
 target/i386/cpu.c               |   4 +-
 target/i386/hyperv.c            | 634 ++++++++++++++++++++++++++++++++++++++--
 target/i386/kvm.c               | 167 +++++++----
 target/i386/machine.c           |  24 +-
 MAINTAINERS                     |   7 +
 scripts/update-linux-headers.sh |   4 +-
 12 files changed, 1256 insertions(+), 171 deletions(-)
 create mode 100644 target/i386/hyperv_proto.h

-- 
2.9.4
