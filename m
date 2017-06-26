Received: from eggs.gnu.org ([2001:4830:134:3::10]:52760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPYeG-0004cU-SS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPYeF-00027B-KV
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:22:08 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPYeF-00026x-DL
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:22:07 -0400
Received: by mail-wm0-x229.google.com with SMTP id 62so4904008wmw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 11:22:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878tke9al6.fsf@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
	<87fuenxdh2.fsf@linaro.org> <878tke9al6.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 19:21:45 +0100
Message-ID: <CAFEAcA99y-RL4KtXHmuotsXSRuthWNsmVC-f8WZV2Zc2LJtfUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 26 June 2017 at 13:50, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> Not that I've seen (at the level of the translation loop). Now I wonder i=
f QEMU
> w/ TCG has a bug that lets it successfully execute instructions that cros=
s page
> boundaries, one of them with invalid permissions (haven't checked).

ARM takes care to get this right -- we stop the TB if the next
insn is going to span the page boundary (or in some corner cases
merely if we think it might span the boundary, because if we guess
wrong that way round the worst that happens is an unnecessarily
short TB). Then the next TB will get the prefetch abort in the right
place if the next page is inaccessible (we will longjump out
of the translate.c code when we attempt the arm_lduw_code for
the 2nd half of the insn). This was fixed in commit 541ebcd401ee4.
The key thing is:
 * first insn in TB: read all its bytes (may result in longjump)
 * subsequent insns in same TB: don't even try to read bytes
   which aren't in pages already known to be safe because of
   having dealt with the first insn (longjump will result in a
   fault with the wrong address)

x86 definitely gets this totally wrong. I would be unsurprised
to find that other variable-length-insn targets do too.

> What I can say is that this check is a very weak one (but common to all
> targets), and that targets like i386 and arm need to refine it further in=
 the
> target-specific code. In fact, now I suspect all targets will need to ref=
ine it,
> so it probably makes sense to simply drop this generic check and burden a=
ll
> targets with handling it.

For targets which can never have instructions that cross the
page boundary, the only requirement is that we do not attempt
to fetch an instruction from a page other than the one we
started on (otherwise we will cause a spurious instruction
fetch abort).

The simple test program I used to test Thumb
page-boundary crossing instructions is here:
http://people.linaro.org/~peter.maydell/thumb-over-page.c
The signal handler it installs prints the r0 and pc values
reported to the handler so you can check the correct insns
executed and the reported PC was right. Works in linux-user
mode and also system mode (you'll need to sort out your own
guest kernel and filesystem).

thanks
-- PMM
