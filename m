Received: from eggs.gnu.org ([2001:4830:134:3::10]:39278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXuuZ-0002sQ-V7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXuuY-0004Y9-P8
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:45:32 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXuuY-0004Xm-Hs
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:45:30 -0400
Received: by mail-wm0-x22a.google.com with SMTP id w191so8319245wmw.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 12:45:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 20:45:08 +0100
Message-ID: <CAFEAcA9Z_8kq_e+swQaZVEecmVmcNw9XJ4WRXatTLG26W=n0uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] tcg-next patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 July 2017 at 05:57, Richard Henderson <rth@twiddle.net> wrote:
> This edition is a real mix:
>   * Code gen improvement for mips64 host (Jiang)
>   * Build fix for ppc-linux (Philippe)
>   * Runtime fix for tci (Philippe)
>   * Fix atomic helper names in debugging dumps (rth)
>
>   * Cross-target tcg code gen improvements (Philippe)
>     This one had no obvious tree through which it should go,
>     so I went ahead and took them all.
>
>   * Cherry-picked the first patch from Lluis' generic translate loop,
>     wherein the interface to gen_intermediate_code changes trivially.
>     It's the only patch from that series that touches all targets,
>     and I see little point carrying it around further.
>
>
> r~
>
>
> The following changes since commit 6887dc6700ccb7820d8a9d370f421ee361c748e8:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170718' into staging (2017-07-18 21:13:48 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170718
>
> for you to fetch changes up to 3d48caee9e2c18385be60bb0467fa1f61d325c64:
>
>   tcg: Pass generic CPUState to gen_intermediate_code() (2017-07-18 14:26:13 -1000)
>
> ----------------------------------------------------------------
> Queued tcg and tcg code gen related cleanups
>

The sparc-linux-user test fails:

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc
-L ./gnemul/qemu-sparc sparc/ls -l dummyfile
Inconsistency detected by ld.so: rtld.c: 858: dl_main: Assertion
`_dl_rtld_map.l_prev->l_next == _dl_rtld_map.l_next' failed!
Makefile:6: recipe for target 'test' failed

A valgrind run produces a lot of noise, but
this bit looks suspicious:

==14436==
==14436== Conditional jump or move depends on uninitialised value(s)
==14436==    at 0x60003F7C: tcg_out_qemu_st_direct (tcg-target.inc.c:1733)
==14436==    by 0x60004295: tcg_out_qemu_st (tcg-target.inc.c:1856)
==14436==    by 0x60004F0C: tcg_out_op (tcg-target.inc.c:2140)
==14436==    by 0x6000B0FF: tcg_reg_alloc_op (tcg.c:2360)
==14436==    by 0x6000BCED: tcg_gen_code (tcg.c:2679)
==14436==    by 0x600387B7: tb_gen_code (translate-all.c:1311)
==14436==    by 0x6003637B: tb_find (cpu-exec.c:367)
==14436==    by 0x60036A7C: cpu_exec (cpu-exec.c:675)
==14436==    by 0x60039DA1: cpu_loop (main.c:1088)
==14436==    by 0x6003B7AF: main (main.c:4860)
==14436==
==14436== Invalid write of size 4
==14436==    at 0x605114FA: ???
==14436==    by 0x6011ADDF: ??? (in
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
==14436==    by 0x6253464F: ???
==14436==    by 0x6022852F: ??? (in
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
==14436==    by 0x6022818C: ??? (in
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
==14436==    by 0x6022852F: ??? (in
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
==14436==    by 0x416FFFFFFFF: ???
==14436==    by 0x60227F1F: ??? (in
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
==14436==  Address 0x59d1c7d0 is not stack'd, malloc'd or (recently) free'd
==14436==

Reverting "target/sparc: optimize gen_op_mulscc() using deposit op"
fixed this, so I think that's probably the culprit.

thanks
-- PMM
