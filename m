Received: from eggs.gnu.org ([2001:4830:134:3::10]:53502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dVkWO-0000jl-0B
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dVkWK-0000x2-Io
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:15:35 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com
	([104.47.1.97]:58779
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dVkWJ-0000vd-TX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:15:32 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 13 Jul 2017 23:15:20 +0300
Message-Id: <20170713201522.13765-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] hyperv: own protocol header instead of
 kernel's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V . Lunev" <den@openvz.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Igor Mammedov <imammedo@redhat.com>

Supersede kernel's header for Hyper-V protocol definitions with our own.
The reason is that, since this is a third-party protocol and not a
kernel API, the kernel folks are not happy exposing it in the kernel
uapi.

The patchset is done to allow gradual transition from the kernel's
hyperv.h to the new one: the first patch introduces the new header that
doesn't conflict with the old one, and the second makes sure the old one
isn't imported from the kernel any longer, so that the maintainers can
do the next round of kernel header import at their leisure and things
will keep working.

Once (if) this lands in QEMU I'll post patches to KVM to move its
hyperv.h out of uapi.

This is the first part split out of my former biggish "hyperv fixes and
enhancements" series.  The only change is the underscore replaced with a
dash in the header file name.

Roman Kagan (2):
  hyperv: add header with protocol definitions
  update-linux-headers: prepare for hyperv.h removal

 target/i386/cpu.h               |  10 +-
 target/i386/hyperv-proto.h      | 257 ++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.c               |   4 +-
 target/i386/hyperv.c            |   6 +-
 target/i386/kvm.c               |  57 +++++----
 target/i386/machine.c           |  15 +--
 scripts/update-linux-headers.sh |   4 +-
 7 files changed, 304 insertions(+), 49 deletions(-)
 create mode 100644 target/i386/hyperv-proto.h

-- 
2.13.0
