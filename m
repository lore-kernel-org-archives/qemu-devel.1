Received: from eggs.gnu.org ([2001:4830:134:3::10]:58708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL8VF-0002ru-RP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL8VC-0007p2-Mi
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dL8VC-0007ok-FX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:38:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 14 Jun 2017 15:38:17 +0200
Message-Id: <20170614133819.18480-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] target/s390x: implement MVCOS and allow
 to enable it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com, Miroslav Benes <mbenes@suse.cz>

This will not change the qemu model, we simply allow to enable the facility
for the qemu model.

A current upstream kernel (compiled for e.g. z900) can be tricked into
using MVCOS for uaccess by simply enabling the facility. This will work
even though the kernel is not compiled with z10+ support, as this
facility is also detected and used dynamically.

qemu-system-s390x ... -cpu qemu,mvcos=on ...

Requires my PGM fix series:
https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02631.html

Based on an original patch by Miroslav Benes

v1 -> v2:
- Squashed CPU model change and don't fake abscence
- Introduced a memhelper to do bulk access
- Minor style and bug fixes suggested/found by Thomas + Richard
- CR0_SECONDARY define was wrong :(
- introduce defines for AC_*
- enable the instruction for USER MODE (however will always result in a
  PRIVILEDGED exception)


David Hildenbrand (2):
  target/s390x: change PSW_SHIFT_KEY
  target/s390x: implement mvcos instruction

 target/s390x/cpu.h         |  24 +++++-
 target/s390x/cpu_models.c  |   1 +
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def |   2 +
 target/s390x/mem_helper.c  | 180 +++++++++++++++++++++++++++++++++++++++++----
 target/s390x/translate.c   |  11 ++-
 6 files changed, 201 insertions(+), 18 deletions(-)

-- 
2.9.3
