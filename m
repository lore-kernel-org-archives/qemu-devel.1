Received: from eggs.gnu.org ([2001:4830:134:3::10]:48967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uP-0007qT-VW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uM-0002tg-PV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:01 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cg7uM-0002tW-JR
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:42:58 -0500
Received: by mail-wr0-x242.google.com with SMTP id q39so14703012wrb.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:42:58 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 11:42:53 +0100
Message-Id: <20170221104256.5153-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] simplify struct QOM properties and use the
 result for GUEST_PANICKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, anton.nefedov@virtuozzo.com, den@openvz.org

This is an alternative approach to simplifying the crash information
patches.

Currently, crash information is exposed twice, through a QOM property
and through a method.  This is because accessing QOM properties with
QAPI struct types is a huge pain in the neck.  Patch 1 fixes this by
providing a simple and well-tested API, that takes care of integrating
the QOM->QObject->QAPI steps into a single function.

Patch 2 then eliminates the get_crash_info method.  Patch 3 finally
cleans up qemu_system_guest_panicked by passing a CPUState* argument
instead of a GuestPanicInformation struct.

Paolo

Paolo Bonzini (3):
  qom-qobject: introduce object_property_{g,s}et_ptr
  cpu: implement get_crash_info through QOM properties
  vl: pass CPUState to qemu_system_guest_panicked

 include/qom/cpu.h                       |   1 -
 include/qom/qom-qobject.h               |  68 ++++++++++++
 include/sysemu/sysemu.h                 |   2 +-
 kvm-all.c                               |   2 +-
 qom/cpu.c                               |  11 +-
 qom/qom-qobject.c                       |  49 +++++++++
 target/i386/cpu.c                       |   2 +-
 tests/Makefile.include                  |   2 +-
 tests/check-qom-proplist.c              | 185 +++++++++++++++++++++++++++++++-
 tests/qapi-schema/qapi-schema-test.json |   8 ++
 vl.c                                    |  13 ++-
 11 files changed, 326 insertions(+), 17 deletions(-)

-- 
2.9.3
