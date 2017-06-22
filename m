Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNyci-0000Db-IR
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNycf-0000Vs-Gh
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNycf-0000Vg-Ar
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:41:57 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 22 Jun 2017 11:41:48 +0200
Message-Id: <20170622094151.28633-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] target/s390x: implement idte and
 improve ipte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

By adding idte, we are now able to expose the DAT-enhancement facility
to our guest. Also, properly simulate and expose the local-tlb-clearing
facility.

To improve the TLB flushing, we will have to remember each used table (or
at least a hash!) for each tlb entry, just like real HW does.

This allows me to start an upstream kernel (having also the mvcos patch
applied) compiled for z9 using:

qemu-system-s390x ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
                           eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
                           exrl=on,dateh=on,ltlbc=on

Linux will detect the DAT-enhancement facility and use idte+cspg.

v1 -> v2:
- Allow to enable the DAT-enhancement facility.
- Fix wrong register in idte.
- Simply set m4 to zero in case local-tlb-clearing is not enabled.

David Hildenbrand (3):
  target/s390x: Indicate and check for local tlb clearing
  target/s390x: Improve heuristic for ipte
  target/s390x: Implement idte instruction

 target/s390x/cpu_models.c  |  2 ++
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 78 +++++++++++++++++++++++++++++++++++++++-------
 target/s390x/translate.c   | 21 ++++++++++++-
 5 files changed, 92 insertions(+), 12 deletions(-)

-- 
2.9.4
