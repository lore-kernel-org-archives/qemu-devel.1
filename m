Received: from eggs.gnu.org ([2001:4830:134:3::10]:49900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgbHF-00026B-3d
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgbHC-0006A0-09
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:04:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgbHB-00069A-RS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:04:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E44BFC051677
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:04:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Feb 2017 19:04:20 +0100
Message-Id: <20170222180423.26571-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] simplify struct QOM properties and use
 the result for GUEST_PANICKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com

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

v1->v2:
       include missing changes to tests/qapi-schema/qapi-schema-test.out 
       tweaks to doc comments
       wrap long lines

Paolo Bonzini (3):
  qom-qobject: introduce object_property_{g,s}et_ptr
  cpu: implement get_crash_info through QOM properties
  vl: pass CPUState to qemu_system_guest_panicked

 include/qom/cpu.h                       |   1 -
 include/qom/qom-qobject.h               |  68 +++++++++++-
 include/sysemu/sysemu.h                 |   2 +-
 kvm-all.c                               |   2 +-
 qom/cpu.c                               |  11 +-
 qom/qom-qobject.c                       |  52 ++++++++++
 target/i386/cpu.c                       |   2 +-
 tests/Makefile.include                  |   2 +-
 tests/check-qom-proplist.c              | 177 +++++++++++++++++++++++++++++++-
 tests/qapi-schema/qapi-schema-test.json |   8 ++
 tests/qapi-schema/qapi-schema-test.out  |   6 ++
 vl.c                                    |  13 ++-
 12 files changed, 326 insertions(+), 18 deletions(-)

-- 
2.9.3
