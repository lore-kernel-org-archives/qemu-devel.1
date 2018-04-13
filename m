Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6xFP-0004M9-L4
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6xFO-00027Y-QN
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:52:07 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:44753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6xFO-000274-Kz
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:52:06 -0400
Received: by mail-oi0-x234.google.com with SMTP id j143-v6so8091972oih.11
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 04:52:06 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 12:51:45 +0100
Message-ID: <CAFEAcA9afpwo+knQSjW7Snw9vydeUDjikf_MeRn9bWBrt3Ht-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] QEMU fails to build on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

mst pointed this out, and I can reproduce it. (I don't have MIPS
in my set of build targets for pull requests because I don't have
access to any sufficiently fast MIPS hosts.)

In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
                 from /home/pm215/qemu/tcg/tcg.c:28:
/home/pm215/qemu/tcg/mips/tcg-target.inc.c: In function =E2=80=98tcg_out_tl=
b_load=E2=80=99:
/home/pm215/qemu/include/qemu/compiler.h:90:36: error: static
assertion failed: "not expecting: offsetof(CPUArchState,
tlb_table[NB_MMU_MODES - 1][1]) > 0x7ff0 + 0x7fff"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/pm215/qemu/include/qemu/compiler.h:98:30: note: in expansion of
macro =E2=80=98QEMU_BUILD_BUG_MSG=E2=80=99
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/pm215/qemu/tcg/mips/tcg-target.inc.c:1236:9: note: in expansion
of macro =E2=80=98QEMU_BUILD_BUG_ON=E2=80=99
         QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
         ^
/home/pm215/qemu/rules.mak:66: recipe for target 'tcg/tcg.o' failed


This has happened because for AArch64 the offset of the tlb_table
from the start of the CPUArchState is now too large:

(gdb) print &((CPUARMState*)(0))->tlb_table[7][1]
$3 =3D (CPUTLBEntry *) 0x10d80

Does anybody have a good suggestion for a fix? We could just
make the codegen for MIPS TCG tcg_out_tlb_load() cope with the
larger offset, at the cost of an extra insn in the fast path.

Moving the tlb_table to earlier in the CPU state structure
seems like a nicer long term approach, but is awkward because
it would mean moving it from the "not cleared on CPU reset"
part of the struct into the "zeroed out on CPU reset" part.
I don't know if that would be safe or not...

(Has nobody been testing with MIPS hosts? I'm surprised
we got to rc3 without anybody spotting this...)

thanks
-- PMM
