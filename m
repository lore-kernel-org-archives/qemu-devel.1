Received: from eggs.gnu.org ([2001:4830:134:3::10]:55369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF2gM-0007io-TR
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF2gL-0008V8-Kf
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:49:38 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gF2gL-0008U8-8q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:49:37 -0400
Received: by mail-oi1-x241.google.com with SMTP id e17-v6so2151110oib.4
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 12:49:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 20:49:15 +0100
Message-ID: <CAFEAcA_NxFaMcZ+ZzympigE8OoYxfmbmAQOReJN_OT32ceMWoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/34] MIPS queue for October 2018 - part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 22 October 2018 at 13:57, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-2
>
> for you to fetch changes up to 2ec219776c633df9e43c5fa1557f70ee4f735f9d:
>
>   target/mips: Fix decoding of ALIGN and DALIGN instructions (2018-10-22 14:41:47 +0200)
>
> ----------------------------------------------------------------
> MIPS queue for October 2018 - part 2
>
> Limited support for R5900 ISA, MMI ASE, and two misc fixes.
>
> ----------------------------------------------------------------

Hi: I get compile errors on 32-bit hosts:

/home/petmay01/qemu-for-merges/disas/mips.c:615:35: error: large
integer implicitly truncated to unsigned type [-Werror=overflow]
 #define INSN_5900                 0x100000000
                                   ^
/home/petmay01/qemu-for-merges/disas/mips.c:1200:17: note: in
expansion of macro 'INSN_5900'
 #define EE      INSN_5900    /* Emotion Engine */
                 ^
/home/petmay01/qemu-for-merges/disas/mips.c:2326:73: note: in
expansion of macro 'EE'
 {"div1",    "z,s,t",  0x7000001a, 0xfc00ffff, RD_s | RD_t | WR_HILO, 0, EE },
                                                                         ^

(and repeats on other similar uses).

This is because this line is an initializer for "struct mips_opcode",
and the final field is "unsigned long membership", which may be only
32 bits wide, but you're trying to put a number in that's too big for that.

thanks
-- PMM
