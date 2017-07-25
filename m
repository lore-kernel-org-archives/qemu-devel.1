Received: from eggs.gnu.org ([2001:4830:134:3::10]:49413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZyZd-0002zG-43
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZyZZ-0007Ns-VT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZyZZ-0007NE-P1
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:04:21 -0400
Date: Tue, 25 Jul 2017 13:55:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170725135534.55f9bd38@gondolin>
In-Reply-To: <20170721125609.11117-1-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] target/s390x: tcg improvments + MSA
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On Fri, 21 Jul 2017 14:56:03 +0200
David Hildenbrand <david@redhat.com> wrote:

> Based on series:
>     "[PATCH v2 0/5] target/s390x: cpu model cleanups + improvements"

I'm trying to decide what to do with this series; probably nothing for
2.10.

> 
> 1. smaller pgm irq instruction length fixes

These, I would have considered. But it seems Richard had an alternative
idea which is 2.11 material. So I'll probably just ignore these for now.

> 2. implement IPM, which is often used in context of MSA instructions
> 3. implement all basic MSA (cpacf/crypto) instructions <= z13. Only provide
>    the query subfunction (to query available subfunctions), no actual
>    de/encryption yet

This is certainly 2.11 material.

> 4. add a couple of alignment checks, that e.g. make some kvm-unit-tests
>    pass now.

That one tells me that I really should try to get an understanding of
tcg...

> 
> I have written kvm-unit-tests for MSA functions and for SPM/IPM. Will
> send them out soon. I use the following cpu model to test with an upstream
> kernel compiled for z10:
> 
> ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>               eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
>               exrl=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on ...
> 
> David Hildenbrand (6):
>   target/s390x: fix pgm irq ilen for stsi
>   target/s390x: fix pgm irq ilen in translate_pages()
>   target/s390x: implement spm (SET PROGRAM MASK)
>   target/s390x: move wrap_address to cpu.h
>   target/s390x: add basic MSA features
>   target/s390x: various alignment check
> 
>  target/s390x/Makefile.objs   |  2 +-
>  target/s390x/cpu.h           | 16 +++++++++
>  target/s390x/cpu_models.c    |  4 +++
>  target/s390x/crypto_helper.c | 65 ++++++++++++++++++++++++++++++++++++
>  target/s390x/helper.h        |  1 +
>  target/s390x/insn-data.def   | 29 ++++++++++++----
>  target/s390x/mem_helper.c    | 49 +++++++++++++++++++--------
>  target/s390x/misc_helper.c   | 10 ++++--
>  target/s390x/mmu_helper.c    |  2 +-
>  target/s390x/translate.c     | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 232 insertions(+), 25 deletions(-)
>  create mode 100644 target/s390x/crypto_helper.c
> 
