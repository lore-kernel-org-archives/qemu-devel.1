Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXvfA-0000Ma-GG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 16:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXvf5-0002rT-JS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 16:33:40 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXvf5-0002qo-FI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 16:33:35 -0400
Received: by mail-qk0-x243.google.com with SMTP id d136so673372qkg.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 13:33:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170719045722.25492-1-rth@twiddle.net>
	<CAFEAcA9Z_8kq_e+swQaZVEecmVmcNw9XJ4WRXatTLG26W=n0uQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9bc19023-eca9-1ea6-02d7-4817fe6fd6fb@amsat.org>
Date: Wed, 19 Jul 2017 17:33:28 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Z_8kq_e+swQaZVEecmVmcNw9XJ4WRXatTLG26W=n0uQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/14] tcg-next patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/19/2017 04:45 PM, Peter Maydell wrote:
> The sparc-linux-user test fails:
> 
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc
> -L ./gnemul/qemu-sparc sparc/ls -l dummyfile
> Inconsistency detected by ld.so: rtld.c: 858: dl_main: Assertion
> `_dl_rtld_map.l_prev->l_next == _dl_rtld_map.l_next' failed!
> Makefile:6: recipe for target 'test' failed
> 
> A valgrind run produces a lot of noise, but
> this bit looks suspicious:
> 
> ==14436==
> ==14436== Conditional jump or move depends on uninitialised value(s)
> ==14436==    at 0x60003F7C: tcg_out_qemu_st_direct (tcg-target.inc.c:1733)
> ==14436==    by 0x60004295: tcg_out_qemu_st (tcg-target.inc.c:1856)
> ==14436==    by 0x60004F0C: tcg_out_op (tcg-target.inc.c:2140)
> ==14436==    by 0x6000B0FF: tcg_reg_alloc_op (tcg.c:2360)
> ==14436==    by 0x6000BCED: tcg_gen_code (tcg.c:2679)
> ==14436==    by 0x600387B7: tb_gen_code (translate-all.c:1311)
> ==14436==    by 0x6003637B: tb_find (cpu-exec.c:367)
> ==14436==    by 0x60036A7C: cpu_exec (cpu-exec.c:675)
> ==14436==    by 0x60039DA1: cpu_loop (main.c:1088)
> ==14436==    by 0x6003B7AF: main (main.c:4860)
> ==14436==
> ==14436== Invalid write of size 4
> ==14436==    at 0x605114FA: ???
> ==14436==    by 0x6011ADDF: ??? (in
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
> ==14436==    by 0x6253464F: ???
> ==14436==    by 0x6022852F: ??? (in
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
> ==14436==    by 0x6022818C: ??? (in
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
> ==14436==    by 0x6022852F: ??? (in
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
> ==14436==    by 0x416FFFFFFFF: ???
> ==14436==    by 0x60227F1F: ??? (in
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc)
> ==14436==  Address 0x59d1c7d0 is not stack'd, malloc'd or (recently) free'd
> ==14436==
> 
> Reverting "target/sparc: optimize gen_op_mulscc() using deposit op"
> fixed this, so I think that's probably the culprit.

Thank you for taking time with valgrind, I'll verify sparc/tcg opcode used.

Phil.
