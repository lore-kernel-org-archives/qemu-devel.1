Received: from eggs.gnu.org ([2001:4830:134:3::10]:57167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csUTH-0006Kf-QU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csUTB-0001u7-R5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:14:07 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csUTB-0001ti-Jx
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:14:01 -0400
Received: by mail-wr0-x22c.google.com with SMTP id w11so42524717wrc.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 06:14:01 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 14:13:38 +0100
Message-ID: <CAFEAcA-Dq8rKadA+eRui-G-YyejmyBUx0CBEL0SJRd24zbCOzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] SPARC tcg backend bugs (was: Proposal for deprecating
 unsupported host OSes & architecutures)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2017 at 17:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> So far I have found that we seem to be mishandling 32-bit guest
> load/stores, which I tentatively suggest
>
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index d1f4c0dead..c72b57dc58 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -1119,7 +1119,7 @@ static void tcg_out_qemu_ld(TCGContext *s,
> TCGReg data, TCGReg addr,
>          /* Skip the high-part; we'll perform the extract in the trampoline.  */
>          param++;
>      }
> -    tcg_out_mov(s, TCG_TYPE_REG, param++, addr);
> +    tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);
>
>      /* We use the helpers to extend SB and SW data, leaving the case
>         of SL needing explicit extending below.  */
> @@ -1199,7 +1199,7 @@ static void tcg_out_qemu_st(TCGContext *s,
> TCGReg data, TCGReg addr,
>          /* Skip the high-part; we'll perform the extract in the trampoline.  */
>          param++;
>      }
> -    tcg_out_mov(s, TCG_TYPE_REG, param++, addr);
> +    tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);
>      if (!SPARC64 && (memop & MO_SIZE) == MO_64) {
>          /* Skip the high-part; we'll perform the extract in the trampoline.  */
>          param++;
>
> (otherwise we pass a high-bits-set value to the slowpath functions,
> which happens to work if QEMU was built with debug enabled but not
> if it doesn't.)
>
> That then at least makes i386 and x86_64 guests behave the same,
> ie they don't work. I haven't figured out what's going wrong there yet.

I've tracked this down to a similar problem: our implementation
of byte and halfword stores doesn't correctly zero/sign extend
the data value before passing it to the C helper function, which
means that if QEMU was compiled with optimization enabled we can
end up writing incorrect values to memory. Not sure what the
best fix is, though -- I guess some sign/zero extend code in
the store trampolines, but what's the best sparc code sequence
for doing 8/16 bit extension?

thanks
-- PMM
