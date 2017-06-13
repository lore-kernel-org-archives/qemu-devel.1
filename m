Received: from eggs.gnu.org ([2001:4830:134:3::10]:58022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dKtf8-0007Lp-GU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dKtf5-0003iL-Fn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dKtf5-0003i7-9W
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:47:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 13 Jun 2017 23:47:33 +0200
Message-Id: <20170613214736.19963-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/3] target/s390x: implement MVCOS and allow
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

This might not be the fastest implementation, but it seems to work and
that is what we care about for now.

Requires my PGM fix series:
https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02631.html

Based on an original patch by Miroslav Benes


David Hildenbrand (3):
  target/s390x: change PSW_SHIFT_KEY
  target/s390x: implement mvcos instruction
  s390x/cpumodel: allow to enable MVCOS for qemu cpu model

 target/s390x/cpu.h         |  21 ++++++++-
 target/s390x/cpu_models.c  |   1 +
 target/s390x/helper.c      |   4 +-
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def |   2 +
 target/s390x/mem_helper.c  | 107 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  12 ++++-
 7 files changed, 143 insertions(+), 5 deletions(-)

-- 
2.9.3
