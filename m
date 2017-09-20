Received: from eggs.gnu.org ([2001:4830:134:3::10]:56704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugxe-0000ES-MS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dugxb-000815-3P
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:30:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dugxa-00080M-Td
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:30:47 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Sep 2017 17:30:13 +0200
Message-Id: <20170920153016.3858-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Implement basic MSA functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

Some leftover from "target/s390x: tcg improvments + MSA functions".

Implement all basic MSA (cpacf/crypto) instructions <= z13. Only provide
the query subfunction (to query available subfunctions), no actual
de/encryption yet. Good enough to unlock the STFL bits.

I have written kvm-unit-tests for MSA functions and for SPM/IPM. Will
send them out soon. I use the following cpu model to test with an upstream
kernel compiled for z10:

... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
              eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
              exrl=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on ...

Available on: https://github.com/davidhildenbrand/qemu.git s390x-msa

v2 -> v3:
 - "s390x/tcg: add basic MSA features"
 -- drop one check (fc >= 128) that can due to masking never happen

v1 -> v2:
 - "s390x/tcg: implement spm (SET PROGRAM MASK)"
 -- use tcg_gen_extrl_i64_i32 + tcg_gen_extract_i32
 - "s390x/tcg: move wrap_address() to internal.h"
 -- internal.h instead of cpu.h
 - "s390x/tcg: add basic MSA features"
 -- minor style fixes


David Hildenbrand (3):
  s390x/tcg: implement spm (SET PROGRAM MASK)
  s390x/tcg: move wrap_address() to internal.h
  s390x/tcg: add basic MSA features

 target/s390x/Makefile.objs   |  2 +-
 target/s390x/cpu.h           |  2 ++
 target/s390x/cpu_models.c    |  4 +++
 target/s390x/crypto_helper.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 target/s390x/helper.h        |  1 +
 target/s390x/insn-data.def   | 15 ++++++++++
 target/s390x/internal.h      | 14 +++++++++
 target/s390x/mem_helper.c    | 14 ---------
 target/s390x/translate.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 169 insertions(+), 15 deletions(-)
 create mode 100644 target/s390x/crypto_helper.c

-- 
2.13.5
