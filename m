Received: from eggs.gnu.org ([209.51.188.92]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gga8c-0002vj-In
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gga8b-0006zs-J3
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:00:38 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:46699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gga8b-0006xO-Bc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:00:37 -0500
Received: by mail-oi1-x22f.google.com with SMTP id x202so1199709oif.13
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 11:00:37 -0800 (PST)
MIME-Version: 1.0
References: <154662609174.25797.11037697007951339169.malonedeb@chaenomeles.canonical.com>
	<154688385484.19401.18084021166417230504.malone@soybean.canonical.com>
In-Reply-To: <154688385484.19401.18084021166417230504.malone@soybean.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 19:00:24 +0000
Message-ID: <CAFEAcA9DRhok9WigB_r9a_DGoC+_FNbtxDvz3k1dBHGkFniy5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1810545] Re: [alpha] Strange exception
 address reported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, 7 Jan 2019 at 18:10, Peter Maydell <peter.maydell@linaro.org> wrote:
(re: https://bugs.launchpad.net/bugs/1810545)

> The problem seems to be that the PC we report for an OPCDEC
> is first selected by gen_invalid()/gen_excp() in
> target/alpha/translate.c, which uses pc_next (ie the insn's
> address plus 4). But that is then handed through to our custom
> PALcode (https://git.qemu.org/?p=qemu-palcode.git;a=blob;f=pal.S;h=1781c4b415700ca3a68af07fdae90ae43e722501;hb=HEAD) which does
>   addq    p6, 4, p1  // increment past the faulting insn
> resulting in insn + 8.
>
> That is, the palcode and the QEMU code have a disagreement about what
> the (private) API between them is. I'm not sure which side is wrong and
> should be corrected. I think the linux-user code assumes the same thing
> that translate.c is doing, so perhaps the palcode.

Richard -- any suggestions for which side of this API we should
be changing?

thanks
-- PMM
